Return-Path: <stable+bounces-108622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B59A10C47
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 17:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2139E18899E7
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2541C5F0F;
	Tue, 14 Jan 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0l/akWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EE15746B;
	Tue, 14 Jan 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736872173; cv=none; b=pJUszGjOZmkpFgZ7eNiX84pAEvtBMWHkyb0t0tASWTdEKNnNDZn96JYYPfBjtspdZjyAHt0SDwPY0Z82zXZmP54GMZZETrQLhHWlbz6k9pbOl8QyIitpMtTSws5Pd8ISgnFtKrfbAGuRGxsfQDxioAQXKvAZtp6ImkbSDF7qGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736872173; c=relaxed/simple;
	bh=h62z4y1wv+NTpFNoOfOMwrg0bd6GXzx/E3jJZhWJ5kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHiGS/JcYPxEFgcbEGOlbT1aMxPqoSlMGeaUBfA96c14u/7NHkVeIPgVdKK7074FGeRWInvIlJ3Qv46X7ZB/pbdzTXl+XHCscIsXWNUEcCvxVmN4ZqKWE3qQb2pDtF1hi6MfM2LgeePrTmWz9UPsqfCjgG5xFPXE7RZXrd1cftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0l/akWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89640C4CEDF;
	Tue, 14 Jan 2025 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736872171;
	bh=h62z4y1wv+NTpFNoOfOMwrg0bd6GXzx/E3jJZhWJ5kA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g0l/akWkNUdWlMejGlteYuENKMox7ADPISatLnC1vgs3xaT9h3yXrP9qcQ86M+rgp
	 I9gugjLyITShbUpOm42Pm+dFS4uufFlvxvRXKw5hvXFMeeTa2MaLXmqEmi9+OeVzWC
	 YojSbtSfhCLqc1nzNR/Ws53hobpg13q2aUpLuO3mjsm7zUCIp4FKJoVnPSxRa0u5ME
	 n9kPlebdSsH70RBCP6g5zaoWMKxRo9kXI4ffyKrTHHNstHpCMrdWb37uUq+DA2Qa9C
	 FsrjD12EBac5fjZRHmYWKSiw7JqpH6R62kbe8bm85qSY8o3WXniakTNmRlnBrYkV6x
	 tcW3zcsOdYm9w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: pratyush@kernel.org,  mwalle@kernel.org,  miquel.raynal@bootlin.com,
  richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Tudor Ambarus <tudor.ambarus@linaro.org>,
  alvinzhou@mxic.com.tw,  leoyu@mxic.com.tw,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  stable@vger.kernel.org,  Cheng Ming Lin
 <linchengming884@gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from
 addr to data
