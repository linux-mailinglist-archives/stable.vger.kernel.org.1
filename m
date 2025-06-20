Return-Path: <stable+bounces-154957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E2AE151A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4F919E4EC0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DEC22655E;
	Fri, 20 Jun 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVpkYOs0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B8202978
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405259; cv=none; b=IAyJiSolc06VcXaxQQkS69s+uBmWHg2fzk73TQ5Stokl/y+mdczMRqIq8438sq5WyhZLtV7azbtZSV1WAa8BHBw3HKyVbCO7Z6fVpPM1wk9iwg9lKKEyEGe2x1uPDkYl/dYzpQFzMbFLMA/GHjjG/jlF5CCtqSjJrp6hmXLCNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405259; c=relaxed/simple;
	bh=legbPc+a+WbNm3WHN2crWiYz2jP36W9ihZVYSoAVorQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AcI+e7JMxw6zO/SP/JBCJXhUt+F7TfdrV4V8gSxIXROz2ioLbffdTEyIFDaleN8llBEEDrmxNiAhXADGzizqUcNbaT4j9bRZ88QKH54/vz7kKEgi/iT6lsWl59T2H4ZfwxmZDgJgmyAWEChVSAHy5216u6VzKXFnbBVN2WcRpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVpkYOs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5AC4CEED;
	Fri, 20 Jun 2025 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405259;
	bh=legbPc+a+WbNm3WHN2crWiYz2jP36W9ihZVYSoAVorQ=;
	h=Subject:To:Cc:From:Date:From;
	b=sVpkYOs07BhKIybsVJpPrd6MwlXxmVASez4HOL79xfdvDz+/pHLEQHNd7uEl2ZbDS
	 1e19+9aATUqJFOU/bKsg7zwkii9AEHgo6W/UdYJDIteyRhSmsnB+mZzgoeUVDZUgPG
	 E6Zq1cg5L3OhwTJViIp6SvH0N9JshuWTJZ6IsERA=
Subject: FAILED: patch "[PATCH] media: imx-jpeg: Reset slot data pointers when freed" failed to apply to 6.1-stable tree
To: ming.qian@oss.nxp.com,Frank.Li@nxp.com,hverkuil@xs4all.nl,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:40:56 +0200
Message-ID: <2025062056-upcoming-numerator-2955@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x faa8051b128f4b34277ea8a026d02d83826f8122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062056-upcoming-numerator-2955@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From faa8051b128f4b34277ea8a026d02d83826f8122 Mon Sep 17 00:00:00 2001
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Mon, 21 Apr 2025 16:12:53 +0800
Subject: [PATCH] media: imx-jpeg: Reset slot data pointers when freed

Ensure that the slot data pointers are reset to NULL and handles are
set to 0 after freeing the coherent memory. This makes he function
mxc_jpeg_alloc_slot_data() and mxc_jpeg_free_slot_data() safe to be
called multiple times.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index ad2284e87985..29d3d4b08dd1 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -758,16 +758,22 @@ static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
 			  jpeg->slot_data.desc,
 			  jpeg->slot_data.desc_handle);
+	jpeg->slot_data.desc = NULL;
+	jpeg->slot_data.desc_handle = 0;
 
 	/* free descriptor for encoder configuration phase / decoder DHT */
 	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
 			  jpeg->slot_data.cfg_desc,
 			  jpeg->slot_data.cfg_desc_handle);
+	jpeg->slot_data.cfg_desc_handle = 0;
+	jpeg->slot_data.cfg_desc = NULL;
 
 	/* free configuration stream */
 	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
 			  jpeg->slot_data.cfg_stream_vaddr,
 			  jpeg->slot_data.cfg_stream_handle);
+	jpeg->slot_data.cfg_stream_vaddr = NULL;
+	jpeg->slot_data.cfg_stream_handle = 0;
 
 	jpeg->slot_data.used = false;
 }


