Return-Path: <stable+bounces-83619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746E99B988
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 15:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC0C281B02
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E61442F2;
	Sun, 13 Oct 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meBkqQby"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B313A3F3;
	Sun, 13 Oct 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825174; cv=none; b=CgJna/XEvS6joHiqnv701F2GYTY/rFb58DmVX7rnwvfYpDm6bYrr9U2AJFRrbI2+0G7dKgvwFuYpbiZ5uMjhvoBU3OZ6UnYGfE5n2XuvXpyE2rImBUyqCJ5mVqS5/OoSP0BtpANvF9SEH7q2N3WIQCbmpSChaKT8Z8iUpy6UTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825174; c=relaxed/simple;
	bh=imJwvTn8esHVmVaH6iOPv7MKhJ9WHL5ZSsil2zvuWSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ThOUiAB+Uuup6KOf4px03CK+Mg/Vi5iRqPQjguyG+erXtnAteNxzXpakYnxRPehu4u1X3VxbMvIbNkwEOsaQyiooDR/jd4ke5aHEtO1/P7IiyoFi5CuKVBUZN3dEJzpMzaQ0OEOUNretA3ZYQfRMj8Uc++RnORTuXSrbcrL9iUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meBkqQby; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4311420b675so31115565e9.2;
        Sun, 13 Oct 2024 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728825170; x=1729429970; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suY/2H8hueSKUBUw9ZRaMrc+OKpEz6w8Q4R5zrdYRTE=;
        b=meBkqQbyhy51cu17TF2eokpbJJl6LUacsH9CmCCswuEl7Ru4TBXM+aUUdjaq1Siyw0
         cDDfcTW/2V7DVA8TG2Rv4pUPspSF4v0DjGaLvs2TeU+0e6uvcwkVWm7NqHUDIqXEqSEB
         ckNqRe32zfPlyd4aDYl2bM/nHCv33beCBQZRVGn786OWKDjgM7OJPLcXXFD/f1mXmdN7
         c4tfqLazFELSZTGHlC4ITRnEL+nC+5zAQa/xEf0Bi7owZInhB0Foh+LKOUp2j1IXgNet
         c+7Z8t35YlnOXgIAzwz5WjNIjzn+WOWmWJuJDacUV/ibGXswZOOMUDaW9WHkixbJGa9e
         IopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728825170; x=1729429970;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=suY/2H8hueSKUBUw9ZRaMrc+OKpEz6w8Q4R5zrdYRTE=;
        b=nwYeumwJq86e/pJLuJoemHrVgT4AHxl8gbFOULGLRtTpoi+/BNMJWnndgakcUggKZ4
         qgh1uSvkFYQq+yah1mpl+HkBYZj39p7ydggjEERnSPnheyt2xei+wX8b1e9/BDLd8e0X
         dZcdCEZHhU0ZRcKdWPuX+SWInrWa9vgxJt5d7ReS5ZxOPR4bvu/vJ386hrkiGR5vc3D3
         vqGTwAxkF03giZnYZvLqB9o2m5+RBTlgehZlCIrAQ1OpEqxrOzo3gW4HJuNmDK4dZOsY
         ochoOiM8tjCzlURFfwaGVszdLk7OJzmvO80a33A9GhyApttFNu5WNcEg/vfBy8qEXJT7
         4KOw==
X-Forwarded-Encrypted: i=1; AJvYcCVyEcReY5NqrehecjgRc4jMCfRnC4I2vyQKc/dnxt0YejqEriyYdURMSjElJJhCE8Af5rNDTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTxStK/5gPxiWpAXDL+Tt0EARYE126+3uugtTK7zfRyA38WFDh
	ocPdZ5YNPtMrizePrd+HHVku8vzD6i7mUT9hOt5dIiz7Vc2PEf2Gd8EsxQ==
X-Google-Smtp-Source: AGHT+IEn4WImeKR5Spxn6p0ECrKDLf6d/5FCshKSGgC/ecVa/rR74PuSjID0EHcgTqD9QG9RCYtMDQ==
X-Received: by 2002:a05:600c:1d97:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-4311df1e4f7mr78115495e9.28.1728825170463;
        Sun, 13 Oct 2024 06:12:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-a034-352b-6ceb-bf05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:a034:352b:6ceb:bf05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7c56sm93068405e9.7.2024.10.13.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:12:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 15:12:46 +0200
Subject: [PATCH] firmware: tf: fix missing of_node_put() in
 of_register_trusted_foundation()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-trusted_foundations-of_node_put-v1-1-093ab98614ac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE3HC2cC/x2NzQqGIBAAXyX2nLD2c6hXiRDLtfai4erHB9G7J
 x0HhpkbhBKTwNzckOjHwjFU0G0D+2nDQYpdZeiwGzTqXuVUJJMzPpbgbK66qOhNiI7MVbIatgl
 H328WcYJauRJ5/n+HZX2eF/Xe891xAAAA
To: Stephen Warren <swarren@nvidia.com>, Tomasz Figa <t.figa@samsung.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728825168; l=1169;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=imJwvTn8esHVmVaH6iOPv7MKhJ9WHL5ZSsil2zvuWSQ=;
 b=bBgCwrtnA+kLxffKgT02gSjFkElsKblKK2tUQ+uj2mwPq+Fw5bQ2iGeurFh/zYF0ITh31KO1w
 CS6K/8ZFuvCAPS8vuCfRcensaJMZnRUsuAg7K39mPtywZu2rUd1Qhxr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_compatible_node() requires a call to of_node_put() when the
pointer to the node is not required anymore to decrement its refcount
and avoid leaking memory.

Add the missing call to of_node_put() after the node has been used.

Cc: stable@vger.kernel.org
Fixes: d9a1beaa10e8 ("ARM: add basic support for Trusted Foundations")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/firmware/trusted_foundations.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/trusted_foundations.c b/drivers/firmware/trusted_foundations.c
index 1389fa9418a7..e9fc79805c3e 100644
--- a/drivers/firmware/trusted_foundations.c
+++ b/drivers/firmware/trusted_foundations.c
@@ -175,6 +175,7 @@ void of_register_trusted_foundations(void)
 				   &pdata.version_minor);
 	if (err != 0)
 		panic("Trusted Foundation: missing version-minor property\n");
+	of_node_put(node);
 	register_trusted_foundations(&pdata);
 }
 

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-trusted_foundations-of_node_put-4b905f3ba009

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


