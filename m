Return-Path: <stable+bounces-151960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD693AD16D0
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949B71887E70
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C142459C8;
	Mon,  9 Jun 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6s5+LfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9393157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436448; cv=none; b=YoIoBDQac5T3A5I8slaAiRWmzmsypXX9KZLGitF6oh4V5lM0G/qs3J5vOjcXpb35X7APaBu7tdcjuVIq6ZwZu1qxr9XchLRO/4IsAOUFMthzCGYyuktEbbTJ/IzGEPq04RaF8xKyqT0IOpGlWbrw5XTcAZBeCTamN/beeZHn60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436448; c=relaxed/simple;
	bh=UrcgVl79heO/gGmvL1S4VuaJkUW2ZVgtD3Pdn+NB5h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JldQ84ynYRtQ3JJUp97lkCwOowfPukgcx57EuF6dNA3hZm9yVoa/108NV+iWrF3X+R1+PxTeQ7pEQyH2p+eTUaRc5e2ZtdX/T+up6n6+E9E8EM+XDMijuF5yuLVVgYy8FhHa/iTQQqKpjHAnPdSoOfhMmr6Eh34E59Er21aZiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6s5+LfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCB4C4CEEE;
	Mon,  9 Jun 2025 02:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436448;
	bh=UrcgVl79heO/gGmvL1S4VuaJkUW2ZVgtD3Pdn+NB5h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6s5+LfK+UiL2HCYeCvd5TfSY80aGS2seXeFl8CftrMbn+ERZwu1iMfyj8Lll0mr+
	 aOAhavwzE0atBP/h+CeV3d/ryKSkKgk9lbEmxjlGPqdyX1ClWPcWtAmEa1uWls92LH
	 lcgUBtwjP1ugSWLlkUHwAMemvrLZl94vtdHFyp8M5LsCpV/YGH4lccT1FIHkBnKdyG
	 Klf+dEfzfO2no0+YTJX7/fZ/IGWpkWuETiWyA5uD/qDMFoRrlvXo575xgcfzxouklF
	 xPzbrtkaZXxLJkpTR2fcKiColADkNOKfpN7CVqWaLBQ+WuJ+SxaOKwA7qpMsEoFpoM
	 2kVdvZaO1TsxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dlechner@baylibre.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
Date: Sun,  8 Jun 2025 22:34:06 -0400
Message-Id: <20250608172432-60813911671e4e29@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250608155050.1517661-1-dlechner@baylibre.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e683131e64f71e957ca77743cb3d313646157329

Status in newer kernel trees:
6.15.y | Not found
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e683131e64f71 ! 1:  9a2b766b7ef19 dt-bindings: pwm: adi,axi-pwmgen: Fix clocks
    @@ Commit message
         Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
         Link: https://lore.kernel.org/r/20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com
         Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
    +    (cherry picked from commit e683131e64f71e957ca77743cb3d313646157329)
    +    Signed-off-by: David Lechner <dlechner@baylibre.com>
     
      ## Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml ##
     @@ Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: properties:
    -     const: 3
    +     const: 2
      
        clocks:
     -    maxItems: 1
    @@ Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: properties:
      
     @@ Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: examples:
          pwm@44b00000 {
    -         compatible = "adi,axi-pwmgen-2.00.a";
    -         reg = <0x44b00000 0x1000>;
    --        clocks = <&spi_clk>;
    -+        clocks = <&fpga_clk>, <&spi_clk>;
    -+        clock-names = "axi", "ext";
    -         #pwm-cells = <3>;
    +        compatible = "adi,axi-pwmgen-2.00.a";
    +        reg = <0x44b00000 0x1000>;
    +-       clocks = <&spi_clk>;
    ++       clocks = <&fpga_clk>, <&spi_clk>;
    ++       clock-names = "axi", "ext";
    +        #pwm-cells = <2>;
          };
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

