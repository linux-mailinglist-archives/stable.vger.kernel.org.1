Return-Path: <stable+bounces-108617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DF0A10BF7
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB8F7A153A
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8AD1CC177;
	Tue, 14 Jan 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILH9a2vs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C51C8776;
	Tue, 14 Jan 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871329; cv=none; b=lUf1OeTpMh+SBSkSnY4+jd/EEwSPBrtq+QqCD11x7y3r6NS4QbuJyUp8IZP/l+7ZP16NNO5tOEPFMsQ8gWPc+nDpjnlqC7JvkAQbwVai13HX4tsnvs8Pi4Eo79od6WYf2p301ZcH9whlaKSYc7FgQR9Fnfbi9hMSbakEDIqaibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871329; c=relaxed/simple;
	bh=F3j37I7eWux3kT/HLzcnR1v1ElCkcnxuIX95XEhfavs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzI4r04AsERFLkEZRe2oVZj50TlztbeTqM+TxgVsoNbjj/3DNwzHXRRQz7zxF/1XRsGkz6mje47b1ZO7giXyqpe5Nis9hJGj6ziw10ps42caOG8n1EoJq6OIlr1o85U4/nkdSjn5LWfYrZI+o0rSr932GRheqMEl/D6d9oFbm8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILH9a2vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4D2C4CEDD;
	Tue, 14 Jan 2025 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736871327;
	bh=F3j37I7eWux3kT/HLzcnR1v1ElCkcnxuIX95XEhfavs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ILH9a2vskhMolQSuF7Ef38niRrZRsKp1vTPx4T9aqNvQKErCGlpyMOPS0oerUl97C
	 E1aBpgxzsrz/ZPrvYcTi4EcIACwJBd5DO4VlIsnN4XKvdi/L5Fw2NzUbcddXFMBPz6
	 2XGWCKRUBFb1wkbltURqQ7pnf1U6p2kgbEUB1eAVmeYIFti8IiTxICbKzJRZQ0HEXh
	 4ogP7Zc2AfnmekN8nHfPstvaHtnhKS6+cYu25CKNV1xBBbCbRP7IBoR/81lelIHg2c
	 0yC4XuBLf5enjERrsFzas4D0l70M1UmoMMcXR14Eto0rwWjLYyTPwmznxHfCD9hVx5
	 W1UILPS0EoGtw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: tudor.ambarus@linaro.org,  pratyush@kernel.org,  mwalle@kernel.org,
  miquel.raynal@bootlin.com,  richard@nod.at,  vigneshr@ti.com,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  stable@vger.kernel.org,  Cheng Ming Lin
 <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
