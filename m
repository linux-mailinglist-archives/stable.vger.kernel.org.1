Return-Path: <stable+bounces-43072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF98BC36B
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 22:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4217A282CD5
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81476EB4C;
	Sun,  5 May 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="XRnQmLQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC366B5E;
	Sun,  5 May 2024 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714939616; cv=none; b=DPY3apL6hYxCT/hIcNqqlvEXfFiRRnBg8mCnRy17+M5unGMAbLNMwA4HWEQJ6bNudxXRINtCgSPajpF+r14Hv/KyIIwdZ7uguNwGTLlkSps9mz0LckHGgiPmLt2f4sBCYIH1HNIpwSwf5VOBDTBPsI7JoZv9ex3g4fu+mlU30iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714939616; c=relaxed/simple;
	bh=EEVcmGSgaKnqICxWiDfhS1+Hrzh9KjsgVqIIMSEiQoY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=gAXukhUKLXjdIUMr8Gr7Um3SBjcQ9H4xIiEn+fB7GKZAP7NErmlVdHYgwEEbkvmitxaE9O2wkm1mz8EATL9xG95iKCp+LJLfZ0cgcWZmgOPOEJ0JFhJhflIturpRzHtaTNvbR+kGcNxR55QwHjJJrdEiuK9231AfqEyVQAkNfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=XRnQmLQO; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 445K6UAl021884
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 5 May 2024 22:06:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1714939593; bh=3HDa0MfW9L/em0aIviekpvrIHHJ0pnys2nUPUNnJo7c=;
	h=Date:From:To:Cc:Subject;
	b=XRnQmLQOFeO9iPXU+wi6FR8WZIg4NwGhOS+ea0D7dymchpLdzpqBgh2c3/UnO2Wtb
	 N1tCDbhjTDIgWpkmh3UZ/W3vqOrLniqfHBb40Ge0/fL3eEJRYTQ8Zt+DOlzXCtD2CS
	 BClpRNWzqsFuU2purwce1Lj0+ZZSOYUJtBvOTJEM=
Message-ID: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
Date: Sun, 5 May 2024 13:06:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>,
        stable@vger.kernel.org
Subject: "ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX()
 macros" - 742bef476ca5352b16063161fb73a56629a6d995 changed logging behavior
 and disabled a number of messages
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.

For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:

scsi host1: ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ata2: port disabled--ignoring
ata1.01: NODEV after polling detection
ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33

After that commit, the following two log entries are missing:
ata2: port disabled--ignoring
ata1.01: NODEV after polling detection

Note that these are just examples, there are many more messages impacted by that.

Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]

The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:

+#define ata_dev_printk(level, dev, fmt, ...)			\
+        pr_ ## level("ata%u.%02u: " fmt,			\
+               (dev)->link->ap->print_id,			\
+	       (dev)->link->pmp + (dev)->devno,			\
+	       ##__VA_ARGS__)
(...)
 #define ata_link_dbg(link, fmt, ...)				\
-	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
+	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
(...)
 #define ata_dev_dbg(dev, fmt, ...)				\
-	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
+	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__

So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).

pr_debug is defined as:
/* If you are writing a driver, please use dev_dbg instead */
#if defined(CONFIG_DYNAMIC_DEBUG) || \
	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
#include <linux/dynamic_debug.h>

/**
 * pr_debug - Print a debug-level message conditionally
 * @fmt: format string
 * @...: arguments for the format string
 *
 * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
 * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
 * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
 *
 * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
 * pr_fmt() internally).
 */
#define pr_debug(fmt, ...)			\
	dynamic_pr_debug(fmt, ##__VA_ARGS__)
#elif defined(DEBUG)
#define pr_debug(fmt, ...) \
	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#else
#define pr_debug(fmt, ...) \
	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
#endif

Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.

Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.

Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
One of the cases like this was covered in the patch:
-#ifdef ATA_DEBUG
        if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
-                               status);
-#endif
+               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);

Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?

Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...

Best regards,
 Krzysztof Olędzki

