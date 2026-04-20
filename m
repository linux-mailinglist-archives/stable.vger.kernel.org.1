Return-Path: <stable+bounces-239390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKk5AHJX5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878BD42FDEC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99C3B34277D0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C83385B2;
	Mon, 20 Apr 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DALk+aIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06932D77E5;
	Mon, 20 Apr 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700124; cv=none; b=Y1R2s9OFeJ/HrAzC4yehYOpStqmok8Bkq7TdmCe/MCk1v01HwYKqU4RL2zultllPQuM3nAYuJhTSon/LX6Y7GKYpBVFsSDPQygcuoQiOTJaYtZCUliyQGYSTp7UhwR8eXX6BEY2pC62EjDu2Z/Mvxfs2+NdxXuujyFiMQZDNB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700124; c=relaxed/simple;
	bh=ZrkRUTh9E+8ir40mHqvEStSGPMVSHJcmpq0phe9OmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a703sQruhU+0couDs/yoVvkV28MXyOUpFQGjpPkt9veLVzuc/wFpOQDnT03mCz+5zLJ9MxcbE8g0Tz/seqTGmH40ibc4duI4d7lvdcgYaiFxz9qTqMin7haaOJh7OEBdUK8oeXDZkamdDXuCtvGwFZsqcGGMFQkjG0wx2mR0KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DALk+aIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29B5C19425;
	Mon, 20 Apr 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700124;
	bh=ZrkRUTh9E+8ir40mHqvEStSGPMVSHJcmpq0phe9OmQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DALk+aIpHNOFdJc9MlrX7AoXY5mrEpV5mOzvn32uBmXg2t1WzHpaEVsbvgWAyDjTw
	 pN31h06X7a43DhlJ+DktyA0DGyzga83Qa4GFEFBWv0dq0/3E+1xw0a7aHM8qFba4IJ
	 355i/wF5a+G1h10u4IYfu0/9tiHF5Ni+ABp0LgPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 052/220] arm64: dts: imx91-tqma9131: improve eMMC pad configuration
Date: Mon, 20 Apr 2026 17:39:53 +0200
Message-ID: <20260420153935.914764758@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239390-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 878BD42FDEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

[ Upstream commit 44db7bc66eb38e85bb32777c5fd3a4e7baa84147 ]

Use DSE x4 an PullUp for CMD an DAT, DSE x4 and PullDown for CLK to improve
stability and detection at low temperatures under -25°C.

Fixes: e71db39f0c7c ("arm64: dts: freescale: add initial device tree for TQMa91xx/MBa91xxCA")
Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx91-tqma9131.dtsi    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
index 5792952b7a8e1..c99d7bc168483 100644
--- a/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
@@ -272,20 +272,20 @@ pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = /* PD | FSEL 3 | DSE X5 */
-			   <MX91_PAD_SD1_CLK__USDHC1_CLK		0x5be>,
+			   <MX91_PAD_SD1_CLK__USDHC1_CLK		0x59e>,
 			   /* HYS | FSEL 0 | no drive */
 			   <MX91_PAD_SD1_STROBE__USDHC1_STROBE		0x1000>,
 			   /* HYS | FSEL 3 | X5 */
-			   <MX91_PAD_SD1_CMD__USDHC1_CMD		0x400011be>,
+			   <MX91_PAD_SD1_CMD__USDHC1_CMD		0x4000139e>,
 			   /* HYS | FSEL 3 | X4 */
-			   <MX91_PAD_SD1_DATA0__USDHC1_DATA0		0x4000119e>,
-			   <MX91_PAD_SD1_DATA1__USDHC1_DATA1		0x4000119e>,
-			   <MX91_PAD_SD1_DATA2__USDHC1_DATA2		0x4000119e>,
-			   <MX91_PAD_SD1_DATA3__USDHC1_DATA3		0x4000119e>,
-			   <MX91_PAD_SD1_DATA4__USDHC1_DATA4		0x4000119e>,
-			   <MX91_PAD_SD1_DATA5__USDHC1_DATA5		0x4000119e>,
-			   <MX91_PAD_SD1_DATA6__USDHC1_DATA6		0x4000119e>,
-			   <MX91_PAD_SD1_DATA7__USDHC1_DATA7		0x4000119e>;
+			   <MX91_PAD_SD1_DATA0__USDHC1_DATA0		0x4000139e>,
+			   <MX91_PAD_SD1_DATA1__USDHC1_DATA1		0x4000139e>,
+			   <MX91_PAD_SD1_DATA2__USDHC1_DATA2		0x4000139e>,
+			   <MX91_PAD_SD1_DATA3__USDHC1_DATA3		0x4000139e>,
+			   <MX91_PAD_SD1_DATA4__USDHC1_DATA4		0x4000139e>,
+			   <MX91_PAD_SD1_DATA5__USDHC1_DATA5		0x4000139e>,
+			   <MX91_PAD_SD1_DATA6__USDHC1_DATA6		0x4000139e>,
+			   <MX91_PAD_SD1_DATA7__USDHC1_DATA7		0x4000139e>;
 	};
 
 	pinctrl_wdog: wdoggrp {
-- 
2.53.0




