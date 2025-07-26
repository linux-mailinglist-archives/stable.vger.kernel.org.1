Return-Path: <stable+bounces-164797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D28B127CC
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213B81CC6D86
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58F23B0;
	Sat, 26 Jul 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMX5UXVE"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDE7E9;
	Sat, 26 Jul 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488264; cv=none; b=Ai6e1D4F+MlqrmGhq5Nn/pRsLPe9bR5qaikWZyY9Z4YSTg445YiscuWOLaeTcggynwQ05MoFQQFQ8jwomavPU7gGq6+qkr2v+nATqh7G7f0OZc71lG+3tq/UhCqh911PSY+EQtY6gS1l2bAtZZuRT+7DUU9A2+VBKZEUFdcKJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488264; c=relaxed/simple;
	bh=tijO90f5V2+dEbHPsrjzz6aV8S4k/7RL7YfLEFSvJ3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9ZC+q/IZMIQxdVbADcOiKrl0K7mxaCAZYstH6tWGpQNJtRu/XtilWyD2FpugerriY+N6CnQb29RV5mib9FmDhhxTEZLN0J/4HEjHxHF1Eb5lT7K7OpkaHD25w/DWbfbF6TlFHgT5Hb6dMVRHgnN5tUZCOlxALsgQ/TrGwWlxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMX5UXVE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e6399d0656so129266085a.3;
        Fri, 25 Jul 2025 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753488262; x=1754093062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLeoKD9pH6YTTrPLKVP4AiqhElR/HaLlmxJaymwaLxw=;
        b=mMX5UXVEbaAxQooMKWO0/UDZCXL1B+84+YCLOnNtQ6ICZgADpwxniN0ufXWHrLXBOD
         /6MmmSoVy12tjxNvxCIKmIm287g0eMqgr0dZO8baIKtCgiaXlVKwNNjz2gqsGIV+hqZp
         o7sNjxAsitr+SsGZc4wKVoNdxzmAVmdVA+ujIDN7Uj4tXWtU89St98IiAP93vf+8M5VY
         f/oH+Dz7zXRlcbKATFTBBRXexciCuzi48a/DQ+DkKyThJNa6GUCGLs625IA/757UQwE1
         tOI5Y8EOZHAYzJ72oIkt8qqpJx5lcuC3J2zSUGKz3rRMZx9rp7IjcL9RNfrB1NxSLNaq
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753488262; x=1754093062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLeoKD9pH6YTTrPLKVP4AiqhElR/HaLlmxJaymwaLxw=;
        b=EDlc/qAEleAMr1kRbabghjWHgaDgOs5sycGcgvUOs7HooCnoYodIrrpVwN39fl+Ora
         JQN+NxKRHyY5dj2v32JrXb1Rl1cKAVPQcOPlDfsEYSXWfHRJFfiztyvmFpLcFexpjnUg
         dIy5at6tA2T9IN12WsJx34ZeOSRn2uL4KUJJ129odFik0yZNLbntGLWmFFcBoi4oc1Kj
         Ild/VRudAOvTIZo7MaRimBgTXNUPouBpvkrTO3RvGMHTrH7oj6iexygS7oz4iFAWZJEq
         0dB947472mqheaJgZloik/+0PJ4iLUXExsWXIOy7kCdrtTRpQmYd0V1YER1tp1m76/RT
         v7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKHOPkMJgm+9E82nVtA9fhdtWKdnfTTlOZCBUIYBpuHUxzuBry4xtej8xby2hlKLL16K5ht50L@vger.kernel.org, AJvYcCVQjNxGXcbE4IWGkz5VZCIYxdk/hV0wK6Z3jVzfsELVyjUgulvCz1NQD+bKhejoRKQRKJ4yE3Sq1TpYJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrn7OO3g09lg7IUc4ebexYeDnnpkWRdf7qB1T+m38Da//jzIaS
	629uPZT+C63nJgdPvqXUpUuFwkTWVm2CvKFnKATOu+1yudxJUid5tzS8WdTC1/kT
X-Gm-Gg: ASbGncujyTZLSVkunzekOJ+dRO4hZjrbX9xLZfenBSQtVe4QmB4AktCvnrXzN8Ynhnz
	qaTptUSUz3CUKk8dYCmKATnDT2nz9F9QYTlzA0ue6CfhIuPcKPwtzZJhW4Vbn+pl8mD2K2NvpR/
	z+cU4dqwV8q4x6vgGCgNAPuV5bAqrEvZdGvGnuax7o5xQVEXsJ7h4NAsoVYLLC1zCwBBLZAKW75
	U344dddfhmO322iAm1TM7V2yNaMrMEoQSgEcd81SHTBfZp1Bmhpra330inyDFmL1bmlUP/7Fhkv
	z80y1bGsTZSe8NYJcX/8wdXT9pK9Soic65T2aO3nwnYfECwxFyPe+Gnbnml7BqSIdQZvIGaj942
	sjf/FDRkQDwNaPvRB231z67IJsgNus51MOIdQJVpa
X-Google-Smtp-Source: AGHT+IG6l3WQqMadpHdNJpC0zSJGr9aB1wMhpvY2ZooIl9NLW/T9j82ReuKVTuQm7JeZ8ae+D6R92Q==
X-Received: by 2002:a05:620a:d94:b0:7c7:a602:66ee with SMTP id af79cd13be357-7e63bf69ba2mr563202185a.10.1753488261592;
        Fri, 25 Jul 2025 17:04:21 -0700 (PDT)
Received: from Latitude-7490.ht.home ([2607:fa49:8c41:2600:afb4:9d47:7cc2:f4e8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327b331sm53652485a.10.2025.07.25.17.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 17:04:20 -0700 (PDT)
From: chalianis1@gmail.com
To: andy@kernel.org
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Chali Anis <chalianis1@gmail.com>
Subject: [PATCH] staging: fbtft: add support for a device tree of backlight.
Date: Fri, 25 Jul 2025 20:04:16 -0400
Message-Id: <20250726000416.23960-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chali Anis <chalianis1@gmail.com>

Support the of backlight from device tree and keep compatibility
for the legacy gpio backlight.

Cc: stable@vger.kernel.org
Signed-off-by: Chali Anis <chalianis1@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a60..5f0220dbe397 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -170,6 +170,18 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	struct backlight_device *bd;
 	struct backlight_properties bl_props = { 0, };
 
+	bd = devm_of_find_backlight(par->info->device);
+	if (IS_ERR(bd)) {
+		dev_warn(par->info->device,
+			"cannot find of backlight device (%ld), trying legacy\n",
+			PTR_ERR(bd));
+	}
+
+	if (bd) {
+		par->info->bl_dev = bd;
+		return;
+	}
+
 	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
 			      "%s(): led pin not set, exiting.\n", __func__);
-- 
2.34.1


