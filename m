Return-Path: <stable+bounces-20383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3445858913
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 23:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F42813C5
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C1148307;
	Fri, 16 Feb 2024 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWQJ5HdU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53606146904;
	Fri, 16 Feb 2024 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123467; cv=none; b=peznSupJ4aCup6Onfm7NWk7chfKhhcbv+INR+YP+0CTbf5g982e6NA0gDToFvEha5YOvB+KV0Q68buVpM/kGZ/5J2JIMencPYVF/8+UsJNH2lyRv8ccyjpQB4ErlkmzBU4pw+KIu2Gnu6ouTVbp3ksEH9k+iaCjn4q+Bh0bm/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123467; c=relaxed/simple;
	bh=QhvjulcGGdTo0awHmk06tL4KcLd6DFGTyFIORcQ/GX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ7TtYH+8v3AEdljuYBVXSZlLRR0DpiYuPglKwOK+YO2YWZ0GQdkLNEeeEuh2a+3QJMDFSrCO9wwTP+ZBtscjM2dDWLs5l841t6VQI2seXlh+hS+XGy7wQ0VttWEujrPzUWXanDsHW4tkpbtko15zCBFWjwVTG6yHJ+FcMR67J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWQJ5HdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11435C433F1;
	Fri, 16 Feb 2024 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123466;
	bh=QhvjulcGGdTo0awHmk06tL4KcLd6DFGTyFIORcQ/GX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TWQJ5HdUVH1Cx6IP8MeG0/H9b/7XPnogvBErwtsfRYpbuK9VasF0zTxwwm8HnbBKS
	 88hAdJg33e6OPs+CM40gbDDIPfR5W+NGFOQO0+AUDG6GrroaDZNtjWeWMP89LLkpS5
	 dPTLa/uL69/8KIN6CQeguGD6mXl5dtyhpVeIbasw9W5jteJkIWpwn9hSXa8nofCpt/
	 QTUBQXxwraT/bo/i8QIC58Jf/eCXwMv4mbkS9ZOMuAVbL1FGg/yBqaIA0toOMdvRCp
	 Vuv2ZT7BSNvyNtZyboA3xNUmG7J//iZc+Lf2rqbuEnxqSJnLpgdhg9Ndf69JA885Kn
	 flX9XOp3V9FEw==
Message-ID: <c06d7d31-0510-46eb-9c3a-96a86edb32cf@kernel.org>
Date: Sat, 17 Feb 2024 07:44:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Do not call ata_dev_power_set_standby()
 twice
To: Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
 linux-ide@vger.kernel.org
References: <20240216112008.1112538-1-cassel@kernel.org>
 <c2054321-401d-4b16-9c20-20ea11929f49@kernel.org>
 <Zc9WJcBRrf5kr/pi@x1-carbon>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zc9WJcBRrf5kr/pi@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/24 21:33, Niklas Cassel wrote:
> On Fri, Feb 16, 2024 at 09:16:23PM +0900, Damien Le Moal wrote:
>> On 2/16/24 20:20, Niklas Cassel wrote:
>>> From: Damien Le Moal <dlemoal@kernel.org>
>>>
>>> For regular system shutdown, ata_dev_power_set_standby() will be
>>> executed twice: once the scsi device is removed and another when
>>> ata_pci_shutdown_one() executes and EH completes unloading the devices.
>>>
>>> Make the second call to ata_dev_power_set_standby() do nothing by using
>>> ata_dev_power_is_active() and return if the device is already in
>>> standby.
>>>
>>> Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>> This fix was originally part of patch that contained both a fix and
>>> a revert in a single patch:
>>> https://lore.kernel.org/linux-ide/20240111115123.1258422-3-dlemoal@kernel.org/
>>>
>>> This patch contains the only the fix (as it is valid even without the
>>> revert), without the revert.
>>>
>>> Updated the Fixes tag to point to a more appropriate commit, since we
>>> no longer revert any code.
>>>
>>>  drivers/ata/libata-core.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>>> index d9f80f4f70f5..af2334bc806d 100644
>>> --- a/drivers/ata/libata-core.c
>>> +++ b/drivers/ata/libata-core.c
>>> @@ -85,6 +85,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>>>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>>>  static void ata_dev_xfermask(struct ata_device *dev);
>>>  static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
>>> +static bool ata_dev_power_is_active(struct ata_device *dev);
>>
>> I forgot what I did originally but didn't I move the code of
>> ata_dev_power_is_active() before ata_dev_power_set_standby() to avoid this
>> forward declaration ?
>>
>> With that, the code is a little odd as ata_dev_power_is_active() is defined
>> between ata_dev_power_set_standby() and ata_dev_power_set_active() but both
>> functions use it...
> 
> Yes, you moved the function instead of forward declaring it.
> 
> But then there was a discussion of why ATA_TFLAG_ISADDR is set in
> ata_dev_power_is_active():
> https://lore.kernel.org/linux-ide/d63a7b93-d1a3-726e-355c-b4a4608626f4@gmail.com/
> 
> And you said that you were going to look in to it:
> https://lore.kernel.org/linux-ide/0563322c-4093-4e7d-bb48-61712238494e@kernel.org/
> 

Ah, yes, I remember now. Let me have a look at this and resend a proper patch, +
another one for the ISADDR cleanup. I really don't want to fix this with that
forward declaration if we can avoid it (and we clearly can here).

> Since this fix does not strictly require any changes to
> ata_dev_power_is_active(), and since we already have a bunch of
> forward declared functions, I think that forward declaring it is a
> good way to avoid this actual fix from falling through the cracks.
> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research


