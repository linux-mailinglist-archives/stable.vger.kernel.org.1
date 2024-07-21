Return-Path: <stable+bounces-60648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8A89385E1
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FC4280F49
	for <lists+stable@lfdr.de>; Sun, 21 Jul 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9419169382;
	Sun, 21 Jul 2024 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIkAz73h"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF1412F365;
	Sun, 21 Jul 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589704; cv=none; b=VZRfsWoE6TaDnbBxY4NYxxw2RB9yy7FkiFA28QNpeCAShxjfpDCkJ0LGHA9mGVpzNMOAR9ahqAPlV7nZsblTFBlJoIG83qDM/NtKRqXc+iXOaHDXBcHvVGYs2bocJQx4dMRgaK/kcUcS9P9Gtb9HaKwqhwv3DstG8x48+tthPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589704; c=relaxed/simple;
	bh=4GELLVQrg4Ntcja5OwSVGHIZH1ApO5eJrOSaSjerjbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dix1qPaQ5AIBnOmTwkgvr8NC6BaTGRtWj8yt0+aK/ARjbt25POvr4he7/gLIfwyN6zGoiK7EkXSWEVgNA2+h/0B+jo14ZcfJsXVkjeIt1nUxWbY0N6Xtu1WNeb3sUWq76wdz6V/CDoWhgfihHLQpmoSuOM3xFPUb2toY6vP+6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIkAz73h; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7b28442f9so31097946d6.3;
        Sun, 21 Jul 2024 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721589701; x=1722194501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BW8O7zO4LyicyWVlwS/XaS6Chd2z5rZ+4N2xFS6fnVk=;
        b=IIkAz73hZXZA2BYKxPJ8/kGjZ4hIYnjj6fhBnjGdr8mLmhHKSewu3R6yr2HBQ5bjON
         S5h1L/QhzCAVRSoHWcp0PiaEr+yXOthEHZb3Z72cIv3vTKsGidDZDZ3AGvwYH+qAs01w
         CyOuC7r5/EEwfbtIZPPmgaPGlTIPDXia7bSsoyEADS3w7WRv4s+pQY8IO2LIVb5+vOAP
         VZqXyvQfODoedYjuQmwmvD5G3qY5Hte//MQ6ZK1Hu0GgljgVCAb1+pFg25Nz16AMBpov
         9mDfdrabQOfMAqGhdwozY7f5X5ptnVOMpglCZb/Km4XPV2Hf7zNvlRJ7xrmUnaPJlvQn
         ns0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721589701; x=1722194501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW8O7zO4LyicyWVlwS/XaS6Chd2z5rZ+4N2xFS6fnVk=;
        b=UZpaf6HojJ2evgN2P4Nf9HT7sRggUUGrOmhFTWAcb4ICJlqh4YqQyGrkuM5R5jBARm
         FLc/n2GYnKIQcVwcZ7ZAkiXvy93GSVtyiQbDZUTGNG7hjCy6PMe4kemNIjnS30nzs+tf
         YVfMUJh0BlsBLXwoQ5d6WjAO40kfO/WKh2bXwgAd+H/DGxG62JtAA/IZS5zo764y7fnf
         Ko3/HVNB74Q1fpSQ+QK5UGPrJmlOTivytlzNHpCHaPjqI+cIjXvjJiEbVM2Exn68/GE9
         BhXaftM7alA5pUSHeBRM0Jx7z6KS9DxMZaCo//7LDYqmV0XfodMDEQn/thQLYtKGUiD9
         daOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOs+T6RCyucEUrcmybZhoHuVaM016LcP85m0cXBIFOvYx8xtby2ekfyU+j0I8bhCUKnLhPmt7XTQpS2XSdfVtyBe+qtII6hGRphTVVFHtnEiovtOKljTJmNQ7bo5N2QZudTcmQ
X-Gm-Message-State: AOJu0Yy+ws7pCu00HUMB0wAMl7oGqS0Kf2gtXgaLxHNxBPKDzNqg8f6J
	g2T0wvfFgaProdczDVBAwTJwdoCcEO/ZLGQsqV22F/iKMxM2A47yAQiDTE+Z
X-Google-Smtp-Source: AGHT+IF8619f8ML2OMfKABkan+2zHPgb5pYQtDvaO0+bRB/243L3oM3Z75OsPtq+mPZUin5OHZnkRQ==
X-Received: by 2002:a05:6214:5096:b0:6b1:e371:99d9 with SMTP id 6a1803df08f44-6b96103ac4amr72881226d6.8.1721589701487;
        Sun, 21 Jul 2024 12:21:41 -0700 (PDT)
Received: from localhost.localdomain (syn-104-229-042-148.res.spectrum.com. [104.229.42.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9c447dsm28659926d6.87.2024.07.21.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 12:21:41 -0700 (PDT)
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
Subject: [PATCH] usb: gadget: core: Check for unset descriptor
Date: Sun, 21 Jul 2024 15:20:49 -0400
Message-ID: <20240721192048.3530097-2-crwulff@gmail.com>
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

Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Wulff <crwulff@gmail.com>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 2dfae7a17b3f..36a5d5935889 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -118,7 +118,7 @@ int usb_ep_enable(struct usb_ep *ep)
 		goto out;
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
-	if (usb_endpoint_maxp(ep->desc) == 0) {
+	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
 		/*
 		 * We should log an error message here, but we can't call
 		 * dev_err() because there's no way to find the gadget
-- 
2.43.0


