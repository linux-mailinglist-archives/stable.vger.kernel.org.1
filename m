Return-Path: <stable+bounces-210064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E5D3321D
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB00730145A1
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD81332EAA;
	Fri, 16 Jan 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPPwwjZ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750F2459E7
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576381; cv=none; b=Rn9hdVMwojfBU84ljCbhQtLSNMIMAfON0NIcj4a+D1ndSzp5wSjUGl3kl5NwImdrhsxr/CJtD1efrIQxBLYsaYemptiMxIIv1fkL+U+aJ7b47eZFLKKaEbuFd81aVSG5bZbX/ocOqYwH6uKVKHBC5UY0XxcS2l7hiWlrpkUFdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576381; c=relaxed/simple;
	bh=W8Du2oDRoyUgx81DMi6zQRmYVixmkTdP39Df8Cp6QtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KNswTX1IxrgJzfodgLij+i7oIDwvs/Z7u7O8xM7OWW9rs7izg5fwSwF2/XFr4uD3daiWLCIMDtvLlN11worVxPSwHZg+LWvO4PLcIu6c39tRL+YAhNRgU47CBuLvsVMo1CnOA8e/T7XFgPasureso1GCgIbanqF/+7x4jAXWfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPPwwjZ/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1318888b3a.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768576379; x=1769181179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRiEbJrzkH/I22ILSwaqJapqGZa7fvSUC1WPmu8Y6zQ=;
        b=VPPwwjZ/tbNtCPKYw3kN5z4QJIAHvuw0vzhlLzLo74l2HxYleVJo25duy0mRZkVwvO
         DYvj4vLn4OG5GvDIDkvYG0+BqTAg6lB3+PDT4+smrpPBkRxryuEbhnTlCIkuGEy0WpWQ
         T8EKu5enPohJKHYLmiy18b2v1PooBguqhgJ+OXQLPu3hXsh+1O6bwc4z9Mm9bPdi7dMs
         H/Vb3NnHzs35xKT3EdEtHyHa9tVCe8xalG675D0w4C6YNzBQIX7gxV9BQGXQKTcbkH5Y
         jFvEvVar3t5NjCOImzziRs88Eb9aLV+KUXoS0HFquUJtnd0ZzmnEx6qMiJEVyGAXxbjC
         /vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768576379; x=1769181179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRiEbJrzkH/I22ILSwaqJapqGZa7fvSUC1WPmu8Y6zQ=;
        b=ksEEvUylu9gWhlWnlb614AHO+C1ZZTJCcFjjZ1hBQNZqy4fYLmDsCxlAGlK3SNkom/
         PR2fPHrWLTH6jslJiNZYtA4Zl13BdUD+3dyLxUv9tAj8oTtPBWIYIVe3gfDcQZyubYK/
         s6DmhFj440zkJX2VkHVBgZPexr4IZDF93YV1jyBgWiB+NgJc5PxUKFKccfGaCyxvwJif
         erfao+VaJsfbalj/sybAwITjs1x7p4mF1VJLQ3ymnwMsAnOuWgV9KtPtighUon8+PHVV
         2iv1voM83NmZ6Tb/zX1okz0b5Wdgfn4clGEetkIcytBCqVCmEiaiLHpr32d6KzPIwlOS
         Z9aw==
X-Forwarded-Encrypted: i=1; AJvYcCW4QZcGKkFby2LgZsA9iNdhtxn9Q5BEKbrf+FeCc3dAU3PMZGBYMbydomt1jre+q3FNmLtIM30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyswgx0DSe3gszKiXpCaISleOzWjtrJGgZj8KEH8lepfYj0t0yI
	ksGyY/k/csSL+s62LdK4tbvFUhHBrC2puYdeplxvrrI65QM8ETTVEhyl
X-Gm-Gg: AY/fxX4wjSxtKK+APuznc+YK4Qie2fMUr4BCXGRnvB6m9y76e23JRQmQlwn+j6LuUvO
	kbHlCzfE0ZFKxUZKSrov6sxu7iJ9h+00skN6K2Mc7D73fNO/nMx/wFDtZi8ekDqxVhuOaj7Y1ba
	+RDv06wqjp8xTsazakuB3lwi4sOktHiFCzY6t8DGR/ra6v2YzW6+Fe8LI5NuGnIqMJ0DKcJEN7N
	/U2VSRbtkJnVAi0mvSYxDkUAhy16fhweIw11EA/kfmyoFkVADslrbc2y5NY6ZRyt2GcgEUr8V6o
	0fYXL+OHY1mTCCP8bjv3uGElIU8/l6VkQ/87E6peSvXEvtbSQynUjWUBVDObwKfG96Z1vy1B61e
	TVgykivv2638oSWDc6k+DmLKF64mNvnCvFAy1v1oaLy662bbRgN4+bZljT7rsl2Uo8Y8cCRZw+E
	kakuxmdlR3K0zVVNgvYW8=
X-Received: by 2002:a05:6a00:3c8b:b0:81f:82b2:ecf8 with SMTP id d2e1a72fcca58-81fa1890ca1mr2604735b3a.63.1768576379447;
        Fri, 16 Jan 2026 07:12:59 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a65:fc91::1001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51fcsm2345072b3a.68.2026.01.16.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:12:59 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	pbrobinson@gmail.com,
	dsimic@manjaro.org,
	didi.debian@cknow.org,
	conor+dt@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Do not enable hdmi_sound node on Pinebook Pro
Date: Fri, 16 Jan 2026 23:12:53 +0800
Message-ID: <20260116151253.9223-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the redundant enabling of the hdmi_sound node in the Pinebook Pro
board dts file, because the HDMI output is unused on this device. [1][2]

This change also eliminates the following kernel log warning, which is
caused by the unenabled dependent node of hdmi_sound that ultimately
results in the node's probe failure:

  platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error

[1] https://files.pine64.org/doc/PinebookPro/pinebookpro_v2.1_mainboard_schematic.pdf
[2] https://files.pine64.org/doc/PinebookPro/pinebookpro_schematic_v21a_20220419.pdf

Cc: stable@vger.kernel.org
Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>

---

Changes in v2:
- Rewrite the description of change
- Link to v1: https://lore.kernel.org/linux-rockchip/20260112141300.332996-1-jerrysteve1101@gmail.com/
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 810ab6ff4e67..753d51344954 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -421,10 +421,6 @@ &gpu {
 	status = "okay";
 };
 
-&hdmi_sound {
-	status = "okay";
-};
-
 &i2c0 {
 	clock-frequency = <400000>;
 	i2c-scl-falling-time-ns = <4>;
-- 
2.52.0


