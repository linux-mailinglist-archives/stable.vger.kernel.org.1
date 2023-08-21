Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C616783347
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHUUHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjHUUHP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079A7A8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 967756498C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15FAC433C7;
        Mon, 21 Aug 2023 20:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648433;
        bh=5MDcLS5lgi1GBOcc0p5AJvWTtUPHj4VK3ZMpalx5v0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEaixFhNMwPDFV7Km7RSYFv3V9nomDxiJQ0IAdFOLg98CaO7Eg5I06HqFPWrxXvhJ
         jScSQaxwmrc6ExaVBWyGeSnR3P0LzjEOgMeAxNIVAiITErcg2iL3dk815qDtgU+91s
         c+fciN/cRuHMhutmeke1JkQ+TzZOU2J/Gg74OMMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 156/234] accel/qaic: Clean up integer overflow checking in map_user_pages()
Date:   Mon, 21 Aug 2023 21:41:59 +0200
Message-ID: <20230821194135.714292124@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 96d3c1cadedb6ae2e8965e19cd12caa244afbd9c ]

The encode_dma() function has some validation on in_trans->size but it
would be more clear to move those checks to find_and_map_user_pages().

The encode_dma() had two checks:

	if (in_trans->addr + in_trans->size < in_trans->addr || !in_trans->size)
		return -EINVAL;

The in_trans->addr variable is the starting address.  The in_trans->size
variable is the total size of the transfer.  The transfer can occur in
parts and the resources->xferred_dma_size tracks how many bytes we have
already transferred.

This patch introduces a new variable "remaining" which represents the
amount we want to transfer (in_trans->size) minus the amount we have
already transferred (resources->xferred_dma_size).

I have modified the check for if in_trans->size is zero to instead check
if in_trans->size is less than resources->xferred_dma_size.  If we have
already transferred more bytes than in_trans->size then there are negative
bytes remaining which doesn't make sense.  If there are zero bytes
remaining to be copied, just return success.

The check in encode_dma() checked that "addr + size" could not overflow
and barring a driver bug that should work, but it's easier to check if
we do this in parts.  First check that "in_trans->addr +
resources->xferred_dma_size" is safe.  Then check that "xfer_start_addr +
remaining" is safe.

My final concern was that we are dealing with u64 values but on 32bit
systems the kmalloc() function will truncate the sizes to 32 bits.  So
I calculated "total = in_trans->size + offset_in_page(xfer_start_addr);"
and returned -EINVAL if it were >= SIZE_MAX.  This will not affect 64bit
systems.

Fixes: 129776ac2e38 ("accel/qaic: Add control path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/24d3348b-25ac-4c1b-b171-9dae7c43e4e0@moroto.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/qaic/qaic_control.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index cfbc92da426fa..388abd40024ba 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -392,18 +392,31 @@ static int find_and_map_user_pages(struct qaic_device *qdev,
 				   struct qaic_manage_trans_dma_xfer *in_trans,
 				   struct ioctl_resources *resources, struct dma_xfer *xfer)
 {
+	u64 xfer_start_addr, remaining, end, total;
 	unsigned long need_pages;
 	struct page **page_list;
 	unsigned long nr_pages;
 	struct sg_table *sgt;
-	u64 xfer_start_addr;
 	int ret;
 	int i;
 
-	xfer_start_addr = in_trans->addr + resources->xferred_dma_size;
+	if (check_add_overflow(in_trans->addr, resources->xferred_dma_size, &xfer_start_addr))
+		return -EINVAL;
 
-	need_pages = DIV_ROUND_UP(in_trans->size + offset_in_page(xfer_start_addr) -
-				  resources->xferred_dma_size, PAGE_SIZE);
+	if (in_trans->size < resources->xferred_dma_size)
+		return -EINVAL;
+	remaining = in_trans->size - resources->xferred_dma_size;
+	if (remaining == 0)
+		return 0;
+
+	if (check_add_overflow(xfer_start_addr, remaining, &end))
+		return -EINVAL;
+
+	total = remaining + offset_in_page(xfer_start_addr);
+	if (total >= SIZE_MAX)
+		return -EINVAL;
+
+	need_pages = DIV_ROUND_UP(total, PAGE_SIZE);
 
 	nr_pages = need_pages;
 
@@ -435,7 +448,7 @@ static int find_and_map_user_pages(struct qaic_device *qdev,
 
 	ret = sg_alloc_table_from_pages(sgt, page_list, nr_pages,
 					offset_in_page(xfer_start_addr),
-					in_trans->size - resources->xferred_dma_size, GFP_KERNEL);
+					remaining, GFP_KERNEL);
 	if (ret) {
 		ret = -ENOMEM;
 		goto free_sgt;
@@ -566,9 +579,6 @@ static int encode_dma(struct qaic_device *qdev, void *trans, struct wrapper_list
 	    QAIC_MANAGE_EXT_MSG_LENGTH)
 		return -ENOMEM;
 
-	if (in_trans->addr + in_trans->size < in_trans->addr || !in_trans->size)
-		return -EINVAL;
-
 	xfer = kmalloc(sizeof(*xfer), GFP_KERNEL);
 	if (!xfer)
 		return -ENOMEM;
-- 
2.40.1



