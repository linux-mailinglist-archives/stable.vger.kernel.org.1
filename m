Return-Path: <stable+bounces-169631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89AB2709B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF005E449C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9717274B2C;
	Thu, 14 Aug 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0Ec6u/0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEC73597B;
	Thu, 14 Aug 2025 21:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755205978; cv=none; b=NPKs8KESYVrRnrQ9aouAutRIIXjUbFYyMoh3YDlRomy7fVNb/2HBpRqyB99sUMxRpVIbLMdAiepqLsrAqacSQa8dBRN1Gs0Uo6V7geZz82zJm0k6GjE5WguHkxGBzuftKXCQLp744dc7Oizy54oOuKOlnuSOf685Koc4+XF1BB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755205978; c=relaxed/simple;
	bh=krVdXyur4cuaBQi8IknCUD4OVejC1eVRuA8JjTiMBzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtssoBLnM9xVgkDzgCC68AIhe4f9NLhnxDLXdf2UBrU1EnVsUOYZlrd/dHFWz3vSIpMAHs0vygfRupqzxOmVEbmFccDuyprs0E4KORmBTmQ3bBK35LADD8b3eGOW0IjMxEmmQFy5LP7h8OanX55Njcr/mNj69VLaqcKxYOLjX1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0Ec6u/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80E7C4CEED;
	Thu, 14 Aug 2025 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755205978;
	bh=krVdXyur4cuaBQi8IknCUD4OVejC1eVRuA8JjTiMBzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0Ec6u/0iKlsavyu3lr1M9Nflr5Wlp0YGwO769c1YH/suoE0lDj5gQr2QmF83QOme
	 Sv7n3aVtFDEC1J002YAilIgjdJRy4aJZBALisOGZyinfLovzMGoWv2LjWdfY5a32Fy
	 I2dQu5ZzU6d5EVZjp2SvMHge3kvr+Wg/wWTD7IkDoRP4Ub9dIZDiPzv4qdNliNREzy
	 zpRjSQlsU6GRwJjutSAYwjXXGcOjimN4FPDXi+Rmk45xXOxd6MBf2eMaWpmKFiE8yn
	 hSbvyu7+eYsNUSKU+8z/Fo7fs9tCOJ6Llc5q7bpJHr2uCOZ6AThfuzE0V6Nu2QtZT8
	 ZkmwoOvvV+I1Q==
Date: Thu, 14 Aug 2025 16:12:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: brcm,bcm7271-uart: Constrain clocks
Message-ID: <175520597669.3919933.8053275644931210199.robh@kernel.org>
References: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812121630.67072-2-krzysztof.kozlowski@linaro.org>


On Tue, 12 Aug 2025 14:16:31 +0200, Krzysztof Kozlowski wrote:
> Lists should have fixed constraints, because binding must be specific in
> respect to hardware, thus add missing constraints to number of clocks.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 88a499cd70d4 ("dt-bindings: Add support for the Broadcom UART driver")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Greg, patch for serial tree.
> ---
>  Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


