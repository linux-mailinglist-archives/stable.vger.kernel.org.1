Return-Path: <stable+bounces-66285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6694D387
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F309D1C21283
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942AF198845;
	Fri,  9 Aug 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juuqxxgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E56168DC;
	Fri,  9 Aug 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217685; cv=none; b=DIDpLLN1+tpQM9ulyBOyPlZ4fp3dWuE0ibke7Ivg8E1kEFpXUUxos2nrszLjNwP9Uz0FzSp24kkOqnU2uQG1KEry0XdpgH1zlqeFWyngXNO6+leDe3vcROg+uo3wMkCnB8kxJbOV9rcgO1MO6W0AZ7ddOgTPLmDe/MezSMl897Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217685; c=relaxed/simple;
	bh=xOeajoTbjJnSdAiPass/Rpyu0Kl8NAn33BDrrQ9U+bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U15/c73NePkuqlpQ1m/qC7qU/4Pt/FIuvpJ6H/V80oiGE9OVZLg8YH1R2fBNeBqL1usYns7HOZMdyql3TOx+05cli5KgtXlGJ+e1n9a/HBQv7tEOwyUx0xwwWl7rcdMgNrxQR7dZ+1X/TCCR4xMf4TYESgAE1CRK9pT1S4WrxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juuqxxgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FB0C32782;
	Fri,  9 Aug 2024 15:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723217684;
	bh=xOeajoTbjJnSdAiPass/Rpyu0Kl8NAn33BDrrQ9U+bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=juuqxxguEpFZcSZ1aLZdWapJYMqubUZHPSLyVJyEIpio7ySRM7dvSR6ydu3UgHYcT
	 LHZd1Vrz3OUy1mBudOj2xbHw4J+PxfV01irOVxAFYUNQVE/MsWp7Ktkw5yoBxd05tr
	 QgcPsUAmikkzZgCHNSim17Ga7O/quLgU8zV+rysSRtUghP7HvNSvBIiAMh/gbIGpz2
	 dR26SQbyeMaDc13ncfb7Nuq+aXfRw95k5cOxhoTy6S27DCGzIMUdDrgZXxfYZ8hxm+
	 sEDk2Nc0ySSwf5quibaZUQEmXPQU6mZG/PVY77909E00qeZtEz5HqgNlPJL1L+gGe5
	 1eahcJpc9af4g==
Message-ID: <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
Date: Fri, 9 Aug 2024 08:34:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
To: Niklas Cassel <cassel@kernel.org>
Cc: Christian Heusel <christian@heusel.eu>, Igor Pylypiv
 <ipylypiv@google.com>, linux-ide@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/08/07 15:10, Niklas Cassel wrote:
> On Wed, Aug 07, 2024 at 11:26:46AM -0700, Damien Le Moal wrote:
>> On 2024/08/07 10:23, Christian Heusel wrote:
>>> Hello Igor, hello Niklas,
>>>
>>> on my NAS I am encountering the following issue since v6.6.44 (LTS),
>>> when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
>>> the active or standby state:
>>>
>>>     $ hdparm -C /dev/sda
>>>     /dev/sda:
>>>     SG_IO: bad/missing sense data, sb[]:  f0 00 01 00 50 40 ff 0a 00 00 78 00 00 1d 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>>      drive state is:  unknown
>>>
>>>
>>> While the expected output is the following:
>>>
>>>     $ hdparm -C /dev/sda
>>>     /dev/sda:
>>>      drive state is:  active/idle
>>>
>>> I did a bisection within the stable series and found the following
>>> commit to be the first bad one:
>>>
>>>     28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
>>>
>>> According to kernel.dance the same commit was also backported to the
>>> v6.10.3 and v6.1.103 stable kernels and I could not find any commit or
>>> pending patch with a "Fixes:" tag for the offending commit.
>>>
>>> So far I have not been able to test with the mainline kernel as this is
>>> a remote device which I couldn't rescue in case of a boot failure. Also
>>> just for transparency it does have the out of tree ZFS module loaded,
>>> but AFAIU this shouldn't be an issue here, as the commit seems clearly
>>> related to the error. If needed I can test with an untainted mainline
>>> kernel on Friday when I'm near the device.
>>>
>>> I have attached the output of hdparm -I below and would be happy to
>>> provide further debug information or test patches.
>>
>> I confirm this, using 6.11-rc2. The problem is actually hdparm code which
>> assumes that the sense data is in descriptor format without ever looking at the
>> D_SENSE bit to verify that. So commit 28ab9769117c reveals this issue because as
>> its title explains, it (correctly) honors D_SENSE instead of always generating
>> sense data in descriptor format.
> 
> You mean: the user space application is using the sense buffer without first
> checking if the returned sense buffer is in descriptor or fixed format.

