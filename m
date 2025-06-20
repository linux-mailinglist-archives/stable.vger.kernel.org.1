Return-Path: <stable+bounces-155098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA13AE1913
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6314A63B9
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9032561BB;
	Fri, 20 Jun 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOOaSA7N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472926FA64;
	Fri, 20 Jun 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415797; cv=none; b=OxP3n46ad21ysnQxtWjOPTm6NbiqyLx6F72XteZ9lGyaElqwfK11B2lavyxTaeII47nCMCrF/Xv0B6/jIfKAaeOKgyZQmiYuVBd/kskyVWNboqVKlzvSqY3PEBC+3QCQUfhqMjSgkvYMlqNJAD0s0qaNXVwspSh+mEAioXZpuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415797; c=relaxed/simple;
	bh=61tzGfGbgQLnSFeKKZHQCEC5cxZqFDsy8PIqZYAdbrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qsOaJgn453TQaiVrUEtZvbTEZ3oozsi5nIt7h4zjrrLDhaOeGvkGsEF/+5x+eiZY7jFm0Xuy2mlpoe1soiK/5F78+D4E6vDL4kAXke0e5v0FY+/S8uMz4eEMp9DIEx4yvmOoS4wb6VKN6JuyntyDSUYCf7jmVqMZs+V/V65gf/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOOaSA7N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso1119016b3a.1;
        Fri, 20 Jun 2025 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750415795; x=1751020595; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PrIwQHjw/p9hrLI0cyhFU0inaUVzxNVCt/CIe/61mQ=;
        b=MOOaSA7NtXDJUSeU7MO+DI/QUwIxohUfWlRkSFZ8BSRSO1LyIe3WsXbtT/rufyOp9D
         epnfrQhqzSTMsDYd0Ajvt1lyPsW40tW3HLHozIbH/JittwXiqVmi4hz2DzexiHMgRC83
         GADyWHPH+hJX+7clFZOlzWI0fSy23PXsshdpsNooqK5d7vbPTgobB8mbttXPNH5iWBdE
         yFjpDoBZe8eqOayDi9p+hJxX5HbvfUMwsF8XiV8iCGzSZ/f223Btydz+O3ukHBWYO6U9
         1MfB5rG8aJ9cDDmFyJLmrMgchw3CcJZwbj0suJgz2NSN2a0IO0dtSwkt5d1X2E8Yj2FR
         ggKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415795; x=1751020595;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PrIwQHjw/p9hrLI0cyhFU0inaUVzxNVCt/CIe/61mQ=;
        b=R+3NFLH7J1NcyRJdsfUASsHlZT8AiPcJVw8qpe3r1jGKcyWlTYTUYwdA9wvc+BEt4G
         rV/z+ERpsmzo8eQQe9xpI83xGWTq9EgcjJoaZM6rEYtX79k920ls8tqJgxaTZEPtLeOZ
         ZqG4grJImHOzezBR9jQb2zGjs0ynu68qPO2q4cXU4GchW5PuC3tCcgVxgwvVmjgedZGn
         Bp7sBbqBPikbYiMQ2fIZfde8IdafXbGvP+HNt6XuXTPK5RVP6No0mR6wgPQdMMHNqW3N
         Bh2Cn013ytpwAORXwWJeUeWTFgF8T4eZ+ZobrTubxsjIfogWn+33XQI7xnz2TG7kKZUT
         xSwA==
X-Forwarded-Encrypted: i=1; AJvYcCU1589WkqxBx7F4CI7vHOVybeHh+1krFio9fNLPrt/F4KO2ZWWPRP2qlPdDfDhZbsKdVUEj9Lr7@vger.kernel.org, AJvYcCUQcBobS6hG3oeiQzy/AkX0HO78J9JHzVtf+sCthLAm/oKSHRHgqTwpj1dyACbwBMD9GgSgrDZ3kWsOD2+9@vger.kernel.org, AJvYcCWRH8i1/u+vNP0ULF5BD5rbGkKdFZmO9Zji4pge6Ukcw6jxsbe0L9Gz6bW84m/Vpsg7x45W6RIWkBd1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6B38GarOpuSXYsTQUIYF6wEC7ZsY8Z69cF/938pyqseyjrsK
	YZTJpTP763UD5PsQBO/YGhXYc3/iKcPWXBSWSeBFj5oIxk9b3MzLGE1s
