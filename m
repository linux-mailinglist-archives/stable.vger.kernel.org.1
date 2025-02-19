Return-Path: <stable+bounces-118277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1ACA3C039
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9822F3AF8C9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B91E25F8;
	Wed, 19 Feb 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQVQO5dC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5319CD01;
	Wed, 19 Feb 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972377; cv=none; b=Mnk7ksi5vNyJMU8L1OWbYv7m9LDIWmrEwVtTrzEf0aQTlEY9uYpVuDTYkasKqSKGPDyGxsH/6P3V/XWWU4fqdo05N2AGXOQRbZ3v60kOK88MeMeiEShGHy0f2+8S+CSSii6vP0N9QUmOPmdFWyR9w8F4OB1kmsJAoZHPS/R7/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972377; c=relaxed/simple;
	bh=UWC9kdLXpJE8pWaUx8hrJrZzvXD6tZ1xwRInfrnG3Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etp9CXVxJpLDfJMRjSz/l/wEib/Av+rxZwkn0yrvVgqAQJQgn69gHXCTuANzkFuocwQH30kgiX0pbBTj/u/bzeL4xe6oaQ58+eQuGOTYkZAbQRx5urJcylvdrbV8zNku4vwe0zJSEAPUaByZq5GehNsa/r0NjPSnHc1Et1OjwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQVQO5dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9647C4CEE7;
	Wed, 19 Feb 2025 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739972376;
	bh=UWC9kdLXpJE8pWaUx8hrJrZzvXD6tZ1xwRInfrnG3Ig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tQVQO5dCEqKiUaWno2JGhXoPPQ3t/dpw4qmnD45kWzJ1NyE6ICEv2vauyi/feiOlS
	 BUiV886IXKwAc93/rORADGCv2L6y7a4+uj6KG7p85hCdK++6LmSl3KpNq2mD+avVGi
	 5LxCHpTeDDJfq5mJPbD3u5UHsXEFfrCsPYhxdtLeCDiiBP6sOkOMV1RHn1fvAevwNa
	 vk9h6nslH7/S72hj73quC55agMn5OxUYrJfq+7PxE78DM8//r2q6SJ0MEs/4TvClcJ
	 LZtFn5U2dR0sB62vXPzZQqJhqykJ8PXaUbUV2tJQBfeTLRG4wfMqSPg2tG5H21cPd4
	 UiquDHFRX7jZg==
Message-ID: <b728b5e7-e3bf-49d6-8829-554936850d5f@kernel.org>
Date: Wed, 19 Feb 2025 07:39:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: socfpga: agilex5: fix gpio0 address
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250213105036.3170943-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250213105036.3170943-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 04:50, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Use the correct gpio0 address for Agilex5.
> 
> Fixes: 3f7c869e143a ("arm64: dts: socfpga: agilex5: Add gpio0 node and spi dma handshake id")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
> 
> changes in v2:
>    * Fix dtbs_check warning and update commit message for better
>      clarity.
> 
> link to v1:
>   - https://lore.kernel.org/all/20250212100131.2668403-1-niravkumar.l.rabara@intel.com/
> 
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied!

Thanks,
Dinh


