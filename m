Return-Path: <stable+bounces-103984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F3A9F08D0
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EB72840AA
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E611C3BE4;
	Fri, 13 Dec 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5JXQOXl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03B1C1AA9;
	Fri, 13 Dec 2024 09:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083725; cv=none; b=SJ6UnoTfBDM8KriIhb0kCJfT9Han/p+Ny39v0mGADQJyf2Bs7Rjkn9r8PvutPK3OgoZzS0WyDOcCtmR4jnmJ+tHah3Gn3XgClS0hA2g04pbZ5y+DxGtNNkY8n4pz7B05ZhcLtaG6FW0jYusC9q5CVhNQXkvjFTll7DrwOuY/UxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083725; c=relaxed/simple;
	bh=rUgmDMTlla3bRCyAWZxXRbJxFwUiKYGnqMqQF22MfHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IIea9f2I/y+cbT9P7vzyDTFdskuIH9NibwsLzcTXVw/5MBGWQceIvgZcL3v8ulGjDza1MYCIYjeQ0dJkfNaW7MyHIVjbJJpNKqQ0qCfC67+ln2tY5JmhtqqrS5wJK1FKHJm1yOmag15ZKbYvpi9plebHTchFIokstoRDjm5Z/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5JXQOXl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso262569866b.1;
        Fri, 13 Dec 2024 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734083721; x=1734688521; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jeEYpoT5ymS8tRy1xVLDixRmFAc5fwDD3sDDNeC0nh8=;
        b=X5JXQOXlCMVqEj5UwFvF4Chk3S3oCWN/Wyv2ZQtfMGrdPfGbDxNuuruJYr1eWWjhf7
         J28JZct5liGlv88Wv7TQoE6Zqfsr1vipM2gFP6Tv/CoKY0w2C25mTtJTZZqw1IM3mqKo
         X2EjPgdBwV069+um5pcZP4f8adWp2XqHsWH+zWCBrcghHYdQosz01ptxP9yki2NoBbde
         4zqLETCNxrTlSyO+UuM5LWZuXhtLFUgQPFjb/6wEeKuylA1nlekuTpyjDS9X/rBIsogq
         /TNOoVgmuZPEFZAaOLmzi0mDjY+hLXoVP9v3qtwStM11wh2DNeM1lilDg8Btt0Y3FQsF
         MhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083721; x=1734688521;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeEYpoT5ymS8tRy1xVLDixRmFAc5fwDD3sDDNeC0nh8=;
        b=KdemYH9DOviA9ANmuzoqROu8IEu4zsvLwtJQJAOD2bRjolOSjnQPZ3d2r4WE2QGNiy
         dV4MaA/Rm5or1I/oqhTK4ka+gLay5Qy4EwiZAsyW6byVIWzAwON1SIertIwkhgtOJPC9
         4V4SROYVZItAZBKWx/4RQ25itE4P48hnEZgF+wz52MZz9SN2kxygNHE2tz33vbnXaCE7
         882Fu8T7RUPnITT/BoIPkapVJqTXWfyw2XJWoZsdCMEHfxUvwrGO/RVi00ERb/HG2dXG
         i0La2/R+l5Hs0wTIK0SSo9oH3gsVpEmNXYK+Y7F3qYU9Nw620icFIfnxdA68MZxs+PMr
         1Daw==
X-Forwarded-Encrypted: i=1; AJvYcCVj3i+9F5oACrLoowKtACNYbZSt6ZBS1rvO+b7yZ53ruC81mEBLKYLmTCCHn12ZeRw78tGPUw8c@vger.kernel.org, AJvYcCXrg7qhpQEMyeUrxTuhkAI6Lfiyb4k9ZiiR4vhBbrXG6s0PjIssd7dVFW9xYPhR5Eq0XCELKUzixCsOfUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw9NL7MWGn+3OULoI0PLBGL9g/ZG5yd7y7LgJdfxn/Hwee7bSG
	9ragTqRJfRad+TKLrKget3c00iUvy0AwqsA4GnCwCB/KeDL2EajxEiSPr/ij
