Return-Path: <stable+bounces-223475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILj/GIsvrmlrAQIAu9opvQ
	(envelope-from <stable+bounces-223475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5E2333BA
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFD4C304AC1B
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A7029BD88;
	Mon,  9 Mar 2026 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXS0xK/H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B4291C33
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022938; cv=none; b=XJEcSFoRmLf2N5J3UNCr1OyZZliD8YKGOPQcyq5adrq0fTXApF0g+t0AM7htnB02JFcR8t7BXnPlpj7axf/ccqgVq9Rc7PwU5JPU8u2wX9YC9bbFEY3fzdF2RcHvf0qJWIrqHYyaSnwW17v+jG0sf/MuK1vLDus2QLCFS/ufg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022938; c=relaxed/simple;
	bh=sfhKlOxhZjp27RRqyMOv5tQbb25tvaGuKH9jjcuerK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQSImUW9kL9CnNKt1HizL0oH0y67Bmdzp9RggnD0KI84vdZMF/438HI7Rvt2ABbE+UEu0U9pYEISOGBfINADkSP3d29aJkwos5PB9sZ6XTb77tItobZOrwkqZeOdwzYVl6DT+qkgL5AZHN7ys8bcDDFVSupeqyh69ijKbsPhZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXS0xK/H; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so7045061a12.3
        for <stable@vger.kernel.org>; Sun, 08 Mar 2026 19:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773022936; x=1773627736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gplv2Tex9lazNCSIePgQz/7GHAFcH+CmqLMfgw0rRa0=;
        b=qXS0xK/H+4hXaFLUlZ8x87PPHpUbo46YLYLBWMcdL9kyLAofzbPujHJCCKYCmfDIKI
         BAaWPJKtf0PDXEyvBUJH3E98gWq9K6EfaAmpcYtIPoWKoQhKlNurghHkYy/OV2bqExfV
         Eb1lGEnpPVGw1Y0vZ7+dIz611n+QcCpX/phanCnjfZbr22m7H9EUpzJHDj5Q6gH7kL88
         A90UAYwwWr2fp4/MjdBikNAwFpE/NM8XRJeElQ8G+7xJJyXyZ0KIXrNNAtAcOBwia6an
         vbOgLueVCmlSlNPm6E/SG7w/kjC/vBZNaJsjdqaz6fZ+1h5zHDx+ebWoCwIHouO8igbE
         OjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773022936; x=1773627736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gplv2Tex9lazNCSIePgQz/7GHAFcH+CmqLMfgw0rRa0=;
        b=G80j0eMqmOIzYwS43WAFTxbQaBZtlnfzx+FfTnfjZ0PntACK/4vfR3k2DmIezYVKt9
         8bRzhm0Wwo1DFTA7q6Uel/s/geSsWdV5WNLPv1RXvIqaEl/Ua4qipTfeZchA99fCXBFQ
         nJ+LErgl55ErAgox4plL8F9FZ/IXq8IJf6yZC4X6ZAeZyXICXdPX3uzXzdfxux0ea+v8
         n8k1caXykf72Wr3/Dl6U0N+zNui/qSaAqY3NcgIbD1Rz3NkGlNgFXvade9Ab7Z7QBLoK
         Jjp/3Od+itK1gKX9Y6ABUbNbKVANkGy1bqE0pRxkTL+wYmBA7hwRfTxE6K8hawAtm4AD
         p6JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeddzvp7Ifzlu1R2Sxtee6++wSoJWWKDLMHOsiRwqYekiHLhtp/cUxe54Uuc538jd8f9NgNpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+f0Kj+raSiIF5mbJ7DBL6hAWSgslqZlV6XUUC3aXGTDA2h+VE
	oX8FJ23LDSx3V3xfwIop2Nejk+LkOLE2HHUjMIv8VjFlLShWEkg+///lSmbvWjqVPEL4goEFIAS
	OG3Igy70VZ+hiExFV1Q==
X-Received: from pliy14.prod.google.com ([2002:a17:903:3d0e:b0:2ae:42de:7ed4])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64e:b0:2ae:3ab7:1545 with SMTP id d9443c01a7336-2ae82505e81mr96587345ad.43.1773022936417;
 Sun, 08 Mar 2026 19:22:16 -0700 (PDT)
Date: Mon,  9 Mar 2026 02:22:05 +0000
In-Reply-To: <20260309022205.28136-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309022205.28136-3-guanyulin@google.com>
Subject: [PATCH v2 2/2] ALSA: usb: qcom: manage offload device usage
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	wesley.cheng@oss.qualcomm.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, Guan-Yu Lin <guanyulin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D9E5E2333BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223475-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.899];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The Qualcomm USB audio offload driver currently does not report its offload
activity to the USB core. This prevents the USB core from properly tracking
active offload sessions, which could allow the device to auto-suspend while
audio offloading is in progress.

Integrate usb_offload_get() and usb_offload_put() calls into the offload
stream setup and teardown paths. Specifically, call usb_offload_get() when
initializing the event ring and usb_offload_put() when freeing it.

Since the updated usb_offload_get() and usb_offload_put() APIs require the
caller to hold the USB device lock, add the necessary device locking in
handle_uaudio_stream_req() and qmi_stop_session() to satisfy this
requirement.