In-Reply-To: <7762352.EvYhyI6sBW@steina-w> (Alexander Stein's message of "Tue,
	14 Jan 2025 17:24:32 +0100")
References: <20241112075242.174010-1-linchengming884@gmail.com>
	<3342163.44csPzL39Z@steina-w>
	<a6a9dfce-6cac-4831-9c96-45471f5ee13a@linaro.org>
	<7762352.EvYhyI6sBW@steina-w>
Date: Tue, 14 Jan 2025 16:29:28 +0000
Message-ID: <mafs0sepl5pg7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 14 2025, Alexander Stein wrote:

> Hi Tudor,
>
> Am Dienstag, 14. Januar 2025, 14:26:47 CET schrieb Tudor Ambarus:
>> On 1/14/25 12:57 PM, Alexander Stein wrote:
>> > Hello everyone,
>> 
>> Hi,
>> 
>> > 
>> > Am Dienstag, 12. November 2024, 08:52:42 CET schrieb Cheng Ming Lin:
>> >> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> >>
>> >> The default dummy cycle for Macronix SPI NOR flash in Octal Output
>> >> Read Mode(1-1-8) is 20.
>> >>
>> >> Currently, the dummy buswidth is set according to the address bus width.
>> >> In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
>> >> dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
>> >> host to read data 4 cycles too early.
>> >>
>> >> Since the protocol data buswidth is always greater than or equal to the
>> >> address buswidth. Setting the dummy buswidth to match the data buswidth
>> >> increases the likelihood that the dummy cycle-to-byte conversion will be
>> >> divisible, preventing the host from reading data prematurely.
>> >>
>> >> Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
>> >> Cc: stable@vger.kernel.org
>> >> Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
>> >> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
>> >> ---
>> >>  drivers/mtd/spi-nor/core.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>> >> index f9c189ed7353..c7aceaa8a43f 100644
>> >> --- a/drivers/mtd/spi-nor/core.c
>> >> +++ b/drivers/mtd/spi-nor/core.c
>> >> @@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
>> >>  		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>> >>  
>> >>  	if (op->dummy.nbytes)
>> >> -		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
>> >> +		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
>> >>  
>> >>  	if (op->data.nbytes)
>> >>  		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
>> >>
>> > 
>> > I just noticed this commit caused a regression on my i.MX8M Plus based board,
>> > detected using git bisect.
>> > DT: arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
>> > Starting with this patch read is only 1S-1S-1S, before it was
>> > 1S-1S-4S.
>> > 
>> > before:
>> >> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> >> name            mt25qu512a
>> >> id              20 bb 20 10 44 00
>> >> size            64.0 MiB
>> >> write size      1
>> >> page size       256
>> >> address nbytes  4
>> >> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> >> | HAS_SR_BP3_BIT6 | SOFT_RESET
>> >>
>> >> opcodes
>> >>
>> >>  read           0x6c
>> >>  
>> >>   dummy cycles  8
>> >>  
>> >>  erase          0xdc
>> >>  program        0x12
>> >>  8D extension   none
>> >>
>> >> protocols
>> >>
>> >>  read           1S-1S-4S
>> >>  write          1S-1S-1S
>> >>  register       1S-1S-1S
>> >>
>> >> erase commands
>> >>
>> >>  21 (4.00 KiB) [1]
>> >>  dc (64.0 KiB) [3]
>> >>  c7 (64.0 MiB)
>> >>
>> >> sector map
>> >>
>> >>  region (in hex)   | erase mask | overlaid
>> >>  ------------------+------------+----------
>> >>  00000000-03ffffff |     [   3] | no
>> > 
>> > after:
>> >> cat /sys/kernel/debug/spi-nor/spi0.0/params
>> >> name            mt25qu512a
>> >> id              20 bb 20 10 44 00
>> >> size            64.0 MiB
>> >> write size      1
>> >> page size       256
>> >> address nbytes  4
>> >> flags           HAS_SR_TB | 4B_OPCODES | HAS_4BAIT | HAS_LOCK | HAS_4BIT_BP
>> >> | HAS_SR_BP3_BIT6 | SOFT_RESET
>> >>
>> >> opcodes
>> >>
>> >>  read           0x13
>> >>  
>> >>   dummy cycles  0
>> >>  
>> >>  erase          0xdc
>> >>  program        0x12
>> >>  8D extension   none
>> >>
>> >> protocols
>> >>
>> >>  read           1S-1S-1S
>> >>  write          1S-1S-1S
>> >>  register       1S-1S-1S
>> >>
>> >> erase commands
>> >>
>> >>  21 (4.00 KiB) [1]
>> >>  dc (64.0 KiB) [3]
>> >>  c7 (64.0 MiB)
>> >>
>> >> sector map
>> >>
>> >>  region (in hex)   | erase mask | overlaid
>> >>  ------------------+------------+----------
>> >>  00000000-03ffffff |     [   3] | no
>> > 
>> > AFAICT the patch seems sane, so it probably just uncovered another
>> > problem already lurking somewhere deeper.
>> > Given the HW similarity I expect imx8mn and imx8mm based platforms to be
>> > affected as well.
>> > Reverting this commit make the read to be 1S-1S-4S again.
>> > Any ideas ow to tackling down this problem?
>> > 
>> 
>> My guess is that 1S-1S-4S is stripped out in
>> spi_nor_spimem_adjust_hwcaps(). Maybe the controller has some limitation
>> in nxp_fspi_supports_op(). Would you add some prints, and check these
>> chunks of code?
>
> Thanks for the fast response. I was able to track it down.
> Eventually the buswidth check in spi_check_buswidth_req fails.
> For command 0x3c:
> Before revert:
>> mode: 0x800, buswidth: 2
> After revert
>> mode: 0x800, buswidth: 1
>
> The mode is set to SPI_RX_QUAD. Thus the check for dummy buswidth fails
> now that data_nbits are used now.
>
> For command 0x6c it's similar but op->dummy.buswidth is 4 now.
>
> It boils down that there are SPI controllers which have
>> spi-tx-bus-width = <1>;
>> spi-rx-bus-width = <4>;
> set in their DT nodes.
>
> So it seems this combination is not supported.

No, this check is wrong. See
https://lore.kernel.org/linux-mtd/20241112075242.174010-1-linchengming884@gmail.com/T/#m7cc1a5055702f5a42a8f3949c968842d845914d7

-- 
Regards,
Pratyush Yadav