In-Reply-To: <3342163.44csPzL39Z@steina-w> (Alexander Stein's message of "Tue,
	14 Jan 2025 13:57:59 +0100")
References: <20241112075242.174010-1-linchengming884@gmail.com>
	<20241112075242.174010-2-linchengming884@gmail.com>
	<3342163.44csPzL39Z@steina-w>
Date: Tue, 14 Jan 2025 16:15:24 +0000
Message-ID: <mafs0zfjt5q3n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 14 2025, Alexander Stein wrote:

> Hello everyone,
>
> Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
>> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> 
>> The default dummy cycle for Macronix SPI NOR flash in Octal Output
>> Read Mode(1-1-8) is 20.
>> 
>> Currently, the dummy buswidth is set according to the address bus width.
>> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
>> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
>> host to read data 4 cycles too early.
>> 
>> Since the protocol data buswidth is always greater than or equal to the
>> address buswidth. Setting the dummy buswidth to match the data buswidth
>> increases the likelihood that the dummy cycle-to-byte conversion will be
>> divisible, preventing the host from reading data prematurely.
>> 
>> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
>> Cc: stable@vger.kernel.org
>> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> ---
>>  drivers/mtd/spi-nor/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> index f9c189ed7353..c7aceaa8a43f 100644
>> --- a/drivers/mtd/spi-nor/core.c
>> +++ b/drivers/mtd/spi-nor/core.c
>> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>>  		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>>  
>>  	if (op->dummy.nbytes)
>> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>>  
>>  	if (op->data.nbytes)
>>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
>> 
>
> I just noticed this commit caused a regression on my i.MX8M Plus based board,
> detected using git bisect.
> DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> Starting with this patch read is only 1S-1S-1S, before it was
> 1S-1S-4S.
>
> before:
>> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> name            mt25qu512a
>> id              20 bb 20 10 44 00
>> size            64.0 MiB
>> write size      1
>> page size       256
>> address nbytes  4
>> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> | HAS_SR_BP3_BIT6 | SOFT_RESET
>> 
>> opcodes
>> 
>>  read           0x6c
>>  
>>   dummy cycles  8
>>  
>>  erase          0xdc
>>  program        0x12
>>  8D extension   none
>> 
>> protocols
>> 
>>  read           1S-1S-4S
>>  write          1S-1S-1S
>>  register       1S-1S-1S
>> 
>> erase commands
>> 
>>  21 (4.00 KiB) [1]
>>  dc (64.0 KiB) [3]
>>  c7 (64.0 MiB)
>> 
>> sector map
>> 
>>  region (in hex)   | erase mask | overlaid
>>  ------------------+------------+----------
>>  00000000-03ffffff |     [   3] | no
>
> after:
>> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> name            mt25qu512a
>> id              20 bb 20 10 44 00
>> size            64.0 MiB
>> write size      1
>> page size       256
>> address nbytes  4
>> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> | HAS_SR_BP3_BIT6 | SOFT_RESET
>> 
>> opcodes
>> 
>>  read           0x13
>>  
>>   dummy cycles  0
>>  
>>  erase          0xdc
>>  program        0x12
>>  8D extension   none
>> 
>> protocols
>> 
>>  read           1S-1S-1S
>>  write          1S-1S-1S
>>  register       1S-1S-1S
>> 
>> erase commands
>> 
>>  21 (4.00 KiB) [1]
>>  dc (64.0 KiB) [3]
>>  c7 (64.0 MiB)
>> 
>> sector map
>> 
>>  region (in hex)   | erase mask | overlaid
>>  ------------------+------------+----------
>>  00000000-03ffffff |     [   3] | no
>
> AFAICT the patch seems sane, so it probably just uncovered another
> problem already lurking somewhere deeper.
> Given the HW similarity I expect imx8mn and imx8mm based platforms to be
> affected as well.
> Reverting this commit make the read to be 1S-1S-4S again.
> Any ideas ow to tackling down this problem?

Thanks for reporting this. I spent some time digging through this, and I
think I know what is going on.

Most controller's supports_op hook call spi_mem_default_supports_op(),
including nxp_fspi_supports_op(). In spi_mem_default_supports_op(),
spi_mem_check_buswidth() is called to check if the buswidths for the op
can actually be supported by the board's wiring. This wiring information
comes from (among other things) the spi-{tx,rx}-bus-width DT properties.
Based on these properties, SPI_TX_* or SPI_RX_* flags are set by
of_spi_parse_dt(). spi_mem_check_buswidth() then uses these flags to
make the decision whether an op can be supported by the board's wiring
(in a way, indirectly checking against spi-{rx,tx}-bus-width).

In arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi we have:

	flash0: flash@0 {
		reg = <0>;
		compatible = "jedec,spi-nor";
		spi-max-frequency = <80000000>;
		spi-tx-bus-width = <1>;
		spi-rx-bus-width = <4>;

Now the tricky bit here is we do the below in spi_mem_check_buswidth():

	if (op->dummy.nbytes &&
	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
		return false;

The "true" parameter here means to "treat the op as TX". Since the board
only supports 1-bit TX, the 4-bit dummy TX is considered as unsupported,
and the op gets rejected. In reality, a dummy phase is neither a RX nor
a TX. We should ideally treat it differently, and only check if it is
one of 1, 2, 4, or 8, and not test it against the board capabilities at
all.

Alexander, can you test my theory by making sure it is indeed the dummy
check in spi_mem_check_buswidth() that fails, and either removing it or
passing "false" instead of "true" to spi_check_buswidth_req() fixes the
bug for you?

I took a quick look and the spi-tx-bus-width == 1 and spi-rx-bus-width >
1 combination seems to be quite common so I think many other boards are
affected by this bug as well.

Since we are quite late in the cycle, and that changing
spi_mem_check_buswidth() might cause all sorts of breakages, I think the
best idea currently would be to revert this patch, and resend it with
the other changes later.

Tudor, Michael, Miquel, what do you think about this? We are at rc7 but
I think we should send out a fixes PR with a revert. If you agree, I
will send out a patch and a PR.

-- 
Regards,
Pratyush Yadav

