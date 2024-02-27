Return-Path: <stable+bounces-24141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A8869349
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B42B2969B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2913AA50;
	Tue, 27 Feb 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hCVVEh3J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E113B2BF;
	Tue, 27 Feb 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041146; cv=none; b=Td0hkK9q/qf0KgXRPx6/99CvIKDgNf7nGRMLoH0ogps38JnPaEX+4gjtj9JFvWRQ/TZGk9B8IAQyOY/6+wYvQizDK80MHOMvkP5RaCmQzKzjYWSY2U7+rXhV6RmGaN/vLdoqZmYiLkbAE1ePu2FHcPN4R6v04/KYtmPogS7gthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041146; c=relaxed/simple;
	bh=BZxSiTM6IdYFHnzqUnPAQ/8/9XtJffvMNsDx7sc6+X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxctXUZGUBRqyJxMOAyk+xbHKh28oYtD5K4MiWwA2H1D56Ed3D7n4c9uhDG5COnvkJdD4DGJU0cNVC1GybvzcWJNDaoHNQe1arDOT07iv5O5vo1NVzJ/+UuC20UsffvmJFem7k5T+Xjp1p9sz6hAAzFNyKRP8wJQK5gvb+s4gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hCVVEh3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B3BC433F1;
	Tue, 27 Feb 2024 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041146;
	bh=BZxSiTM6IdYFHnzqUnPAQ/8/9XtJffvMNsDx7sc6+X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCVVEh3JhtyllptgUa+fLTPEXZrEbDtN53e3OOM2SuHkabew9p5qzaGpAcf3mUx24
	 /qRIPUjxcp5SnSft5UGNKgJsXK+D/+nfn+EodJ2lsr5n2ApjmzBJanc7ZZy6Y3wT9v
	 7HEkosIfPy7MWdM6fnggBEnRXIjkcr5gHvReP/B8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 236/334] arm64: dts: imx8mp: Disable UART4 by default on Data Modul i.MX8M Plus eDM SBC
Date: Tue, 27 Feb 2024 14:21:34 +0100
Message-ID: <20240227131638.481665013@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit f03869698bc3bd6d9d2d9f216b20da08a8c2508a ]

UART4 is used as CM7 coprocessor debug UART and may not be accessible from
Linux in case it is protected by RDC. The RDC protection is set up by the
platform firmware. UART4 is not used on this platform by Linux. Disable
UART4 by default to prevent boot hangs, which occur when the RDC protection
is in place.

Fixes: 562d222f23f0 ("arm64: dts: imx8mp: Add support for Data Modul i.MX8M Plus eDM SBC")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
index d98a040860a48..5828c9d7821de 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
@@ -486,7 +486,7 @@
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-	status = "okay";
+	status = "disabled";
 };
 
 &usb3_phy0 {
-- 
2.43.0




