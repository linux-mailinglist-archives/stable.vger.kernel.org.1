Return-Path: <stable+bounces-98845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729CD9E5998
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51F318815EE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995521A453;
	Thu,  5 Dec 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alx/IgcM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD9219A6C;
	Thu,  5 Dec 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412009; cv=none; b=W9V++B1wOe/LYZsNzTeaq7WtVdOee8IO/tJhov8muV6intRlMSJL8rkPABG6xGPy6BFqbvXbNDu9w0BghSXEmATYZc0yu3O0zvXicMUt7eT3Zd0/YdYBntsVvIPyPtsC4njFjH+rSZawTcLmEPArEOoP4uRkRSSI5BiQi1voFgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412009; c=relaxed/simple;
	bh=1ZwSldQHN1adL6CUF84+f4rPEdW01b7oF71XDTVlw6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AFO7SiyUiNM/0y1E+OyPYOrjiNe7bCTU3xl88vNrdwCvVyz6IGeOxmNZ8uT9mVSijA37RqlASC/6TmEV0bIcmvxc3CZISJiFybAHzy9n8M0Tp7lCfjkvB2EkZAq5V7i1A1H85XtNEWEc3nOK39PO67qXm2I67VovVEL9JBXODsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Alx/IgcM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so11124975e9.3;
        Thu, 05 Dec 2024 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733412006; x=1734016806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ8MZsLY5xEMudemo8XsKwc/XtXn0HgWnIckzCi3q4Q=;
        b=Alx/IgcMmF1SxAXLLXwO28iahToBOKipqppHl1PrUZrFlrKtIcEv0hP2zwLS2cGWAJ
         OK5qGuqowqUOtK1RzFonmucCUfOLlwJFVH/m4ivrBYV96/vwQ9mhOljX59e68LA5dWxB
         G7zJtLu0ZaRg9mrvct5i5/rsQ8VHLb1swN2GSblz5ZgQKq+xju6huz9ykURbGbrZKkSA
         mMpR+Nsd6nSCbikHV/DlkGJLTwOM917qTHs020wmXQagi9s0UCjhWzLOQbkHxU0aHIeD
         7YAAfCh6F5Z6V6K6JxqKIXe6al5CGYyrwnKUxSLB9vH2spSRVJvdTGN3GwZEQ23zFM2N
         2YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412006; x=1734016806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ8MZsLY5xEMudemo8XsKwc/XtXn0HgWnIckzCi3q4Q=;
        b=w965D1BxRVIaL5xIlBRVJi/05iaP7pTb2yyhZtPXisH8dc5F5YcD9nRVtVH4dhqhRy
         DqefsSTIITNnR5dNjHo9eqZBEnkwL02x9bNvq1QXmeoEN8TuWg7WeERkrYMITc+g1mlv
         5Lz8e/wk/BtDjMdEWaFE9YN/7avq0kokbV2DwR4qP7D3Gsm/sSJzFt7gGDaarXt/cS/c
         FRqsNw4P/FF1XtOchZvjULMSlhxSou5Y7OgJvZMCUAabF1V69DXSJaW+3M1vv/lckwh4
         MbtCFR1nA4h6zMtJUGiAdWM+2I9ZZRz7vEH5o7KLjyNFqa7/z9WhGu+EG39xGFRfSXoq
         u9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVAiysL9G4tmd5jFoNrbnEBalGIFPnwqX3eWXdWFUIzjlFmfMFr7GA/r20EXrm8vhXgiWI1DsZmJK1n@vger.kernel.org, AJvYcCWexWm604AewAmrTzkrS1OwxhRe4EzkpjcyhfBeazldX4wneHJFSeyGdMDi+AtnL/6a/+7fA+wvIPwEwFq4@vger.kernel.org
X-Gm-Message-State: AOJu0YwsluMw/0/ZyfkEgZCF7QCXmj+rv9PFmV9CcZq49eRU7MsjX/fZ
	Bh/6SIrA84LEdZWIsZ/vfYO5ihVlIvyoYVaRi25oY/gPi8Vv93XZY8/cBO/Y
X-Gm-Gg: ASbGncszcXF3fylJsqhHtI83qY0IiHU0vSI6mkO5cTvGmRlncgi7JxhwL1cvNrXJcl2
	6SQv6ahPF2YQmQtsMvwgtep2yCFAFZtk/oIIcF6g3e9LzpFGrGEI/QYulWKwNlSGlY9yxMESb6R
	/4w1w7fOsYnva0y82m31RunSMnPqCVzi+tBofHMP9eyqvIajoF9ZqWpYm6LBljBSnBzoFRJwcux
	UM9ggKnTStIovtUZZPYeC4incDZmUEVkdx8W3LMCxTUMmwudGHBSkjonx6BamT9yBiuSctGUc3l
	yx7GeXN4pcmvP2Y/wRY=
X-Google-Smtp-Source: AGHT+IEi/F8PB/gDGTEq0wQol98PXt8a8NO1gCgLug2J7Sm2o/F9d6Q2zB2V/7/hscb2BGWUKu7/5g==
X-Received: by 2002:a05:6000:1547:b0:382:3754:38fa with SMTP id ffacd0b85a97d-385fd436128mr9664529f8f.51.1733412005553;
        Thu, 05 Dec 2024 07:20:05 -0800 (PST)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbdd8sm2167304f8f.95.2024.12.05.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:20:05 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Iskander Amara <iskander.amara@theobroma-systems.com>,
	Sasha Levin <sashal@kernel.org>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
	Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: rockchip: increase gmac rx_delay on rk3399-puma
Date: Thu,  5 Dec 2024 16:18:27 +0100
Message-Id: <20241205151827.282130-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Relates-to: PUMA-111
Fixes: 2c66fc34e945 ("arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM")
Cc: <stable@vger.kernel.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
v3: use rx_delay = 0x23 instead of 0x11, which was not enough.
v2: cc stable, add "Fixes:", add omitted "there" to commit msg,
    add Reviewed-by.

 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 9efcdce0f593..f9b4cd2d7daa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -181,7 +181,7 @@ &gmac {
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x23>;
 	status = "okay";
 };
 
-- 
2.39.5


