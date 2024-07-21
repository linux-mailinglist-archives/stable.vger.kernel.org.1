Return-Path: <stable+bounces-60649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FED9385E4
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 21:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7006F281101
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37845169397;
	Sun, 21 Jul 2024 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbKSq8RN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F103323D;
	Sun, 21 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589861; cv=none; b=Dj+bmTBgF7r+ubkdCj8oUDqgBoxUSvpTvloYvgJaPiJ8XZF/hbZD/6e/NyRud5e6R+P5Gru2KKVPnkMRFLjt1AGWHpLwvvRbCnWhfaCS6ATmvdPyUsWdcQdZi4TOkTGs2KkRXxNgZlnYfvMS+rhkWs6YyIdQ9/GTmweu99nPmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589861; c=relaxed/simple;
	bh=AqT35sDXJ0iu6yBNB7r+JGSv/gJJ49DhERq/qxLAwEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyETD0FrMyqGwjNaFKvOOLi608sDvQVZRjoS4O3VHIGZM6w9L3Y97xHY1XYPQunkYS1Aj17ZDcLO9r5+UIDuwn1EUtWKcbAidN/W6FEvYwGfNLIwB2mLXi5cxqA/TLBuLiEQPQRqoIhUqH4XPDVm5ufBUhipMFFTZJ2RFsxUOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbKSq8RN; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9400a1ad9so2077254b6e.1;
        Sun, 21 Jul 2024 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721589858; x=1722194658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKmyuILTI8ybEcidGG1vAPXbk+2J62QqKdMmKlVKTgo=;
        b=LbKSq8RNTHkDcUHKuGxf1Yu8NRGI4ZCSpkVQ2Vp1w0hpMjwzomrVrwYXz4Wgsm72oX
         yB9jY2NeGvIixHuzC+yOs4xIxnZlEka7ID3Ci2sVsTpBvK98yKzJKyVJt/1/OWijjemk
         tpDkxAPPkzIg/tUarJ8g/oOR3Dft5Meexcvp4j7Bt1M32KTKtTEHG86tRaZWM5dCmuuR
         EUbF7rz6Ijuqy4k8yG/kMkFrsIEBlXMlUWDkLn+9h6DWRFV2MfMEiYAR7FDNACihkNFv
         4O+JWxZklQhX9vPUQky7mQ/ZQOWb376PRWI5qIrGRs961hgOlvIoIr7xoHVuuC8jdZN2
         RQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721589858; x=1722194658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKmyuILTI8ybEcidGG1vAPXbk+2J62QqKdMmKlVKTgo=;
        b=Vh02Dl0dBTM9E18tP5EI/8Ydoi+Q7hYtSXK04Rb5m5bwIXiZ3i+JqEV8DmM3Qo2Wco
         HLDKlRNefmhvx32kI1DQ3PC1GmrCnhzMMqvjDN3F4KL0ojG61kbuTXySFtUlir2N1ORh
         up/1/YCYdKTaa1ZK86kjomNL2VW8BIqcTgHXP8Vm2ESub/WRGsHmrgCZOkSfbe7FXD4V
         PNJLM7QV2AGmxVrEE4vlBaGLpU+43fUXheOP/mQk3ELVtJacvqsYWSErxWC/+PA/XV3S
         BziAJdVjJIocOkxhEpBWWBfJ+PZBSzk/1ueQijTXQrS4DMzq7LV43rhh/RUhfjO7t6Gr
         qLMg==
X-Forwarded-Encrypted: i=1; AJvYcCVq04wJINDQVJF3bNxCrgNEq39IUJeHXnQsuUfO+1Qrg3qkkaO0FFoKctM1rycmsY3oOwTb+CjvLiqMjqlH35LvRIOFJiXrVTH876ID5U2Xfoi83HyO6e4bCL/TDzdc86ZRiHUX
X-Gm-Message-State: AOJu0YwN91WmyXSzXD2+JoBIFV4TR/XBDgOGalW60PekxRgjrh9xLo88
	DwSBll6vu12Vzu9NcPAwSdmQST92NvDxv/yLDqHZM/gn2s6VZfTNE3Nl6Wbu
X-Google-Smtp-Source: AGHT+IFyEBZY6FF+5xopCKyNITVCA+2JP4WlXSStEt/9clXjNzwlv/2shP7qekz//BAhjmlRhHktow==
X-Received: by 2002:a05:6808:1483:b0:3d9:2def:21b4 with SMTP id 5614622812f47-3dae5f729f5mr7840495b6e.14.1721589858090;
        Sun, 21 Jul 2024 12:24:18 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04062sm27277361cf.40.2024.07.21.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 12:24:17 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: u_audio: Check return codes from usb_ep_enable and config_ep_by_speed.
Date: Sun, 21 Jul 2024 15:23:15 -0400
Message-ID: <20240721192314.3532697-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <crwulff@gmail.com>

These functions can fail if descriptors are malformed, or missing,
for the selected USB speed.

Fixes: eb9fecb9e69b ("usb: gadget: f_uac2: split out audio core")
Fixes: 24f779dac8f3 ("usb: gadget: f_uac2/u_audio: add feedback endpoint support")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 42 ++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 89af0feb7512..24299576972f 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -592,16 +592,25 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 	struct usb_ep *ep, *ep_fback;
 	struct uac_rtd_params *prm;
 	struct uac_params *params = &audio_dev->params;
-	int req_len, i;
+	int req_len, i, ret;
 
 	prm = &uac->c_prm;
 	dev_dbg(dev, "start capture with rate %d\n", prm->srate);
 	ep = audio_dev->out_ep;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for out_ep failed (%d)\n", ret);
+		return ret;
+	}
+
 	req_len = ep->maxpacket;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for out_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {
@@ -629,9 +638,18 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 		return 0;
 
 	/* Setup feedback endpoint */
-	config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed in_ep_fback failed (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
+
 	prm->fb_ep_enabled = true;
-	usb_ep_enable(ep_fback);
+	ret = usb_ep_enable(ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep_fback (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
 	req_len = ep_fback->maxpacket;
 
 	req_fback = usb_ep_alloc_request(ep_fback, GFP_ATOMIC);
@@ -687,13 +705,17 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	struct uac_params *params = &audio_dev->params;
 	unsigned int factor;
 	const struct usb_endpoint_descriptor *ep_desc;
-	int req_len, i;
+	int req_len, i, ret;
 	unsigned int p_pktsize;
 
 	prm = &uac->p_prm;
 	dev_dbg(dev, "start playback with rate %d\n", prm->srate);
 	ep = audio_dev->in_ep;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for in_ep failed (%d)\n", ret);
+		return ret;
+	}
 
 	ep_desc = ep->desc;
 	/*
@@ -720,7 +742,11 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	uac->p_residue_mil = 0;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {
-- 
2.43.0


