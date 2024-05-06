Return-Path: <stable+bounces-43158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E011C8BD6F8
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 23:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9053B281FEF
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF113DBBE;
	Mon,  6 May 2024 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO5o155L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20927269;
	Mon,  6 May 2024 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032156; cv=none; b=XkHcCSi+iE3xDK7CzqpePWcKA9cA4vkyzPnybE+nsIxIWIsaIQhEdtSPoWaMsPNuTdBQi1lGijxUS2iiouoZ/H/fja14frIEy6I909EcOEbSk7NoDXNidxztXPdMJivL1XaHCYTBryb3Fg6B4WFk3TohmXWmvOwoyitA2kb1eHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032156; c=relaxed/simple;
	bh=u+eITQHQHdhh+dX08SWoFvr9lO3rL7WYHSTk19LFs/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdAlJXOuGU+Fi2UvAorhVSh4wtIYhA19P1aUxroCYynPlt6XxQFcz0RcpTWxSryWqc9CnI3XCZuDO9kTmFbLNyFm8COjtMrtw8nn7rBkMBwc42rYErCaqDKzH/KOKV0+AyBYX1p22zzUmq3q4He2NRcT69SFlmoK8JC0QnGbehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO5o155L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F0C116B1;
	Mon,  6 May 2024 21:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715032156;
	bh=u+eITQHQHdhh+dX08SWoFvr9lO3rL7WYHSTk19LFs/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OO5o155LP4rLCcNEBcZaU+qa85QnZOB/kBeEpysVRGeth4CnmqvFoVl8/K4sANJ1p
	 68v8Il/Xe8kCz3/6Q9Rs2FSUmCF8kvn59ePOapWqLOSTg915fVXYrdZswtPCAFGR4Y
	 tqRvZ5apx+1LDCsgUf7rStM+DMWRwnwybN/0gc429ApU15nKNYb80gUVzO2+xjpQy+
	 NGJq0F00wnPDdblGdEDGHEP+0gB5yrsJdaSS5o2epHOYgS6OscRVzUk4D/Z3a+Ec8S
	 D5fBF/IqnSVc8IikuQVBTF8WW0xw87Fw7N6BXKTrCyU0BG67mTI5HDAY6UQH5Z/SfW
	 NFDVimNluPeiA==
Date: Mon, 6 May 2024 23:49:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	IDE/ATA development list <linux-ide@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: "ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX()
 macros" - 742bef476ca5352b16063161fb73a56629a6d995 changed logging behavior
 and disabled a number of messages
Message-ID: <ZjlQV-6dEgwhf-vc@ryzen.lan>
References: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>

Hello Krzysztof,

On Sun, May 05, 2024 at 01:06:28PM -0700, Krzysztof Olędzki wrote:
> Hi,
> 
> I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.
> 
> For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:
> 
> scsi host1: ata_piix
> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> ata2: port disabled--ignoring
> ata1.01: NODEV after polling detection
> ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33
> 
> After that commit, the following two log entries are missing:
> ata2: port disabled--ignoring
> ata1.01: NODEV after polling detection
> 
> Note that these are just examples, there are many more messages impacted by that.
> 
> Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
> ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
> ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]
> 
> The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:
> 
> +#define ata_dev_printk(level, dev, fmt, ...)			\
> +        pr_ ## level("ata%u.%02u: " fmt,			\
> +               (dev)->link->ap->print_id,			\
> +	       (dev)->link->pmp + (dev)->devno,			\
> +	       ##__VA_ARGS__)
> (...)
>  #define ata_link_dbg(link, fmt, ...)				\
> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
> (...)
>  #define ata_dev_dbg(dev, fmt, ...)				\
> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
> +	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__
> 
> So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).
> 
> pr_debug is defined as:
> /* If you are writing a driver, please use dev_dbg instead */
> #if defined(CONFIG_DYNAMIC_DEBUG) || \
> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
> #include <linux/dynamic_debug.h>
> 
> /**
>  * pr_debug - Print a debug-level message conditionally
>  * @fmt: format string
>  * @...: arguments for the format string
>  *
>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>  *
>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
>  * pr_fmt() internally).
>  */
> #define pr_debug(fmt, ...)			\
> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
> #elif defined(DEBUG)
> #define pr_debug(fmt, ...) \
> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #else
> #define pr_debug(fmt, ...) \
> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> #endif
> 
> Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.
> 
> Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.
> 
> Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
> One of the cases like this was covered in the patch:
> -#ifdef ATA_DEBUG
>         if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
> -               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
> -                               status);
> -#endif
> +               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
> 
> Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?
> 
> Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...

The change to the dynamic debug model was very much intentional.

CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG (and ata_msg_info/ata_msg_probe)
was replaced with dynamic debug.

So the reason why you saw the messages before was most likely because you
built your kernel with CONFIG_ATA_DEBUG / CONFIG_ATA_VERBOSE_DEBUG.
If you want to see the same error messages, you are now expected to use
dynamic debug for the file which you want debug messages enabled.


I do agree that the debug prints that were NOT guarded by CONFIG_ATA_DEBUG
do now work differently, as they are no longer printed to dmesg at all.
I'm not sure if this part was intentional. I'm guessing that it wasn't.

Looking at these three prints specifically:
ata_link_dbg(link, "port disabled--ignoring\n");
ata_dev_dbg(dev, "NODEV after polling detection\n");
ata_dev_dbg(dev, "disabling queued TRIM support\n");

None of them were protected with CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG
before the series converting to dynamic debug was merged.


The best way forward is probably to look at all debug prints before the
series converting to dynamic debug was merged, and see if any print NOT
guarded by CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG should be considered
to promoted to an info print instead.
(The prints that were guarded are not relevant, for those you really are
expected to need to use dynamic debug in order to actually get them
printed to dmesg.)


Kind regards,
Niklas

