Return-Path: <stable+bounces-94952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CE9D7274
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E12B44981
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589661DFD81;
	Sun, 24 Nov 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxGk/V9U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4F1DFE33;
	Sun, 24 Nov 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455365; cv=none; b=ex2cIogcoeNDRkKzLrPD9rFKNH+xg7eZdh/KT6X230GcHrM76wejIx4w/KaA6ksrrBz0yLU+EWgkBAJWl3/fVxeBxw8b1V942Yx7ukaaMT+vdjDWIgGxJ7CGpBOC5JDxn7XBEQOvM0fD9QopOUtbPsitrlkF+o3AmcTh9UCiWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455365; c=relaxed/simple;
	bh=zFPlCJFfDBebf0bG6Mx9689tRjtn3qTTTMtEGdNV8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peBhMKDgKPAf2aWo/vKmn6N8eJFbYuiGFN4Yow5+4WVeYp2yxDw7Lv4YyzEecFq9gQAoePk6jtGeG6nldVwlChH7MQSwSGc1fJrkL4901hjhcW7oFxAqiEISTvg18kRdcnuAaPek9OysbbIdDGu6GB6EFwPNdcOQ3T6EB/A096Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxGk/V9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B45C4CED3;
	Sun, 24 Nov 2024 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455364;
	bh=zFPlCJFfDBebf0bG6Mx9689tRjtn3qTTTMtEGdNV8GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxGk/V9ULEKyBNygaSwckpgymXPzyA6rwHvuoksCsJgff386xXACtImfUKhbjYxqE
	 brQWj6htuVKSanBAQr5Wt4vei5WXL3wke42Yh+1Nw0aLY/CHhxol/tZyfKDe7EvTEM
	 DNpQatRV89cF+VFsGMf7sEsIwFHOE+C2fLJ2dvnZhUh8Z6ZeKRC6WGPlUDMY6Yzyq2
	 fClh3VqDf5pse9Eka8DWhZyKqbguN4q0W+4LMjHyjf1AO79MTZ8vqeJ/VOrUpyis+9
	 DfeKN3VdDit5L9GSC071Z8htVos8RXxsqZIYB7+q+tqYLpx12Fy83bGkjnn/JfVS4N
	 n0kog02krWgiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 056/107] net: sfp: change quirks for Alcatel Lucent G-010S-P
Date: Sun, 24 Nov 2024 08:29:16 -0500
Message-ID: <20241124133301.3341829-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Shengyu Qu <wiagn233@outlook.com>

[ Upstream commit 90cb5f1776ba371478e2b08fbf7018c7bd781a8d ]

Seems Alcatel Lucent G-010S-P also have the same problem that it uses
TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Link: https://patch.msgid.link/TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884bd..dcec92625cf65 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -466,7 +466,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 static const struct sfp_quirk sfp_quirks[] = {
 	// Alcatel Lucent G-010S-P can operate at 2500base-X, but incorrectly
 	// report 2500MBd NRZ in their EEPROM
-	SFP_QUIRK_M("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex),
+	SFP_QUIRK("ALCATELLUCENT", "G010SP", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
 
 	// Alcatel Lucent G-010S-A can operate at 2500base-X, but report 3.2GBd
 	// NRZ in their EEPROM
-- 
2.43.0


