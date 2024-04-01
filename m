Return-Path: <stable+bounces-34836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E5894119
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B7B224A6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273291E525;
	Mon,  1 Apr 2024 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQgnVLze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980838DD8;
	Mon,  1 Apr 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989461; cv=none; b=exWz2P1aO0IBPHtt8ulnJF16nPOJ/ir0VpZIyk/JuaNs88rCmIfgr3QARqrtj7C7XJDAFrBsBVMIcMVjsjfHADs4p5RXAhicSneWit+cJNItTh+yGJCq+HtHPbdWl+R8GRjE0ZiXwMznS1IMiA0AXtd5jR9QTQ+Pm+DqmRResEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989461; c=relaxed/simple;
	bh=PUog2+80WmatoqEymRT2IawYChZLpqWDPK4s+H0lg+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkPFklmDKwrYNFLeQgSU4EMX+fBFnZSxlXesZSHB5zdEEHOGrmAa86kbrjnB/kJtiRUBJ5BN1hhhfLJMpuN6Kppeo8VDtPsmCXmAk+l6UaWcuZNy6Q0dn8cISCl+x6flkWgU+UfCxqpt+TEfW6iTPAPXutIcn8fMOjROhAmZEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQgnVLze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A7DC433F1;
	Mon,  1 Apr 2024 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989461;
	bh=PUog2+80WmatoqEymRT2IawYChZLpqWDPK4s+H0lg+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQgnVLzesnavUizBizFtXr49XqDJhvP3uMDM5TuIchfd8yYO+KBkDuYmACBVMQ8SE
	 JmAb6uzIjAttanJU8p/YKBNDveotM4U3t1Q6esCRvYgRQQpqUQzSdAtn7/gBfQ7JFK
	 ZInknm8KmMP/GduoGigvZOWOLt3dkUuieHBX+uvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 027/396] arm64: dts: qcom: sm8550-mtp: correct WCD9385 TX port mapping
Date: Mon,  1 Apr 2024 17:41:16 +0200
Message-ID: <20240401152548.713380234@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b66966b1bbc0aa58f7af83cbd56d5a206892857c ]

WCD9385 audio codec TX port mapping was copied form HDK8450, but in fact
it is offset by one.  Correct it to fix recording via analogue
microphones.

The change is based on QRD8550 and should be correct here as well, but
was not tested on MTP8550.

Cc: stable@vger.kernel.org
Fixes: a541667c86a9 ("arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240124164505.293202-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index f29cce5186acd..c4bfe43471f7c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -743,7 +743,7 @@ &swr2 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		qcom,tx-port-mapping = <1 1 2 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
 	};
 };
 
-- 
2.43.0




