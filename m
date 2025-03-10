Return-Path: <stable+bounces-122594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6FA5A060
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221033A3765
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC322FAF8;
	Mon, 10 Mar 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yf73EJPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4581C5F1B;
	Mon, 10 Mar 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628942; cv=none; b=s92DuCk46jVAIFbytSazB5r3mEoZQaS+qTTHfxtEvEYj5IBdllb0AhP4n986UvojKKG+UqrpP9Tb0b+NLhL1C20UZrSSWi+PkiUzCWPpid8+tZZbAYqecMp9UQ/A0+XQRPjItzNa2Z85h/7ojIfhfTuj1MC90jOI8zgDUKSjGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628942; c=relaxed/simple;
	bh=rVlTDUKnQpgc+LRigs92uA+RV4wdWfWlTtGKFtkYCoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxwH7tZTB0GsjD0EkKywvz9cdl6qheqxC3B2Sn9yUDSHCW2kSVFmHXTwEBAjufFbJ3WtBP123aHs7QaDHGGCR0YOxwOIJaSvflOvojyP9Or39MtR+NfoDTgh/QpONl4b9+K4+DX+gBgxGwigVjygDbwehRMbFFmbCXghCDZOBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yf73EJPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93F9C4CEE5;
	Mon, 10 Mar 2025 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628942;
	bh=rVlTDUKnQpgc+LRigs92uA+RV4wdWfWlTtGKFtkYCoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yf73EJPECh5j55T7vAnbe7jLw4OLqxWLhV6iMUczO8mwcrpOt9yeL63WSP9otmXgc
	 ihOJrY03z4tOv2GL4LzOZSMFhviC6Xv6witeHrbJ0o1HzBIKsEi8R7i4dFlSWLFx0j
	 fZuF/i7D1tnccVubtDOk3i+8UOI3ZeyVghmXy7VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 123/620] arm64: dts: qcom: sm8250: correct sleep clock frequency
Date: Mon, 10 Mar 2025 17:59:29 +0100
Message-ID: <20250310170550.456415294@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 75420e437eed69fa95d1d7c339dad86dea35319a ]

The SM8250 platform uses PM8150 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 9ff8b0591fcf ("arm64: dts: qcom: sm8250: use the right clock-freqency for sleep-clk")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241224-fix-board-clocks-v3-13-e9b08fbeadd3@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 99afdd1ad7c6e..bf91e0acd435f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -82,7 +82,7 @@
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};
-- 
2.39.5




