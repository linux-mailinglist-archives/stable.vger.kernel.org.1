Return-Path: <stable+bounces-523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90667F7B72
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D051C2096E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4431740;
	Fri, 24 Nov 2023 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bp7ctnax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48D364D6;
	Fri, 24 Nov 2023 18:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774E1C433C8;
	Fri, 24 Nov 2023 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849110;
	bh=4c9Ca7ggKIM+Ueto+RTAupmQ8JBcMsp7QwP3NuUaedQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp7ctnaxu7u7XEWEby0opm0F7Z8Cyf7+C6rRk98Fn6d3DOkmqWyXktzs2T6U4+dy9
	 7lCJWfL03dXEn07VY492fjnrgIEYj6SatMrUaOR0yt7Nk3fFqArc4otfExpHlZF7cF
	 UEJhKKZye05GTe1sIjmAgA0JoVYwjrw4qZLJ6Lvw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 027/530] net: sfp: add quirk for Fiberstone GPON-ONU-34-20BI
Date: Fri, 24 Nov 2023 17:43:13 +0000
Message-ID: <20231124172028.894146015@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit d387e34fec407f881fdf165b5d7ec128ebff362f ]

Fiberstone GPON-ONU-34-20B can operate at 2500base-X, but report 1.2GBd
NRZ in their EEPROM.

The module also require the ignore tx fault fixup similar to Huawei MA5671A
as it gets disabled on error messages with serial redirection enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20230919124720.8210-1-ansuelsmth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ecfac2278651..a50038a452507 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -452,6 +452,11 @@ static const struct sfp_quirk sfp_quirks[] = {
 	// Rollball protocol to talk to the PHY.
 	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
 
+	// Fiberstore GPON-ONU-34-20BI can operate at 2500base-X, but report 1.2GBd
+	// NRZ in their EEPROM
+	SFP_QUIRK("FS", "GPON-ONU-34-20BI", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
-- 
2.42.0




