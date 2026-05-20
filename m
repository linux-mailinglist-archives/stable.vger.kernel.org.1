Return-Path: <stable+bounces-251620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNHTATkcDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:40:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C293599E89
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96D2340BE1D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745E369D67;
	Wed, 20 May 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xqxtU4Yz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CE9312825;
	Wed, 20 May 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298456; cv=none; b=VSmHw5b85cpmXgK5TQ1NEb9pPBdv7IejnllMZVu+lDoqU+lzCD2nbERNPJtLM8/NWuiB/wG2fb2Jo9c3HM04swJ39escsCZtU/x/D+uIaTqvNQhli0A5cgl4b7tBUTCQrBNDdj2CX7R2FeSOYaZVyYHE5R3Tig2AVEfSThjOMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298456; c=relaxed/simple;
	bh=eCSeVju3pQ0Wf2QgRdkB4t7ERMBJgaVX80syj/9SI50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZjVMl1TImbyaqnrkVUckfwYhkjVCT9nXvvnAiDdfZuVWVFCTAhx1zBnAT3KOrglSB0FaNUvO3Dp+vYd8Y7LajzXXxjrjLwb0oCzi7IoxJVnvAQ6IOnAotUaKr7rZCSRhqDqUcdlS66Oio1CemY2vZwnYYoH6GvjnNDDAJjVdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xqxtU4Yz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05711F000E9;
	Wed, 20 May 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298455;
	bh=CBFEVCwjgScy3m+scWSQl2XbMsXTEQnfdIaMmn+OzmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xqxtU4Yz1VDhwY16zUUeFbpt/8w7fnKkAcNkOUBuQ1F/E/pPmLgeM8AFewmdzPcyN
	 BVcoHypwv+yjbFz3xKQXQOH+wi/JCv4v/uXVytBFAIdCXIQ02cNCTczNeZQN7gWsnm
	 OVmHk38ZkhvLwvqXFnZ3x92a22nC2jwrw7RNysT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Annette Kobou <annette.kobou@kontron.de>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 417/957] arm64: dts: imx8mp-kontron: Fix boot order for PMIC and RTC
Date: Wed, 20 May 2026 18:15:00 +0200
Message-ID: <20260520162143.565944673@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.0.52:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,kontron.de:email]
X-Rspamd-Queue-Id: 6C293599E89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Annette Kobou <annette.kobou@kontron.de>

[ Upstream commit 130d90114c5255a7a729158da8fd8298a02017f1 ]

The PMIC provides a level-shifter for the I2C lines to the RTC. As the
level shifter needs to be enabled before the RTC can be accessed, make sure
that the PMIC driver is probed first.

As the PMIC also provides the supply voltage for the RTC through the 3.3V
regulator, simply express this in the DT to create the required dependency.

Avoid sporadic boot hangs that occurred when the RTC was accessed before
the level-shifter was enabled.

Fixes: 946ab10e3f40f ("arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier board")
Signed-off-by: Annette Kobou <annette.kobou@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
index b97bfeb1c30f8..bc1a261bb000e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
@@ -330,6 +330,12 @@ rv3028: rtc@52 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rtc>;
 		interrupts-extended = <&gpio3 24 IRQ_TYPE_LEVEL_LOW>;
+		/*
+		 * While specifying the vdd-supply is normally not strictly necessary,
+		 * here it also makes sure that the PMIC driver enables the level-
+		 * shifter for the RTC before the RTC is probed.
+		 */
+		vdd-supply = <&reg_vdd_3v3>;
 	};
 };
 
-- 
2.53.0




