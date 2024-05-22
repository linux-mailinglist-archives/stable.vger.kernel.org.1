Return-Path: <stable+bounces-45548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B28CBA22
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 05:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DAFB21265
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 03:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195470CC9;
	Wed, 22 May 2024 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="keZGPWzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79081103
	for <stable@vger.kernel.org>; Wed, 22 May 2024 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716350344; cv=none; b=dBctzDWFZMW+SMasu16qo5V5v1QuIBwWhNl09Eg3u4S+WuOh7Ls58T42RRcxQDbHcwYWY4tadsa4pLLy+908sdPYvssJqDj10YYTc27c372w7MrzU3yGjJdkr2ArQgNj7UdGFBGCVcm+Zm2agN0m5rh1VU/bjd5E66CMRN6qtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716350344; c=relaxed/simple;
	bh=tmEP58P4hyfvScHIXrGzsH5ujX/7NMB2KTOEDdQWtZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky/ExTVMJF/KNpiT+k1PWdOySmePrvLlQqeXvlFiP57UcUcLBj32aZsczo+2XhmcxX5MQNdVJR6v9tb+ROIhQf8IIVdlwXNv6uJPsubojV/zT2KwALhqUXb/C/Hm4LgbCWV1xZ0cFYeqD6GK5ZGxY1jI0eNTIXh/LLXdX1xrdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=keZGPWzx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E88B400F7
	for <stable@vger.kernel.org>; Wed, 22 May 2024 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716350334;
	bh=y255971hrLvTqQBRybQowt2FPyNyI3D6Ajai4qb3uTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=keZGPWzx8Rfvdtr3d7qH0lZ6uwm6CFvmytb1wCVD1FdfCYXsSewLc400sgArajFN0
	 6H9jo9FCiX5AN8BKGmNRrNspt+GRQvt23LzG9q42lcOCH6sJV6FcDp0RGD3IZjYYFX
	 Xpj48qRjJIQQdhpzzjLK6DkTKeWOSxkCgapjUipHYjr/C5lSWms7WJ1+QmpB5NAdyQ
	 z3jlR/umEjZoDgTNmpI+GXW/zsyjMonh2sm58lt3662hbzeigYLNYm0Wl7qAb8K6RK
	 o7TJJDUUJrX+Kmuu+3+kGq9/JkkSthFAZJmvCb8ZFaRYzrJFSXaWkUDNzn2uFrkY2v
	 91K0m6HudR3eQ==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so11977317a91.1
        for <stable@vger.kernel.org>; Tue, 21 May 2024 20:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716350333; x=1716955133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y255971hrLvTqQBRybQowt2FPyNyI3D6Ajai4qb3uTg=;
        b=iTWJB9EJWU3EFj3vqT4iTaFldx4SE+BJtcgou8m8a9XKY/X6UwzdfIzEJKJty0Iy6d
         bXphqFcp+DtGyOspyuFMHg1jCq/qgbQAaaCxMNfeSw9vG1dSG2uHgjhRZ7zaoEwBtmWZ
         Lh/iLAfycO7NDdr3TTmrsryv17t+XYk6EAYsPRunLDrKPADqEOSNcD8WE9tNxlLhPkM2
         zx6YaKep4Av6XeP+Sp9bfH3C75yakMiNPzXxAitJzoPN9e1qztrP0ygJYO3coaynobrf
         fwDMYDG5TqDaMcZEJOIaB8HVoAyF94iDiPuWF/SjgE6uirIYSGTJ4EXCNTnhSh6vB4Ql
         6DJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqDJUAFOlUDMonFix250GJ7b9FIDftwaJm/xyh9dQjtcHq0XFyujfgTXwZghqdzwEb+VinJCSUbVwAVGZzel8pZva20FIr
X-Gm-Message-State: AOJu0YxCLQkJEy+pX5Vj18a9nh4BcDpX8qn3TUlUZXbmcagDlC5vbW9I
	1CATfoep1qfpJ342SIPh6LU4y0JMcHkfhLYS3xYtGRK0+sfD3D5/gsyvGT3j4LCR6fnUwXjGpr+
	9EFoadSes4WEt+Hoe03qbpMZ4nMBDt18uTVO2lDjTrcPimP5ZW82CjovcvMvJb/LO2ytajA==
X-Received: by 2002:a17:90b:300f:b0:2b4:32ae:8569 with SMTP id 98e67ed59e1d1-2bd9f5c3967mr904847a91.40.1716350332963;
        Tue, 21 May 2024 20:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD/+WM1l2z4SYoyQiK3JqFZu/WsAd/TrCmOzd57x6dSe56cZF/FUxVYi74CU90QsGVkD196Q==
X-Received: by 2002:a17:90b:300f:b0:2b4:32ae:8569 with SMTP id 98e67ed59e1d1-2bd9f5c3967mr904835a91.40.1716350332507;
        Tue, 21 May 2024 20:58:52 -0700 (PDT)
Received: from localhost ([122.199.27.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd8abf5013sm3399077a91.3.2024.05.21.20.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 20:58:52 -0700 (PDT)
From: Liam Kearney <liam.kearney@canonical.com>
To: gregkh@linuxfoundation.org
Cc: Liam Kearney <liam.kearney@canonical.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	stable@vger.kernel.org
Subject: [PATCH v2] crypto: arm64: use simd_skcipher_create() when registering aes internal algs
Date: Wed, 22 May 2024 13:58:37 +1000
Message-ID: <20240522035837.18610-1-liam.kearney@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arm64 crypto drivers duplicate driver names when adding simd
variants, which after backported commit 27016f75f5ed ("crypto: api -
Disallow identical driver names"), causes an error that leads to the
aes algs not being installed. On weaker processors this results in hangs
due to falling back to SW crypto.
Use simd_skcipher_create() as it will properly namespace the new algs.
This issue does not exist in mainline/latest (and stable v6.1+) as the
driver has been refactored to remove the simd algs from this code path.

Fixes: 27016f75f5ed ("crypto: api - Disallow identical driver names")
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: stable@vger.kernel.org
Signed-off-by: Liam Kearney <liam.kearney@canonical.com>
---
v2:
 - No changes
---
 arch/arm64/crypto/aes-glue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
index aa13344a3a5e..af862e52a36b 100644
--- a/arch/arm64/crypto/aes-glue.c
+++ b/arch/arm64/crypto/aes-glue.c
@@ -1028,7 +1028,6 @@ static int __init aes_init(void)
 	struct simd_skcipher_alg *simd;
 	const char *basename;
 	const char *algname;
-	const char *drvname;
 	int err;
 	int i;
 
@@ -1045,9 +1044,8 @@ static int __init aes_init(void)
 			continue;
 
 		algname = aes_algs[i].base.cra_name + 2;
-		drvname = aes_algs[i].base.cra_driver_name + 2;
 		basename = aes_algs[i].base.cra_driver_name;
-		simd = simd_skcipher_create_compat(algname, drvname, basename);
+		simd = simd_skcipher_create(algname, basename);
 		err = PTR_ERR(simd);
 		if (IS_ERR(simd))
 			goto unregister_simds;
-- 
2.40.1


