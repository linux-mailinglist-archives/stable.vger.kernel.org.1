Return-Path: <stable+bounces-43626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209088C4194
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672E6B22F5C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF41514E5;
	Mon, 13 May 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI6MrFf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EBE15098C;
	Mon, 13 May 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606051; cv=none; b=DefyF2np1ThaF1M7QEKJog+EcQC37XDhTfrwbhwB6pCCzjDFbKK6R11Ogr/hjjv2laFHc4+O8YuHyJHK9Z8wbxqBIg1TN3t91wYdoSRy8Wuwu87dS482UCvH9MxY+Ir05cWDM2YyHqJuNScKhgTWL+nmBsxnrcaC30no5RIkkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606051; c=relaxed/simple;
	bh=fi7ajwDGFpX/WOxeEIBCXDLr5Jpj2iRdjE3cet2atoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPJPqGe/YnPs2j4Pslebdm8j/ZwZdF68xBQcRIrk9PEtLtYrep0vgk+DrHZy/PGnJe2S2wDJfFy7FuHU3AqXRDI9nG1pM3kjiI3nGPsSiPTLTzTXxbeB20ymTZgXCQRhdCmonEwpX8DEnZqc6IGupen2FBLcnYScdXsGEmmaHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI6MrFf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D078C113CC;
	Mon, 13 May 2024 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715606050;
	bh=fi7ajwDGFpX/WOxeEIBCXDLr5Jpj2iRdjE3cet2atoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QI6MrFf4hrxdujCvdgC/+CShyk9ZmBo+KlEaH2MhiFnQFCeTTN3cI3WbziEgkLxVV
	 Jd5yEwCRvhV+n/K2E13IoLYSWvRSNrAOsBNRauefOQSjHVkN+G3KgVDHfID1MOecYd
	 ECWKi16rUsCeTxJvsF4OdK1kvlq7hCS9B+kfsW7uuuC+40bvFKM/P0XPlNGAre0cHw
	 V/1RHTDADtyDuvK0/+BobUG+ON39fiiNtQTEC4OPYWPttRCfOhu+7TenV5pkwRBOwb
	 XNBSmnoYZqngNTi1mF80S0xqoX9NY3c5D28GNfQ9iQVb3lH0ZjmAOTdxzyPdayWHgm
	 hJP2KOOanJ8/Q==
Message-ID: <81f19ca4-bb63-4d72-a197-c27f1bb7d381@kernel.org>
Date: Mon, 13 May 2024 22:14:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX()
 macros" - 742bef476ca5352b16063161fb73a56629a6d995 changed logging behavior
 and disabled a number of messages
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 IDE/ATA development list <linux-ide@vger.kernel.org>, stable@vger.kernel.org
References: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
 <ZjlQV-6dEgwhf-vc@ryzen.lan>
 <9140fb43-8c58-4a01-85ab-08d179a6cb59@kernel.org>
 <d7a8ca73-3625-4d13-8ece-fc38519594d6@ans.pl>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d7a8ca73-3625-4d13-8ece-fc38519594d6@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/05/13 15:50, Krzysztof Olędzki wrote:
