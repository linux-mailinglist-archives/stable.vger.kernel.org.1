Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FC75C6D0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 14:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGUMVE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGUMVC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 08:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6430E7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 05:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C99F61A78
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4383CC433C8;
        Fri, 21 Jul 2023 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689942058;
        bh=5xSK0vavlAeDfDfV8ugTMxTLDTL4lsxaQl5zD0n4Hw0=;
        h=Subject:To:Cc:From:Date:From;
        b=b96PBB6mV1iV+o08XTECzWhgdLUmnBNzCOV1ys50+D8Tb/Q/6DiPTUSRQ0vVN00El
         Y1GUcVOnKHxa1SqCkpK2BsNASF1+znBlDVhd2qd8tb3qiY3lSfyNB5WE9ukpXr3nyW
         JAl96yLJaz0KtTcXEPErTfnL97YKVYFXceV3Rstw=
Subject: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when adding a entry" failed to apply to 6.1-stable tree
To:     Yunxiang.Li@amd.com, christian.koenig@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 14:20:47 +0200
Message-ID: <2023072147-outfit-hermit-0f79@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4481913607e58196c48a4fef5e6f45350684ec3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072147-outfit-hermit-0f79@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

4481913607e5 ("drm/ttm: fix bulk_move corruption when adding a entry")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4481913607e58196c48a4fef5e6f45350684ec3c Mon Sep 17 00:00:00 2001
From: Yunxiang Li <Yunxiang.Li@amd.com>
Date: Thu, 22 Jun 2023 10:18:03 -0400
Subject: [PATCH] drm/ttm: fix bulk_move corruption when adding a entry
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the resource is the first in the bulk_move range, adding it again
(thus moving it to the tail) will corrupt the list since the first
pointer is not moved. This eventually lead to null pointer deref in
ttm_lru_bulk_move_del()

Fixes: fee2ede15542 ("drm/ttm: rework bulk move handling v5")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
CC: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20230622141902.28718-3-Yunxiang.Li@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 7333f7a87a2f..e51dbc7a2d53 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -86,6 +86,8 @@ static void ttm_lru_bulk_move_pos_tail(struct ttm_lru_bulk_move_pos *pos,
 				       struct ttm_resource *res)
 {
 	if (pos->last != res) {
+		if (pos->first == res)
+			pos->first = list_next_entry(res, lru);
 		list_move(&res->lru, &pos->last->lru);
 		pos->last = res;
 	}
@@ -111,7 +113,8 @@ static void ttm_lru_bulk_move_del(struct ttm_lru_bulk_move *bulk,
 {
 	struct ttm_lru_bulk_move_pos *pos = ttm_lru_bulk_move_pos(bulk, res);
 
-	if (unlikely(pos->first == res && pos->last == res)) {
+	if (unlikely(WARN_ON(!pos->first || !pos->last) ||
+		     pos->first == res && pos->last == res)) {
 		pos->first = NULL;
 		pos->last = NULL;
 	} else if (pos->first == res) {

