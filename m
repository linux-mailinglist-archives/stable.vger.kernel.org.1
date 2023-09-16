Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA007A2FE2
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjIPMMF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjIPMLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:11:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A220CEB
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:11:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5DDC433C7;
        Sat, 16 Sep 2023 12:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694866301;
        bh=e2/VsXGZb1a3GFIYS0NEtSJTX0tD5Z73q6QJK/vvdvY=;
        h=Subject:To:Cc:From:Date:From;
        b=resBdTrh1BP5E9BPuI7uul1175CewFnPNjOQNs7VJuv9bNcqTyaU+lVfXT31BUrcH
         nqIkpxgo+NfWfPCwsRqKqeupBCcmwHLYjpWVEUV60r+oEc9MEZ6SXDS/XQUad0iuxn
         yEV54L8oe6qtoV7e6HGKou+ry/R/dpWMV8ao1Kn0=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix incorrect DMA mapping unmap request" failed to apply to 5.15-stable tree
To:     quic_ekangupt@quicinc.com, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org, stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:11:37 +0200
Message-ID: <2023091637-clinic-wanted-7595@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a2cb9cd6a3949a3804ad9fd7da234892ce6719ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091637-clinic-wanted-7595@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a2cb9cd6a394 ("misc: fastrpc: Fix incorrect DMA mapping unmap request")
791da5c7fedb ("misc: fastrpc: Prepare to dynamic dma-buf locking specification")
e90d91190619 ("misc: fastrpc: Add support to secure memory map")
7f1f481263c3 ("misc: fastrpc: check before loading process to the DSP")
3abe3ab3cdab ("misc: fastrpc: add secure domain support")
6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
5c1b97c7d7b7 ("misc: fastrpc: add support for FASTRPC_IOCTL_MEM_MAP/UNMAP")
965602eabb57 ("misc: fastrpc: separate fastrpc device from channel context")
304b0ba0a21b ("misc: fastrpc: Update number of max fastrpc sessions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2cb9cd6a3949a3804ad9fd7da234892ce6719ec Mon Sep 17 00:00:00 2001
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
Date: Fri, 11 Aug 2023 12:56:42 +0100
Subject: [PATCH] misc: fastrpc: Fix incorrect DMA mapping unmap request

Scatterlist table is obtained during map create request and the same
table is used for DMA mapping unmap. In case there is any failure
while getting the sg_table, ERR_PTR is returned instead of sg_table.

When the map is getting freed, there is only a non-NULL check of
sg_table which will also be true in case failure was returned instead
of sg_table. This would result in improper unmap request. Add proper
check before setting map table to avoid bad unmap request.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20230811115643.38578-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7d8818a4089f..0b376d9a2744 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -757,6 +757,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct sg_table *table;
 	int err = 0;
 
 	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
@@ -784,11 +785,12 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		goto attach_err;
 	}
 
-	map->table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
-	if (IS_ERR(map->table)) {
-		err = PTR_ERR(map->table);
+	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
+	if (IS_ERR(table)) {
+		err = PTR_ERR(table);
 		goto map_err;
 	}
+	map->table = table;
 
 	if (attr & FASTRPC_ATTR_SECUREMAP) {
 		map->phys = sg_phys(map->table->sgl);