X-Gm-Gg: ASbGncsqj443zy4Zo1hBewSv59HsXUqLAWsKb2YREzIjTJ8HuLg4CLmKHPFpdG046hG
	/4l/1BoeI+ZetTyWtfeYRIyt3njZrAjyZvHJ/q7afs1oG19n/f8D90K1fwmajIxSPOELR6gX0xJ
	Nl72RJuuiBERwyl5k8a+sOn1XDWyCGztkdbmxQ4uYHA4rv+5CnlDYoCU4tjqWMf1t1RnhwkT3+v
	jsp2NwUXyo1GIdC7VzCpnUCDCn+HR6pX6K4y5cH/j+5vFjaY++7noSxb9BaDuLZshO5nrMmxGZX
	xLSPjbc3MdNBMj/Z1oKXI2w4J5w7FYGk86DpREXGwUb8PA2g5XvCRU/XlfZC61ausRL6b7Jjtcy
	3RIVySxpumm8=
X-Google-Smtp-Source: AGHT+IFc4Q10D8OQtMZi2Dtm3qf1ST8pz1u/NxWiETOVzSYrkkbcHnd7yIU8yT784naKdOMQMa/5mQ==
X-Received: by 2002:a05:6a20:1593:b0:21f:54e0:b0a3 with SMTP id adf61e73a8af0-22029176202mr3058959637.2.1750415794665;
        Fri, 20 Jun 2025 03:36:34 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a674eb6sm1779230b3a.144.2025.06.20.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:36:34 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 20 Jun 2025 18:35:36 +0800
Subject: [PATCH v2] arm64: dts: apple: t8012-j132: Include touchbar
 framebuffer node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-j132-fb-v2-1-65f100182085@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHc5VWgC/2XMSwrCMBSF4a2UOzaSB02sI/chHeTZXrFNSSQoJ
 Xs3durwPxy+HbJP6DNcux2SL5gxri34qQM763XyBF1r4JT3VHJKHkxwEgxxyvXyopxQ1EF7b8k
 HfB/SfWw9Y37F9Dngwn7rv1EYYcRYOQhldKBmuE2LxufZxgXGWusXVoRMD54AAAA=
X-Change-ID: 20250620-j132-fb-d7d5687d370d
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=61tzGfGbgQLnSFeKKZHQCEC5cxZqFDsy8PIqZYAdbrw=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoVTmpH7C123HN9er4olInMFkdcbOHWIYV8pnYG
 B04Py1NkqGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaFU5qQAKCRABygi3psUI
 JEsjD/48isIZsVW9mZVR2PW1U4M3BDzHiqAL09krcSNQRq8Wcq53au1xxRfYAmRdGhkH0W3wwTG
 TUx9cjx62SnX4s3VXjucX222dQv5r5eU+sAQQj9ieFpkV9ssSUJGFTySHsoLwOk/2zFXkA59x1g
 TeQP+zVBjd/W7PXMH/mgav7rUs9UarxEhVj7LjagusBrW+q8s4d2Du1X8xwLFFZkX6o8nbat6JR
 Mh/VKvCxQdn49CFCzS6fN/Hj6C/IY9+luO9s85wGZdFQiGrprxHXpjiZ4V3XkJ5kpK/GE4jgLid
 16SjSvlUYXyUENw7UoFU7MUTUZ6fP5aayAkRqHqEIyhQUeHAVP9ihEU/U9RUviiPfE34ug+AVrU
 5KxK+1ZR5E5m5SlfLt6qGiF9fXCS3W8gIN3+LT6mlWcECfky17dqyUMHuWCABXKv6musUoKULgn
 gAeFjgNG5KdWdv1UMnm4BNtxW6RkOo/fTruFE/wwHyqEuZ7Y+qf/2ax13g15oyeXp/61+Z1BLi6
 DaD++Se1zd7eYOe101biQdLG0RbPyx30VBMz3PC93RlR67JuxKfrTcYYOYw4cumpJJQ2DTmXlV5
 3o3bHjRMgAcDoTR+q/PrQmVyPi+5rPnaK7Hbc4/uN4FNxtXaWKh1A+zQqJgxe1j8DBSHt/Qeg8o
 ukrsyXeu8tnx8jg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Apple T2 MacBookPro15,2 (j132) has a touchbar so include the framebuffer
node.

Cc: stable@vger.kernel.org
Fixes: 4efbcb623e9bc ("arm64: dts: apple: Add T2 devices")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- CC stable list in Sign-off area. No content change.
---
 arch/arm64/boot/dts/apple/t8012-j132.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8012-j132.dts b/arch/arm64/boot/dts/apple/t8012-j132.dts
index 778a69be18dd81ab49076fb39ca4bc82f551e40f..7dcac51703ff60e0a6ef0929572a70adb65b580f 100644
--- a/arch/arm64/boot/dts/apple/t8012-j132.dts
+++ b/arch/arm64/boot/dts/apple/t8012-j132.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "t8012-jxxx.dtsi"
+#include "t8012-touchbar.dtsi"
 
 / {
 	model = "Apple T2 MacBookPro15,2 (j132)";

---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250620-j132-fb-d7d5687d370d

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


