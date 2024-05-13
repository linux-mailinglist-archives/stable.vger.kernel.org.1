Return-Path: <stable+bounces-43598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943118C3BB6
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 09:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AFE1C20FFF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40640146A6C;
	Mon, 13 May 2024 07:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="gO4bwacG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8A1FA1;
	Mon, 13 May 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584163; cv=none; b=tMfSaANQcBUQswddNkCBI52yNE/ycdO2M3WgeqofrpAx5ONSdv6rf7HOWoJMg3+R91tEmXwg5dlAEC4WwfkGyQ5b4P8JEQol93vWYhnvvQRwlIx3krYHeEhrt6cTh+EconSC+GFmgLMx/rIaXE3d2J14lMeRGwC7XN2dcvClb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584163; c=relaxed/simple;
	bh=oUPE7rlSyFBd3PWdGa+1iRUndIpgs7oWk9YG0bDYKqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQecH0/OS+lf1iJvLWuioFjtDPkbs58AazpUTAUGiPONiiwQrPqhWYPmdeuCpsJjyYj4mU5v6mXwX3GpUraYXN+uDYVMKycxs67dcUUPs6yScapWVLH13iGwM/F8m0xDhfGy/BiPh5oNKD+vwZIUWr01AqxPXehtflPQMDs+wiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=gO4bwacG; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44D6oYtk013285
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 13 May 2024 08:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1715583037; bh=b+pmeEO7GLT5ap51rky8N3S9uGWdwxt67R3bnE1lZ6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gO4bwacGNr75JqH1zAEaqLgvIlwWzBTyIhnTQ/ra7F7d7Z668Pr0YDlb9Zik7pnoM
	 QCc22or5YxLIlV5eYL0L7IfFS7QGp/lIn5kxRLQD1dJeNXZwJITGg6DPF5PKMWJwny
	 5bvAZCMJ9aE7wRt31aYQzH2a+4gFGJ7ua1WdZf58=
Message-ID: <d7a8ca73-3625-4d13-8ece-fc38519594d6@ans.pl>
Date: Sun, 12 May 2024 23:50:32 -0700
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
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        stable@vger.kernel.org
References: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
 <ZjlQV-6dEgwhf-vc@ryzen.lan>
 <9140fb43-8c58-4a01-85ab-08d179a6cb59@kernel.org>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <9140fb43-8c58-4a01-85ab-08d179a6cb59@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06.05.2024 at 15:08, Damien Le Moal wrote:
> On 5/7/24 06:49, Niklas Cassel wrote:
>> Hello Krzysztof,

Hello and thank you for your quick and detailed response from both of you!

>> On Sun, May 05, 2024 at 01:06:28PM -0700, Krzysztof Olędzki wrote:
>>> Hi,
>>>
>>> I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.
>>>
>>> For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:
>>>
>>> scsi host1: ata_piix
>>> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
>>> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>> ata2: port disabled--ignoring
>>> ata1.01: NODEV after polling detection
>>> ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33
>>>
>>> After that commit, the following two log entries are missing:
>>> ata2: port disabled--ignoring
>>> ata1.01: NODEV after polling detection
>>>
>>> Note that these are just examples, there are many more messages impacted by that.
>>>
>>> Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
>>> ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
>>> ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]
>>>
>>> The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:
>>>
>>> +#define ata_dev_printk(level, dev, fmt, ...)			\
>>> +        pr_ ## level("ata%u.%02u: " fmt,			\
>>> +               (dev)->link->ap->print_id,			\
>>> +	       (dev)->link->pmp + (dev)->devno,			\
>>> +	       ##__VA_ARGS__)
>>> (...)
>>>  #define ata_link_dbg(link, fmt, ...)				\
>>> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>> +	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
>>> (...)
>>>  #define ata_dev_dbg(dev, fmt, ...)				\
>>> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>> +	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__
>>>
>>> So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).
>>>
>>> pr_debug is defined as:
>>> /* If you are writing a driver, please use dev_dbg instead */
>>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>> #include <linux/dynamic_debug.h>
>>>
>>> /**
>>>  * pr_debug - Print a debug-level message conditionally
>>>  * @fmt: format string
>>>  * @...: arguments for the format string
>>>  *
>>>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>>>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>>>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>>>  *
>>>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
>>>  * pr_fmt() internally).
>>>  */
>>> #define pr_debug(fmt, ...)			\
>>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>> #elif defined(DEBUG)
>>> #define pr_debug(fmt, ...) \
>>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>> #else
>>> #define pr_debug(fmt, ...) \
>>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>> #endif
>>>
>>> Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.
>>>
>>> Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.
>>>
>>> Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
>>> One of the cases like this was covered in the patch:
>>> -#ifdef ATA_DEBUG
>>>         if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
>>> -               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
>>> -                               status);
>>> -#endif
>>> +               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>>>
>>> Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?
>>>
>>> Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...
>>
>> The change to the dynamic debug model was very much intentional.
>>
>> CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG (and ata_msg_info/ata_msg_probe)
>> was replaced with dynamic debug.

Understood.

>> So the reason why you saw the messages before was most likely because you
>> built your kernel with CONFIG_ATA_DEBUG / CONFIG_ATA_VERBOSE_DEBUG.

I don't believe this is the case - please note these were ATA_VERBOSE_DEBUG / ATA_DEBUG (i.e. not CONFIG_...) and these logging entries were not covered by ifdefs, for example:

if (rc == -ENOENT) {
        ata_link_dbg(link, "port disabled--ignoring\n");
        ehc->i.action &= ~ATA_EH_RESET;

        ata_for_each_dev(dev, link, ALL)
                classes[dev->devno] = ATA_DEV_NONE;

        rc = 0;
} else
        ata_link_err(link,
                     "prereset failed (errno=%d)\n",
                     rc);

>> If you want to see the same error messages, you are now expected to use
>> dynamic debug for the file which you want debug messages enabled.

Totally agree on the "debug" type of messages but I'm not sure if asking users to use dynamic debug to see error messages is what we want...

>> I do agree that the debug prints that were NOT guarded by CONFIG_ATA_DEBUG
>> do now work differently, as they are no longer printed to dmesg at all.
>> I'm not sure if this part was intentional. I'm guessing that it wasn't.

That's precisely the point I have been trying to make here. The dynamic debugging change seems like a very welcome one, the messages disappearing - perhaps not so much. Especially in a middle of a -stable kernel.

>> Looking at these three prints specifically:
>> ata_link_dbg(link, "port disabled--ignoring\n");
> 
> Given the recent addition of the port map mask, we could restore this print as
> an info level.
> 
>> ata_dev_dbg(dev, "NODEV after polling detection\n");
> 
> This one is weird. It should be an error print.
> 
>> ata_dev_dbg(dev, "disabling queued TRIM support\n");
> 
> This is also OK to restore as an info print. But given that, there are a lot
> more horkage disabling features that we probably should print.

Thanks. Just a note that these were just some examples. Also, can I help somehow or should I just wait for patches to test?

>> None of them were protected with CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG
>> before the series converting to dynamic debug was merged.
>>
>>
>> The best way forward is probably to look at all debug prints before the
>> series converting to dynamic debug was merged, and see if any print NOT
>> guarded by CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG should be considered
>> to promoted to an info print instead.

Same question as the above: can I help somehow or should I just wait for patches to test?

>> (The prints that were guarded are not relevant, for those you really are
>> expected to need to use dynamic debug in order to actually get them
>> printed to dmesg.)

Fair and I fully agree with this one.

Thanks,
 Krzysztof


