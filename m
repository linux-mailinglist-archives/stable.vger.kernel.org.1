Return-Path: <stable+bounces-142441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4EAAEA9B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B702652389C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE05628AAE9;
	Wed,  7 May 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skGG7BNK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3571482F5;
	Wed,  7 May 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644260; cv=none; b=ZKPQkFiQ9qRsd31dstOZ7ZLW4/JMShRktKkz9QocJS4QvKBDd0jT+gOdNMlXzbYtWB+muSgVJZFRA9ZRioZdu5FdoY1HYW2VUZabOrPwVBJtKCu8t067FDz0C/F17UXvfL7QBIrN0k7awgzf9YUHXveOIWRGqsssTJpdPaOP+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644260; c=relaxed/simple;
	bh=oqmy6JE7vVkKbK4XN3lYgQ3Y1brTiqvFNnORZ+G3XTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+PZgi6PfV0C/JoQDqTukEjdmLcJ6W/vv3c3qZ4kpDT1nk9floOKT0Wed8NCSnAz1mpfoliaidjk4+qsMyUYNsEAcVwTzq7wt1neLAHnvfRJ4dsar6rxrPajcWpS7o4ZwfV1onwdz4CXlMg1LK1RZPXvSxbtnyvLe6yALA+S0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skGG7BNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F18C4CEE2;
	Wed,  7 May 2025 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644260;
	bh=oqmy6JE7vVkKbK4XN3lYgQ3Y1brTiqvFNnORZ+G3XTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skGG7BNKXYHGSUHtsVubcErB/Vl+qCSTy2ndchvbXTUoM0Pzl3zbwDOeujDtqQyA7
	 niqlRiE3Eoj3DyXjM47ohENhis54q03pq4ao4ywqJfeX8rOzjgZIeTbtmkI3cYkpvg
	 6HB4g4Siu5MOPQTVkXcvu0G/BxerS/u3V+6jV62E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Bruel <christian.bruel@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 170/183] arm64: dts: st: Adjust interrupt-controller for stm32mp25 SoCs
Date: Wed,  7 May 2025 20:40:15 +0200
Message-ID: <20250507183831.747103758@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Bruel <christian.bruel@foss.st.com>

[ Upstream commit de2b2107d5a41a91ab603e135fb6e408abbee28e ]

Use gic-400 compatible and remove address-cells = <1> on aarch64

Fixes: 5d30d03aaf785 ("arm64: dts: st: introduce stm32mp25 SoCs family")
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Link: https://lore.kernel.org/r/20250415111654.2103767-2-christian.bruel@foss.st.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index f3c6cdfd7008c..379e290313dc0 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -115,9 +115,8 @@
 	};
 
 	intc: interrupt-controller@4ac00000 {
-		compatible = "arm,cortex-a7-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0x0 0x4ac10000 0x0 0x1000>,
 		      <0x0 0x4ac20000 0x0 0x2000>,
-- 
2.39.5




