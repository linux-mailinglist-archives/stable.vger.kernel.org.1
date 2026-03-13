Return-Path: <stable+bounces-225311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GcYFdMWtGlkgwAAu9opvQ
	(envelope-from <stable+bounces-225311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:53:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265928448F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A03E30BA487
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612A397E89;
	Fri, 13 Mar 2026 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq+3PqYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADC392802;
	Fri, 13 Mar 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409177; cv=none; b=Axu0odPMfD5d5Uko9qzRUX3sQw89/euWgWgh1bSbQR+HsWEHzDC91MzThb2VYM90qsZD7+lvM/ZXqD/xkJy2zxGj9Zv104z3SIdyTyg98N8UdU6XiB67VrPSUNseDu5hyNKujOWp+jxaIy4gAqRqek+9CydgNkHH92Q+gFZ+9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409177; c=relaxed/simple;
	bh=xnp+Riyh/w0YpgxEvhFWS/9bdMiL79ATIFLfP7pHKwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0fBfIvLXxTdduhOmG7YDfrxQhs/EVR1euXOfmCQju5b6djes5SCh1J7zAWanp0yKtEDyrPOVP0PdLrvhJcKZyzYr7XtlV4g8igHwuD5GvOfcIZfTVMs9HWpJJA2GyD1FZeZACjA8ccD6lQ+F+uG45TSMFO7fNUbdsGwAQ+bAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq+3PqYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD73C19425;
	Fri, 13 Mar 2026 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773409176;
	bh=xnp+Riyh/w0YpgxEvhFWS/9bdMiL79ATIFLfP7pHKwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uq+3PqYk5bxRdIZxNbbFeNn6Z2tT9FmuCHBT9bGu23AKK/FAm/m42z16iZ3L/IMoJ
	 u6aIcaigAKV2VxMz9c30y1iwOrvAL5f/FzeJTzva5tMrBWkbXIXBFEiY58G4hcKFK4
	 OvzixvLmvGLntJy3+xMTnRU6dt0h1rD85ZDdStA2yTUwudy3TVvdvHVlAey+feOuLK
	 9juPeU/F2JxozjlkQPtXsx4uhLE7IYIVcyT1kDluoiUXdxmjZmR2pLs9UOE82UA8fK
	 HkDaiej8qSJhVncd5R260aZlb53SEwjvD4f7A2mFT8393hFF1Xu7NX5TjfFOAazmv8
	 2N6bxXhE+OihQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Hendrik Donner <hd@os-cillation.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <mwalle@kernel.org>,  Sanjaikumar V S <sanjaikumarvs@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  miquel.raynal@bootlin.com,  richard@nod.at,
  sanjaikumar.vs@dicortech.com,  stable@vger.kernel.org,
  tudor.ambarus@linaro.org,  vigneshr@ti.com
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
In-Reply-To: <aa6bfa3a-8389-4dfa-a477-dcfb3340b1f5@os-cillation.de> (Hendrik
	Donner's message of "Fri, 13 Mar 2026 13:50:42 +0100")
References: <DGM6ZPOT1WCR.157JI0LW4W3E8@kernel.org>
	<20260223091733.47-1-sanjaikumarvs@gmail.com>
	<DGM8HPC181AF.3FCCS4MIE4A43@kernel.org>
	<8a1db3a5-09b3-4ef1-87e8-66553a81ec27@os-cillation.de>
	<2vxzpl58dk9u.fsf@kernel.org>
	<aa6bfa3a-8389-4dfa-a477-dcfb3340b1f5@os-cillation.de>
Date: Fri, 13 Mar 2026 13:39:32 +0000
Message-ID: <2vxz8qbvetm3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225311-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.infradead.org,bootlin.com,nod.at,dicortech.com,linaro.org,ti.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0265928448F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13 2026, Hendrik Donner wrote:

> Hello,
>
> On 3/13/26 12:46, Pratyush Yadav wrote:
>> On Fri, Mar 06 2026, Hendrik Donner wrote:
>> 
>>> Hello,
>>>
>>> On 2/23/26 10:29, Michael Walle wrote:
>>>> Hi,
>>>> On Mon Feb 23, 2026 at 10:17 AM CET, Sanjaikumar V S wrote:
>>>>>> Raises concern about writes ending at odd offsets potentially
>>>>>> having the same issue
>>>>>
>>>>> The odd end address case (trailing byte) is already handled in the
>>>>> existing code at lines 243-255:
>>>>>
>>>>> /* Write out trailing byte if it exists. */
>>>>> if (actual != len) {
>>>>>       ret = spi_nor_write_enable(nor);
>>>>>       ...
>>>>>       ret = sst_nor_write_data(nor, to, 1, buf + actual);
>>>>> }
>>>> Ah, I must be blind. I stopped reading at the write_disable.
>>>>
>>>>> So write_enable is already called before writing the trailing
>>>>> byte. My patch only addresses the odd start case where BP clears
>>>>> WEL before the AAI sequence begins.
>>>>>
>>>>>> Suggests simplifying the conditional logic by removing the length
>>>>>> check
>>>>>
>>>>> The condition `if (actual < len - 1)` avoids an unnecessary
>>>>> write_enable when len == 1 (single byte write at odd address, no
>>>>> AAI follows). But if you prefer unconditional write_enable for
>>>>> simplicity, I can change it in v3.
>>>> I know, but I actually don't like repeating the condition in the for
>>>> loop. So I'd prefer to have a local "needs_write_enable" boolean
>>>> which will be set to true. But then, I wouldn't care too much if
>>>> there is a write enable followed by a write disable for a rare case.
>>>>
>>>>>> Notes the patch lacks runtime testing
>>>>>
>>>>> I don't have the hardware setup to test odd-address writes at the
>>>>> moment. The fix is based on code analysis. I have tested patch 2/2
>>>>> (dirmap fallback) on hardware.
>>>> I'm hesitant - because like I said, if there is really a bug - it
>>>> would have never worked correctly, since day 1. But yeah, I've also
>>>> read the datasheet and it clearly states that the byte write will
>>>> clear the write enable latch.
>>>>
>>>
>>> i can confirm both patches fix real issues, i have similiar fixes
>>> on a kernel tree i always wanted to clean up and upstream. Diffs
>>> based on 6.6.127:
>>>
>>> diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
>>> index 197d2c1101ed5..eaa50561ede2c 100644
>>> --- a/drivers/mtd/spi-nor/sst.c
>>> +++ b/drivers/mtd/spi-nor/sst.c
>>> @@ -155,6 +155,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>>                  if (ret)
>>>                          goto out;
>>>
>>> +               ret = spi_nor_write_enable(nor);
>>> +               if (ret)
>>> +                       goto out;
>>> +               ret = spi_nor_wait_till_ready(nor);
>>> +               if (ret)
>>> +                       goto out;
>>> +
>>>                  to++;
>>>                  actual++;
>>>          }
>>>
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 1b0c6770c14e4..646bfb2e91a65 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -276,7 +276,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
>>>          if (spi_nor_spimem_bounce(nor, &op))
>>>                  memcpy(nor->bouncebuf, buf, op.data.nbytes);
>>>
>>> -       if (nor->dirmap.wdesc) {
>>> +       if (nor->dirmap.wdesc && nor->program_opcode != SPINOR_OP_AAI_WP) {
>> Why is this better? This removes the use of dirmap for all flashes other
>> than SST.
>
> i claim the opposite down below? That patch 2 of the posted patch series
> looks better to me. Sorry if that was unclear.

Oh, then I misunderstood.

Please review and test the v4, it will help land those fixes.

[...]

-- 
Regards,
Pratyush Yadav

