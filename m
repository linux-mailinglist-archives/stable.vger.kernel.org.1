Return-Path: <stable+bounces-46187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BA8CF2AF
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EDB28139F
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 06:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BEA28FF;
	Sun, 26 May 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="IDk7W+2F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B21849;
	Sun, 26 May 2024 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716705613; cv=none; b=CYGzlqIJQ5cUaNOpUB4Dy+Qrg2hUl9BI/qGag7tyj+O0ci+fYCXgw4Ga4yJXqasEUuNhyeMMT/sk5dBlfuTGNJgefBpGtusro1ijLhyWdNV6yc1uI/IUCyYvZB+c2BfQFYEm1KSgnSSz6aHUN1zPukxhA46MGPEpHnXlInnBi7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716705613; c=relaxed/simple;
	bh=lT2/6mFU64xCxLwXHkQci0yzfn00d8bIcxkG5Ii88YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eu1Z01gh0buh1A53mezzA+AVZ8gXHUcCALtVQj8sJSwHzWD/18uN3X94zeMl2oRGDBJlZMkvMikL1YKrNgeWK0OqUFSI0wTx8bYGXqprpqGrOuYoFCrXq+iSu/vpuZbhcdEG+DFQwiIoflWXRSp/yRvRDjOFHaE9UoHpKwa5XII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=IDk7W+2F; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 44Q6dakK015169
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 26 May 2024 08:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1716705580; bh=6K+abIcRd2UBm0dfvaT7j5LXiHQ/Za17YD/2HFJQacQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IDk7W+2FdGTKOuseTM2QWP40KFxKMwHeHd9lKTwqzxt/n6ImvEWQ8zKQ7LMJqiexU
	 h98YaFdSYV/eRY89tXXFjGNvJ0kA64eDHAQDY3TnGlgoJlyQsY+GS9ZuNhOV9EhZsp
	 8hIWw+jcdpOFDkGIT5KFn5aL4MCngYuNvrPAc33k=
Message-ID: <a116c331-530e-4d45-a32c-37c57542724a@ans.pl>
Date: Sat, 25 May 2024 23:39:35 -0700
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
 <d7a8ca73-3625-4d13-8ece-fc38519594d6@ans.pl>
 <81f19ca4-bb63-4d72-a197-c27f1bb7d381@kernel.org>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <81f19ca4-bb63-4d72-a197-c27f1bb7d381@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13.05.2024 at 06:14, Damien Le Moal wrote:
