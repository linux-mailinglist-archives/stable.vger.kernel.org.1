Return-Path: <stable+bounces-230230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNW3JrX2wmkEngQAu9opvQ
	(envelope-from <stable+bounces-230230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:40:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EEF31C6AC
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81C6306CF5F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D561B3542E2;
	Tue, 24 Mar 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Io/UBixT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FB354AE3
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384746; cv=none; b=o8lpU8VRgP2fpOTT7coVXR7azEK9NgYPxdgJb96cTqvHCHn+XEOqALiTenNRk1qaY/i/r/rfrc29f+zWk6DI+QaOF7XcKfBrrK9MVmD4S4n3ZENagF4EqSevs8t9ddUwbTwHCa/P7QBHEtIdEtdKWMGpyIANdkeklvtk1Lt6utQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384746; c=relaxed/simple;
	bh=6Ck3L+CE5zCcBRuao0IdjzcnQd7HU4crf4dPRSbvMKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LwQKMD0St6uCw91VRJtzWc93YqQrGjbjmKHm4IvxrGeXy7A9pFBaPizZ7KjH4lOuMFgOmaZMdWS4ZW4vDjjf5Z42nxL3/xsm6cXe6VE6kML5BC79yShxKf4L1YlSM10wz+svctBt35Hl4IlEN6DhnydfdxNvCer8Vu290eqvwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Io/UBixT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630753cc38so26215127a12.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774384745; x=1774989545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OL+7kQbp5Bd7JEAMiGmzSMDg6A6JNXw/2f9uUU+JDmw=;
        b=Io/UBixTBsWof4aB50JqkjQOoeglK3KlMjhMFQsx5n4pzQC9tklyg91ZVSsKh4nmjp
         PGufXh42HXIuxFxc6x6C16CYWIQA0RNsr/2LPGr15sHeQv8g0pS6sHDxa0nxjjiW0qjM
         wBOC58duUHiEajkZ9//M2Aallc0NOPMFjI1Mm0CTy7SkBhWSX7HunPMRKlC2T3soQLYX
         7cuepZjDWn+sH9Od/32+BZ5LqGtcT5SRDIAlkqkUvua10KLS+0MW/tnaM2Yq2dtW6Vvd
         Q5tFkeh90jyiCieBGdmjGSyhXEEjRnSqICAJ7sA0LrBzF/Undrj+DgNFqNhWls2Jkk3/
         Dwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774384745; x=1774989545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OL+7kQbp5Bd7JEAMiGmzSMDg6A6JNXw/2f9uUU+JDmw=;
        b=IeQ/3Ey6d+aPQpXtUrzhAZwO7l2u4JxP+2krZONXRFdfdj9bNkIHIAfDN6iFOjRn+w
         Jvfw3iiex34yH30U0Txv2H/EkhOiiBLdH7uFHMxaBbnf9mKMADPpoGvZkUIPMukaeD+I
         Mq78nKTOXtpg/tq65jp2iaFUSmrpySJHlHoyirVFTH1h/UFC50Jcu2jQP2e4MqeSj18k
         5gm3rElOc+MdsZGMP8WxSH5k1uXAh69Wuw6Uh4Mfevw0wpfwHzm4b4cRbsx4G65xIk3w
         QALDl7jl7qCa/cFt7XWcEj6GnESvKORBefpuV1BxZXDLmjPHfcuAc/gby+RIvDrU5nps
         7g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcnbC9xjvGgdPKSyAxbhusZFs5ixSsb6f7TAdEJoHGri4y7L44pPg86gFHOOM+qSZLpSHl2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Nls7yd/FeRT3aGx3zGemogLe834cz+FcZrYDtGW74O5Qc3NG
	G4nbP0OakgT5TpJ2WkUGl8OuiV+FTaqFmOeuY39IgBWRw42tCyrBKpqaee/LHXnWfI1jmvIQ9O+
	/n8II0j4yKO1dD600tQ==
X-Received: from pgbfq3.prod.google.com ([2002:a05:6a02:2983:b0:c76:5844:e6da])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3388:b0:398:9466:2ee8 with SMTP id adf61e73a8af0-39c4abb6ac3mr1138240637.7.1774384744541;
 Tue, 24 Mar 2026 13:39:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:38:10 +0000
In-Reply-To: <20260324203851.4091193-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324203851.4091193-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260324203851.4091193-3-guanyulin@google.com>
Subject: [PATCH v3 2/2] usb: host: xhci-sideband: delegate offload_usage
 tracking to class drivers
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	xiaopei01@kylinos.cn, wesley.cheng@oss.qualcomm.com, hannelotta@gmail.com, 
	sakari.ailus@linux.intel.com, eadavis@qq.com, stern@rowland.harvard.edu, 
	amardeep.rai@intel.com, xu.yang_2@nxp.com, andriy.shevchenko@linux.intel.com, 
	nkapron@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,kylinos.cn,oss.qualcomm.com,gmail.com,linux.intel.com,qq.com,rowland.harvard.edu,nxp.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-230230-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15EEF31C6AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove usb_offload_get() and usb_offload_put() from the xHCI sideband
interrupter creation and removal paths.

The responsibility of manipulating offload_usage now lies entirely with
the USB class drivers. They have the precise context of when an offload
data stream actually starts and stops, ensuring a much more accurate
representation of offload activity for power management.

Cc: stable@vger.kernel.org
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/host/xhci-sideband.c  | 14 +-------------
 sound/usb/qcom/qc_audio_offload.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 1ddb64b0a48e..651973606137 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -93,8 +93,6 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
 static void
 __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	struct usb_device *udev;
-
 	lockdep_assert_held(&sb->mutex);
 
 	if (!sb->ir)
@@ -102,10 +100,6 @@ __xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 
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
 
@@ -348,12 +339,9 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
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
 
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index cfb30a195364..abafbc78dea9 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -699,6 +699,7 @@ static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
 		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
 				   PAGE_SIZE);
 		xhci_sideband_remove_interrupter(uadev[dev->chip->card->number].sb);
+		usb_offload_put(dev->udev);
 	}
 }
 
@@ -1182,12 +1183,16 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
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
@@ -1219,6 +1224,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	mem_info->dma = 0;
 remove_interrupter:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+put_offload:
+	usb_offload_put(subs->dev);
 exit:
 	return ret;
 }
@@ -1483,6 +1490,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
 	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
 free_sec_ring:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+	usb_offload_put(subs->dev);
 drop_sync_ep:
 	if (subs->sync_endpoint) {
 		uaudio_iommu_unmap(MEM_XFER_RING,
-- 
2.53.0.1018.g2bb0e51243-goog


