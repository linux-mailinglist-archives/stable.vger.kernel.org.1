Return-Path: <stable+bounces-61330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33593BA04
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671CE28331D
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ABB568A;
	Thu, 25 Jul 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU8UwWDF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107601C3E;
	Thu, 25 Jul 2024 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869492; cv=none; b=MAxVOinL/qhaqg/cDYjj/4j0HvTi7nVU9bu5QSHwCRLol6ADnIW7iwyhOtaSTKvR5tH3AurxWQHAKicIH1IKtxrAWxwlMwXPzpBsikMyn7G2HOv1nseBuUP6DlonR7SSQ6AEqZFM8jAiNwC9ij2pJ8FEnaWnRSYNo2hBDZKLGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869492; c=relaxed/simple;
	bh=FkXvWEASoQIhCNphlq33Wn7fwiBAnfMa94Og65tuTRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hy/K6StKkU9SIDZk2wjRY10dVu5nUlVzFEEhVxI8y1FYi6C9e/NMbUKsQrUHvR5etn8WTcOwrc7N6EEM2gyay7JYS0AirJVX27fBmsN8ksw1LpJotIE6jBUa8vGt8YjDdADoFKNuRfbuIwQ2yRdAQwI2w4GLSeRUN3Nute48+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU8UwWDF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7aed340daso2814146d6.3;
        Wed, 24 Jul 2024 18:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721869490; x=1722474290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ftxgiMcVsRHqBNg513NU4w/TBI4ACJweLZGqoMyEGJY=;
        b=OU8UwWDFMCYawHyDTFhBQJE4d4ikDYOBCIDbF1Uz/5SSsSXoocMFCOrQT2GW9qy2Nc
         lfchJt44pfGjgvB8JTu2GfZYIyods/jalQAYMGWP1jl86fGoZEk0AcHF9uip9hv6TDuq
         bziepITsB5vvSr11QzCD03+zyT6G1lepa7gKpvSC7Hh5gLEV/omdrzEplz7DfpbT9FVb
         /Xtug6coae3opXJlwQGhK4y+5sapebeGG8HYOijpxqjlXT7J+JITQY2/KYqDc4Kcb3eC
         uQ7plow8deIGnL5w/qyDVBCBt7QZegL4pCNX820hbdwHljj2fIbI4lNY4LB/up6HQn1U
         ORaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869490; x=1722474290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftxgiMcVsRHqBNg513NU4w/TBI4ACJweLZGqoMyEGJY=;
        b=VnhVN1Xxar+lWRAPGIkX59KtsxHodT9fBex2T6M/Fw4vjKrh/ChmWQxo6srGgWYdAu
         xKxFxXH7TbtpkNT/xvudoE63S2dRYtb41YcOkNLjcsYEsESfPC2MWMpjLgiy6X1yOjHe
         QeLmH9V4xhEyQpXwJv16HZ9OtEhl0wOBnBmC4uQdyg5MgwYO1Cnxved7jbZIha+JhcAT
         tF2i9AF811AvpHeb29NTkQbj0Uite/obn1aeZZ7LTLxemjIO1B861EvgY4YlzvdgRViR
         qBYUGY4DxWvLuzdGdRSAUYBu/9fkV21BtLzt6thdtPMYTknKRI3KidGNggxft4AxNAZr
         J0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVGjiZWcHUGPIyMnFRQsTFaB7CrGtyp7oI3L2a5x9B/HBMVXiYMuF8S7zNkOQ7e2VgfTLWT28qozJmGMp6YR+HWHNNBtUOyzJZf1gfq8DlwhZ84zcG34W7yn9czV/CkfvTO+/sF
X-Gm-Message-State: AOJu0YyFzoZv112ToUGsFLUekvS+/P20qd8Ma7Fh32HxAzAv++3ebSlU
	oE6Zyt48YSMeDLSoBCNiFzoaPkJC5netb4xWxturvKUpF+sxALdAkAfTEcDU
X-Google-Smtp-Source: AGHT+IE40Pfj1UDlxcWl82G1k/qYKdOSuiSn6PQkuLZYq4uqxObjLVFvm9Mlj+KeBRgirPGwC7MxXQ==
X-Received: by 2002:a05:6214:2029:b0:6b7:a7ff:7b4a with SMTP id 6a1803df08f44-6bb3cad5a71mr17355406d6.46.1721869489645;
        Wed, 24 Jul 2024 18:04:49 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb12082sm1540246d6.143.2024.07.24.18.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 18:04:49 -0700 (PDT)
From: crwulff@gmail.com
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>,
	linux-kernel@vger.kernel.org,
	Chris Wulff <crwulff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: core: Check for unset descriptor
Date: Wed, 24 Jul 2024 21:04:20 -0400
Message-ID: <20240725010419.314430-2-crwulff@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Wulff <crwulff@gmail.com>

Make sure the descriptor has been set before looking at maxpacket.
This fixes a null pointer panic in this case.

This may happen if the gadget doesn't properly set up the endpoint
for the current speed, or the gadget descriptors are malformed and
the descriptor for the speed/endpoint are not found.

No current gadget driver is known to have this problem, but this
may cause a hard-to-find bug during development of new gadgets.

Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
v2: Added WARN_ONCE message & clarification on causes
v1: https://lore.kernel.org/all/20240721192048.3530097-2-crwulff@gmail.com/
---
 drivers/usb/gadget/udc/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 2dfae7a17b3f..81f9140f3681 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -118,12 +118,10 @@ int usb_ep_enable(struct usb_ep *ep)
 		goto out;
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
-	if (usb_endpoint_maxp(ep->desc) == 0) {
-		/*
-		 * We should log an error message here, but we can't call
-		 * dev_err() because there's no way to find the gadget
-		 * given only ep.
-		 */
+	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
+			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
+
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.43.0


