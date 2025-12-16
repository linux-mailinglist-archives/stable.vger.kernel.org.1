Return-Path: <stable+bounces-202128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6AECC2DE5
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F5A319FDFC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6483934846D;
	Tue, 16 Dec 2025 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lr6MMogP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024B347FD0;
	Tue, 16 Dec 2025 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886906; cv=none; b=Rfv2ZGV3Vjkl89g05t6brBUjkT0+BWYZTwnfKX0gGnHVd2ofzHnJDwF03dpHPgAktPTjQcOY6QWY/+npYtPojvB+Z/wx8FoUXdLNftQCmf6ocJnSfXkdHRZKyYDH9nKqcvoGvYYpmMR/LF+6AbOyH3SBREu5poccNwmO+gntV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886906; c=relaxed/simple;
	bh=SqOsmrh3bJsxai/JdqF3TTYANASTc2hAhluZkCtqMJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfTaTLfWKzbUlVPZhGC94/7qE4ZL95cQqrXSC+MzsdsGRxIdAyBYCf4aavwvSZ0KjuyguVVUSH6jcDCOYE/JYHDjJtSj66S0Rj8ouIGjKN+8EvezEyW/qv6OuhKy4U9dn9DM9REYwZNdcZ9LugaRe93i666sZXUDQJi7+i3M/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lr6MMogP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854CDC4CEF1;
	Tue, 16 Dec 2025 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886906;
	bh=SqOsmrh3bJsxai/JdqF3TTYANASTc2hAhluZkCtqMJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lr6MMogPUJN4cGVkgLdMkO+rhkaJIZsq75TzORDdKWRenfnWufCYXkh0UuebXkBnS
	 stJqBQlijTooXCWvCnwk9xCV6eaGMjdphTAuQSGJj0wutNBFBT23y8X2Pm34tBUjAq
	 uBBnOaFfhlELQ7XzRD7iUe/RdQsNmBLeAYtpaasc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Harvey <tharvey@gateworks.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 069/614] arm64: dts: imx8mm-venice-gw72xx: remove unused sdhc1 pinctrl
Date: Tue, 16 Dec 2025 12:07:16 +0100
Message-ID: <20251216111403.814486182@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Harvey <tharvey@gateworks.com>

[ Upstream commit d949b8d12d6e8fa119bca10d3157cd42e810f6f7 ]

The SDHC1 interface is not used on the imx8mm-venice-gw72xx. Remove the
unused pinctrl_usdhc1 iomux node.

Fixes: 6f30b27c5ef5 ("arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini Development Kits")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/freescale/imx8mm-venice-gw72xx.dtsi      | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
index 752caa38eb03b..266038fbbef97 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
@@ -351,17 +351,6 @@ MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX	0x140
 		>;
 	};
 
-	pinctrl_usdhc1: usdhc1grp {
-		fsl,pins = <
-			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
-			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
-			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
-			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
-			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
-			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
-		>;
-	};
-
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
-- 
2.51.0




