Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418726FAA34
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjEHLAj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjEHLAN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CCF1FDD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F6561E4B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4F0C433D2;
        Mon,  8 May 2023 10:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543511;
        bh=ZheHF2Es9l7dGqTGX453WIo07dJi81f7biRKOVgUASw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQrLzMxm0S+Bm3qGuHUvgW9vfiO8bXaaeid/YgenjFSGDP+pBr//zQcML5170W77u
         +jN3KVHnlX2Rbzvi5/byUony5Ohg06cPFMqFpwBB/ZUhc9vykPdsRZr2D8se0T4nAu
         3Ncoa1EELBqLurVjXD1V7Bcrdxc6O6sl9jRMjLpY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhihao Cheng <chengzhihao1@huawei.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 6.3 085/694] Revert "ubifs: dirty_cow_znode: Fix memleak in error handling path"
Date:   Mon,  8 May 2023 11:38:40 +0200
Message-Id: <20230508094435.286256957@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Zhihao Cheng <chengzhihao1@huawei.com>

commit 7d01cb27f6aebc54efbe28d8961a973b8f795b13 upstream.

This reverts commit 122deabfe1428 (ubifs: dirty_cow_znode: Fix memleak
in error handling path).
After commit 122deabfe1428 applied, if insert_old_idx() failed, old
index neither exists in TNC nor in old-index tree. Which means that
old index node could be overwritten in layout_leb_in_gaps(), then
ubifs image will be corrupted in power-cut.

Fixes: 122deabfe1428 (ubifs: dirty_cow_znode: Fix memleak ... path)
Cc: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ubifs/tnc.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -267,18 +267,11 @@ static struct ubifs_znode *dirty_cow_zno
 	if (zbr->len) {
 		err = insert_old_idx(c, zbr->lnum, zbr->offs);
 		if (unlikely(err))
-			/*
-			 * Obsolete znodes will be freed by tnc_destroy_cnext()
-			 * or free_obsolete_znodes(), copied up znodes should
-			 * be added back to tnc and freed by
-			 * ubifs_destroy_tnc_subtree().
-			 */
-			goto out;
+			return ERR_PTR(err);
 		err = add_idx_dirt(c, zbr->lnum, zbr->len);
 	} else
 		err = 0;
 
-out:
 	zbr->znode = zn;
 	zbr->lnum = 0;
 	zbr->offs = 0;


