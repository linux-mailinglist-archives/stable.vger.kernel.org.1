Return-Path: <stable+bounces-14904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684583831A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590D51C29858
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F37D605CF;
	Tue, 23 Jan 2024 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aLnwqSVm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCC56025E;
	Tue, 23 Jan 2024 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974704; cv=none; b=lDfBcnclFAURZBeDTTsrTFdxcJg6B3xD5XFOlPXOC30g5uUwqqifpdke4xwD/igW7yCOrhWH5WOlEsyjj2Hh3JOvb5xJQ6lakMY7zp/k7AizrVpartxjvuzsyyY8WkR+Pw+BBX8sa8De4YywDhd1t4P6j+m9i8TtLWV4PXfSkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974704; c=relaxed/simple;
	bh=Ws/Vo7W4qnXXI5/6IowO2ZiQRrJ1fdi+xuZZZT/7EIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iru18dAFJGdt95uRhgb39CvB06MO2FdeMsz+dHbkbq/imk+XFHCe7E8uCLxo9LJ3/NeGn0G86JUnoE7x5NVMrrpHTvTFiD4BYYG0qwmcq+ZAkImu24acpHg4OerK8G3EppYuxw8qAT6zYHtn6C1uWQmP4qnivZ4F/TjnXo3l+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aLnwqSVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2E0C433C7;
	Tue, 23 Jan 2024 01:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974703;
	bh=Ws/Vo7W4qnXXI5/6IowO2ZiQRrJ1fdi+xuZZZT/7EIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLnwqSVm6sS1REhkc5Zehvhtg8BsPdLS1QZl8g5NbRjQTJoRFXqKzB+KRUnNHUBxA
	 7rhVX0OTFIEYFlRyyGivTl1s3IglxWLiaqU2jKH5xzWMlextd0fbyQETKPl0JRewz8
	 3vEMaKbkasRTjja3ct+aSA7lZxCoLixxFdTV9Sv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre TORGUE <alexandre.torgue@foss.st.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Douglas Anderson <dianders@chromium.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 106/583] dt-bindings: arm: qcom: Fix html link
Date: Mon, 22 Jan 2024 15:52:37 -0800
Message-ID: <20240122235815.408274505@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 3c3fcac8d3b1b0f242845c3b3c3263bd38b3b92f ]

This link got broken by commit e790a4ce5290 ("arm: docs: Move Arm
documentation to Documentation/arch/") when the doc moved from arm/ to
arch/arm/. Fix the link so that it can continue to be followed.

Fixes: e790a4ce5290 ("arm: docs: Move Arm documentation to Documentation/arch/")
Cc: Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc: Yanteng Si <siyanteng@loongson.cn>
Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20231129030443.2753833-1-swboyd@chromium.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..90f31beb80c2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -136,7 +136,7 @@ description: |
   There are many devices in the list below that run the standard ChromeOS
   bootloader setup and use the open source depthcharge bootloader to boot the
   OS. These devices do not use the scheme described above. For details, see:
-  https://docs.kernel.org/arm/google/chromebook-boot-flow.html
+  https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html
 
 properties:
   $nodename:
-- 
2.43.0