Cc: stable@vger.kernel.org
Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 sound/usb/qcom/qc_audio_offload.c | 102 ++++++++++++++++++------------
 1 file changed, 60 insertions(+), 42 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index cfb30a195364..1da243662327 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -699,6 +699,7 @@ static void uaudio_event_ring_cleanup_free(struct uaudio_dev *dev)
 		uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
 				   PAGE_SIZE);
 		xhci_sideband_remove_interrupter(uadev[dev->chip->card->number].sb);
+		usb_offload_put(dev->udev);
 	}
 }
 
@@ -750,6 +751,7 @@ static void qmi_stop_session(void)
 	struct snd_usb_substream *subs;
 	struct usb_host_endpoint *ep;
 	struct snd_usb_audio *chip;
+	struct usb_device *udev;
 	struct intf_info *info;
 	int pcm_card_num;
 	int if_idx;
@@ -791,8 +793,13 @@ static void qmi_stop_session(void)
 			disable_audio_stream(subs);
 		}
 		atomic_set(&uadev[idx].in_use, 0);
-		guard(mutex)(&chip->mutex);
-		uaudio_dev_cleanup(&uadev[idx]);
+
+		udev = uadev[idx].udev;
+		if (udev) {
+			guard(device)(&udev->dev);
+			guard(mutex)(&chip->mutex);
+			uaudio_dev_cleanup(&uadev[idx]);
+		}
 	}
 }
 
@@ -1183,11 +1190,15 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	er_pa = 0;
 
 	/* event ring */
+	ret = usb_offload_get(subs->dev);
+	if (ret < 0)
+		goto exit;
+
 	ret = xhci_sideband_create_interrupter(uadev[card_num].sb, 1, false,
 					       0, uaudio_qdev->data->intr_num);
 	if (ret < 0) {
 		dev_err(&subs->dev->dev, "failed to fetch interrupter\n");
-		goto exit;
+		goto put_offload;
 	}
 
 	sgt = xhci_sideband_get_event_buffer(uadev[card_num].sb);
@@ -1219,6 +1230,8 @@ static int uaudio_event_ring_setup(struct snd_usb_substream *subs,
 	mem_info->dma = 0;
 remove_interrupter:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+put_offload:
+	usb_offload_put(subs->dev);
 exit:
 	return ret;
 }
@@ -1483,6 +1496,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
 	uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZE);
 free_sec_ring:
 	xhci_sideband_remove_interrupter(uadev[card_num].sb);
+	usb_offload_put(subs->dev);
 drop_sync_ep:
 	if (subs->sync_endpoint) {
 		uaudio_iommu_unmap(MEM_XFER_RING,
@@ -1528,6 +1542,7 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 	u8 pcm_card_num;
 	u8 pcm_dev_num;
 	u8 direction;
+	struct usb_device *udev = NULL;
 	int ret = 0;
 
 	if (!svc->client_connected) {
@@ -1597,50 +1612,53 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 
 	uadev[pcm_card_num].ctrl_intf = chip->ctrl_intf;
 
-	if (req_msg->enable) {
-		ret = enable_audio_stream(subs,
-					  map_pcm_format(req_msg->audio_format),
-					  req_msg->number_of_ch, req_msg->bit_rate,
-					  datainterval);
-
-		if (!ret)
-			ret = prepare_qmi_response(subs, req_msg, &resp,
-						   info_idx);
-		if (ret < 0) {
-			guard(mutex)(&chip->mutex);
-			subs->opened = 0;
-		}
-	} else {
-		info = &uadev[pcm_card_num].info[info_idx];
-		if (info->data_ep_pipe) {
-			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
-					       info->data_ep_pipe);
-			if (ep) {
-				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
-							    ep);
-				xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
-							      ep);
+	udev = subs->dev;
+	scoped_guard(device, &udev->dev) {
+		if (req_msg->enable) {
+			ret = enable_audio_stream(subs,
+						map_pcm_format(req_msg->audio_format),
+						req_msg->number_of_ch, req_msg->bit_rate,
+						datainterval);
+
+			if (!ret)
+				ret = prepare_qmi_response(subs, req_msg, &resp,
+							info_idx);
+			if (ret < 0) {
+				guard(mutex)(&chip->mutex);
+				subs->opened = 0;
+			}
+		} else {
+			info = &uadev[pcm_card_num].info[info_idx];
+			if (info->data_ep_pipe) {
+				ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
+							info->data_ep_pipe);
+				if (ep) {
+					xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
+									ep);
+					xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
+									ep);
+				}
+
+				info->data_ep_pipe = 0;
 			}
 
-			info->data_ep_pipe = 0;
-		}
-
-		if (info->sync_ep_pipe) {
-			ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
-					       info->sync_ep_pipe);
-			if (ep) {
-				xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
-							    ep);
-				xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
-							      ep);
+			if (info->sync_ep_pipe) {
+				ep = usb_pipe_endpoint(uadev[pcm_card_num].udev,
+							info->sync_ep_pipe);
+				if (ep) {
+					xhci_sideband_stop_endpoint(uadev[pcm_card_num].sb,
+									ep);
+					xhci_sideband_remove_endpoint(uadev[pcm_card_num].sb,
+									ep);
+				}
+
+				info->sync_ep_pipe = 0;
 			}
 
-			info->sync_ep_pipe = 0;
+			disable_audio_stream(subs);
+			guard(mutex)(&chip->mutex);
+			subs->opened = 0;
 		}
-
-		disable_audio_stream(subs);
-		guard(mutex)(&chip->mutex);
-		subs->opened = 0;
 	}
 
 response:
-- 
2.53.0.473.g4a7958ca14-goog


