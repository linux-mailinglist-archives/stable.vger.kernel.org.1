Return-Path: <stable+bounces-154958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E1AE151B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608A54A47AF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9421D3E7;
	Fri, 20 Jun 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NH6tsKJr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB217583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405268; cv=none; b=GvAP3rLXMWVEJU8ZSPdU95TyoeF4B/ioZ1djPz655xc+DbJFi4Rq6uQ/w7o3PSQEXtNIxYWl+zJ46jW0NggNlDD9IG0wZaKAfK7gm8PCjC1aR07zF5LliDrt9vZGXzyhZs1uQUWZLSEgeTHZSUbfihlCBcQ+p4oXXTX0/bNnG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405268; c=relaxed/simple;
	bh=Qn3Zby0liO7rjaq0mEY1hZIe8aHa1E1MxDYJDN5v/oE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Eu7foVG4HKAJYeVhEQx2qRRXQIcDGUiogb3O8yiXl10qkLseRqMvphJoBAzVwARzuWZ6+w4gr0qK3xsNw0N+8VV6NtMVPODUnk5x0kHhehwAQ6tKmtIKuXh7vEfh57OApeQTDM+HBnKjNJtyTbyrz3b/bEuJi6uVDmTrTPFghB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NH6tsKJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06EBC4CEE3;
	Fri, 20 Jun 2025 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405268;
	bh=Qn3Zby0liO7rjaq0mEY1hZIe8aHa1E1MxDYJDN5v/oE=;
	h=Subject:To:Cc:From:Date:From;
	b=NH6tsKJrHLT65DafLGrtZjKmHcMq6k1Le8ZmvSM7sgCWdf0HzPOrAbFa3pDObk0oQ
	 CLLJv28Ikhn6/1BBaX9l/Md71vDQRi7zoFvxCrROa4PtJno0riR6CLGpIoFTP7E4vd
	 WfatRple9BfObTC2fvyagYMN467FwPKhCbkPaiTQ=
Subject: FAILED: patch "[PATCH] media: imx-jpeg: Reset slot data pointers when freed" failed to apply to 5.15-stable tree
To: ming.qian@oss.nxp.com,Frank.Li@nxp.com,hverkuil@xs4all.nl,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:40:57 +0200
Message-ID: <2025062057-sift-mulled-7ea9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x faa8051b128f4b34277ea8a026d02d83826f8122
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062057-sift-mulled-7ea9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


