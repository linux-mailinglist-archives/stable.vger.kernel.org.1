Return-Path: <stable+bounces-127878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE2FA7ACBA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D7B189BB40
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CD280CF7;
	Thu,  3 Apr 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXX9hJDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5824280CE6;
	Thu,  3 Apr 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707299; cv=none; b=AC5f8buC1sNpJQ8pMEj4kdn7wNl/PHW5PXxhOGmKHpOGc1/ucoOHoszBBcFdUd3pjAaNgcZtp3XJhyNpdrPgoA1gKRP7y2LWbxUvqaPQcUwk3dQd8QGLePDuCWq0hrWbhlbPZFOY5SmiLIQqR9o7Hy96VuHgw/AmP20LUoWesZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707299; c=relaxed/simple;
	bh=4n+yGl4n5cPRwxHQrjFjB9A3EmatxVciZibuLBdodcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+qIlWLeA0Yu3oqX4mBEJ/hA4txHUC43GxMTjmGVmX2zS4DE250/1tZLZGhd9uhiE5Sm8GaCJY0EJVVdJiWuBLg05dwcQ8SakckfYaaFTm47xjYn8rh8Z84NRFui/cWTnFdp4Lr0R5yyM2xL+5LBl2Luw1UaYihIScA2/vDc+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXX9hJDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEAC4CEE8;
	Thu,  3 Apr 2025 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707298;
	bh=4n+yGl4n5cPRwxHQrjFjB9A3EmatxVciZibuLBdodcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXX9hJDk71dHkh2K1+We9b8Kw/LCCfrd9l3hEuB4GB+Cc7KcJbgFhLUkOsxe64+CM
	 xeh1qHdYqu/8Uf9Tk+mjRqvbYyiunEpl7R/0C282FUAGP3+RhXUc70Aev36ho02TW8
	 yrdN9LkHkjw3Eg7aWMB23Sq0tXzm3RALwrONoXA16zz2RE5rQhGuBEI2o8sHYHV9JN
	 w764ptp1tw86yQTiycaSKiY4UjSGmqlqUJplWSsfRukb6s1OmfUTAuCsi+/lpDpujD
	 PCWtKp39HeJ8UIpawnak1MOAD6xLZuJiRwg9fjENxd3UN2Pd2OZSmxZKPTSb7rvGmI
	 77ZdFtrI+nbBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Birger Koblitz <mail@birger-koblitz.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/26] net: sfp: add quirk for 2.5G OEM BX SFP
Date: Thu,  3 Apr 2025 15:07:32 -0400
Message-Id: <20250403190745.2677620-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
Content-Transfer-Encoding: 8bit

From: Birger Koblitz <mail@birger-koblitz.de>

[ Upstream commit a85035561025063125f81090e4f2bd65da368c83 ]

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Link: https://patch.msgid.link/20250218-b4-lkmsub-v1-1-1e51dcabed90@birger-koblitz.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index e0e4a68cda3ea..dc62f141f4038 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -488,6 +488,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
-- 
2.39.5


