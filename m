Return-Path: <stable+bounces-8603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFCA81EE2A
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FC91F21C8D
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 10:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940692CCCA;
	Wed, 27 Dec 2023 10:26:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422B32C867
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9af1f12e8so616741b3a.1
        for <stable@vger.kernel.org>; Wed, 27 Dec 2023 02:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672790; x=1704277590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4o65FJnkC9p/TCL0v5JcDCQidzN/Zqv3crlLcp9q00=;
        b=AhKw6cT0myUZaBHBbq/+ES6g0iCZGEIMVtGhpdAMz/TG6SYIiX4VIQuyjFp1gZYca2
         /vpUXJfN1+h4ryPWMafRP0YtoUkHw1P9Qc2rQ1BhkxSn6OrEw8aXuHhlx/itLyMWjI0n
         pYpIVer9J03fxpfQusfmCYEnp4f+MeHGIR3RR6r1XrLm155gqmLpoVOa8fNb6FzxduGD
         jW+use823wjmj04vOo5z2ITt1B5bxy/lSXS7n990NsaALckNPyCefTMiT7bWKCzTkYJm
         rGpPV21ulbNRHrABPUmiBOcXzc4NPwBtrqz/IicFvYyoCtBDv+dyu4Ql+K7rXUZqkNkT
         HZaw==
X-Gm-Message-State: AOJu0Ywis0Hd7A0G4liGmYYg+P/n6PMshYW9xm2PuQslpU747cKZXsY1
	ydESbJUsjQC+lvTPdcC5kZJ7lKMULYU=
X-Google-Smtp-Source: AGHT+IF/P3HuEnheNUSaXLP67gmlj3eqDZ9C6Gq4BPNfQ2HJkq/hDYjEoBKWf2JPF9djBh8jJWFVJA==
X-Received: by 2002:a05:6a00:14cc:b0:6d9:950f:6919 with SMTP id w12-20020a056a0014cc00b006d9950f6919mr2862036pfu.63.1703672790554;
        Wed, 27 Dec 2023 02:26:30 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id v21-20020a056a00149500b006d9cf4b56edsm3588419pfu.175.2023.12.27.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 02:26:30 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 5.15.y 1/8] ksmbd: have a dependency on cifs ARC4
Date: Wed, 27 Dec 2023 19:25:58 +0900
Message-Id: <20231227102605.4766-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Omitted the change that has a dependency on cifs ARC4 from backporting
commit f9929ef6a2a5("ksmbd: add support for key exchange").
This patch make ksmbd have a dependeny on cifs ARC4.

Fixes: c5049d2d73b2 ("ksmbd: add support for key exchange")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..971339ecc1a2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
 	tristate
-	default y if CIFS=y
-	default m if CIFS=m
+	default y if CIFS=y || SMB_SERVER=y
+	default m if CIFS=m || SMB_SERVER=m
 
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
-- 
2.25.1


