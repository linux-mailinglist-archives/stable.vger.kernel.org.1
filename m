Return-Path: <stable+bounces-117807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6FFA3B84D
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A35188797B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921D1DE4CE;
	Wed, 19 Feb 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcWTr7hf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765C1C173D;
	Wed, 19 Feb 2025 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956397; cv=none; b=De+F5KRc2SHG7XuwvaUGR3FcfWEx4rfjfhSGWWNF6HmB8TysmZz503sZsPjICBpt57qSIjVhmMXMxE/zY4SXLcT8QSFGsEDkhgYhD2YsprrNCJHihbpyD7xoVlRiJjFQ++nqwS47UL5wVkq++9kyNxeGX1e+rcqloqfbCwLf/ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956397; c=relaxed/simple;
	bh=jyYKaVjN2ee15XQXSrCF7yBdOjQoJkVZyE5W/OZK0v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjDXJag5zhQotrALEayPg6GBITo2wzvhqKJ8t82CNRYNM/04Dk5OqWPJY1Ikqz8paKWXfsxAj9Bxm6jHkYTayWBkDU0YeYmB9Zw27Vv9zlDxm90vvIzRiXzsADKe0AruHrkfUKi/CbqIQVDOcB0fk42LwaTkRmZmYNdTOP/3gLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcWTr7hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA71C4CED1;
	Wed, 19 Feb 2025 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956397;
	bh=jyYKaVjN2ee15XQXSrCF7yBdOjQoJkVZyE5W/OZK0v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcWTr7hfe9WATJAmpOFFAuhacSdeuMd98+yKBiKRTsv/SWZFWED1uelcs4fKxIRWH
	 leBMeYxUP5iRlRPtsVsa+W19QanYoutWIAdcCnDwmeEk5ISLq7a+Om8HlWTYCFFo/5
	 HnSXMR33NqmI0kgzOAREKyWk4JyE7YQoDhVPzUwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bin Liu <b-liu@ti.com>,
	Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 165/578] arm64: dts: ti: k3-am62a: Remove duplicate GICR reg
Date: Wed, 19 Feb 2025 09:22:49 +0100
Message-ID: <20250219082659.458284181@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan Brattlof <bb@ti.com>

[ Upstream commit 6f0232577e260cdbc25508e27bb0b75ade7e7ebc ]

The GIC Redistributor control range is mapped twice. Remove the extra
entry from the reg range.

Fixes: 5fc6b1b62639 ("arm64: dts: ti: Introduce AM62A7 family of SoCs")
Reported-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
Link: https://lore.kernel.org/r/20241210-am62-gic-fixup-v1-2-758b4d5b4a0a@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 9301ea3888021..4b349d73da21f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -18,7 +18,6 @@
 		compatible = "arm,gic-v3";
 		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
 		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
-		      <0x00 0x01880000 0x00 0xc0000>,   /* GICR */
 		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
 		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
 		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
-- 
2.39.5




