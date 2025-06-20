Return-Path: <stable+bounces-154959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAEDAE151D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1877ADD84
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9FC21D3E7;
	Fri, 20 Jun 2025 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zm0mbgL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAD17583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405277; cv=none; b=mpk8GySh3A2uuZyT+UMYweYkLy5j+PDclM+1yAx01naI+Nab1nQVEREDP5oAPkOGYB/QsUvIOeo23KHihEX7Kn6ywiU2TdxyTCLFH4laEEZAYl7m8xoAUXumHXZ8Lko5ybno4q9lBSEMQBMWeRZCQZZQkV5vNl7k9ofnz4B+034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405277; c=relaxed/simple;
	bh=/3VyMjm0cAGFfn7mtMXIHAK0BV43YrAvIncV4vtccHY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HezjsQj0QqZjmtI+W4hD7TE7/AdxOKN08IvQ3kwSopnvfmYj9DEL38igOxYMPgG0Zeu1eznB9mtSGnoGGXRSiKjmdHF1D8h+YH1aBfmSNFbXSUvZ6edPUg9kwmbjQUaWlOypxcLWz3NxPNIWDtfmSx94Mow5aH4ZZ7PEYVSB/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zm0mbgL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78BBC4CEE3;
	Fri, 20 Jun 2025 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405276;
	bh=/3VyMjm0cAGFfn7mtMXIHAK0BV43YrAvIncV4vtccHY=;
	h=Subject:To:Cc:From:Date:From;
	b=Zm0mbgL11Sfk7udHuKv1GMvnPAKLL59hJ19KHI3OPeeb3hDPUY5mZnIps3ZfJCsh3
	 EKrCCj0JQyI9doiof1pjd5BZIIVQ7+FncgHk4doJ0mcV14a1CEoWVYYxuT66QxrJZY
	 t15zhb2P8Ol9Y7FePRs7YgbPXLU8V7jgZp6mp/+w=
Subject: FAILED: patch "[PATCH] media: imx-jpeg: Cleanup after an allocation error" failed to apply to 6.1-stable tree
To: ming.qian@oss.nxp.com,Frank.Li@nxp.com,hverkuil@xs4all.nl,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:41:07 +0200
Message-ID: <2025062007-screen-jurist-5d6d@gregkh>
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
git cherry-pick -x 7500bb9cf164edbb2c8117d57620227b1a4a8369
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062007-screen-jurist-5d6d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7500bb9cf164edbb2c8117d57620227b1a4a8369 Mon Sep 17 00:00:00 2001
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Mon, 21 Apr 2025 16:12:54 +0800
Subject: [PATCH] media: imx-jpeg: Cleanup after an allocation error

When allocation failures are not cleaned up by the driver, further
allocation errors will be false-positives, which will cause buffers to
remain uninitialized and cause NULL pointer dereferences.
Ensure proper cleanup of failed allocations to prevent these issues.

Fixes: 2db16c6ed72c ("media: imx-jpeg: Add V4L2 driver for i.MX8 JPEG Encoder/Decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 29d3d4b08dd1..8a25ea8905ae 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -820,6 +820,7 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 	return true;
 err:
 	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", jpeg->slot_data.slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	return false;
 }


