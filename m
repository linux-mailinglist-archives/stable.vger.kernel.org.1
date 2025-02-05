Return-Path: <stable+bounces-113366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A170A291F9
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87060188C6C0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3821DC9BA;
	Wed,  5 Feb 2025 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XY81unAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBB1C6BE;
	Wed,  5 Feb 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766718; cv=none; b=rxbvUpgCoMsxtoDud71i2KajXwnVl06Pmm8ooRR3dASxRLcXtQ69ETM8tsayHX8VDdOgeiDUxocsjTLhkr0N+oyMjOc6iVp/i6sDs3x3guJfoIg/zIBkMoDHYxOH85Fk/nfpBR8ZjC/vSBCXRJjbDdyxKIzPtJddTLs4xtZFLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766718; c=relaxed/simple;
	bh=0gBx31L0gJ8iaz5sLf6BtUnOZse9q3GKOlEvBMRn2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAGz71qFrSdLQvzyS+8YKrNbba5XlXv/A/Pafrd8xh5YJhaJ6Dc7JBmOhggYn0AOY2GIOOjD12800nfQ9/9t9UB1wijpQDYSU3XhIyX07cYhl4RQoadMQJNiU+JNMNe8QROKW1ydM64J/Yno+Hz3PL977DC1eK17AAVFoYkvXgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XY81unAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F32CC4CED1;
	Wed,  5 Feb 2025 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766717;
	bh=0gBx31L0gJ8iaz5sLf6BtUnOZse9q3GKOlEvBMRn2rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XY81unACoA8XlPybPs1X1wxYq7aaW4L+g/5i6ZnN0F0p/Q0MjSWHMho+dYuYBxNxS
	 +VkGkpw61KRo2oNFYHZLD7ywOzZGzsyWyYYEiIE3GABDFKN6sbafdg0L31uCDqIA/+
	 1jGMTUyto/x08ytYVaOB74fVSj4hsyH/wEKxOiL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 353/590] arm64: dts: qcom: sm6375: correct sleep clock frequency
Date: Wed,  5 Feb 2025 14:41:48 +0100
Message-ID: <20250205134508.775185981@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 223382c94f1f07c475d39713e4c058401480b441 ]

The SM6375 platform uses PM6125 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241224-fix-board-clocks-v3-12-e9b08fbeadd3@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 4d519dd6e7ef2..72e01437ded12 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -29,7 +29,7 @@
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
-- 
2.39.5