X-Gm-Gg: ASbGncvAbMbBJ1m2A5oMUFwVQUPSQQdxkarbCpOk76FCAQ1oCvHj8ARIYGhwoVqLp8M
	xNh44ZwzuWCyYZrSYIFCmHDmDgxv6u0Zs3O8EmGnqqIJP1XyIItsVsVwis1DdQ40M9Bts9mAZ3D
	MWwqApbCd7Dn1eCk0KwMVUKv9GIVDmUV0Ur1SWJbHLSTXu6ICdUnsyrvZOaM1r87iakP1Z7yDK7
	NxAyZxy3nXwHcA3qhArDgjS8Xr9ZakblY1N3f491eDXDdUr2uMwJ9iEvJVthqk2/U2m2H0MCuR+
	H1q67vMhoQz72UW+YMVPLY7HwQ==
X-Google-Smtp-Source: AGHT+IHZMHT5CWtXaqVR5si+MBRX4Sk47tkz4p5lH/eSEWo0dRkleARMLltPnuR/+triSY+HnVjWaA==
X-Received: by 2002:a17:907:1c8b:b0:aa6:7cae:dba7 with SMTP id a640c23a62f3a-aab778c6ef1mr216718366b.4.1734083721229;
        Fri, 13 Dec 2024 01:55:21 -0800 (PST)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6969a7645sm598970866b.16.2024.12.13.01.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:55:20 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Date: Fri, 13 Dec 2024 10:54:58 +0100
Subject: [PATCH v4] arm64: dts: rockchip: increase gmac rx_delay on
 rk3399-puma
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-puma_rx_delay-v4-1-8e8e11cc6ed7@cherry.de>
X-B4-Tracking: v=1; b=H4sIAHEEXGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxNDI0Nj3YLS3MT4oor4lNScxErdtMSUpOSUNANLcwtjJaCegqLUtMwKsHn
 RsbW1AFzzeNhfAAAA
X-Change-ID: 20241213-puma_rx_delay-fadbcdf09783
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.14.2

During mass manufacturing, we noticed the mmc_rx_crc_error counter,
as reported by "ethtool -S eth0 | grep mmc_rx_crc_error", to increase
above zero during nuttcp speedtests. Most of the time, this did not
affect the achieved speed, but it prompted this investigation.

Cycling through the rx_delay range on six boards (see table below) of
various ages shows that there is a large good region from 0x12 to 0x35
where we see zero crc errors on all tested boards.

The old rx_delay value (0x10) seems to have always been on the edge for
the KSZ9031RNX that is usually placed on Puma.

Choose "rx_delay = 0x23" to put us smack in the middle of the good
region. This works fine as well with the KSZ9131RNX PHY that was used
for a small number of boards during the COVID chip shortages.

	Board S/N        PHY        rx_delay good region
	---------        ---        --------------------
	Puma TT0069903   KSZ9031RNX 0x11 0x35
	Puma TT0157733   KSZ9031RNX 0x11 0x35
	Puma TT0681551   KSZ9031RNX 0x12 0x37
	Puma TT0681156   KSZ9031RNX 0x10 0x38
	Puma 17496030079 KSZ9031RNX 0x10 0x37 (Puma v1.2 from 2017)
	Puma TT0681720   KSZ9131RNX 0x02 0x39 (alternative PHY used in very few boards)

	Intersection of good regions = 0x12 0x35
	Middle of good region = 0x23

Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Cc: stable@vger.kernel.org
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # Puma v2.1 and v2.3 with KSZ9031
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v4: drop internal Relates-to tag, add Tested-by, rebase to Linus master, send with b4
v3: use rx_delay = 0x23 instead of 0x11, which was not enough.
v2: cc stable, add "Fixes:", add omitted "there" to commit msg,
v1: initial submission
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index d12e661dfd9917f820284477a215389c16205f46..995b30a7aae01a0326e9f80d6be930f227968539 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -182,7 +182,7 @@ &gmac {
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x23>;
 	status = "okay";
 };
 

---
base-commit: f932fb9b40749d1c9a539d89bb3e288c077aafe5
change-id: 20241213-puma_rx_delay-fadbcdf09783

Best regards,
-- 
Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>


