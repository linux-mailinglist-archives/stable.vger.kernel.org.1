Return-Path: <stable+bounces-108635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBAFA10F75
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E9E3A9117
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCF21516E;
	Tue, 14 Jan 2025 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7IsANAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4B215055;
	Tue, 14 Jan 2025 18:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877848; cv=none; b=ifnz3oSd9ZsjA2J8QjPx1cEsiModUCiMuChgNR1dJXNebubQ7Jj04vIwycaVQXmcXwRudkDPwIlhZX+i599Oevoio3NYrysS8TkS/UemiucZhi//7qMzF8ZEKszAGsDanBJ90r22vSjpB8pLZTvfvYhih/nAdAqgRrgNRLkoBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877848; c=relaxed/simple;
	bh=//WPnkeUMFLdD66obt4Oa+dfDwiQLbntnbgZQ7a/8BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sb3oWhrCImo6byxAiT1sSzRUhIMINmmT/da59w++rp2K/QOOSpBt4m0aNJOUA+wcquuH0OFxRmXyi9+kxhZxSAbTbDy1RJDrCydCriD7xZzOe3RkFNkO+hMY5HxGxA/fEwrJm02w41XsVClQeHtxSMM2is1nMu3Ig1MtHv0+DZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7IsANAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A98FC4CEDD;
	Tue, 14 Jan 2025 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877847;
	bh=//WPnkeUMFLdD66obt4Oa+dfDwiQLbntnbgZQ7a/8BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h7IsANANpcRvLJ9tMi9aBc9jX6qxstFDBawbQzRm1dRIZ6BIM6YDBOn+EaVOWRPd1
	 dOnxlqnGKVoNmWQ1kPxuKEhFctICyMl8+/rWKfnbCSui9jXKmoguvAW/FM/NsMK/EJ
	 T4hJHBH+bsEEt3C6Hb26VIOvBALcugsuSg0GPzcqYBXAqGy6x4EMnZXyvpeGjdrt+J
	 hAWKg6ktYmQTvn+FRgjGdTC8zi4ztXqCLgKGA9srqjUaJdUujCcpEDUFyJI7WE1Mu2
	 UEUmb60c5hT+5Lk88mR08xl6lcyrrbRrQrsWhwaYGnFiZtZSlHTtr8Znn0VAL3thmC
	 L/dCrb0ZTHcCg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Stein
 <alexander.stein@ew.tq-group.com>,  tudor.ambarus@linaro.org,
  mwalle@kernel.org,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  stable@vger.kernel.org,  Cheng Ming Lin
 <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
In-Reply-To: <87wmexp9lh.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 14
	Jan 2025 18:51:38 +0100")
References: <20241112075242.174010-1-linchengming884@gmail.com>
	<20241112075242.174010-2-linchengming884@gmail.com>
	<3342163.44csPzL39Z@steina-w> <mafs0zfjt5q3n.fsf@kernel.org>
	<87wmexp9lh.fsf@bootlin.com>
Date: Tue, 14 Jan 2025 18:04:03 +0000
Message-ID: <mafs0ldvd5l2k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 14 2025, Miquel Raynal wrote:

> Hello Pratyush,
>
> On 14/01/2025 at 16:15:24 GMT, Pratyush Yadav <pratyush@kernel.org> wrote:
>
>>>> --- a/drivers/mtd/spi-nor/core.c
>>>> +++ b/drivers/mtd/spi-nor/core.c
>>>> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>>>  		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>>  
>>>>  	if (op->dummy.nbytes)
>>>> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>>> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>
> Facing recently a similar issue myself in the SPI NAND world, I believe
> we should get rid of the notion of bits when it comes to the dummy
> phase. I would appreciate a clarification like "dummy.cycles" which
> would typically not require any bus width implications.

I agree. All peripheral drivers convert cycles to bytes, and controller
drivers convert them back to cycles. This whole thing should be avoided,
especially since it contains some traps with division truncation.

>
> ...
>
>> Most controller's supports_op hook call spi_mem_default_supports_op(),
>> including nxp_fspi_supports_op(). In spi_mem_default_supports_op(),
>> spi_mem_check_buswidth() is called to check if the buswidths for the op
>> can actually be supported by the board's wiring. This wiring information
>> comes from (among other things) the spi-{tx,rx}-bus-width DT properties.
>> Based on these properties, SPI_TX_* or SPI_RX_* flags are set by
>> of_spi_parse_dt(). spi_mem_check_buswidth() then uses these flags to
>> make the decision whether an op can be supported by the board's wiring
>> (in a way, indirectly checking against spi-{rx,tx}-bus-width).
>
> Thanks for the whole explanation, it's pretty clear.
>
>> In arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi we have:
>>
>> 	flash0: flash@0 {
>> 		reg = <0>;
>> 		compatible = "jedec,spi-nor";
>> 		spi-max-frequency = <80000000>;
>> 		spi-tx-bus-width = <1>;
>> 		spi-rx-bus-width = <4>;
>>
>> Now the tricky bit here is we do the below in spi_mem_check_buswidth():
>>
>> 	if (op->dummy.nbytes &&
>> 	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
>> 		return false;
>
> May I challenge this entire section? Is there *any* reason to check
> anything against dummy cycles wrt the width? Maybe a "can handle x
> cycles" check would be interesting though, but I'd go for a different
> helper, that is specific to the dummy cycles.

I suppose you would want to sanity check that the cycles are at least
between 1, 2, 4, or 8 (or at the very least not 0).

>
>> The "true" parameter here means to "treat the op as TX". Since the
>> board only supports 1-bit TX, the 4-bit dummy TX is considered as
>> unsupported, and the op gets rejected. In reality, a dummy phase is
>> neither a RX nor a TX. We should ideally treat it differently, and
>> only check if it is one of 1, 2, 4, or 8, and not test it against the
>> board capabilities at all.
>
> ...
>
>> Since we are quite late in the cycle, and that changing
>> spi_mem_check_buswidth() might cause all sorts of breakages, I think the
>> best idea currently would be to revert this patch, and resend it with
>> the other changes later.
>>
>> Tudor, Michael, Miquel, what do you think about this? We are at rc7 but
>> I think we should send out a fixes PR with a revert. If you agree, I
>> will send out a patch and a PR.
>
> Either way I am fine. the -rc cycles are also available for us to
> settle. But it's true we can bikeshed a little bit, so feel free to
> revert this patch before sending the MR.

To be clear, since the patch was added in v6.13-rc1 I want to revert it
via a fixes pull request to Linus before he releases v6.13 this week. I
want to fix it in v6.13, not in v6.14.

-- 
Regards,
Pratyush Yadav

