Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6BE73538A
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjFSKqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjFSKpu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0263C6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAAC60670
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4FFC433C8;
        Mon, 19 Jun 2023 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171528;
        bh=h4DCIJ3UGoN6GvpgulwLtd764IOqw/nNJ/Y/qZtCJ44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUvPmPP2+oR48jfT0yZXlBHiTTSk0iYQU+JlO86r+kmQHS1io6SnE1K6btY80evSU
         LAo3o0BtrA2naDh11b9GFFoDFZgFSSPM6RSLX8VLV2NEkTjIWWsyVfSiQQPjAARCI+
         b70HVhCQSW5yaTwo8h1+jcYHBs1MuuelihqdDeH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Lingfeng <lilingfeng3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 6.1 064/166] dm thin metadata: check fail_io before using data_sm
Date:   Mon, 19 Jun 2023 12:29:01 +0200
Message-ID: <20230619102157.890399334@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Lingfeng <lilingfeng3@huawei.com>

commit cb65b282c9640c27d3129e2e04b711ce1b352838 upstream.

Must check pmd->fail_io before using pmd->data_sm since
pmd->data_sm may be destroyed by other processes.

       P1(kworker)                             P2(message)
do_worker
 process_prepared
  process_prepared_discard_passdown_pt2
   dm_pool_dec_data_range
                                    pool_message
                                     commit
                                      dm_pool_commit_metadata
                                        ↓
                                       // commit failed
                                      metadata_operation_failed
                                       abort_transaction
                                        dm_pool_abort_metadata
                                         __open_or_format_metadata
                                           ↓
                                          dm_sm_disk_open
                                            ↓
                                           // open failed
                                           // pmd->data_sm is NULL
    dm_sm_dec_blocks
      ↓
     // try to access pmd->data_sm --> UAF

As shown above, if dm_pool_commit_metadata() and
dm_pool_abort_metadata() fail in pool_message process, kworker may
trigger UAF.

Fixes: be500ed721a6 ("dm space maps: improve performance with inc/dec on ranges of blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-thin-metadata.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1750,13 +1750,15 @@ int dm_thin_remove_range(struct dm_thin_
 
 int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
 {
-	int r;
+	int r = -EINVAL;
 	uint32_t ref_count;
 
 	down_read(&pmd->root_lock);
-	r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
-	if (!r)
-		*result = (ref_count > 1);
+	if (!pmd->fail_io) {
+		r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
+		if (!r)
+			*result = (ref_count > 1);
+	}
 	up_read(&pmd->root_lock);
 
 	return r;
@@ -1764,10 +1766,11 @@ int dm_pool_block_is_shared(struct dm_po
 
 int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_inc_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_inc_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;
@@ -1775,10 +1778,11 @@ int dm_pool_inc_data_range(struct dm_poo
 
 int dm_pool_dec_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e)
 {
-	int r = 0;
+	int r = -EINVAL;
 
 	pmd_write_lock(pmd);
-	r = dm_sm_dec_blocks(pmd->data_sm, b, e);
+	if (!pmd->fail_io)
+		r = dm_sm_dec_blocks(pmd->data_sm, b, e);
 	pmd_write_unlock(pmd);
 
 	return r;


