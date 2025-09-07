Return-Path: <stable+bounces-178807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB0B480AF
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 00:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35391757AB
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13626264A97;
	Sun,  7 Sep 2025 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr+VUqJq"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463812B73;
	Sun,  7 Sep 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757282794; cv=none; b=Mr/myONb7n99p9TlH7yblTsarDFxrsxs4tYH559886qKGQKT2G63frQbKkdpCO9tKQlX4Zt60g2qdVrLhyFB3byZwFDmWTb4saUb8fKbIl6Z+nVPbo47dgLJNufHgZUoPHrzLvT7oGCzYhwDMIxUgydE6J1A5I0h5PkxLDszTk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757282794; c=relaxed/simple;
	bh=qLRdvSJ8uiJiuRtlL7SuX80IfGmKXF9bpTRPiOf5o6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tqDP0l20VVQs/4AhDByfAV6qoaD/Dj+RjPCgvoirehrQmJBzLUnhovfxREPdM5UtzEQUJfBiU2byqpk9IPNssvs1Vb+okofNAYpnlj8qYqD9m9vlPFdfLh++xpSpKp2Xwr6GtVEuoQUmMaXAHFc5cDykyxm29wEPO+07dCZyAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr+VUqJq; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544c620d486so2643288e0c.1;
        Sun, 07 Sep 2025 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757282792; x=1757887592; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hptlqdp9b1MF6OhlNmp++9M2/f9tUuxlq06VT9Ialk=;
        b=Mr+VUqJqeYtyNmwoHIDvcgFpW+Dtwb6+TEjyONRyO9AB2O8s4IWz2drPmhRm0LzPjD
         KDqXhu56ICtdX8aoenWgVgjs/YlFDBIqQEGscBElAIjsr+kACJgUzZHlVA+DlBjuK0HX
         JMlOs5e0ZVRCxOovhEm6pSt51G4E2irfgYROo4dtg+53WzFCqdaOrt4D5eFu9hXC6C8h
         41CzD+Ok2dpR3RETbWqHdl4SaOW/8gGs+KCEB+6L3xWnyTkTR6b5fZG40XIqUmcj5Zzb
         LJSLTjSuUmBEKeaX8gJPsUqDe1ODdxxl+4woSlFQDeTga+qc2omc0oR9ilSDY8Gk7APK
         dctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757282792; x=1757887592;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hptlqdp9b1MF6OhlNmp++9M2/f9tUuxlq06VT9Ialk=;
        b=ru8XL2JPIsv/46FrEinV7NN1Vtv1dm6Tm8/jToxivLZ/D39ByqJ5qwWvOs1MyP853h
         nM3oA65MSZsT2UEspyWMGOu56cyc9el/Z++5HbA23p46u9EUG5UQ8vYfiL82vicXdUtD
         2o/m//1tBv4lDnWdrcXyOjQ6vOspALx5f6PFRi6aw9eF2qUnjrbTInUq49Xjf06gFKPO
         W18lhS4UBGywiP5Lcy/Wo16fzxcJrqA6Y9Z0SPPp9faZoB4UC0kz2PDK+UoC9ishxtW4
         fVrDo9icSbFxS5uwb7FjIC4w1+1OpYle0OLurYZMnn3lSbXOu75sisAWuYtthBQJsnQn
         7FAw==
X-Forwarded-Encrypted: i=1; AJvYcCUNxCLL1jdlYKNZz8O/jlZ+2zadLWmLf9GkXCEud6fCS6/5jB4b8zIWJflQ2iEOEvK6zIN7qWdxiWFA@vger.kernel.org, AJvYcCVeRJCnogpHervqQKOAJLhL85VjgMJ2/3n1Lp8pf3XrJoBBo54jN6vov/dDb1BA+lhM36NUkXa9Jgd9Fn8M@vger.kernel.org, AJvYcCVqmBELnAyPZmsD78men2u29VCsaVt3QDwkMUdycD6SxGZn39+EVoGDyB4GvhpcsNIHBwcVipMBizCQnjA=@vger.kernel.org, AJvYcCXQdYkEKsbuB3FHT3gWDrIHij6OMjv8Gk60aAB+FS8yCBvQPVWBauJZQO89TsdyVVsiwereokjYHbkB@vger.kernel.org
X-Gm-Message-State: AOJu0YwTFI0OpNUUFoEsQBcrsM8XWChzwL80AA2Gv86gtHguUFkhyIcp
	eDE+JNa2ryuFq9GfZvHlACBO55KJ12m4yHgvft1dDzx3ocaYPknXBZbx
