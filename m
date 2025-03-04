Return-Path: <stable+bounces-120245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4092A4DE69
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5653A897A
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B0D20127D;
	Tue,  4 Mar 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRYtRR3b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26721EA7CE;
	Tue,  4 Mar 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092869; cv=none; b=sngfxGDsU8PjJkYWa4vuXnKpy2OnnTNaHruNWQLeXhO0SmM0rEfuelCqMrKUQCEpSzjcxE1YvNsZuHKa6H2yVPXjFrdkqAR+ttbC1ffDmmMUKb4bJzNUZK1Q82rDxMjsdar1iI1GHznKwJxTdbpSUZ+QsYh6G07eMCPdhp8LmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092869; c=relaxed/simple;
	bh=/A1A2qZsYsqWgcNSomPW+1mfRwPf8XYoLazhrNYnIU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PafBDmfumIH8ejBaeaARoQ0b3BxAMVaLB/asFLgzQbF7ckAUm3fNeddo9QTg7j0g/H5XNwXp4AF7QGYBbUVdudUj9wohCxl0XvDVcsUzUYkHpaJjaSxZKJBsHan40/ot+EHvfMhYPC+pDBK+kKiaQPyb2dIPZVhv8Vnl17PVnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRYtRR3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC710C4CEE5;
	Tue,  4 Mar 2025 12:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092868;
	bh=/A1A2qZsYsqWgcNSomPW+1mfRwPf8XYoLazhrNYnIU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRYtRR3bSOxt7sDY714pvRJ+cGuKXP1KXOzq7Es4hIChNxf5yfdbuZR5bbw1DInq+
	 XTyxl4Uqj3539js3jqHejm1CRVV7YfTAUWlpCEwBZy0AYwnmRSvviIJm8lbcw7aazu
	 4OC2+CshNXdu7/wMzgqSKbWzDwVJgHouoMilfhdnXGAIYOIZLSP4f7RL+hRnWBTYGR
	 eGkWv1extNmvHcBzHUjTxVQR7Ib1ZVjkI74nip4Lg17FLRRotOHJu/dF194mwzJ6JF
	 /zqLdIbNwnC3GXPYwYewdPtt6YVfoZKKEtzuRJkuxxWfgQvde2FiRCrUK4sw74wDrf
	 M2DSvNvOxsr9Q==
Message-ID: <847c7cd3-3b23-4180-b2b3-affa47413cf4@kernel.org>
Date: Tue, 4 Mar 2025 06:54:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] arm64: dts: socfpga: agilex: Add dma channel id
 for spi
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250225133919.4128252-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250225133919.4128252-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 07:39, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add DMA channel ids for spi0 and spi1 nodes in device tree.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 1235ba5a9865..616259447c6f 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -457,6 +457,8 @@ spi0: spi@ffda4000 {

Applied!

Thanks,
Dinh


