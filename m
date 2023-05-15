Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFA703A66
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbjEORvC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbjEORug (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FD11B72
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E954362EEB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F272DC433EF;
        Mon, 15 May 2023 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172913;
        bh=8gJnnmseKkIWzQfGlrPXjzycTu+gTOhiXSp3C6TcOzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltAuZ2haffaEoZO/epz4GN4AgMk5pZsiL1ZGBpig9d0l4HafJ5T6r6jQ9xIQiTPH/
         Q+glqU7NAS88SO9CDY0pYvM3t4jTkOdrNR4HLaxtvxnjH8TVgulAZzbWl4O/x2+CDl
         E3f1i3Ic/47E72pgsZ/QKXlACbCU9EXy7UwnK18c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sungjong Seo <sj1557.seo@samsung.com>,
        Yeongjin Gil <youngjin.gil@samsung.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 307/381] dm verity: fix error handling for check_at_most_once on FEC
Date:   Mon, 15 May 2023 18:29:18 +0200
Message-Id: <20230515161750.705280788@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Yeongjin Gil <youngjin.gil@samsung.com>

[ Upstream commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3 ]

In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
directly. But if FEC configured, it is desired to correct the data page
through verity_verify_io. And the return value will be converted to
blk_status and passed to verity_finish_io().

BTW, when a bit is set in v->validated_blocks, verity_verify_io() skips
verification regardless of I/O error for the corresponding bio. In this
case, the I/O error could not be returned properly, and as a result,
there is a problem that abnormal data could be read for the
corresponding block.

To fix this problem, when an I/O error occurs, do not skip verification
even if the bit related is set in v->validated_blocks.

Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")
Cc: stable@vger.kernel.org
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-verity-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index d9c388e6ce76c..0c2048d2b847e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -482,7 +482,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, &io->iter);
 			continue;
-- 
2.39.2



