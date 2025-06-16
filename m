Return-Path: <stable+bounces-152712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D48ADB1C4
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604DC16234E
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E223D2980B0;
	Mon, 16 Jun 2025 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XShyaIPv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F82DBF5B;
	Mon, 16 Jun 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080352; cv=none; b=fWx35q/kopet3zvWsVD1GE+m6428N/Sz5DNoy/gR4oG2EG/PAhUJbfmggeo/k5KfbVqoPkwKv6ucTR/tC3D4I3v7rDQfSSrxfHFtYTUpqtfrkRD3p7UD+ldHoLlcrHXNzJxfqcllGcZ2sQpu8xyFR4igT4zUkshsKNlL1ICodMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080352; c=relaxed/simple;
	bh=td7khtP98l7Q2qh50OlQWBKZ7UZjfxc2FqvRip6lP7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DATvBFFDmDkcBVJn39f2QdhzNmnrMgjyls85SgWvsWxMYg023h+JBJXcJ2kvXoU3rdIEqEkFfEKBVa8BBpZ3aREHfKRcjD9SOA9+G0p/dFWc0ByZrmS57DIDdl86hYAy0tbZboECrsigELmZMjG/K3rp79DuNfZj0l0PUygDzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XShyaIPv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7485bcb8b7cso3541467b3a.1;
        Mon, 16 Jun 2025 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080350; x=1750685150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=XShyaIPvNRM8Y2D6HDn7WEJxwP5n9mFlRhyC8p+8PebSKKfpMeqOzNQJjRZWM5T8o4
         461gTWfJEheFT/wj/aGJImHJjdrKB/HSnwrKt4kPnGwyLRXeuktLomjINshrZtReZBNY
         2ECCht29r5fBoV4eavAt9EaH8osgTxpez08yLqFr16kAX5UKyKHwbsRxpzT/Ir/e7rKs
         mphliHojSwAe9Sg9fFRT0w2mO619ul0jnJyVx7QOVMjaYE8xfKHSEwTVEN0XubTi12u6
         ct5wQvmMcrO78LZZwvunIpoB0KVfyGx/EISp0yLQvpPsnBHXkb/kSP0US//Dd8gK3oFm
         +9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080350; x=1750685150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=WwnoHsHRkmrXs3ozbvJ0jvpxD4iMgnXiAsHRg1+/mTJMBCbpDvo8GJIMUteby9XGED
         +U/5cEjLXbWt/fvFPTFmfhJdaB+uI8/Tu+LKa3gsUzhVnx7TBHMFVkuKmZCneJtq5JzC
         DT37b2IyKk0XG2m1SqiWHnVNG06pbJdEsfR+YcH/aYs2k9PEwHsAoFw6YlHxvskGv9UJ
         BNKdBlJ/Ab6dDpNreYPsUIlH4ge7K0QFTZ/lqvu7OfaUrxqFWlWEjzBjTXHaSh/Qp+mg
         1LfX+aTVa5p+MGlvLV2f0Pw706TE3523tocJhI2Thwgswk859jM7wem4EUDX8qq2ltAE
         rY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM4aGlMWmjNDpTrOrnGx+2rsvta5C7/41uqj3tuSmIkil+v0ADaDjPOSRUGT6bREgNrAo0+TLCbRPRBBc=@vger.kernel.org, AJvYcCX2Zome2nyOxoE4qQoMRXgp0RT/qokn61WzuiUKoetBwVcR0UJ/TE5udEC1/QPx1AmsRSbzBaby@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBqHka7Mrm40Wq5I4kxfnCU1+48wTWIOg0xa8GimZFcg+oPSK
	VecBoaLCnFYph7+4dU811Zy7ZInG5lO+64Oam96WFYpBAvkED9jN0tYT
X-Gm-Gg: ASbGncsW2jQKQ3vnaoLh/ZYSJVaB6ldwsdc3uRv8Te/E+9Qv2UJBhUJfeNG/DrXgRKY
	mFBlcCkvn/ml1EAGuSXrHfb6mU5XPdDxWu7TINnU9zA0M3k0hs+EtYa3hm3tgqvDUCdDXrzcX+A
	o07tqC8EgWNY47EpaK1hAZW6NVyMsePu8Vjpmdlz2qZznyTPubh/nlx8gob45d8Zi4iXF88YgQd
	TskPfNjC0iAlS9av4EWrGU6I2g0qckK7nLdTpiibEvRwTKuj/MgDdTHXDnbkFfdtv2OjsKQSWVl
	MSKBZoxex0LX198xz+WBuy8f+NK2JS+uvhb0fvkB0e7mRpdWXxnAyUrm6zHXpGz7JUiN6g==
X-Google-Smtp-Source: AGHT+IGGC0yG9eWTrvC96f40RZCC+M7NlH4ZHN5h3TAKdLDn6BgEURju/EiL6fGQTx8qNnzcyUZCzQ==
X-Received: by 2002:a05:6a00:846:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-7489cf5a90fmr12310846b3a.5.1750080350538;
        Mon, 16 Jun 2025 06:25:50 -0700 (PDT)
Received: from localhost ([42.120.103.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffec9c6sm6750467b3a.9.2025.06.16.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:25:50 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Date: Mon, 16 Jun 2025 21:25:39 +0800
Message-ID: <20250616132539.63434-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A buffer overflow vulnerability exists in the USB 9pfs transport layer
where inconsistent size validation between packet header parsing and
actual data copying allows a malicious USB host to overflow heap buffers.

The issue occurs because:
- usb9pfs_rx_header() validates only the declared size in packet header
- usb9pfs_rx_complete() uses req->actual (actual received bytes) for memcpy

This allows an attacker to craft packets with small declared size (bypassing
validation) but large actual payload (triggering overflow in memcpy).

Add validation in usb9pfs_rx_complete() to ensure req->actual does not
exceed the buffer capacity before copying data.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 net/9p/trans_usbg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef..047a2862fc84 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -242,6 +242,15 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!p9_rx_req)
 		return;
 
+	/* Validate actual received size against buffer capacity */
+	if (req->actual > p9_rx_req->rc.capacity) {
+		dev_err(&cdev->gadget->dev,
+			"received data size %u exceeds buffer capacity %zu\n",
+			req->actual, p9_rx_req->rc.capacity);
+		p9_req_put(usb9pfs->client, p9_rx_req);
+		return;
+	}
+
 	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
 
 	p9_rx_req->rc.size = req->actual;
-- 
2.43.0


