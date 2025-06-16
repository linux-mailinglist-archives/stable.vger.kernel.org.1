Return-Path: <stable+bounces-152709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42E2ADB1A2
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35D516462F
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCA2D9ED8;
	Mon, 16 Jun 2025 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRShoROl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5120B80D
	for <stable@vger.kernel.org>; Mon, 16 Jun 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080105; cv=none; b=D5CU8zndpK2U+qpeLZt+nJcJUWKMHEeXDHu78aK72xHQMeZEFZQaeJV4fsMEInIP/o/Y7TS9V9kFl+Nq26cpSc9bD0hgwNuhYjbRjO1QGgVpMfLgJcrDkDgoZyRcjrv8dPKM8MTCzGjmrev4bekuDQq8n6nXGbwxy6HdtZjC2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080105; c=relaxed/simple;
	bh=td7khtP98l7Q2qh50OlQWBKZ7UZjfxc2FqvRip6lP7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjbCSag1ATWH3iV9Q4+ljQmS89nv6j1urOrHwZ7Lwnh3GDzzKr2+aUExVmp9/3ZDYXLW2yQOa2tqOub7iODLv162TwW+WmTxt5Zu2WdpiyOCT2dGn+Qff4zMn+AjJtGw0kRbtKxZFtYWtNep4gvrDTdA3mHE/qWRfmz8I/BbVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRShoROl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235ea292956so39453615ad.1
        for <stable@vger.kernel.org>; Mon, 16 Jun 2025 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750080104; x=1750684904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=KRShoROlbn/dewHB7vNKCLOWaoC8J+sDvbl9Idxz3Nh1u9jqi1xHQt/Ke/Z31awrPB
         jqBkORPwUCRTZoKMSz1eCn1uWt6JuJH85JUr8Hz3r+zooSyTY+BU49/koyLOhPWLU15D
         LbeLiQEaMPVbgmphez5+7kCnemCf+oRAvMQiBOswaMSoLmAthqkkHE2j/vYbbGuBUJ6R
         F056uJFKntjk7gIWQ49nbiN+BrTxXRTIndDqhH3woVP8U6QHNsEcbzwAv3zLzcXBlj45
         /uyjaVDzp3WdvdA3xVtNlXlZW/sXX7BgqriZ2bHt8eUFT8DroBEC+xmyJ2RXtVMp8/Re
         jdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080104; x=1750684904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPykcaldmChQZHEMlm465r/ktpDt3VnqSSRAnP0PM/8=;
        b=knXm7n750T3gE3+NvJdS11nE769iI5R9CjwmaQHOPi8VrSqdV0Sj2lJrGkRlWSVw4K
         c5PTmeIiLc59bvPWgqJgmWRPXO9ZG/NsmUKh2AHCbuUqTTkBV3qUEqhhCypaBrYpqGVS
         EIvSY4B1KFeHJwMgCgUcFxjn9gBHdk4z+1MVjjNPFTomPh+aNDU5Kpjc22KIKUI+WxY8
         ylANa0PVj6HQMDGPkJP8ARZ7lZfFjHkPMfuPyM30evUqWptQdP5GI2Zwsrh1uYMmi2bG
         DFRR3y1UdTsC4c578O9NyPGDG//wzjkg6XRIKXZM4PXmpaqAO/DU5POZuEyWsrfmF0ns
         O5ig==
X-Gm-Message-State: AOJu0YyBxyFnOJNq75Xf+Uz5yCqOEF9alcLPFR+iYdtoDtTYk49hUaSr
	Y+tNxIiz7CbSxSHrikai8ycW+kHElEFLRQeDJ/nhByIUJshF/t2QuYNn
X-Gm-Gg: ASbGncvwGv7Zx8s0Cw/ylpCgoXKn0zx5DnpvJHNoGgJIU7PNEvQ0GXylSnv+NbCmSRa
	5NSqfLjXmQlZtjtOuEN1RSYusnhe0PQpdBHLw27wo1GY8C1eqfJMLYF1/ewW84gpQpf2pfZCtru
	Ptq9E1IBFHwxMAkHI5vBgKyL39/abQz/n1/OSX4heLXYDZMO/Aa5r92hVm/Om7JURMQQGlTDCaG
	VzsnFNCv5oktTdOXCQcC0IhgAIBCvboIPA3uoDI52EyYhqiv+6DHhP/QKBqjSX8qtQbGx6Bfz8S
	+WHslVw7/nFtOTJnYPlOW33J47grcz7EE7X6Q3pEWis71sR+7oPTwwUF7xwU/69E2ySi1g==
X-Google-Smtp-Source: AGHT+IGlbNCuFjB8NFM4vC3OJcZlgrl9r7d5vElHRB64tuTsgM6F4Z9k3bsHn/UKgwNuHXuc7yqLqQ==
X-Received: by 2002:a17:902:ce8a:b0:234:d10d:9f9f with SMTP id d9443c01a7336-2366b14e571mr147627075ad.40.1750080103568;
        Mon, 16 Jun 2025 06:21:43 -0700 (PDT)
Received: from localhost ([42.120.103.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca3a6sm60820515ad.209.2025.06.16.06.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:21:43 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: danisjiang@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] net/9p: Fix buffer overflow in USB transport layer
Date: Mon, 16 Jun 2025 21:21:39 +0800
Message-ID: <20250616132139.63276-1-danisjiang@gmail.com>
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


