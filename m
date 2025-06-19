Return-Path: <stable+bounces-154838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DCAE1011
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EF75A1DD7
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71790290DA1;
	Thu, 19 Jun 2025 23:30:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12F28F51C;
	Thu, 19 Jun 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375834; cv=none; b=gE0GYbbe6Ga3r9lxJ6YZsbDWhumagiBJGuAqXBpyJdvrZocWEEUHK9chDZT3iAJJqmgXvWQ4syS8RxLOUlug2iU6bcKKqBdggVtaW3BTxyYfPG5JFWxvk3Qt3TsWqRoTTJNCoUcSKxHMElsAFVTfqh/ejFlz/JJVQFBwnshPPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375834; c=relaxed/simple;
	bh=u7FaARh/eSFiH5liOAks1ysHBoQBS/nmWZNrwiFBo3w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gVSi8OU/9yKJ+LpnkqZ3Y/jkuD5ueDIsVaze+/mhh/Uz0KJqpTsXZcDUPeslM9cHXb0MGmExUHHz8nAaiJ69gy1N7jjajXALZlKGR6ewsxaEeOnohqGYN3uysKP6o1ivu+pOeTuSCcvv7pxMRl7+q/f+NXQO7J59wGolmXe4Vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55JNW8bD010124;
	Thu, 19 Jun 2025 16:32:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 16:32:08 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Florian Fainelli
 <f.fainelli@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <5a21c21844beadb68ead00cb401ca1c0@wizardsworks.org>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
 <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
 <385f2469f504dd293775d3c39affa979@wizardsworks.org>
 <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com>
 <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com>
 <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org>
 <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org>
 <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
 <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
 <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com>
 <alpine.DEB.2.21.2506192238280.37405@angie.orcam.me.uk>
 <5a21c21844beadb68ead00cb401ca1c0@wizardsworks.org>
