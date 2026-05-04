Return-Path: <stable+bounces-243369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pBPYMF2p+Gm6xgIAu9opvQ
	(envelope-from <stable+bounces-243369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B24BECD7
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52358305CFCD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A113D5645;
	Mon,  4 May 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0feBp7II"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D981ADC83;
	Mon,  4 May 2026 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903709; cv=none; b=H4MVhtKZDi6UYM80TrqECiPcVJkSZcVZRMn4yQ+e1d68zRoDLVFifudk2woQPmVRdDnoh5D/J4f/qfJma9H2vQkXl1+cF6ozVMtxuLjHGiNNTH0dqEl2zITd/kBNrE7HGMq7ygFrIpjAwHchYwkEfEXvxS/TmSPcV0I5uxBdjX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903709; c=relaxed/simple;
	bh=U7NRuY2U8rqZP/7U3x9esvfwLKbBkl5+fKOAhURHGLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3kcCFtfqf85T9+ieZH47JfFfFNasazmQn4hmV+zv3x8nUcR7VLTxKSRLZ0VHTy+fWJxahyLcQ+0FGkDtcPbEUyOxkV/ZZTkbMzCOKzw/1FPdhHczKv/ZMEIMzuLmtoYmRYwNdp4/D6FQxW08vcWaNXrMxiH+msFCWOlfBcvAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0feBp7II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF35EC2BCB8;
	Mon,  4 May 2026 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903709;
	bh=U7NRuY2U8rqZP/7U3x9esvfwLKbBkl5+fKOAhURHGLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0feBp7II92EbrcS/QBV/bGTe22Z0Kfid49Et32kc142zc7UNeFgmJ94uGYrml1JMr
	 y29ExHUkEVxsyFBOrDwkZCq5+bQVJqcFDu7db5t+QHuyLjru5QE9C0CSSRVWRQ7KxI
	 bZoGxFqje+ljhHeZbOuS1OwgWNKz9fdxHrE/ynwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Williamson <alex.williamson@nvidia.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 6.18 032/275] vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex
Date: Mon,  4 May 2026 15:49:32 +0200
Message-ID: <20260504135144.132056574@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C70B24BECD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243369-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,amd.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,shazbot.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@nvidia.com>

commit 670e8864b1a218d72f08db40d0103adf38fa1d9b upstream.

vfio_cdx_set_msi_trigger() reads vdev->config_msi and operates on the
vdev->cdx_irqs array based on its value, but provides no serialization
against concurrent VFIO_DEVICE_SET_IRQS ioctls.  Two callers can race
such that one observes config_msi as set while another clears it and
frees cdx_irqs via vfio_cdx_msi_disable(), resulting in a use-after-free
of the cdx_irqs array.

Add a cdx_irqs_lock mutex to struct vfio_cdx_device and acquire it in
vfio_cdx_set_msi_trigger(), which is the single chokepoint through
which all updates to config_msi, cdx_irqs, and msi_count flow, covering
both the ioctl path and the close-device cleanup path.  This keeps the
test of config_msi atomic with the subsequent enable, disable, or
trigger operations.

Drop the pre-call !cdx_irqs test from vfio_cdx_irqs_cleanup() as part
of this change: the optimization it provided is redundant with the
!config_msi early-return inside vfio_cdx_msi_disable(), and leaving the
test in place would be an unsynchronized read of state the new lock is
meant to protect.

Fixes: 848e447e000c ("vfio/cdx: add interrupt support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Acked-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Link: https://lore.kernel.org/r/20260417202800.88287-3-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vfio/cdx/intr.c    |    9 ++-------
 drivers/vfio/cdx/main.c    |   19 +++++++++++++++++++
 drivers/vfio/cdx/private.h |    3 +++
 3 files changed, 24 insertions(+), 7 deletions(-)

--- a/drivers/vfio/cdx/intr.c
+++ b/drivers/vfio/cdx/intr.c
@@ -152,6 +152,8 @@ static int vfio_cdx_set_msi_trigger(stru
 	if (start + count > cdx_dev->num_msi)
 		return -EINVAL;
 
+	guard(mutex)(&vdev->cdx_irqs_lock);
+
 	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE)) {
 		vfio_cdx_msi_disable(vdev);
 		return 0;
@@ -206,12 +208,5 @@ int vfio_cdx_set_irqs_ioctl(struct vfio_
 /* Free All IRQs for the given device */
 void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
 {
-	/*
-	 * Device does not support any interrupt or the interrupts
-	 * were not configured
-	 */
-	if (!vdev->cdx_irqs)
-		return;
-
 	vfio_cdx_set_msi_trigger(vdev, 0, 0, 0, VFIO_IRQ_SET_DATA_NONE, NULL);
 }
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -8,6 +8,23 @@
 
 #include "private.h"
 
+static int vfio_cdx_init_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+
+	mutex_init(&vdev->cdx_irqs_lock);
+	return 0;
+}
+
+static void vfio_cdx_release_dev(struct vfio_device *core_vdev)
+{
+	struct vfio_cdx_device *vdev =
+		container_of(core_vdev, struct vfio_cdx_device, vdev);
+
+	mutex_destroy(&vdev->cdx_irqs_lock);
+}
+
 static int vfio_cdx_open_device(struct vfio_device *core_vdev)
 {
 	struct vfio_cdx_device *vdev =
@@ -281,6 +298,8 @@ static int vfio_cdx_mmap(struct vfio_dev
 
 static const struct vfio_device_ops vfio_cdx_ops = {
 	.name		= "vfio-cdx",
+	.init		= vfio_cdx_init_dev,
+	.release	= vfio_cdx_release_dev,
 	.open_device	= vfio_cdx_open_device,
 	.close_device	= vfio_cdx_close_device,
 	.ioctl		= vfio_cdx_ioctl,
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -6,6 +6,8 @@
 #ifndef VFIO_CDX_PRIVATE_H
 #define VFIO_CDX_PRIVATE_H
 
+#include <linux/mutex.h>
+
 #define VFIO_CDX_OFFSET_SHIFT    40
 
 static inline u64 vfio_cdx_index_to_offset(u32 index)
@@ -31,6 +33,7 @@ struct vfio_cdx_region {
 struct vfio_cdx_device {
 	struct vfio_device	vdev;
 	struct vfio_cdx_region	*regions;
+	struct mutex		cdx_irqs_lock;
 	struct vfio_cdx_irq	*cdx_irqs;
 	u32			flags;
 #define BME_SUPPORT BIT(0)



