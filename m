Return-Path: <stable+bounces-253031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEqnGfQADmqs5QUAu9opvQ
	(envelope-from <stable+bounces-253031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CC5971D7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B070831461EA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5892270545;
	Wed, 20 May 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8Gw4t0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709AC331A41;
	Wed, 20 May 2026 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302223; cv=none; b=UWLyTAcK+ayCZAaENi7h1VIK3PfzqUul6eUGilUmF0lbXg0Cat1AliHEHkf9Ao/TTTv7bv7tFU+/0ei7ie6D4SZ+wnj4Nzb7RZd06Biyw8fwQhc02m5uD2DBVoItqMlltJWhfNcRcYGK7LNUlGCwBdAqwkOxQdnSfcG/G2ZYYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302223; c=relaxed/simple;
	bh=9eAze9ulSL716molV/t9se/wgUJzD8B8eCxadUJ8byY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G851PnljfWnDnxx/Mk9jGeelA55PH0gF+UNqBBYjQe50hgCVXINH/yjYyrGnFgVchXmpbSIS3wPelMMgfrUyjbHpOCHsvG2eQss9ZILZt/Nc90YEvJRtdWWEXPSxzCauA4pZBHv67Okq0oBF855TsUvReaSiJbq/OqNLE+ZPJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8Gw4t0s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7D21F000E9;
	Wed, 20 May 2026 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302222;
	bh=QfkpeCg1AfeGv2MkWT/gSEKtgyaX3b8iXqnJh3BlGfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S8Gw4t0sVJltEt7D+EHKhMcjWBh85KzcSdOm5NOkUbD/e2wphyP29fbAjakpWxeRs
	 /c6EUnxzdF7mhxVVNJJ+mLQc+5plsmgh0TTi24vkuEZau7bg5GkOS1hDYsHIIciTcp
	 oKYw925mGrq/eFBMYTtyxjHQKIaRi1O3Qqjp61iE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sherry Sun <sherry.sun@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 185/508] arm64: dts: imx8mp-evk: Enable pull select bit for PCIe regulator GPIO (M.2 W_DISABLE1)
Date: Wed, 20 May 2026 18:20:08 +0200
Message-ID: <20260520162102.644298229@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-253031-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 016CC5971D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sherry Sun <sherry.sun@nxp.com>

[ Upstream commit d1e7eab6033f9885a02c4b4e8f09e34d8e9d21ab ]

The current pin configuration for MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06
sets the weak pull-up but does not enable the pull select field.
Bit 8 in the IOMUX register must be set in order for the weak pull-up
to actually take effect.

Update the pinctrl setting from 0x40 to 0x140 to enable both the pull
select and the weak pull-up, ensuring the line behaves as expected.

Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 92f8cc05fe9da..e29b6e9a70276 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -764,7 +764,7 @@ MX8MP_IOMUXC_SD1_DATA5__GPIO2_IO07	0x40
 
 	pinctrl_pcie0_reg: pcie0reggrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x40
+			MX8MP_IOMUXC_SD1_DATA4__GPIO2_IO06	0x140
 		>;
 	};
 
-- 
2.53.0




