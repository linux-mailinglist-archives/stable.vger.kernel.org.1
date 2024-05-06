Return-Path: <stable+bounces-43159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628248BD787
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 00:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B091C229EA
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94815CD49;
	Mon,  6 May 2024 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIiDEu/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A613D2BC;
	Mon,  6 May 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715033294; cv=none; b=UQypZ6u20h2kG+sgNk/dcFw84A0hC+2AzlYuM5r3prTdCAEaMp/C7+ZEHiZjbFDTBmpuz8Jtp8D8h4QLuE9blg+c37ljWqdzy7WYlYpxeSOZotMdP5Z/LuzKz0ODEpeml0aEfdInB/xcePl6Idv68GpuYyru2JflmBVzIXNPm30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715033294; c=relaxed/simple;
	bh=Aa+kmcHnNGp7CE5TCRMuZpBJQlZpVcSSMigDJ8c9ovk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WunOSmmZsqteQpfm4hTIvqkJGPF27Q/ArXIGCxxfKlII+GSwe2iJqpb2cxLs382B1/KlNNkQypG7FSYxj8MBNz+Gxe6CGDJHkwe85dCzf9H9R05mwhnijlQP28KjL61Mf7jBHTC4IkiWmr9UYVjCaG0ZvnftpXZjrWQJzcwMcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIiDEu/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A67C116B1;
	Mon,  6 May 2024 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715033293;
	bh=Aa+kmcHnNGp7CE5TCRMuZpBJQlZpVcSSMigDJ8c9ovk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EIiDEu/ufKAuvRiPErUmS0N1fexIyUQDFZvSqoY+NGsmKOSyDm5Qt6vnI1FGRHc47
	 GCVDfHmO/8w6anFikJB9JCnWH1KU4qOTMi4OtDX5ymNTfLpfvD8wDpsl3RnEEUV2b+
	 OBkh+T3NGyFZMAo/oGtG3O27bywIodZEceFMFe9P+MnlPFVxjOabg8wDM1dtIUK7IC
	 utt2cdl6hnqX8rwMi6Il0q4J2iYq5x3jkIY6Go7TCrFErWTLT1Uq/NJqTO3H+0mZON
	 U2iOxI+fyEorGra0MBbsYr3IAr0kNCi0SJclNCfeDOmZgnxClixytsNKIYevFJcduC
	 X+YprS7cXGHBw==
Message-ID: <9140fb43-8c58-4a01-85ab-08d179a6cb59@kernel.org>
Date: Tue, 7 May 2024 07:08:10 +0900
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
To: Niklas Cassel <cassel@kernel.org>, =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?=
 <ole@ans.pl>
Cc: Hannes Reinecke <hare@suse.de>,
 IDE/ATA development list <linux-ide@vger.kernel.org>, stable@vger.kernel.org
References: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
 <ZjlQV-6dEgwhf-vc@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZjlQV-6dEgwhf-vc@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/24 06:49, Niklas Cassel wrote:
> Hello Krzysztof,
> 
> On Sun, May 05, 2024 at 01:06:28PM -0700, Krzysztof Olędzki wrote:
>> Hi,
>>
>> I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.
>>
>> For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:
>>
>> scsi host1: ata_piix
>> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
>> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>> ata2: port disabled--ignoring
>> ata1.01: NODEV after polling detection
>> ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33
>>
>> After that commit, the following two log entries are missing:
>> ata2: port disabled--ignoring
>> ata1.01: NODEV after polling detection
>>
>> Note that these are just examples, there are many more messages impacted by that.
>>
>> Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
>> ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
>> ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]
>>
>> The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:
>>
>> +#define ata_dev_printk(level, dev, fmt, ...)			\
>> +        pr_ ## level("ata%u.%02u: " fmt,			\
>> +               (dev)->link->ap->print_id,			\
>> +	       (dev)->link->pmp + (dev)->devno,			\
>> +	       ##__VA_ARGS__)
>> (...)
>>  #define ata_link_dbg(link, fmt, ...)				\
>> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
>> +	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
>> (...)
>>  #define ata_dev_dbg(dev, fmt, ...)				\
>> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
>> +	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__
>>
>> So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).
>>
>> pr_debug is defined as:
>> /* If you are writing a driver, please use dev_dbg instead */
>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>> #include <linux/dynamic_debug.h>
>>
>> /**
>>  * pr_debug - Print a debug-level message conditionally
>>  * @fmt: format string
>>  * @...: arguments for the format string
>>  *
>>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>>  *
>>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
>>  * pr_fmt() internally).
>>  */
>> #define pr_debug(fmt, ...)			\
>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>> #elif defined(DEBUG)
>> #define pr_debug(fmt, ...) \
>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>> #else
>> #define pr_debug(fmt, ...) \
>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>> #endif
>>
>> Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.
>>
>> Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.
>>
>> Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
>> One of the cases like this was covered in the patch:
>> -#ifdef ATA_DEBUG
>>         if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
>> -               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
>> -                               status);
>> -#endif
>> +               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>>
>> Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?
>>
>> Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...
> 
> The change to the dynamic debug model was very much intentional.
> 
> CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG (and ata_msg_info/ata_msg_probe)
> was replaced with dynamic debug.
> 
> So the reason why you saw the messages before was most likely because you
> built your kernel with CONFIG_ATA_DEBUG / CONFIG_ATA_VERBOSE_DEBUG.
> If you want to see the same error messages, you are now expected to use
> dynamic debug for the file which you want debug messages enabled.
> 
> 
> I do agree that the debug prints that were NOT guarded by CONFIG_ATA_DEBUG
> do now work differently, as they are no longer printed to dmesg at all.
> I'm not sure if this part was intentional. I'm guessing that it wasn't.
> 
> Looking at these three prints specifically:
> ata_link_dbg(link, "port disabled--ignoring\n");

Given the recent addition of the port map mask, we could restore this print as
an info level.

> ata_dev_dbg(dev, "NODEV after polling detection\n");

This one is weird. It should be an error print.

> ata_dev_dbg(dev, "disabling queued TRIM support\n");

This is also OK to restore as an info print. But given that, there are a lot
more horkage disabling features that we probably should print.

> 
> None of them were protected with CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG
> before the series converting to dynamic debug was merged.
> 
> 
> The best way forward is probably to look at all debug prints before the
> series converting to dynamic debug was merged, and see if any print NOT
> guarded by CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG should be considered
> to promoted to an info print instead.
> (The prints that were guarded are not relevant, for those you really are
> expected to need to use dynamic debug in order to actually get them
> printed to dmesg.)
> 
> 
> Kind regards,
> Niklas
> 

-- 
Damien Le Moal
Western Digital Research


