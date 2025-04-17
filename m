Return-Path: <stable+bounces-133339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C18A9253F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBB88A467E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6432259C8B;
	Thu, 17 Apr 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ko751jq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8E259C98;
	Thu, 17 Apr 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912776; cv=none; b=RaxDvdA/BOBIyLxPJxCLpTryeX28JwTReTe5C8h9V9LFFk9UzsgZ+bcLbnJ4hIPlClWDYp7Sf289uHyD8SY0L6Qztnk3sht92M9m/6B7kxro0IS82FUGgRGpyUpQZWQHCkh6CcYuXoXrPgmVkJIOCRAPpd1HYWnqtj0U7CPv4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912776; c=relaxed/simple;
	bh=o/+vMAIYbDXP29X7GpC9FRnJT1cULpecXkN14qTfs2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbTljbpN2JYvTrged8NgcAjFF9j0Livx2IFfWkTfHnO1mC8wsr70gyj6BF7z5ISRh+BUrgONRImazHaYmsfbI7bnllZv1jmNPbTErnIe/xs9bQx7ujKffjMPpVrhAd17iR3o+6PQ5nCeRmaVjPvmWj5cylXzPxnwPq7QNvFxCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ko751jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D449C4CEE4;
	Thu, 17 Apr 2025 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912776;
	bh=o/+vMAIYbDXP29X7GpC9FRnJT1cULpecXkN14qTfs2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ko751jqXv12fv1JUOUlejK3crj7HagsFRuLCca/SUQFDQVGJUlNQbB63lPbfw+v9
	 CKAhSLaAKJim6aYnfohc0Bqv+0G06fkzP1X1ix1Peg14XxKiB2mCMr+E/xvbxbEsSJ
	 PnqrOClMrAmR8O5OpSdM1xiA+lUVFhrdi+FVBHes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Birger Koblitz <mail@birger-koblitz.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 120/449] net: sfp: add quirk for 2.5G OEM BX SFP
Date: Thu, 17 Apr 2025 19:46:48 +0200
Message-ID: <20250417175122.801178023@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