Yes. The code looks like:

desc = sb + 8;
if (io_hdr.driver_status != SG_DRIVER_SENSE) {
	...
} else if (sb[0] != 0x72 || sb[7] < 14 || desc[0] != 0x09 || desc[1] < 0x0c) {
	if (verbose || tf->command != ATA_OP_IDENTIFY)
		dump_bytes("SG_IO: bad/missing sense data, sb[]",
			   sb, sizeof(sb));
}

So clearly it assumes descrip@tor format.

> This seems like a fundamentally flawed assumption by the user space program.
> If it doesn't even bother checking the first field in the sense buffer, sb[0],
> perhaps it shouldn't bother trying to use the sense buffer at all.

> (Yes, the D_SENSE bit can be configured by the user, but that doesn't change
> the fact that a user space program must check the format of the returned buffer
> before trying to use it.)

Yep. I agree.

> 
> 
>> Hmm... This is annoying. The kernel is fixed to be spec compliant but that
>> breaks old/non-compliant applications... We definitely should fix hdparm code,
>> but I think we still need to revert 28ab9769117c...
> 
> Well.. if we look at commit:
> 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> https://github.com/torvalds/linux/commit/11093cb1ef56147fe33f5750b1eab347bdef30db
> 
> We can see that before that commit, the kernel used to call
> ata_scsi_set_sense().
> 
> Back then ata_scsi_set_sense() was defined as:
> https://github.com/torvalds/linux/blob/11093cb1ef56147fe33f5750b1eab347bdef30db/drivers/ata/libata-scsi.c#L280
> scsi_build_sense_buffer(0, cmd->sense_buffer, sk, asc, ascq);
> 
> Where the first argument to scsi_build_sense_buffer() is if the generated sense
> buffer should be fixed or desc format (0 == fixed format), so we used to
> generate the sense buffer in fixed format:
> https://github.com/torvalds/linux/blob/11093cb1ef56147fe33f5750b1eab347bdef30db/drivers/scsi/scsi_common.c#L231
> 
> However, as we can see, the kernel then used to incorrectly just
> change sb[0} to say that the buffer was in desc format,
> without updating the other fields, e.g. sb[2]:
> https://github.com/torvalds/linux/blob/11093cb1ef56147fe33f5750b1eab347bdef30db~/drivers/ata/libata-scsi.c#L1026
> so the format was really in some franken format...
> following neither fixed or descriptor format.
> 
> 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> did change so that successful ATA-passthrough commands always generated
> the sense data in descriptor format. However, that commit also managed to
> mess up the offsets for fixed format sense...
> 
> The commit that later changed ata_scsi_set_sense() to honor D_SENSE
> was commit: 06dbde5f3a44 ("libata: Implement control mode page to select
> sense format")
> 
> So basically:
> Before commit 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through
> sense"), we generated sense data in some franken format for both successful
> and failed ATA-passthrough commands.
> 
> After commit 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through
> sense") we generate sense data for sucessful ATA-passthrough commands in
> descriptor format unconditionally, but still in franken format for failed
> ATA-passthrough commands.
> 
> After commit 06dbde5f3a44 ("libata: Implement control mode page to select
> sense format") we generate sense data for sucessful ATA-passthrough commands
> in descriptor format unconditionally, but for failed commands we actually
> honored D_SENSE to generate it either in fixed format or descriptor format.
> (However, because of a bug in 11093cb1ef56, if using fixed format, the
> offsets were wrong...)
> 
> 
> The incorrect offsets for fixed format was fixed recently, in commit
> 38dab832c3f4 ("ata: libata-scsi: Fix offsets for the fixed format sense data")
> 
> Commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and
> no error") fixed so that we actually honor D_SENSE not only for failed
> ATA-passthrough commands, but also for successfull ATA-passthrough commands.
> 
> TL;DR: it is very hard to say that we have introduced a regression, because
> this crap has basically been broken in one way or another since it was
> introduced... Personally, I would definitely want all the patches that are in
> mainline in the kernel running on my machine, since that is the only thing
> that is consistent.
> 
> However, that assumes that user space programs that are trying to parse the
> sense data actually bothers to check the first field in the sense data,
> to see which format the returned sense data is in... Applications that
> do not even both with that will have problems on a lot of (historic) kernel
> versions.

Yes, indeed. I do not want to revert any of these recent patches, because as you
rightly summarize here, these fix something that has been broken for a long
time. We were just lucky that we did not see more application failures until
now, or rather unlucky that we did not as that would have revealed these
problems earlier.

So I think we will have some patching to do to hdparm at least to fix the
problems there.


-- 
Damien Le Moal
Western Digital Research