Message-ID: <51830501a2c5969806e418b8843183f5@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/19 15:56, Greg Chandler wrote:
> On 2025/06/19 14:53, Maciej W. Rozycki wrote:
>> On Thu, 19 Jun 2025, Florian Fainelli wrote:
>> 
>>> >   Maybe it'll ring someone's bell and they'll chime in or otherwise I'll
>>> > bisect it... sometime.  Or feel free to start yourself with 5.18, as it's
>>> > not terribly old, only a bit and certainly not so as 2.6 is.
>>> 
>>> I am still not sure why I could not see that warning on by Cobalt 
>>> Qube2 trying
>>> to reproduce Greg's original issue, that is with an IP assigned on 
>>> the
>>> interface yanking the cable did not trigger a timer warning. It could 
>>> be that
>>> machine is orders of magnitude slower and has a different CONFIG_HZ 
>>> value that
>>> just made it less likely to be seen?
>> 
>>  Can it have a different PHY attached?  There's this code:
>> 
>> 	if (tp->chip_id == PNIC2)
>> 		tp->link_change = pnic2_lnk_change;
>> 	else if (tp->flags & HAS_NWAY)
>> 		tp->link_change = t21142_lnk_change;
>> 	else if (tp->flags & HAS_PNICNWAY)
>> 		tp->link_change = pnic_lnk_change;
>> 
>> in `tulip_init_one' and `pnic_lnk_change' won't ever trigger this, but 
>> the
>> other two can; apparently the corresponding comment in 
>> `tulip_interrupt':
>> 
>> /*
>>  * NB: t21142_lnk_change() does a del_timer_sync(), so be careful if 
>> this
>>  * call is ever done under the spinlock
>>  */
>> 
>> hasn't been updated when `pnic2_lnk_change' was added.  Also ISTM no 
>> link
>> change handler is a valid option too, in which case `del_timer_sync' 
>> won't
>> be called either.  This is from a cursory glance only, so please take 
>> with
>> a pinch of salt.
>> 
>>   Maciej
> 
> 
> 
> 
> I'm not sure which of us that was directed at, but for my onboard 
> tulips:
> 
> Micro Linear ML6698CH <- PHY
> Intel 21143-TD <- NIC
> 
> I know that the ML chips are most commonly used with 21143s and a very 
> small smattering of others, I don't think they are all that common at 
> least not since the late '90s..
> I'm relatively certain all my DEC ISA/PCI nics use them though.
> 
> I found a link to the datasheet (If needed), but have had mixed luck 
> with alldatasheets:
> https://www.alldatasheet.com/datasheet-pdf/pdf/75840/MICRO-LINEAR/ML6698CH.html
> 
> Glancing over it I don't see anything about the link, I'll go stick my 
> eyes in the driver a bit and see what stabs me in the eye....



That didn't take long..  The first thing to jab it's thumb in my eye was 
this:
const struct tulip_chip_table tulip_tbl[] = {
   { }, /* placeholder for array, slot unused currently */
   { }, /* placeholder for array, slot unused currently */

   /* DC21140 */
   { "Digital DS21140 Tulip", 128, 0x0001ebef,
         HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, 
tulip_timer,
         tulip_media_task },

   /* DC21142, DC21143 */
   { "Digital DS21142/43 Tulip", 128, 0x0801fbff,
         HAS_MII | HAS_MEDIA_TABLE | ALWAYS_CHECK_MII | HAS_ACPI | 
HAS_NWAY
         | HAS_INTR_MITIGATION | HAS_PCI_MWI, tulip_timer, 
t21142_media_task },


The alpha ev6 platform to my knowledge has never had ACPI, this one 
surely doesn't, and checking my config the variables aren't even listed 
compared to the ones enabled or commented for my other platforms.
It's possible that other alphas (ev67 or ev7s) may have but it's also 
not likely.  I know for sure the: ev4, ev45, ev5, and ev56 architectures 
did not, as the ACPI standard hadn't been ratified, or wasn't around 
long enough to make it into the production of the chipsets, and boards.

I will see if I can find a link between not having ACPI and this issue, 
it's possible that the other instances you mentioned also have that same 
issue.  Or that they do have ACPI and have it disabled for 10 reasons or 
another....



The second potential issue I see is that I don't know off-hand what PCI 
MWI is...

It's only found in the tulip driver and nowhere else in the kernel:

root@constellation:/tmp/tmp/linux-6.12.12/drivers/net/ethernet/dec/tulip# 
grep -R HAS_PCI_MWI ../../../../../
grep: ../../../../../drivers/net/ethernet/dec/tulip/tulip.ko: binary 
file matches
grep: ../../../../../drivers/net/ethernet/dec/tulip/eeprom.o: binary 
file matches
grep: ../../../../../drivers/net/ethernet/dec/tulip/interrupt.o: binary 
file matches
../../../../../drivers/net/ethernet/dec/tulip/tulip.h:  HAS_PCI_MWI      
        = 0x01000,
../../../../../drivers/net/ethernet/dec/tulip/tulip_core.c:     HAS_MII 
| HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_PCI_MWI, tulip_timer,
../../../../../drivers/net/ethernet/dec/tulip/tulip_core.c:     | 
HAS_INTR_MITIGATION | HAS_PCI_MWI, tulip_timer, t21142_media_task },
../../../../../drivers/net/ethernet/dec/tulip/tulip_core.c:     HAS_MII 
| HAS_NWAY | HAS_8023X | HAS_PCI_MWI, pnic2_timer, },
../../../../../drivers/net/ethernet/dec/tulip/tulip_core.c:     | 
HAS_NWAY | HAS_PCI_MWI, tulip_timer, tulip_media_task },
../../../../../drivers/net/ethernet/dec/tulip/tulip_core.c:     if 
(!force_csr0 && (tp->flags & HAS_PCI_MWI))
grep: ../../../../../drivers/net/ethernet/dec/tulip/tulip.o: binary file 
matches
grep: ../../../../../drivers/net/ethernet/dec/tulip/tulip_core.o: binary 
file matches




It's defined as what looks labeled as a table flag in the tulip.h:

enum tbl_flag {
         HAS_MII                 = 0x00001,
         HAS_MEDIA_TABLE         = 0x00002,
         CSR12_IN_SROM           = 0x00004,
         ALWAYS_CHECK_MII        = 0x00008,
         HAS_ACPI                = 0x00010,
         MC_HASH_ONLY            = 0x00020, /* Hash-only multicast 
filter. */
         HAS_PNICNWAY            = 0x00080,
         HAS_NWAY                = 0x00040, /* Uses internal NWay xcvr. 
*/
         HAS_INTR_MITIGATION     = 0x00100,
         IS_ASIX                 = 0x00200,
         HAS_8023X               = 0x00400,
         COMET_MAC_ADDR          = 0x00800,
         HAS_PCI_MWI             = 0x01000,
         HAS_PHY_IRQ             = 0x02000,
         HAS_SWAPPED_SEEPROM     = 0x04000,
         NEEDS_FAKE_MEDIA_TABLE  = 0x08000,
         COMET_PM                = 0x10000,
};




