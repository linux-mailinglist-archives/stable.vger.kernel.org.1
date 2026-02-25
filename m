Return-Path: <stable+bounces-218603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNz7CfFTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BE718FAED
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49243181DF9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3E26056D;
	Wed, 25 Feb 2026 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSSRsCN8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9D1FE45D;
	Wed, 25 Feb 2026 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983448; cv=none; b=f+0vGjGoMcJMF3HMZD14pZPwz+cL7qtyGOQ/iW3JuwIv0/OaHkqnCbZe+Oge9QoY3loVIo7hojyjpn9f7FDxUROc9E2kKYfAEf/estaiR5NeAGOjb2WBJL1oekUsAu9b9pajNDy+hdLSL/daQJbYVOcIu37nVLOxt8nC4KAZ2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983448; c=relaxed/simple;
	bh=IXeNWZSF2lzG9nJbO4eZ2PZv6uih5wzD1X30J025B0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YY2eAETv0/oDF5gVVLgm+Vf5sp9SD+JoOOwudpeJ5O3zes/2/nzTDGsV/rHsZ702MAn4Qb9hlXgIq5WnfplV7sb2ACLZ3XorEJ96qx83yGBWWtm+66iHQmnTmj8lEtnSmUKz/MowUPedqZCDho2q+mWBzpgC4UiVPKTfcIOxYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSSRsCN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D68C116D0;
	Wed, 25 Feb 2026 01:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983448;
	bh=IXeNWZSF2lzG9nJbO4eZ2PZv6uih5wzD1X30J025B0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSSRsCN8DjN5SgCl7Hl+PCeNKUuqyABeQmYBH/BMB3iaTmhOQDENnOOggFJQdQpnm
	 M0tqwpWk4o/3A/7YLL+sN17ts+W7uWzF3RDv9Lbie13Ee/tTw666BP6rGhE1RfjLob
	 s6LL3F9aoGEQqC5jrMYN/Tk7lE784xOvCHaEeuKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Derek Foreman <derek.foreman@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 564/781] phy: rockchip: samsung-hdptx: Pre-compute HDMI PLL config for 461.10125 MHz output
Date: Tue, 24 Feb 2026 17:21:13 -0800
Message-ID: <20260225012413.634623585@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218603-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90BE718FAED
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit f2daf0c67a1767ff6536aa3e96599afb42ca42e7 ]

Attempting to make use of a 1080p@120Hz display mode with 10 bpc RGB on
my Acer XV275K P3 monitor results in a blank image.  A similar behavior
has been reported on Philips 279M1RV.

The faulty modeline is created by drm_gtf_mode_complex() based on the
following EDID entry from the Standard Timings block:

  GTF:  1920x1080  119.999987 Hz  16:9    138.840 kHz    368.759000 MHz

It's worth noting the computed pixel clock ends up being slightly higher
at 368.881000 MHz.  Nevertheless, this seems to work consistently fine
with 8 bpc RGB.

After switching to 10 bpc, the TMDS character rate expected for the mode
increases to 461.101250 MHz, as per drm_hdmi_compute_mode_clock().

Since there is no entry for this rate in the ropll_tmds_cfg table, the
necessary HDMI PLL configuration parameters are calculated dynamically
by rk_hdptx_phy_clk_pll_calc().  However, the resulting output rate is
not quite a perfect match, i.e. 461.100000 MHz.  That proved to be the
actual root cause of the problem.

Add a new entry to the TMDS configuration table and provide the
necessary frequency division coefficients for the PHY PLL to generate
the expected 461.101250 MHz output.

Fixes: 9d0ec51d7c22 ("phy: rockchip: samsung-hdptx: Add high color depth management")
Tested-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20251221-phy-hdptx-pll-fix-v2-1-ae4abf7f75a1@collabora.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 29de2f7bdae8a..cafa618d70fdc 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -414,6 +414,8 @@ struct rk_hdptx_phy {
 static const struct ropll_config ropll_tmds_cfg[] = {
 	{ 594000000ULL, 124, 124, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
+	{ 461101250ULL, 97, 97, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 71, 1, 53, 2, 6,
+	  35, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 371250000ULL, 155, 155, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
 	  1, 1, 0, 0x20, 0x0c, 1, 0x0e, 0, 0, },
 	{ 297000000ULL, 124, 124, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 62, 1, 16, 5, 0,
-- 
2.51.0




