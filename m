Return-Path: <stable+bounces-127793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400CA7AB9A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C3D188BA29
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1A264FA8;
	Thu,  3 Apr 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN6piocA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2C264F9F;
	Thu,  3 Apr 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707104; cv=none; b=eHaoox8VySKP+RaUK9gOKFPmLMjDc71EQsBxzhNIF0PQlg79PMkXKrJEpTnj6WZrd/W1Pg1Rlgi+6GePBwhLz8dL92FJtuE7ZjuhRZuyknl2g02sCIJ/WKnBd36b9E9sbExbOf8XuBqARuchVKXftSsdjG3DQMELuvwrpyW1Q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707104; c=relaxed/simple;
	bh=I8F4Utz+tR4jnkzKolBk0CeIpK7ElkWVUGIJsszsnUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oX/SxZqbIpHUNBmAn75U+05YfqAkfUU78WV30MLFjRgMPluPYN8Q+bbtVa6OoVksY3JcdiVUuLY8ROrTsWDEKI00wxAGqc6U8LKG9MF6Us0dTE7QWSh58hv9XYJzfjaMpsd6IcTewjjtU19RdlbLq3cHtXuNd99wV0FkTlN9EXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN6piocA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37E4C4CEE3;
	Thu,  3 Apr 2025 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707104;
	bh=I8F4Utz+tR4jnkzKolBk0CeIpK7ElkWVUGIJsszsnUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iN6piocAEJcTO8jzu7hfYn0BflwF49kM/AHQt1TCRw7IWxJ32bdLbg82be+r4rCQx
	 mWHn1KqZt8IPpiVVZLtwzO+HYstwfLFBtH2bLa5zEB1l/91bKwUU1kHZJklG/ALI15
	 aKsqNqyYsYG3xE9LOo5l9I6sX1g7oJYHz9kJl15AnGw+zDY36Hv38tJ+XAMmv2ciZU
	 TahMCBLKuPqTbPuWJ5XXF8fCUikqsAxrWKJ8NwFhFuP1Fxuj/ZCTKKEjFoxKClctuH
	 YDcGXgsX5R0ggKgsiXutbFpphmMpZ3zDNI5vDv/WZBgWOCQqUT24aRog5pXJ8+q39e
	 se7mH0uq7TQpQ==
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
Subject: [PATCH AUTOSEL 6.13 24/49] net: sfp: add quirk for 2.5G OEM BX SFP
Date: Thu,  3 Apr 2025 15:03:43 -0400
Message-Id: <20250403190408.2676344-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 7dbcbf0a4ee26..9369f52977694 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
 	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.39.5


