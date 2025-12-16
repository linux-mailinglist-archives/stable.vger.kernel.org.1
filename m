Return-Path: <stable+bounces-202168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA46CC28F6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B4A93026BE6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285B3659E6;
	Tue, 16 Dec 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFctP0js"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CC3659E5;
	Tue, 16 Dec 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887035; cv=none; b=ZhLN5dc3G+XsS7bvWbtJtRJRQNVll6UOay8KBTPUC2SfKn2rDPS992rC+FZINd9SiE0M2jg4FDJNhhSpzZNBuG+jNswx5rD5QoNw5plsgF5RbOtfqsiWFEN63lo7RY6AKglqLheGbBLpqlFRVfj4NwzRO0oJmyuA/jQGiPLKsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887035; c=relaxed/simple;
	bh=4IiCX5V29VzA70ytlGfBvBHeiV2CY33zDJJBGwQ9djY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lr1g0+e6Hv9QDqPyMn7Tozcab7E5qjWmxnMBgT5KU1y4KTe6naPmKm1mp2sUGOae7iKyPlBsAEFPDTRUt3OtxeJHA6Ll9Y6NW4O1u18YQ1WNrP39V3rNmgXyEGfOCMibzgjZcl9t3Xr3uieCXN2mMShHKEvqcC1MN7670G3A6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFctP0js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C014C4CEF1;
	Tue, 16 Dec 2025 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887035;
	bh=4IiCX5V29VzA70ytlGfBvBHeiV2CY33zDJJBGwQ9djY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFctP0jsDXfMv/BY7/2Q+jZ/XFny3SAsgKeujFHQtVAPRe0NHmPNHqyJpheagBC6B
	 P3whTSCmYU9adWJoEkv0kCVR5UxCHFByRw4li46FRLUMOR3kTp7mP42XuJSeNg1HFH
	 5zVhh3i7p2vTpFYHpSb7V+T1uN9OtgbXxrqk+TEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randolph Sapp <rs@ti.com>,
	Michael Walle <mwalle@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 108/614] arm64: dts: ti: k3-am62p: Fix memory ranges for GPU
Date: Tue, 16 Dec 2025 12:07:55 +0100
Message-ID: <20251216111405.249537449@linuxfoundation.org>
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

From: Randolph Sapp <rs@ti.com>

[ Upstream commit 76546090b1726118cd6fb3db7159fc2a3fdda8a0 ]

Update the memory region listed in the k3-am62p.dtsi for the BXS-4-64
GPU to match the Main Memory Map described in the TRM [1].

[1] https://www.ti.com/lit/ug/spruj83b/spruj83b.pdf

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Signed-off-by: Randolph Sapp <rs@ti.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Link: https://patch.msgid.link/20250919193341.707660-2-rs@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b..dd24c40c7965d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -59,7 +59,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
-			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
 			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
-- 
2.51.0




