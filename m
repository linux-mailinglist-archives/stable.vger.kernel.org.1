Return-Path: <stable+bounces-217362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C27DplxlmlqfQIAu9opvQ
	(envelope-from <stable+bounces-217362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:12:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A235D15B98D
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 03:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7E2030764BF
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 02:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768D2FFFA5;
	Thu, 19 Feb 2026 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuZjLIzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F183033D8;
	Thu, 19 Feb 2026 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771466693; cv=none; b=sfoQVfnWn+FlHKWqtwo12EipkR85nPJRheIh3jxjvOofDujNLvfoFpw3SDljanASRwIWS8ZkZymgYw2pbtIzAFsBvsKNR7lsvj59/YQJ1eGkO9jDX1hIqtj81DRrxU5JTO3RLl4EcDikWVyl5+l4leh3160+FHK8MvXociYcIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771466693; c=relaxed/simple;
	bh=e6NMrq76++ecy0geh6Jz+iENGud9CnyXfiTKqmuZpl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+PYIlvl5G3St3gqwp/+a9pGUBIBO5Sm9rDDB7xSTc0BBLwcpm5nlXxr/2IYjODUGshC0jx8Xlub40/5H9/xoptSMG7fPH+V5wDFbLOwZ3lOgDH79Y3UPAPsvWgOGLftrQcMD+57zE7hhTw617Hj1HRmqtB0SgCvvdALj1g6BqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuZjLIzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4E9C2BCB0;
	Thu, 19 Feb 2026 02:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771466692;
	bh=e6NMrq76++ecy0geh6Jz+iENGud9CnyXfiTKqmuZpl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuZjLIzrIsJU//QrkMDNcNPG/TadX40ubZ20TKRAMWR1syMhZbfUf3nF/xaJ7LCw1
	 pwMLeeDS7fhBTqhFXdoRpu3mWg/mbNbn8KkBbdkyUWWR281PgO0ECg/zt2Ch1CUhbV
	 q7h1pHC1KySuwC9HFWqTHl/wnyooTxhDK8GyC9Wv1GCPd+5wqh/uFKkVcLNvh0Fr5e
	 xtlNJu1zO3/RkZMAhFs10/4l/IeT8b/Hj+OR2rDBBUK67YUPcxi+H/zUur8EMjPUO4
	 b/AV3FXUIUuLZ/AB3XRZw3zSPt4owpVzHiZUXZXtKk7pbnUYBnR1V2HRnlQdvnc49Z
	 3s+T1A/KI4teA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] phy: cadence-torrent: restore parent clock for refclk during resume
Date: Wed, 18 Feb 2026 21:03:59 -0500
Message-ID: <20260219020422.1539798-23-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219020422.1539798-1-sashal@kernel.org>
References: <20260219020422.1539798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.2
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: A235D15B98D
X-Rspamd-Action: no action

From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>

[ Upstream commit 434e1a0ee145d0389b192252be4c993f86cf1134 ]

While suspend and resume, parent clock config for refclk was getting lost.
So save and restore it in suspend and resume operations.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
Link: https://patch.msgid.link/20251216-phy-cadence-torrent-resume-restore-refclk-parent-v3-1-8a7ed84b47e3@bootlin.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The verification confirms all the key elements:

1. **`cdns_torrent_refclk_driver_get_parent` and
   `cdns_torrent_refclk_driver_set_parent`** exist and are well-defined
   clock operations that read/write register fields for the clock mux
   configuration.

2. **`CDNS_TORRENT_REFCLK_DRIVER`** is defined as index `0` in
   `include/dt-bindings/phy/phy-cadence.h` and is used to index into
   `clk_hw_data->hws[]`.

3. **Suspend/resume was introduced in commit `0da27ed080b2c`** (April
   2024) by the same author (Thomas Richard). This means the
   suspend/resume feature already exists in recent kernels, and this is
   a bug fix to that existing feature.

