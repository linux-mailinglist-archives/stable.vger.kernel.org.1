Return-Path: <stable+bounces-113562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F698A292D4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4BC3A84AF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8C194A45;
	Wed,  5 Feb 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1Axrkh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729D19415E;
	Wed,  5 Feb 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767384; cv=none; b=hDqfB7sn8zED0guaCxoLmqCvIjzLSGzXD2/SgidXUrD6ksX64P88GRa0JSDqT9iw0XJTizUFCKNmwny8pDceoMYYW1NdakGZGCUfJDFdqK0LYGsZo08JxExOWSF49Z2869Q8hYnO7gntlUUuKZCGq2UsILTVVvhiyTEwgkqJbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767384; c=relaxed/simple;
	bh=g9lUN+Q+3o2c5vQAwHs6YI47noNv2LGoyPwi54xWw8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0HjgXnKn4FgCmPMxH9Wq93qrPn/Pb8Zmv4+SLQDJhN4l582FlmfSKZgnctPa8NvdIhQ/l/G55VlWujyJLaA8rASN8j8SI9oovgEH2/qg3gCP2uhscoAbpciAd2bphKB47oVZfEKWZmqMno/09FgigjL/RyWuEH1qEJKP9rldUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1Axrkh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7734EC4CED6;
	Wed,  5 Feb 2025 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767383;
	bh=g9lUN+Q+3o2c5vQAwHs6YI47noNv2LGoyPwi54xWw8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1Axrkh2UQbtG1LerJEEneYzNYo5fpyPRtQaxCCJi4ryyQc0lW0bxb+5O3SN2nM3c
	 KojITjQrPo6Tz0S0lzLt35EyvFL0orfCuZkSjJYfQEW/FA+SWNSN11feAK0mietjhz
	 9s9RhpILH+ZqOlv1HhOa/83iWE+VdXaZcPOJo5Zc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bin Liu <b-liu@ti.com>,
	Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 397/623] arm64: dts: ti: k3-am62a: Remove duplicate GICR reg
Date: Wed,  5 Feb 2025 14:42:19 +0100
Message-ID: <20250205134511.410094116@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
index a93e2cd7b8c74..a1daba7b1fad5 100644
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




