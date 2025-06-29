Return-Path: <stable+bounces-158854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3BAED0FB
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52BA7AA20D
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6D225403;
	Sun, 29 Jun 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZnBDNab"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C892BB04;
	Sun, 29 Jun 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228515; cv=none; b=Oc5zaeC96fqZ4TUXMPRwSbxJTthNc1B7EpWJNv5LJYPC9n3CPin2ZkCNB4OYogim5DSXaB8L/g8rXP4dI6Q1FLy+GqKToOwMJ2htKKcVj8C7rqTBD+Qhp5b6WGR51J2e9kB80VEHez2R7GkuV7+9/GWedTj8UAbK5wyq/jYp9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228515; c=relaxed/simple;
	bh=10NYvTis+ZoUDdKYTvYJpAMMRAFqChsF1l5t2Hsh7Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hp4y6V4Bto08c4lkIamaqvYA/mxfabkz+MKddSS2ydQ8EPeFcG3rfBNrn6suPcX7122lvCgCMfm2WQqC9dSLk56f9H1xHVI/AnijaNjo2l7w8jCj3xKsRDFmwRchqJxQVray6W1IC2CNjHax18aD/4lvtcCExLCgBm5WuNSEWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZnBDNab; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fadb9a0325so13030406d6.2;
        Sun, 29 Jun 2025 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751228513; x=1751833313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrGJhFj+uGvqfpm9hC0ZWZfkr1UzVV1w+QHF3h1Qi0A=;
        b=RZnBDNabS8OhpA0gN5KUBEIbWEM5rL7pTSS2aYg/WUrdaGs+RJk+k9MkGpFZLthjEw
         +Dkw2vyzh5bZKabQJqSYOme10jorwkQFKyt9REfMNgpr4RWzP9xtAGFcw1GkveR/aFja
         OWJVYjSev9IJFjnOgItYhD0Ekjeur5eq7rMdjZJDZAiUq0Ai7o0N7X8QvE0CpS0eJ+mC
         qu0b3velOzOn88m/3TcoGbnNWqtF/qbkfaU3F5NWR5QoimGInBrv0ImKk0yY6QsAp4m9
         TcZvT5010xz1NwNBIUWw22bM1wue5BzSyYiQyeEQ76tqnyK8KNaq+VcB4v/8zuC7BWb9
         hPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751228513; x=1751833313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrGJhFj+uGvqfpm9hC0ZWZfkr1UzVV1w+QHF3h1Qi0A=;
        b=NKuINORmNiEYVBnBr3+gECs+SKny/JbKbf8i/k46o8DtnpfyeVQNRyV6SmvNFHB4/M
         LLBVzsN19sAPpvlz2zEKrj0byaqGzNQDqdX57a7CxbxvyXEY1WAxND95oevW7dx4XtgY
         3ijq6IHTefifKDGELCsiXJMvm9AnU5JGTqngQhgTu5458+dAP95VXbvstF/q/cr7oeYi
         vSr/wfJUILcjsm/le0PYPYx8HQ8Bbxl96SQk70vwoXb3asKAiwYXR2sY+/gY3t8X2Wkt
         cnrAOHvg2nicJF8odo3Rf5OH2TXmWm2H97Hh86CKNTrNCAwg2cYcmW5J/bUEMwt7BbGx
         5Zzg==
X-Forwarded-Encrypted: i=1; AJvYcCV+8AuXGXTMvmUHFz3rI/PeVVgCxDDuMKQO122UpLFP5m/Jh0pmqKpm1w2LSHpD5aMFixeC88urFoIRfHI=@vger.kernel.org, AJvYcCVCXApE5U0HsKk8vD5MfPaMhoMJPU9nosM7GNCAMC/XT5D3eFWJYL3c2O5fGEFm32G6qiGGMUhzwUSw@vger.kernel.org, AJvYcCXsvMec9jU31WyGftIXecqBlTAaFnQbQxt01i6T01y45gn8IQGv2JSGkNXZqlrfhm6ijIzEC5DE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn867cvTJ5vCRArjfHBd3DMZWMCoj64koB8L74EITIfCysBEsF
	rOdPIdguG6YffezAYm2hqW6UxkPOvGH0HZLwNzC2RkU8pBBwUkn4iw6icWY3/IFYoEM=
X-Gm-Gg: ASbGnctYtoYOdIDRGswYvDYMR87bebrVzOt5VPPFh6ryz4VWZG8iP+TLdrPTgR3YaX0
	yzaScrGHiz1puhj1UCrdHKk8RL5tfR+YFccS63Bc6JO05xxGkw/ri6ERTq7S6WY6ZGVYr4Vzevt
	CyygPbgqdjbRKR+KG1NaG8fJyuExWUOGoHBJUscMSt8EMmM+g6ltkCDqLUtyBtICAcZA0wMhgB6
	i8oVsR0vORaLOP8KKc+srjU9wmIUe4hljirXdJJMGHMn1XflArekgyRxFOdIbPHZtujYuE26YDJ
	mWZ9yV9pL1p0Z5X/JsjpVMnsFxt8xHz8LoYKogtwLeVD8PZJJAQaUjFlDusah5BLX0iStmPGFWI
	yn/0t9esZxCJoUp2eeTbRqnpbKsBap3ZbafBa8of4Yaub9Ptgm/04ggQvNtVWIh6tqH5t
X-Google-Smtp-Source: AGHT+IGd/xUQwP5gbHH76+NGUezmhBGyUXege7Vdxt3LU36HCfGLt++qwJJ6/1sqc7j7v3unPZBieA==
X-Received: by 2002:a05:6214:440c:b0:6fa:ba15:e8d with SMTP id 6a1803df08f44-6ffed768083mr168190556d6.0.1751228512926;
        Sun, 29 Jun 2025 13:21:52 -0700 (PDT)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7730aaf8sm56388186d6.109.2025.06.29.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 13:21:52 -0700 (PDT)
From: Seungjin Bae <eeodqql09@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: pip-izony <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Jassi Brar <jaswinder.singh@linaro.org>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: max3420_udc: Fix out-of-bounds endpoint index access
Date: Sun, 29 Jun 2025 16:13:27 -0400
Message-ID: <20250629201324.30726-4-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the max3420_set_clear_feature() function, the endpoint index `id` can have a value from 0 to 15.
However, the udc->ep array is initialized with a maximum of 4 endpoints in max3420_eps_init().
If host sends a request with a wIndex greater than 3, the access to `udc->ep[id]` will go out-of-bounds,
leading to memory corruption or a potential kernel crash.
This bug was found by code inspection and has not been tested on hardware.

Fixes: 48ba02b2e2b1a ("usb: gadget: add udc driver for max3420")
Cc: stable@vger.kernel.org
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/usb/gadget/udc/max3420_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 7349ea774adf..e4ecc7f7f3be 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -596,6 +596,8 @@ static void max3420_set_clear_feature(struct max3420_udc *udc)
 			break;
 
 		id = udc->setup.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (id >= MAX3420_MAX_EPS)
+			break;
 		ep = &udc->ep[id];
 
 		spin_lock_irqsave(&ep->lock, flags);
-- 
2.43.0


