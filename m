Return-Path: <stable+bounces-178832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1054B48236
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5F93C0797
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D712080C1;
	Mon,  8 Sep 2025 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRKmmKCM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABC1F790F;
	Mon,  8 Sep 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295243; cv=none; b=BBF8aPLNIIx/GQY/9Izdk2GYUcGyGgar3mDr8InC6gFQzEq/W+XFmkGl7yI06Zmge1AEtjGVyux/9HraxrY/ZJxe7GBi5XXDbtpQ2neskg3QOrdMbhdZoZIr31pZ75o+mZTCOjZlp3N0YdsmDMc0mqrRHl4aeW2MpevxAWPxWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295243; c=relaxed/simple;
	bh=2c/B+jVJU+eMT1REUyPuXAvy9saBACnvLnSQGlmXcaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xjf6dmwxLYq+DYBj4oWo33O+7RnljQULzHVDeMCnKMushMz9Tnh2NLHVPdfprkabIPurdE/8WepMCSIatYbTpwfC30iwpB6/1yutWOeAiXkN92ZHZI1Ud2VL4Cz7y/Q+BrwbVP7sUez6Lspflt0CXQZUiD62LHo80Z+NNJvDgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRKmmKCM; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-52a8b815a8aso2070600137.3;
        Sun, 07 Sep 2025 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757295241; x=1757900041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dGtV+MjNh+y4+MbTmaKA4kHO3anKPg6NBgz3rdrNSY=;
        b=PRKmmKCMaNDYI6x3V8pGDHzKBsXEg14A/07tWj/BnaX0/39S4Xkzv1y4RU53l+suoQ
         2Dt/vcQ0ZuWib+r1TqcM7S8xCNVlHswqjHBkZ/oHkWYA2/770oI3pMS0J+P8lDpmQxCK
         T8xfha4nqnVJHbUda8rmUoilSa4cqAMd+o0yQaIXIEyNjBiBQR76EpyhBTPM8mnTQO+W
         yFfjLkS8DZX08FvcYhqnmqGOEXR+gyVp5LUpefjlifMlaP064q+7R83jsJ2rcIfG8kjD
         Pa+86tYdkBNI4D2QR8OOfr7xltT4VKzeXtG+Xm4wpWXYCn7Y0eYBX0ik+jJ6cd7r7X54
         GEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757295241; x=1757900041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dGtV+MjNh+y4+MbTmaKA4kHO3anKPg6NBgz3rdrNSY=;
        b=Qzt/Ojau5ABZS/4h9HpmQZnUw8IM4Bd6f5WpB/BcYeoxiV4mllLExHHv0v4U2Ddfe6
         VqkF9J9UYW31ywG8+E8p2M47IUmlJI524v6gPqxAdUgdtzUStjIUQqABFf6YEU5mmLEt
         qFW3usd/SyvOuv96mwTzCkGg+VO3zwUPAUDkzf3PFaekCa2znYGQhJx/nokvbq36IC2F
         G1agMnoQVf8/Qp6ONr9ZTGRpch8nhE3eoQH11Hb7PsoQ+d99yvsN1SHnYQx1toS0BzX5
         WUzpAww+bPVLmAZhyC8YcnTF3JZVs2XxgdKEhbm8xw35H9iWCOfBiUn21I72qzAUDktZ
         vr5A==
X-Forwarded-Encrypted: i=1; AJvYcCWDrNO7HetqJV/+us+Y/o9ki6S6YDOoGZL8jYGVL9/Js0Tjzwl1ZUSKOaIfdffUKxR9uCNWQg+aBcTTZRpi@vger.kernel.org, AJvYcCWUXT3hjPisY0OY1dj5naLagEkqzbv7oMnEZ6hbtEw+bVE21sPdixYePf3kcOI7Wjmif5U8uyG6BuD0@vger.kernel.org, AJvYcCWjK4mmNx8p8z1JXhuApMJ7nPK2vkTERBcdX+QeTeEps103QIcQKMj8HAgfeuONVtwKhUaT6PFboq8R@vger.kernel.org, AJvYcCWlO5mDHxQmmEbXxBwSVasaAuDw2Nal2YWNCMrtIw+dPA3iKQnob5R8lUzHhAjPoRGk2S+AeE64@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDuwBo+uezid0nGCxZXl5Y/Gs5JiVe/1XF2V4PdKdofZku8Cy
	UKvoDzNIw7v2s9ak1IYmkCIUajYj+Y1BusVKMflPB7zgFTOo3Wj9LRfFItadPg==
X-Gm-Gg: ASbGncvvkUIOQDwkNdPb2UA81C2FtHjoukDtkrLZgW3M06FpGMHi4ka1EDRXlgJj+SX
	QE9SJVtIYaj7zV6PcoWD/nYZmRs6xva/y8mdio3AtrBJ3eqrcs/LGOzkCRnhSxmobRkG8ojh6hj
	oL/oD4ZpOo2oqepiSimLFKW5STu/v51CodMVKsSbPmCn3hie77pThzYKBUjpsnGa3g2atzzBLAd
	tmcRf/5LqH9TVw8Y4tBnMzrjS6PyRl7LgWTc20+VLwBdA5uI2oomBTgEE5U2oQWgzzDlTjMwUG3
	XgqguMNUOk5J+YWsJ5lzYqLC4cpY+sWhvI7Umx3APN/Crdgr51NytLYFIPJhSQvFhABC8C40VcY
	Av57memy67TuE5Cy5FIkOLuw3z9PjjCl5DpI=
X-Google-Smtp-Source: AGHT+IG1/Zjn4wzk0rEPN2NMHavM+UsB3Ymsn52h6u1H7ECAKTvwzXSagwM5V0EjgzZP/2+UdxTCyQ==
X-Received: by 2002:a05:6102:50a1:b0:523:da8c:eda2 with SMTP id ada2fe7eead31-53d128e60a8mr1264610137.18.1757295240589;
        Sun, 07 Sep 2025 18:34:00 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-899c47af508sm5857494241.11.2025.09.07.18.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 18:34:00 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 07 Sep 2025 20:33:51 -0500
Subject: [PATCH v3 4/4] dt-bindings: trivial-devices: Add sht2x sensors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-sht2x-v3-4-bf846bd1534b@gmail.com>
References: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
In-Reply-To: <20250907-sht2x-v3-0-bf846bd1534b@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=2c/B+jVJU+eMT1REUyPuXAvy9saBACnvLnSQGlmXcaM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7jOrN5z2SdZhXZ5krrszUZm5mZphvc89PqYCrVP5hZ
 eGt69c7SlkYxLgYZMUUWdoTFn17FJX31u9A6H2YOaxMIEMYuDgFYCLcXowMnetvzmExuTTxg/eG
 A5tK78kXvtJ4+npu6omkFtunEiJHljD8d/N92qfH/ufJLTHVtUsUv0488zNY7a7uWZU3PW6Ml8W
 tWAE=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add sensirion,sht2x trivial sensors.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f81255141bdda6daf8e45369a2c2..952244a7105591a0095b1ae57da7cb7345bdfc61 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -362,6 +362,9 @@ properties:
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion temperature & humidity sensor with I2C interface
+          - sensirion,sht20
+          - sensirion,sht21
+          - sensirion,sht25
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312

-- 
2.51.0


