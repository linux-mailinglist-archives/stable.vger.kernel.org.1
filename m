Return-Path: <stable+bounces-166705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B221B1C7C8
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D990E621EA6
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2728EA5A;
	Wed,  6 Aug 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IskJItYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332128DF33;
	Wed,  6 Aug 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491233; cv=none; b=NY0emowDPahNNINUWXlI2AvPstDFhhyuzlsCR+i/km3gIwlZtkKzohpXtBxW7XvAs3dQhMQq7o1jbFH+odpCmuVmdPNS0Mr+xQ+pp5w9LoRY3h1Ecu3le0zDsT9zJXMFfTGws0Etg9zgXjBGdRgyCCDOZ1LJX3LwaZJtFJmR5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491233; c=relaxed/simple;
	bh=HUIQMF66FePlPJPI95nNDJ3aspbdARZuuJ251SnikDY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ke3b7GobxETHQ63IIfGSU/fGsschP/CPU29dDZxcDm6NPGvTS8eatV3QDvtcWi9CA0hEZ62rCBxgET+xuhwaPeCptmCEDxjnAsdDfotZU3gTqmqvcschTic4ZodYxAzWkCLJ6hFz9k6lfEFDwtPYY0aS/6tB1BpJBDde6iZHAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IskJItYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656DDC4CEEB;
	Wed,  6 Aug 2025 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754491232;
	bh=HUIQMF66FePlPJPI95nNDJ3aspbdARZuuJ251SnikDY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IskJItYmLX5jAxfvXhleCpKfKPoi3Vkbu7FwALAhjf8RypT/4QavaYWH5zCy5Ueem
	 bJIgqpiyLjnsaMf9XCKTtGZdsh5R7kBqHa2CG5SG69O+SW2TEP9SQ1vWlNjW+WviTs
	 BK2kqREG9emx/bW4dNggalAuQ/JtpWwK0eynay43oAN7oomekJjih61UR03g+V4DoO
	 ji0vEIWQp9kAt1NSYGYdX/Y9/oginVWqdLtr56wageF1TO45IXzJf/mzJrlvoBNCtZ
	 vEew0PzJ6iEYXXF0WHORm8aEArs+E7w/5cnokyiYS6HVvbMinfzmru9B8gBkkVAWHk
	 +W4Eq0FkZM76Q==
Date: Wed, 06 Aug 2025 09:40:31 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
To: Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com>
References: <20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com>
Message-Id: <175449112431.639622.3115502959226804810.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1


On Wed, 06 Aug 2025 10:09:35 +0200, Patrice Chotard wrote:
> Add memory-region-names property for stm32mp257f-ev1.
> This allows to identify and check memory-map area's configuration.
> 
> Cc: stable@vger.kernel.org
> Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
>  1 file changed, 1 insertion(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit 038d61fd642278bab63ee8ef722c50d10ab01e8f

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/st/' for 20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com:

arch/arm64/boot/dts/st/stm32mp257f-ev1.dtb: ommanager@40500000 (st,stm32mp25-omm): memory-region-names:0: 'mm_ospi1' is not one of ['ospi1', 'ospi2']
	from schema $id: http://devicetree.org/schemas/memory-controllers/st,stm32mp25-omm.yaml#