> On 2024/05/13 15:50, Krzysztof Olędzki wrote:
>> On 06.05.2024 at 15:08, Damien Le Moal wrote:
>>> On 5/7/24 06:49, Niklas Cassel wrote:
>>>> Hello Krzysztof,
>>
>> Hello and thank you for your quick and detailed response from both of you!
>>
>>>> On Sun, May 05, 2024 at 01:06:28PM -0700, Krzysztof Olędzki wrote:
>>>>> Hi,
>>>>>
>>>>> I noticed that since https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=742bef476ca5352b16063161fb73a56629a6d995 (which also got backported to -stable kernels) several of messages from dmesg regarding the ATA subsystem are no longer logged.
>>>>>
>>>>> For example, on my Dell PowerEdge 840 which has only one PATA port I used to get:
>>>>>
>>>>> scsi host1: ata_piix
>>>>> ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
>>>>> ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
>>>>> ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
>>>>> ata2: port disabled--ignoring
>>>>> ata1.01: NODEV after polling detection
>>>>> ata1.00: ATAPI: SAMSUNG CD-R/RW SW-248F, R602, max UDMA/33
>>>>>
>>>>> After that commit, the following two log entries are missing:
>>>>> ata2: port disabled--ignoring
>>>>> ata1.01: NODEV after polling detection
>>>>>
>>>>> Note that these are just examples, there are many more messages impacted by that.
>>>>>
>>>>> Looking at the code, these messages are logged via ata_link_dbg / ata_dev_dbg:
>>>>> ata_link_dbg(link, "port disabled--ignoring\n");	[in drivers/ata/libata-eh.c]
>>>>> ata_dev_dbg(dev, "NODEV after polling detection\n");	[in drivers/ata/libata-core.c]
>>>>>
>>>>> The commit change how the logging is called - ata_dev_printk function which was calling printk() directly got replaced with the following macro:
>>>>>
>>>>> +#define ata_dev_printk(level, dev, fmt, ...)			\
>>>>> +        pr_ ## level("ata%u.%02u: " fmt,			\
>>>>> +               (dev)->link->ap->print_id,			\
>>>>> +	       (dev)->link->pmp + (dev)->devno,			\
>>>>> +	       ##__VA_ARGS__)
>>>>> (...)
>>>>>  #define ata_link_dbg(link, fmt, ...)				\
>>>>> -	ata_link_printk(link, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>>>> +	ata_link_printk(debug, link, fmt, ##__VA_ARGS__)
>>>>> (...)
>>>>>  #define ata_dev_dbg(dev, fmt, ...)				\
>>>>> -	ata_dev_printk(dev, KERN_DEBUG, fmt, ##__VA_ARGS__)
>>>>> +	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__
>>>>>
>>>>> So, instead of printk(..., level == KERN_DEBUG, ) we now call pr_debug(...). This is a problem as printk(msg, KERN_DEBUG) != pr_debug(msg).
>>>>>
>>>>> pr_debug is defined as:
>>>>> /* If you are writing a driver, please use dev_dbg instead */
>>>>> #if defined(CONFIG_DYNAMIC_DEBUG) || \
>>>>> 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
>>>>> #include <linux/dynamic_debug.h>
>>>>>
>>>>> /**
>>>>>  * pr_debug - Print a debug-level message conditionally
>>>>>  * @fmt: format string
>>>>>  * @...: arguments for the format string
>>>>>  *
>>>>>  * This macro expands to dynamic_pr_debug() if CONFIG_DYNAMIC_DEBUG is
>>>>>  * set. Otherwise, if DEBUG is defined, it's equivalent to a printk with
>>>>>  * KERN_DEBUG loglevel. If DEBUG is not defined it does nothing.
>>>>>  *
>>>>>  * It uses pr_fmt() to generate the format string (dynamic_pr_debug() uses
>>>>>  * pr_fmt() internally).
>>>>>  */
>>>>> #define pr_debug(fmt, ...)			\
>>>>> 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>>>> #elif defined(DEBUG)
>>>>> #define pr_debug(fmt, ...) \
>>>>> 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>>> #else
>>>>> #define pr_debug(fmt, ...) \
>>>>> 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
>>>>> #endif
>>>>>
>>>>> Without CONFIG_DYNAMIC_DEBUG and if no CONFIG_DEBUG is enabled, the end result is calling no_printk which means nothing gets logged.
>>>>>
>>>>> Looking at the code, there are more impacted calls, like for example ata_dev_dbg(dev, "disabling queued TRIM support\n") for ATA_HORKAGE_NO_NCQ_TRIM, which also seems like an important information to log, and there are more.
>>>>>
>>>>> Was this change done intentionally? Note that most of the "debug" printks in libata code seem to be guarded by ata_msg_info / ata_msg_probe / ATA_DEBUG which was sufficient to prevent excess debug information logging.
>>>>> One of the cases like this was covered in the patch:
>>>>> -#ifdef ATA_DEBUG
>>>>>         if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
>>>>> -               ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
>>>>> -                               status);
>>>>> -#endif
>>>>> +               ata_port_dbg(ap, "abnormal Status 0x%X\n", status);
>>>>>
>>>>> Assuming this is the intended direction, would it make sense for now to at promote "unconditionally" logged messages from ata_link_dbg/ata_dev_dbg to ata_link_info/ata_dev_info?
>>>>>
>>>>> Longer term, perhaps we want to revisit ata_msg_info/ata_msg_probe/ATA_DEBUG/ATA_VERBOSE_DEBUG vs ata_dev_printk/ata_link_printk/pr_debug (and maybe also pr_devel), especially that DYNAMIC_DEBUG is available these days...
>>>>
>>>> The change to the dynamic debug model was very much intentional.
>>>>
>>>> CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG (and ata_msg_info/ata_msg_probe)
>>>> was replaced with dynamic debug.
>>
>> Understood.
>>
>>>> So the reason why you saw the messages before was most likely because you
>>>> built your kernel with CONFIG_ATA_DEBUG / CONFIG_ATA_VERBOSE_DEBUG.
>>
>> I don't believe this is the case - please note these were ATA_VERBOSE_DEBUG / ATA_DEBUG (i.e. not CONFIG_...) and these logging entries were not covered by ifdefs, for example:
>>
>> if (rc == -ENOENT) {
>>         ata_link_dbg(link, "port disabled--ignoring\n");
>>         ehc->i.action &= ~ATA_EH_RESET;
>>
>>         ata_for_each_dev(dev, link, ALL)
>>                 classes[dev->devno] = ATA_DEV_NONE;
>>
>>         rc = 0;
>> } else
>>         ata_link_err(link,
>>                      "prereset failed (errno=%d)\n",
>>                      rc);
>>
>>>> If you want to see the same error messages, you are now expected to use
>>>> dynamic debug for the file which you want debug messages enabled.
>>
>> Totally agree on the "debug" type of messages but I'm not sure if asking users to use dynamic debug to see error messages is what we want...
>>
>>>> I do agree that the debug prints that were NOT guarded by CONFIG_ATA_DEBUG
>>>> do now work differently, as they are no longer printed to dmesg at all.
>>>> I'm not sure if this part was intentional. I'm guessing that it wasn't.
>>
>> That's precisely the point I have been trying to make here. The dynamic debugging change seems like a very welcome one, the messages disappearing - perhaps not so much. Especially in a middle of a -stable kernel.
>>
>>>> Looking at these three prints specifically:
>>>> ata_link_dbg(link, "port disabled--ignoring\n");
>>>
>>> Given the recent addition of the port map mask, we could restore this print as
>>> an info level.
>>>
>>>> ata_dev_dbg(dev, "NODEV after polling detection\n");
>>>
>>> This one is weird. It should be an error print.
>>>
>>>> ata_dev_dbg(dev, "disabling queued TRIM support\n");
>>>
>>> This is also OK to restore as an info print. But given that, there are a lot
>>> more horkage disabling features that we probably should print.
>>
>> Thanks. Just a note that these were just some examples. Also, can I help somehow or should I just wait for patches to test?
>>
>>>> None of them were protected with CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG
>>>> before the series converting to dynamic debug was merged.
>>>>
>>>>
>>>> The best way forward is probably to look at all debug prints before the
>>>> series converting to dynamic debug was merged, and see if any print NOT
>>>> guarded by CONFIG_ATA_DEBUG/CONFIG_ATA_VERBOSE_DEBUG should be considered
>>>> to promoted to an info print instead.
>>
>> Same question as the above: can I help somehow or should I just wait for patches to test?
> 
> If you have something in mind, please, by all means, send patches and we'll go
> from there. What I think we need is:
> 
> 1) Review the code to make sure that we print an error message for everything
> that fails but should really succeeds. Beware here that some things may "fail"
> during port scan if a device is not attached. That is normal and should not
> result in printing errors.
> 
> 2) Add prints whenever a horkage flag is applied to a device, port or link.
> 
> That should not be a lot.

