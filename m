Return-Path: <stable+bounces-63077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C994172B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D271F254B6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D518B464;
	Tue, 30 Jul 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMpgz7LX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC418B476;
	Tue, 30 Jul 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355588; cv=none; b=tqZBXA6uxs1zAIJLh1hrcwUbm6xP6a0i98hhzVXjnTl6NIeBDieZIUJ1C/iDlDG9tLvlp/V1gku+ta0X1k732nHPbtHnMUHz151wTX8UszxktLR+ckHBfSQ6ch4aznS70R3Zg8bHb9NZyBlF66/avdzaMip/1QkAvaruqLHhIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355588; c=relaxed/simple;
	bh=9sZOelVl99EQebGZw6iiHfmW/bXVFykuS4hzfnAJ3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfEvajtJLF3ehv3BviioiQFr/7dmSUSCY/uHYktqn4/FkIoBaKPuE/hnPNP+2miFSKreIMjQCMzeC9xdQzgtCU4iwL0pyXKiiB69YLN1WTNfLYD/QsrTLTU4CAXvlzfcrlwUtMrjNexlBVrl/LH1d8BIauycBU+TEFXBQ8JWQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMpgz7LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C060AC32782;
	Tue, 30 Jul 2024 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355588;
	bh=9sZOelVl99EQebGZw6iiHfmW/bXVFykuS4hzfnAJ3IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMpgz7LXVHlHJ7yYoruZ9E+zBlf8QJKlv4Hh4mzmSJbRJZq7gShN12t051+DDIGie
	 uOZE+JGbCm/4n+hHRIjXlXJw9dpeWfAmBYr3JftYnxzFslFPYeblRL+DcriBEhtHpl
	 ePJRlPxUtbhzO/8rtjWLiLe9f3wi2NgDzbvxEhFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 069/809] arm64: dts: qcom: qrb4210-rb2: make L9A always-on
Date: Tue, 30 Jul 2024 17:39:05 +0200
Message-ID: <20240730151727.367743567@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d6c6b85bf5582bbe2efefa9a083178b5f7eef439 ]

The L9A regulator is used to further control voltage regulators on the
board. It can be used to disable VBAT_mains, 1.8V, 3.3V, 5V rails). Make
sure that is stays always on to prevent undervolting of these volage
rails.

Fixes: 8d58a8c0d930 ("arm64: dts: qcom: Add base qrb4210-rb2 board dts")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240605-rb2-l9a-aon-v2-1-0d493d0d107c@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index cb8a62714a302..1c7de7f2db791 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -414,6 +414,8 @@ vreg_l9a_1p8: l9 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-allow-set-load;
+			regulator-always-on;
+			regulator-boot-on;
 		};
 
 		vreg_l10a_1p8: l10 {
-- 
2.43.0