> On 06.05.2024 at 15:08, Damien Le Moal wrote:
>> On 5/7/24 06:49, Niklas Cassel wrote:
>>> Hello Krzysztof,
> 
> Hello and thank you for your quick and detailed response from both of you!
> 
>>> On Sun, May 05, 2024 at 01:06:28PM -0700, Krzysztof Olędzki wrote:
>>>> Hi,
>>>>
>>>> I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.
>>>>
>>>> For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:
>>>>
>>>> scsi host1: ata_piix
>>>> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
>>>> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
>>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>>> ata2: port disabled--ignoring
>>>> ata1.01: NODEV after polling detection
>>>> ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33
>>>>
>>>> After that commit, the following two log entries are missing:
>>>> ata2: port disabled--ignoring
>>>> ata1.01: NODEV after polling detection
>>>>
>>>> Note that these are just examples, there are many more messages impacted by that.
>>>>
>>>> Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
>>>> ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
>>>> ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]
>>>>
>>>> The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:
>>>>
>>>> +#define ata_dev_printk(level, dev, fmt, ...)			\
>>>> +        pr_ ## level("ata%u.%02u: " fmt,			\
>>>> +               (dev)->link->ap->print_id,			\
>>>> +	       (dev)->link->pmp + (dev)->devno,			\
>>>> +	       ##__VA_ARGS__)
>>>> (...)
>>>>  #define ata_link_dbg(link, fmt, ...)				\
>>>> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>>> +	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
>>>> (...)
>>>>  #define ata_dev_dbg(dev, fmt, ...)				\
>>>> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>>> +	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__
>>>>
>>>> So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).
>>>>
>>>> pr_debug is defined as:
>>>> /* If you are writing a driver, please use dev_dbg instead */
>>>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>>> #include <linux/dynamic_debug.h>
>>>>
>>>> /**
>>>>  * pr_debug - Print a debug-level message conditionally
>>>>  * @fmt: format string
>>>>  * @...: arguments for the format string
>>>>  *
>>>>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>>>>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>>>>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>>>>  *
>>>>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
>>>>  * pr_fmt() internally).
>>>>  */
>>>> #define pr_debug(fmt, ...)			\
>>>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>>> #elif defined(DEBUG)
>>>> #define pr_debug(fmt, ...) \
>>>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>> #else
>>>> #define pr_debug(fmt, ...) \
>>>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>> #endif
>>>>
>>>> Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.
>>>>
>>>> Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.
>>>>
>>>> Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
>>>> One of the cases like this was covered in the patch:
>>>> -#ifdef ATA_DEBUG
>>>>         if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
>>>> -               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
>>>> -                               status);
>>>> -#endif
>>>> +               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>>>>
>>>> Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?
>>>>
>>>> Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...
>>>
>>> The change to the dynamic debug model was very much intentional.
>>>
>>> CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG (and ata_msg_info/ata_msg_probe)
>>> was replaced with dynamic debug.
> 
> Understood.
> 
>>> So the reason why you saw the messages before was most likely because you
>>> built your kernel with CONFIG_ATA_DEBUG / CONFIG_ATA_VERBOSE_DEBUG.
> 
> I don't believe this is the case - please note these were ATA_VERBOSE_DEBUG / ATA_DEBUG (i.e. not CONFIG_...) and these logging entries were not covered by ifdefs, for example:
> 
> if (rc == -ENOENT) {
>         ata_link_dbg(link, "port disabled--ignoring\n");
>         ehc->i.action &= ~ATA_EH_RESET;
> 
>         ata_for_each_dev(dev, link, ALL)
>                 classes[dev->devno] = ATA_DEV_NONE;
> 
>         rc = 0;
> } else
>         ata_link_err(link,
>                      "prereset failed (errno=%d)\n",
>                      rc);
> 
>>> If you want to see the same error messages, you are now expected to use
>>> dynamic debug for the file which you want debug messages enabled.
> 
> Totally agree on the "debug" type of messages but I'm not sure if asking users to use dynamic debug to see error messages is what we want...
> 
>>> I do agree that the debug prints that were NOT guarded by CONFIG_ATA_DEBUG
>>> do now work differently, as they are no longer printed to dmesg at all.
>>> I'm not sure if this part was intentional. I'm guessing that it wasn't.
> 
> That's precisely the point I have been trying to make here. The dynamic debugging change seems like a very welcome one, the messages disappearing - perhaps not so much. Especially in a middle of a -stable kernel.
> 
>>> Looking at these three prints specifically:
>>> ata_link_dbg(link, "port disabled--ignoring\n");
>>
>> Given the recent addition of the port map mask, we could restore this print as
>> an info level.
>>
>>> ata_dev_dbg(dev, "NODEV after polling detection\n");
>>
>> This one is weird. It should be an error print.
>>
>>> ata_dev_dbg(dev, "disabling queued TRIM support\n");
>>
>> This is also OK to restore as an info print. But given that, there are a lot
>> more horkage disabling features that we probably should print.
> 
> Thanks. Just a note that these were just some examples. Also, can I help somehow or should I just wait for patches to test?
> 
>>> None of them were protected with CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG
>>> before the series converting to dynamic debug was merged.
>>>
>>>
>>> The best way forward is probably to look at all debug prints before the
>>> series converting to dynamic debug was merged, and see if any print NOT
>>> guarded by CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG should be considered
>>> to promoted to an info print instead.
> 
> Same question as the above: can I help somehow or should I just wait for patches to test?

If you have something in mind, please, by all means, send patches and we'll go
from there. What I think we need is:

1) Review the code to make sure that we print an error message for everything
that fails but should really succeeds. Beware here that some things may "fail"
during port scan if a device is not attached. That is normal and should not
result in printing errors.

2) Add prints whenever a horkage flag is applied to a device, port or link.

That should not be a lot.


-- 
Damien Le Moal
Western Digital Research