Thank you. How about the following patch? I'm sure I missed something
but it should bring us close to where we were before the logging cleanup.

If something like this is acceptable, perpahs it would be also possible
to include it in the -stable kernels, I think up to and including 5.15?

From b1f93347828a3d8c52ae4a73f9fb48341d0c2afb Mon Sep 17 00:00:00 2001
From: Krzysztof Piotr Oledzki <ole@ans.pl>
Date: Sat, 25 May 2024 22:35:58 -0700
Subject: [PATCH] ata: libata: restore visibility of important messages

With the recent cleanup and migration to standard
pr_{debug,info,notice,warn,err} macros instead of the
hand-crafted printk helpers some important messages
disappeared from dmesg unless dynamic debug is enabled.

Restore their visibility by promoting them to info or err (when
appropriate).

Also, improve or add information about features disabled due to
ATA_HORKAGE workarounds like NONCQ, NO_NCQ_ON_ATI and NO_FUA.

For ATA_HORKAGE_DIAGNOSTIC and ATA_HORKAGE_FIRMWARE_WARN convert the
message to a single line and update the ata.wiki.kernel.org link.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 drivers/ata/libata-core.c | 49 +++++++++++++++++++++------------------
 drivers/ata/libata-eh.c   |  2 +-
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4f35aab81a0a..0603849692ae 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1793,7 +1793,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
-			ata_dev_dbg(dev, "NODEV after polling detection\n");
+			ata_dev_err(dev, "NODEV after polling detection\n");
 			return -ENOENT;
 		}
 
@@ -1825,8 +1825,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			 * both flavors of IDENTIFYs which happens
 			 * sometimes with phantom devices.
 			 */
-			ata_dev_dbg(dev,
-				    "both IDENTIFYs aborted, assuming NODEV\n");
+			ata_dev_info(dev,
+				     "both IDENTIFYs aborted, assuming NODEV\n");
 			return -ENOENT;
 		}
 
