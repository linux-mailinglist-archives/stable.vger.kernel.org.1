Return-Path: <stable+bounces-200188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA288CA8F3D
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7BD8302B336
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6A364766;
	Fri,  5 Dec 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbvNVe8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B60362AAD
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960647; cv=none; b=e+//Hl/H3FzLpt0CSHbQFauIAZrQP7Xdh32wOTNhlbdE/g5JjE8MtxYZ6YD5F5vTQGic5Artz/1cNCzdAtCa9Wt+9PnEt1LeU2plaqnNv9IdECr6TiDCrUJ6IlC9UYjWsueLUX7gsNs4y88NToZV7vn9pCgQPETdvwv3g28oHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960647; c=relaxed/simple;
	bh=wVWV9v2dndzW9G7C9zHZu6Hf5HnBKJQnlI/RL0C9pFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqrHgYR8G2spJ0+tSWYi5G2XijMFGjlrrMONTLDQ/dCk/hGBTv4b5TnpuV/a/R6jSUiwS/nEZVyIxswYTNM3ys0BU9Mp5zdssBWMA+zrLpTSdYDjOvlnTQDiZ/2aHbtSFJ07u+k/7GUTHCPxfi+P5NiF/RXlp/xJDLeU9HEsHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbvNVe8a; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78a712cfbc0so28598727b3.1
        for <stable@vger.kernel.org>; Fri, 05 Dec 2025 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764960644; x=1765565444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4FC9ZR4LnrPLjRGT6F+4FkLOaJCr0tyBTJeZVKrvaQ=;
        b=hbvNVe8aqZDkvqvIbTrt6cul8beqitob7GEz+4k6EmBOieS6v5eh9kHLQ58cIYLwRy
         OUh6FGF0dbzagHa1Yd8uHOGyjLn/GjxNJ+K2UnjKjQuUbIBU5c2ILTrnqQn9sfwPS9X/
         K2g/t9a1JjU/PcF9VgbrSDUPOZEvFU3aAz82/Mc5I4TRS9al4T7Ck7T5rOn+7WXRaaIS
         LX4kd/UgnG9jPSfg5WbQfNpmCl9u4DWPsMaDJbzsqutkzPyU+LOzmfz/1ppu7oE1K6Mi
         OGkD+5xlj8aCVVJ9ZF1wgPWuf3luoctXwb5+b3XaXKtXNj6O7fhrXqHN2eKc1N0KzxBh
         cpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764960644; x=1765565444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+4FC9ZR4LnrPLjRGT6F+4FkLOaJCr0tyBTJeZVKrvaQ=;
        b=BpzmlDC4Yoq6jU5sGthSsjtLcsMpaQ2nc5Az42NQqyytgzdfyELwsnKlRh5PnZglKi
         YckDaoEJtY3vu66CPdVrxQB9k6Fz9HF8gU23VXdeXQ+tOfvmwkjFhWdanUgw4OFNwlPK
         YLxAxbDA1fpvDeIaK2d0qednYhT7BLH31eFKy95aw5o5qUv3u1HTEKJNU+9mU/miINd9
         uNJFaP1UfMbBIOD0yTjWa+mxMDM7Q8IUTXuTgbhFrhKQSkkT+GAb0Cdf3fosI7Jqky18
         iS/BAYSYb1AaPacG5mJ2T8axjT37wMm0u44Vy70Ekzdm2bBRawqzBUhrdJ+rc5TnYeoc
         8afw==
X-Forwarded-Encrypted: i=1; AJvYcCUDwaTyrc0h5lf8yi5CrzAeGea+bck2/5oE9pRGd/SotW2b7aMHZmMRc1tzozh9i56Pbvd3v88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxYuagdDJLYiDZqBvOQTjEh23w5gl/ZcfcYSTwwwRSFllbX/w
	BSNe/wfQ1ufc51TDjkgvHMsTCjqJMiusbCSAtBEzzmf+ePR5uDHmXUBf
X-Gm-Gg: ASbGnctngroxJom9+isZW7niu5/K/zB7iRISbXjQoMZZ46vw8Qt/lRxk+g9J0XnoL4n
	dMKGjSTRBb/sr9YF6kf/gWffxKwvFCRsMCqYi+mibLD6cvRcAFzo+7mk8iXB9g1KaU4ZJSgnwzc
	rrYMAMJVwjlwN8tyhx0bIa0yrnlDXVKp+gQz62S3pHe3igXZTvd5jH6q8H1feTji1O0cHNnlgPh
	A2MV3BvJk18G5J+2QcRUIl3OX++O9e/Q4hTkmKAZl/BtxvEC/elG+EyORQpJ2InUQCpskEoXvOZ
	NiVVOZmUREHWwfo0OZRsZDK8UzmiuQ6v5vs2ErqnFk29B+Bie4vuAyuo3R7qaWYuRugmcu4NxIH
	dqrP0KmAOz7pHjUlXQeUOBFQJ4bh07WcgVQF8uOVfd0YBRLpa03ChyybkgYBvJMvShEckcOeRFg
	oI526GWWXiy1kl
X-Google-Smtp-Source: AGHT+IHDnDPvUbYlQgcriJvfjhySPybGA4/BWIL9b6ubFJhIXF54dFxJRTUU+VR3u85g8j4D/Pioig==
X-Received: by 2002:a05:690c:6982:b0:78c:2a2e:e9fa with SMTP id 00721157ae682-78c33c1612emr843437b3.32.1764960644095;
        Fri, 05 Dec 2025 10:50:44 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c2f0aaf83sm4586407b3.32.2025.12.05.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:50:43 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 05 Dec 2025 13:50:10 -0500
Subject: [PATCH 1/3] platform/x86: alienware-wmi-wmax: Add support for new
 Area-51 laptops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-area-51-v1-1-d2cb13530851@gmail.com>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
In-Reply-To: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=wVWV9v2dndzW9G7C9zHZu6Hf5HnBKJQnlI/RL0C9pFQ=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJnGmg0mC5S4r26qK3v/SPf5xYCQ0xM0XSSMcs8q/y755
 cdSfsmoo5SFQYyLQVZMkaU9YdG3R1F5b/0OhN6HmcPKBDKEgYtTACby7QbD/8TA60qv5t/3OTN/
 5hYb4ef5Dbp3l5xsazi0NbLu/9/g3z0M/4MmNLrM/dy07s/kzzf1tG+cSSmdaxy8aF3Us3m68m2
 LnnIBAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add AWCC support for new Alienware Area-51 laptops.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index fadf7aac6779..b7b684fda22e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -89,6 +89,22 @@ static struct awcc_quirks generic_quirks = {
 static struct awcc_quirks empty_quirks;
 
 static const struct dmi_system_id awcc_dmi_table[] __initconst = {
+	{
+		.ident = "Alienware 16 Area-51",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware 16 Area-51"),
+		},
+		.driver_data = &g_series_quirks,
+	},
+	{
+		.ident = "Alienware 18 Area-51",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware 18 Area-51"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware 16 Aurora",
 		.matches = {

-- 
2.52.0


