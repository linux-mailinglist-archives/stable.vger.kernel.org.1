Return-Path: <stable+bounces-234631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG/5JZ6h1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053B3C14B9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E0131ADE9D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2FF3D4134;
	Wed,  8 Apr 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGY5siBd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F1331A44;
	Wed,  8 Apr 2026 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673359; cv=none; b=qakKV0JaTdLerWIhZhbmsp2t1HDFw9PCqMOqlM5ihBYXxNVViULmoPo+2QaAdXeEKUDAOV9Kl1MNSDDPGvmEssbmOZHhULVfBGkixV8cHM1Z6EEwHDcthSLUa8iYwbhCSm3UxWhDBvq7gNQoCI3hdjzhzTGNmdOe228ByugmJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673359; c=relaxed/simple;
	bh=8z52vFteoOc4MeoNVtrnxa6h1l2YIo0GrrF862tJ1Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flLBnNU+ySlFifPzBwaYlhckvdIU57nE8NCJdjn0Y6irZaZGDtw2tv32/I9FpN5A2v01//UBVOlH1lIsMg5XVv2Jg2br6hyNbimIh0+vCSSgwup8PQImLXVlxZT7ow7f8vZN+/zU0jQlUyG3s3uGDxtxEiE2pYK5Jx6yyAjquOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGY5siBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3566C2BC87;
	Wed,  8 Apr 2026 18:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673359;
	bh=8z52vFteoOc4MeoNVtrnxa6h1l2YIo0GrrF862tJ1Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGY5siBd3gPdSUJw3otCJ0HO0AaxB4RYrxAwNH21VV9LNmVOiAr1ZwDZQWKHTV0f/
	 W0F7kBDkzjNgV/pmcGFomv2lbx9RpWcRQ6nZt3dkWj4EX47Rg1SqekGb9zRKihauhn
	 tvqYlHqEVggzGxmO1CtokjW3bE/U1Z8oiz+76Pnc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Guan-Yu Lin <guanyulin@google.com>,
	Hailong Liu <hailong.liu@oppo.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.18 201/277] usb: host: xhci-sideband: delegate offload_usage tracking to class drivers
Date: Wed,  8 Apr 2026 20:03:06 +0200
Message-ID: <20260408175941.368618676@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234631-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2053B3C14B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guan-Yu Lin <guanyulin@google.com>

commit 5abbe6ecc6203355c770bf232ade88e29c960049 upstream.

Remove usb_offload_get() and usb_offload_put() from the xHCI sideband
interrupter creation and removal paths.

The responsibility of manipulating offload_usage now lies entirely with
the USB class drivers. They have the precise context of when an offload
data stream actually starts and stops, ensuring a much more accurate
representation of offload activity for power management.

Cc: stable <stable@kernel.org>
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
Tested-by: Hailong Liu <hailong.liu@oppo.com>
Tested-by: hailong.liu@oppo.com
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20260401123238.3790062-3-guanyulin@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-sideband.c  |   14 +-------------
 sound/usb/qcom/qc_audio_offload.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 14 deletions(-)

--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -93,8 +93,6 @@ __xhci_sideband_remove_endpoint(struct x
 static void
 __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	struct usb_device *udev;
-
 	lockdep_assert_held(&sb->mutex);
 
 	if (!sb->ir)
@@ -102,10 +100,6 @@ __xhci_sideband_remove_interrupter(struc
 
 	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
 	sb->ir = NULL;
-	udev = sb->vdev->udev;
-
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_offload_put(udev);
 }
 
 /* sideband api functions */
@@ -328,9 +322,6 @@ int
 xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear, u32 imod_interval, int intr_num)
 {
-	int ret = 0;
-	struct usb_device *udev;
-
 	if (!sb || !sb->xhci)
 		return -ENODEV;
 
@@ -348,12 +339,9 @@ xhci_sideband_create_interrupter(struct
 	if (!sb->ir)
 		return -ENOMEM;
 
-	udev = sb->vdev->udev;
-	ret = usb_offload_get(udev);
-
 	sb->ir->ip_autoclear = ip_autoclear;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -699,6 +699,7 @@ static void uaudio_event_ring_cleanup_fr
 		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
 				   PAGE_SIZE);
 		xhci_sideband_remove_interrupter(uadev[dev->chip->card->number].sb);
+		usb_offload_put(dev->udev);
 	}
 }
 
@@ -1182,12 +1183,16 @@ static int uaudio_event_ring_setup(struc
 	dma_coherent = dev_is_dma_coherent(subs->dev->bus->sysdev);
 	er_pa = 0;
 
+	ret = usb_offload_get(subs->dev);
+	if (ret < 0)
+		goto exit;
+
 	/* event ring */
 	ret = xhci_sideband_create_interrupter(uadev[card_num].sb, 1, false,
 					       0, uaudio_qdev->data->intr_num);
 	if (ret < 0) {
 		dev_err(&subs->dev->dev, "failed to fetch interrupter\n");
-		goto exit;
+		goto put_offload;
 	}
 
 	sgt = xhci_sideband_get_event_buffer(uadev[card_num].sb);
@@ -1219,6 +1224,8 @@ clear_pa:
 	mem_info->dma = 0;
 remove_interrupter:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+put_offload:
+	usb_offload_put(subs->dev);
 exit:
 	return ret;
 }
@@ -1483,6 +1490,7 @@ unmap_er:
 	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
 free_sec_ring:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+	usb_offload_put(subs->dev);
 drop_sync_ep:
 	if (subs->sync_endpoint) {
 		uaudio_iommu_unmap(MEM_XFER_RING,



