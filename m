Return-Path: <stable+bounces-178810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AECFBB480BC
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338811892AE4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646029D297;
	Sun,  7 Sep 2025 22:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZqsX5yO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06929BDBB;
	Sun,  7 Sep 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757282800; cv=none; b=k9mTiqGiburfiWY5TRDEhs8zu+2L3YvggQ/j7kgQZVY7oddHYvX0N35Gav8toSpxuP1kc38iJ/bTblTE+pufBxtl94Eix+TQV7apDzNJWKXUiv1Blxy4t/t0ibTYc1qi1YTmxzKdUUnOTd1ZU/A6aD3n6WWS9G/x9Rgstm65PN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757282800; c=relaxed/simple;
	bh=PCMBASvQ5nOtVDvUdRsvZSJTMc7BZohzTqlsS7DSP98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vA/6Wl9BJ79EsVTePE4Y1EocitMfheeHLuuK+mKm/wzowy++RahPJRXf/vNTYu6fvaQipQtiq0DaxdW/ztlvnK0dl16AIn4bj8E1zmRCTjb5S29FzXa3W1GYJc+xnMY4fvW5JBy4fKVHCxx+3x9OTCeaMHz3+NWe7x2TBOd8MVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZqsX5yO; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54488e51c37so1491718e0c.2;
        Sun, 07 Sep 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757282798; x=1757887598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trvTyargdqGe7qp6lGj19gNt7RsGcGq8W9yuGZo/e9E=;
        b=lZqsX5yOH/unwVZFWVyeZISbKHCaNAg86+K4barscGZocS2fqI5XZA8ptYRgBgaIP0
         hZmwkJATJonBsjGVlj0XbvcLNFjkHxJozu3cM9qoGLo8Uz7VqN0GPgDUuTKFkGn4GrN0
         +ICS8atq+e/kgAofvIE4fCFf3Yfi2l8L4SgrS3EyuJ3qi407QjEHl9UYeteef4hGsX+6
         vHXwXNtkzf501eKysIrq/vl2wv2ZuXUxhosATQA6AmvFLXgGD3bQxV+nzrCI6SOoqLHx
         FvuYuzYzImWF38EBnWNzTeVQ2YQBPbf4LHHyicoppaKZYAdNe23Uwt+QgQDNnNxFRIgu
         EzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757282798; x=1757887598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trvTyargdqGe7qp6lGj19gNt7RsGcGq8W9yuGZo/e9E=;
        b=IfeBuYAxGDYCB0CP6IXobGkio2Q1ORk75PE2TMYMSI3slx6rwvu65mBl7FajVpVa91
         Cj/FE+FQu9zxHNA9q2JDppE3swxMXJ2acquYUJBr4uMUvLUcwT03XQv6eemB/g9/6iT/
         j0tBydYoEpnbknkwulOrEx5hgzmNIEjm6LzChztGHDwJ83OFAcmVV1e+IHxDHZXNNvzI
         l0J2MopstAvIPun4CQ0eX1Kamb9/tmbcgrbrQGLzG7qbZO7KzryS8r3ulitn+8shrWsR
         vxUJB06AH8rhVlqut8rJu6z995PZkXN5HcicrII9Q3lvyni9qkzUkTiqiw6UVVFCKVaf
         pfCg==
X-Forwarded-Encrypted: i=1; AJvYcCUcUTml0mVFd7zm6MqCaKWNcumzl02+WcuW8pd1immztUNtqvJSyBa+HmlC1oYKUjPnAEG/CtGpZJgV@vger.kernel.org, AJvYcCVU28dccs7zbJUm3tI3+KchmxPWdSlH11XiO8b9mWIYSgufuOXlLANUlTS2EVFWgQsThjxsvzlbnVNC@vger.kernel.org, AJvYcCVnVaUA/XTxGDi6LBVdcX7EMh+8XWFdKXZoopdUCDjCtNGQ/pwD9F2KMrmlEAU/pj1NulT0tZuPByZrcSY=@vger.kernel.org, AJvYcCXspiARmtoEW8OjjpRO8CEQXWcK7tO94z+lYSVCtEptUlNUGtmmNioB7hF3yOJUNONHcUzTJhGzndjB8pkX@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxdFYJPfc9fYOMMVMf6uPvJNM+8C9jXa/u9y0otSp+lRQYdAj
	LUCqCishHwQWf70f2PHdRdwj2rAkQzW7Tl7sVejAq41ORGJIV/WM9zcdAF6Omw==
X-Gm-Gg: ASbGncuH/QHzfajRtsUw6c0RjoAV0KFTkgr1htC3odeIk7unAuoOi8XO6yfaxoy/3fe
	dEs6fDTawtK4Yj3BF2ORkZ8F9O44BwUZZOQygTQsh61quJnp37SLJm/pqZIdyiHuCqUd529P7V6
	GhaUslQ52jGv9fk2wLeG/EtkVM6l7fhQm1bVj1Jl4shPeJeESqDU59dROtStSL865RvZ9SGpwdt
	NdUCgSsf+KSnVZuopzGGoJKMAMTgOI5GlPpX131RR5+0uf8c+3zHs76JeMyOLLbzSuGjJd+0j7W
	Ez/4kbHc1rsPBAR4BcxS423Cln0TsUbEuyg8na/BFNIZAdQ2H/peyR6+k9BX7LcVC8v+pV8TjDV
	9z3LRMGUeIJep4+yX1AUzYGTQt5yKbiO0IfvFQe05AklWxg==
X-Google-Smtp-Source: AGHT+IG380zKlRQnOT1qzsIHNnrDwf4hZiIYzbe1FVcruC1DewW0lseBiaAcrtBV+Nz+8LDVV+0yCQ==
X-Received: by 2002:a05:6122:1d44:b0:541:52d4:7447 with SMTP id 71dfb90a1353d-5472abf01dbmr1185433e0c.0.1757282797581;
        Sun, 07 Sep 2025 15:06:37 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449ed5a91esm10397004e0c.20.2025.09.07.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 15:06:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 17:06:17 -0500
Subject: [PATCH 3/3] dt-bindings: trivial-devices: Add sht2x sensors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v1-3-fd56843b1b43@gmail.com>
References: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
In-Reply-To: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=PCMBASvQ5nOtVDvUdRsvZSJTMc7BZohzTqlsS7DSP98=;
 b=kA0DAAoWFmBDOPSf1GYByyZiAGi+AebIUVVcBcfWeQq8fb6QW+U/Qj7IITzbQv3AFQlJhI2W/
 4h1BAAWCgAdFiEEh2Ci9uJabu1OwFXfFmBDOPSf1GYFAmi+AeYACgkQFmBDOPSf1GaD3wD7BUwI
 SeicKn1uRLDF9eJGDAu7lTuSvQ50tRvyNHYuJboA/ic43Zfu003PP3mYfJJOLNqCeIPHSZ1Trln
 ySpE682AF
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add sensirion,sht2x trivial sensors.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f81255141bdda6daf8e45369a2c2..736b8b6819036a183f26f84dc489ce27ec7d8bc4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -362,6 +362,7 @@ properties:
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion temperature & humidity sensor with I2C interface
+          - sensirion,sht2x
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312

-- 
2.51.0