@@ -1857,9 +1857,9 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	if (class == ATA_DEV_ATA || class == ATA_DEV_ZAC) {
 		if (!ata_id_is_ata(id) && !ata_id_is_cfa(id))
 			goto err_out;
-		if (ap->host->flags & ATA_HOST_IGNORE_ATA &&
-							ata_id_is_ata(id)) {
-			ata_dev_dbg(dev,
+		if ((ap->host->flags & ATA_HOST_IGNORE_ATA) &&
+		    ata_id_is_ata(id)) {
+			ata_dev_info(dev,
 				"host indicates ignore ATA devices, ignored\n");
 			return -ENOENT;
 		}
@@ -2247,7 +2247,8 @@ static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
 		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_SEND_RECV_SIZE);
 
 		if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM) {
-			ata_dev_dbg(dev, "disabling queued TRIM support\n");
+			ata_dev_info(dev, "disabling queued TRIM - "
+					  "known buggy device\n");
 			cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &=
 				~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
 		}
@@ -2335,13 +2336,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	if (!IS_ENABLED(CONFIG_SATA_HOST))
 		return 0;
 	if (dev->horkage & ATA_HORKAGE_NONCQ) {
-		snprintf(desc, desc_sz, "NCQ (not used)");
+		snprintf(desc, desc_sz, "NCQ (not used - known buggy device)");
 		return 0;
 	}
 
 	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
 	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
-		snprintf(desc, desc_sz, "NCQ (not used)");
+		snprintf(desc, desc_sz, "NCQ (not used - known buggy device/host adapter)");
 		return 0;
 	}
 
@@ -2397,7 +2398,7 @@ static void ata_dev_config_sense_reporting(struct ata_device *dev)
 
 	err_mask = ata_dev_set_feature(dev, SETFEATURE_SENSE_DATA, 0x1);
 	if (err_mask) {
-		ata_dev_dbg(dev,
+		ata_dev_err(dev,
 			    "failed to enable Sense Data Reporting, Emask 0x%x\n",
 			    err_mask);
 	}
@@ -2479,7 +2480,7 @@ static void ata_dev_config_trusted(struct ata_device *dev)
 
 	trusted_cap = get_unaligned_le64(&ap->sector_buf[40]);
 	if (!(trusted_cap & (1ULL << 63))) {
-		ata_dev_dbg(dev,
+		ata_dev_err(dev,
 			    "Trusted Computing capability qword not valid!\n");
 		return;
 	}
@@ -2688,9 +2689,15 @@ static void ata_dev_config_fua(struct ata_device *dev)
 	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
 		goto nofua;
 
-	/* Ignore known bad devices and devices that lack NCQ support */
-	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
+	/* Ignore devices that lack NCQ support */
+	if (!ata_ncq_supported(dev))
+		goto nofua;
+
+	/* Finally, ignore buggy devices */
+	if (dev->horkage & ATA_HORKAGE_NO_FUA) {
+		ata_dev_info(dev, "disabling FUA - known buggy device");
 		goto nofua;
+	}
 
 	dev->flags |= ATA_DFLAG_FUA;
 
@@ -3060,24 +3067,22 @@ int ata_dev_configure(struct ata_device *dev)
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(dev);
 
-	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
+	if ((dev->horkage & ATA_HORKAGE_DIAGNOSTIC) && print_info) {
 		/* Let the user know. We don't want to disallow opens for
 		   rescue purposes, or in case the vendor is just a blithering
 		   idiot. Do this after the dev_config call as some controllers
 		   with buggy firmware may want to avoid reporting false device
 		   bugs */
 
-		if (print_info) {
-			ata_dev_warn(dev,
-"Drive reports diagnostics failure. This may indicate a drive\n");
-			ata_dev_warn(dev,
-"fault or invalid emulation. Contact drive vendor for information.\n");
-		}
+		ata_dev_warn(dev, "Drive reports diagnostics failure."
+				  " This may indicate a drive fault or invalid emulation."
+				  " Contact drive vendor for information.\n");
 	}
 
 	if ((dev->horkage & ATA_HORKAGE_FIRMWARE_WARN) && print_info) {
-		ata_dev_warn(dev, "WARNING: device requires firmware update to be fully functional\n");
-		ata_dev_warn(dev, "         contact the vendor or visit http://ata.wiki.kernel.org\n");
+		ata_dev_warn(dev, "WARNING: device requires firmware update to be"
+				  " fully functional contact the vendor or visit"
+				  " http://ata.wiki.kernel.org/index.php/Known_issues\n");
 	}
 
 	return 0;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..5b9382ef261c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2667,7 +2667,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
 		if (rc) {
 			if (rc == -ENOENT) {
-				ata_link_dbg(link, "port disabled--ignoring\n");
+				ata_link_info(link, "port disabled--ignoring\n");
 				ehc->i.action &= ~ATA_EH_RESET;
 
 				ata_for_each_dev(dev, link, ALL)
-- 
2.45.1

Thanks,
 Krzysztof