4. All structures and fields referenced by the new code are actively
   used in the driver.

## Verification Summary

- **Verified**: `cdns_torrent_refclk_driver_get_parent()` and
  `cdns_torrent_refclk_driver_set_parent()` exist and operate on
  register fields via regmap - these are the standard clock parent
  operations.
- **Verified**: `CDNS_TORRENT_REFCLK_DRIVER` = 0, used as clock index in
  `clk_hw_data->hws[]`.
- **Verified**: Suspend/resume functions were added in commit
  `0da27ed080b2c` (April 2024) by the same author - this is a follow-up
  fix to that code.
- **Verified**: The `parent_index` field and new suspend/resume helpers
  only use existing, proven APIs.
- **Verified**: The patch is reviewed by Neil Armstrong and signed off
  by the PHY subsystem maintainer Vinod Koul.
- **Note**: The suspend/resume support was introduced in v6.11 merge
  window timeframe (April 2024), so this fix is relevant for stable
  trees that include that commit.

## Classification

This is a **clear bug fix** for suspend/resume functionality:
- **Bug type**: State loss during power transitions (clock parent
  configuration lost)
- **Impact**: PHY may not function correctly after resume, potentially
  breaking PCIe, USB, or DisplayPort links
- **Scope**: Small, contained, single-driver fix (~22 lines)
- **Risk**: Very low - uses existing APIs, standard save/restore pattern
- **Dependencies**: Requires the suspend/resume support commit
  (`0da27ed080b2c`) to be present in the stable tree

## Conclusion

This commit fixes a real suspend/resume bug where clock parent
configuration is lost, causing the PHY to malfunction after resume. The
fix is small, obviously correct, well-reviewed, and follows standard
kernel suspend/resume patterns. It meets all stable kernel criteria:
fixes a real bug, is small and contained, introduces no new features,
and has minimal regression risk.

The only consideration is that the stable tree must already contain the
initial suspend/resume support (commit `0da27ed080b2c` from ~April
2024), which limits this to newer stable branches (6.11+).

**YES**

 drivers/phy/cadence/phy-cadence-torrent.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 37fa4bad6bd72..877f22177c699 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -397,6 +397,7 @@ struct cdns_torrent_refclk_driver {
 	struct clk_hw		hw;
 	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
 	struct clk_init_data	clk_data;
+	u8 parent_index;
 };
 
 #define to_cdns_torrent_refclk_driver(_hw)	\
@@ -3326,11 +3327,29 @@ static const struct cdns_torrent_vals sgmii_qsgmii_xcvr_diag_ln_vals = {
 	.num_regs = ARRAY_SIZE(sgmii_qsgmii_xcvr_diag_ln_regs),
 };
 
+static void cdns_torrent_refclk_driver_suspend(struct cdns_torrent_phy *cdns_phy)
+{
+	struct clk_hw *hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	refclk_driver->parent_index = cdns_torrent_refclk_driver_get_parent(hw);
+}
+
+static int cdns_torrent_refclk_driver_resume(struct cdns_torrent_phy *cdns_phy)
+{
+	struct clk_hw *hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER];
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	return cdns_torrent_refclk_driver_set_parent(hw, refclk_driver->parent_index);
+}
+
 static int cdns_torrent_phy_suspend_noirq(struct device *dev)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(dev);
 	int i;
 
+	cdns_torrent_refclk_driver_suspend(cdns_phy);
+
 	reset_control_assert(cdns_phy->phy_rst);
 	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++)
@@ -3352,6 +3371,10 @@ static int cdns_torrent_phy_resume_noirq(struct device *dev)
 	int node = cdns_phy->nsubnodes;
 	int ret, i;
 
+	ret = cdns_torrent_refclk_driver_resume(cdns_phy);
+	if (ret)
+		return ret;
+
 	ret = cdns_torrent_clk(cdns_phy);
 	if (ret)
 		return ret;
-- 
2.51.0


