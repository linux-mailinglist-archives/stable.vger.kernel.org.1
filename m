Return-Path: <stable+bounces-232772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGQmBAkUzWmMZwYAu9opvQ
	(envelope-from <stable+bounces-232772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:48:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A7B37AB58
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 14:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 273503043A57
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC040F8D0;
	Wed,  1 Apr 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcYnKtKc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76E408232
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046776; cv=none; b=gDfAC/opbwb40tKHVpdvu8LBtyYGEru9OdmmDaqptAjekUQsEMRs08PVqjXGBjyuRyK89qC6enY0xeFVtp6wXfAeY9GmF1bRa3J1DbqYUmr9QZKKtndQ8JkVo3S6tqdYpQwJJSIQVaaLQVibGTbCSA17YB66MzArjEr3M5y56HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046776; c=relaxed/simple;
	bh=KkSeBNY3hs6vZK7sLPzwlipB2goibX4NNNjln0Douo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUOGy/OjvUoFSAZle6KmKh/nPYZxOAWDfKWmXfQs/LXr3uxSIsHCx9/VBcmGrXb3oASeW5HYKjpTepM7QD5ysJAGffdrZRDfbqUeW8OArgVoAwoPYPyOmxJvfROWcke0+BrP4KtgbtVhh70Zj0MvH5qYLyaiq2CH1hETluMGXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcYnKtKc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b242b9359aso44170265ad.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775046773; x=1775651573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3jgFxhL9seWFIIYjdg90uFfdQsY9zg/UC8p0KRMhkg=;
        b=AcYnKtKcy2dm2jNvxpv4ZFGFJVnB4W17gxSQwic7Et275ANHiLJ4fTPLWvTRlYwDzK
         EhvEDXaI1E5oVSCosAeAicOexQkDhMclEGCGVy3eHmn6LPeZipNb4RGMZy95OozNcPP7
         6Lxp4dD0FF2wpA2sEADSIdBXy8I+UxwhphSSfdCzOg+y8zJIAIUvGGrUzPpFy6sMShEH
         NLa3JRAe6LWbw3AZ8fBx7P6DN1WnbOkdHmB7wHGEd+5821gR9cUlscW3/pcWRWgKRo8U
         rIGhT1Dwjwo5/bAjaTLfjBNTImGNGMvrFdMM9TI6V+Ci8S7UB566gTXmhzMJqF4slmKB
         fJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775046773; x=1775651573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3jgFxhL9seWFIIYjdg90uFfdQsY9zg/UC8p0KRMhkg=;
        b=Rr3082QP9bM9k0j7DkFTt8HbL4/gptTruAM8jp8d/Jqm+mP0KpBfEqky9CmfKQYpvD
         L3xZQ8AELBky/IXUXF3/J5zQP61Q0cbfYk29hGvMfrasT5GgjgUvLCVR3yjTR9tywlez
         R5RYxr8PM8CXFrdDPZYncm6iksacMnzWp3aUc2pQxksokpSGHMaS70TK8qAIL+12HjoJ
         w6pvJVvonjbaSqdPNapZgn6GNVL+qRIMuGTtJp7SabMHRLM2ph23shpOlvLUcEioTOzk
         EbVnw+lnnhy2QVquOdyTtsvpw7IKP3E8mWv0wM3i8zOEXGkHgctfj+qZNAoROzw+hehr
         p1tg==
X-Forwarded-Encrypted: i=1; AJvYcCWCvvAFAmdAA6QJv9NWxvf24IEJK5n5Q1mA+L5fCSxf/JNF/15BHtFPUmTsF17CciZEpgrHxE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBjRScL9iJDkxWOUZaGrjmuKBRirZaVAqOBa4890m5RwEAttTX
	wP56vKMsnZgSZKHNrjhiFpnP28r5Nq3HUOH3bRC/d/XxS2/437Wkx/gH/qlzt5tBLrYlKMYalwg
	Zb6Ou2eu8sCyGhx14jg==
X-Received: from pgbdp4.prod.google.com ([2002:a05:6a02:f04:b0:c74:12b9:ee05])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3c89:b0:35f:26b2:2f94 with SMTP id adf61e73a8af0-39ef7715fe2mr3500662637.46.1775046772582;
 Wed, 01 Apr 2026 05:32:52 -0700 (PDT)
Date: Wed,  1 Apr 2026 12:32:18 +0000
In-Reply-To: <20260401123238.3790062-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401123238.3790062-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401123238.3790062-3-guanyulin@google.com>
Subject: [PATCH v4 2/2] usb: host: xhci-sideband: delegate offload_usage
 tracking to class drivers
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	dominique.martinet@atmark-techno.com, eadavis@qq.com, hannelotta@gmail.com, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	xiaopei01@kylinos.cn, wesley.cheng@oss.qualcomm.com, 
	sakari.ailus@linux.intel.com, stern@rowland.harvard.edu, 
	amardeep.rai@intel.com, xu.yang_2@nxp.com, andriy.shevchenko@linux.intel.com, 
	nkapron@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org, 
	Hailong Liu <hailong.liu@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,intel.com,perex.cz,atmark-techno.com,qq.com,gmail.com,suse.com,quicinc.com,kernel.org,arndb.de,kylinos.cn,oss.qualcomm.com,linux.intel.com,rowland.harvard.edu,nxp.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-232772-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oppo.com:email]
X-Rspamd-Queue-Id: 20A7B37AB58
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
Tested-by: Hailong Liu <hailong.liu@oppo.com>
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


