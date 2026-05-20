Return-Path: <stable+bounces-253049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPINHCABDmo95QUAu9opvQ
	(envelope-from <stable+bounces-253049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3745972A4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E09A316419D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241A83E2AAD;
	Wed, 20 May 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+csbheH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8475DF59;
	Wed, 20 May 2026 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302270; cv=none; b=OuM+lDdKaTIxpkZDKWXEfyoFg5Ck+VAuSOn1GJ6fVvldIvUMD2JzTNW/kHmGayoWZNt0qdWase6fE4dgB9ZUqur6k6+unwGvskl5Yg6/zCNqTYTY8NecdhJMQAP0iDlZmpf7c1doLzAHjfj5w4weSvUY1MlqpuKpRN7GNqwIfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302270; c=relaxed/simple;
	bh=HKHD8SoC8det60i41cx9PyvoUk5aPbd3vdkpJvT5JE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pthk0iPti47XyQBn1uv8VkbrZEamul5jwhHhext445KOEngpkhwfY+oAeBepfKmrIBgsgTgST1+WX2rqc7lxRzCW2iY2oVnG5aYQa4jrZf/aJ8u4ny+AuEhimg7hO2Vr5z+2gO4UHVVPBu4SxuFjv04zETzk5A+blupk6Qqr0Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+csbheH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8FC1F000E9;
	Wed, 20 May 2026 18:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302269;
	bh=u/EBVKGppiTMptyWgJHQD2rr298cllV+q7CZJySDM6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+csbheHPcxTEILcJjVAkmkQKsKr+rgEId3+nNPQab/wezE6oo4Vbgh024qRbDxUy
	 sOKxExUKPX3A6wpgx4TytsQaForVOMNopqi5zzJ5elegV6JcNXOfc0WMfep8wxjdxl
	 eClocQ078Vy9I2aPrQHVZSZggYDaIe96XKPaBuI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 202/508] arm64: dts: imx8qxp-mek: switch Type-C connector power-role to dual
Date: Wed, 20 May 2026 18:20:25 +0200
Message-ID: <20260520162103.015096187@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253049-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0D3745972A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 825b8c7e1d2918d89eb378b761530d1e51dba82e ]

When attach to PC Type-A port, the USB device controller does not function
at all. Because it is configured as source-only and a Type-A port doesn't
support PD capability, a data role swap is impossible.

Actually, PTN5110THQ is configured for Source role only at POR, but after
POR it can operate as a DRP (Dual-Role Power). By switching the power-role
to dual, the port can operate as a sink and enter device mode when attach
to Type-A port.

Since the board design uses EN_SRC to control the 5V VBUS path and EN_SNK
to control the 12V VBUS output, to avoid outputting a higher VBUS when in
sink role, we set the operation current limit to 0mA so that SW will not
control EN_SNK at all.

Fixes: 2faf4ebcee2e5 ("arm64: dts: freescale: imx8qxp-mek: enable cadence usb3")
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7924b0969ad8f..3814568e4ee50 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -161,9 +161,17 @@ typec_dr_sw: endpoint {
 		usb_con1: connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "source";
+			power-role = "dual";
 			data-role = "dual";
+			try-power-role = "sink";
 			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			/*
+			 * Set operational current to 0mA as we don't want EN_SNK
+			 * enable 12V VBUS switch when it work as a sink.
+			 */
+			sink-pdos = <PDO_FIXED(5000, 0, PDO_FIXED_USB_COMM)>;
+			op-sink-microwatt = <0>;
+			self-powered;
 
 			ports {
 				#address-cells = <1>;
-- 
2.53.0




