Return-Path: <stable+bounces-250795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEsZNEX4DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52559552F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44A6E30F3E03
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247723EFD09;
	Wed, 20 May 2026 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQJgs0VB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142E3EAC83;
	Wed, 20 May 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296332; cv=none; b=tYDa3/yE/2EpBpah3TiivGvKNDJxkmBourDbP4jzLwc3LOAfWmPO9kNRZeuuV4SBLPYbF9lxT3tSoxRyyx17YcsuUkQlo0lSGnqrsaxpQDbHbGpD3DIWEcj8dXADCU6g8CbYyW2bY3JxxjaegL/676moktiSBdPq8QS4hqmEgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296332; c=relaxed/simple;
	bh=Hvfc3JJ0nz6A0CHlEtAmClbA/RyhuK+YOPZ69HTCpFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxTA3LZWMJLI4RVpY7dassM70+xChykX4SmKb0kNyvVzSfX2tUzJU8iqVxioFlyw94cIYZqBnSUZlWI+ynpGtgaDWlyQH9eyFHUN8R76C9j04aW8kjrqPSQLY10kL9CHMIgzFIoojo9BH/wCEM+2pVN+NTksCYp/LxVzjhooNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQJgs0VB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9641F000E9;
	Wed, 20 May 2026 16:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296331;
	bh=/Y2U0MPTIeEwzIxJiL8KaS83x9y2kCA0cY1BlPcoCXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RQJgs0VBXjeR9FFsXieGSEula1vbSMKk0NFkXxDC3bg+yjMvkoa5VPBdt8swFrgDS
	 8IZ5RAZ2FxhCXYCCxdzjnZctnzIHt99ZnO4DHAtofSe5OeHrZKYuniZ7CaZGD9jVuF
	 tBGYX2kVpBaTTooT6qaA/VpDtzLEfkHA77YQEZCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0759/1146] arm64: dts: imx8mp-dhcom-som: Correct PAD settings for PMIC_nINT
Date: Wed, 20 May 2026 18:16:49 +0200
Message-ID: <20260520162205.387846766@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250795-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C52559552F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit f9ed5afc988da3e22543725e35be6addbb0497bc ]

PMIC_nINT is low level triggered, but the current PAD settings is
PE=0,PUE=0,FSEL_1_FAST_SLEW_RATE=1,SION=1. So PAD needs to be configured
as PULL UP with PULL Enable, no need SION. Correct it.

Fixes: 8d6712695bc8e ("arm64: dts: imx8mp: Add support for DH electronics i.MX8M Plus DHCOM and PDK2")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
index f8303b7e2bd22..0a6a60670f762 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-dhcom-som.dtsi
@@ -989,7 +989,7 @@ MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20		0x22
 	pinctrl_pmic: dhcom-pmic-grp {
 		fsl,pins = <
 			/* PMIC_nINT */
-			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x40000090
+			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x1c0
 		>;
 	};
 
-- 
2.53.0