X-Gm-Gg: ASbGncskA6mganw00tYYvanJmZxD4GWjiIw6Q12yBShd8TQMDgYSauK8mSq90dJZpcm
	mUED6HXA8wEXPYarKopzy8x5tqVk7EgpoSGggeFuQq13Ohqw+wcE4XsObIr7ZB+Y2kI9bI811Yh
	8zHRkkVGnP/bhri6/9EfMGedTuBod6Xgu97yf9G6GjewYp0sFCm2YPFpPAuBZunXZvMAKlR59Gv
	uB2RlshBOx1+LHnE/E9t2ZLuukOMbmsTRhOQXrYCy5P4SB+ZfByizmPmAoBtgkDy22duBo/1s8+
	zFjJ9OMdc8tp77uWIrLwTqAZPkEL0vyNp9Nd7S63mc/3luxj9zUtT/AeaywJs6CypWfEopdyVRZ
	JceglvDwWqAiTyi1SClWUP5tCFxu6NLk7r78=
X-Google-Smtp-Source: AGHT+IGcJZFqldRo/H0GE7Xbe/Q8EGo7qLaMA8REEiKVuXE2jwTFe1RKcaZ9VGUgfV3crPZme9vCHg==
X-Received: by 2002:a05:6122:7c9:b0:544:79bd:f937 with SMTP id 71dfb90a1353d-5473d2900e3mr1469599e0c.15.1757282792173;
        Sun, 07 Sep 2025 15:06:32 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5449ed5a91esm10397004e0c.20.2025.09.07.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 15:06:31 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/3] hwmon: (sht21) Add devicetree support
Date: Sun, 07 Sep 2025 17:06:14 -0500
Message-Id: <20250907-sht2x-v1-0-fd56843b1b43@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYBvmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNz3eKMEqMKXcskSzNDI9NEg+Q0UyWg2oKi1LTMCrA50bG1tQBvN+V
 eVwAAAA==
X-Change-ID: 20250907-sht2x-9b96125a0cf5
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: stable@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=qLRdvSJ8uiJiuRtlL7SuX80IfGmKXF9bpTRPiOf5o6Q=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7GB+s//Pk+dcDezN8rpcY+xac1Dtee4P1mOq+8BW2l
 /NXMC3o7yhlYRDjYpAVU2RpT1j07VFU3lu/A6H3YeawMoEMYeDiFICJTF3JyLDm9eKjASw/4+2k
 jHkE4hfPLNtX8djFSjltmnt6YLVC405GhsZaNY3T9rMljOblf54xoVzWNn9u8U5zBtP5zelZLoL
 n+QA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

The sht21 driver actually supports all i2c sht2x chips so add support
for those names and additionally add DT support.

Tested for sht20 and verified against the datasheet for sht25.

Thanks!

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (3):
      hwmon: (sht21) Add support for all sht2x chips
      hwmon: (sht21) Add devicetree support
      dt-bindings: trivial-devices: Add sht2x sensors

 Documentation/devicetree/bindings/trivial-devices.yaml |  1 +
 Documentation/hwmon/sht21.rst                          | 11 +++++++++++
 drivers/hwmon/sht21.c                                  | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: b236920731dd90c3fba8c227aa0c4dee5351a639
change-id: 20250907-sht2x-9b96125a0cf5
-- 
 ~ Kurt


