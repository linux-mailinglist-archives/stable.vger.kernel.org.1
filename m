Return-Path: <stable+bounces-158465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48485AE72F4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 01:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA1D1782B0
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 23:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A264257AEE;
	Tue, 24 Jun 2025 23:17:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from constellation.wizardsworks.org (wizardsworks.org [24.234.38.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3563595C;
	Tue, 24 Jun 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.234.38.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807044; cv=none; b=q2mTL9uJRXP0EcdgJrsfL+jP7leV/vs5vQc0xs7FuVuaxwKUWkrbxveeNLGEKadGSZ3NZnhrqIHTY44A8afLAs6QgmliorwoX6EZdt8+/xSGPlgBbakpPTtq6efr53k+MJw+NqsM7fN6NwD9uXhF+tKmlpTjpqaUIsXuJfkTpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807044; c=relaxed/simple;
	bh=QzyJv1WnqDszxJaFjDatP0Jk/4g3Q7Y1sjRgSJ2MDfw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mPXWpMdK1Awsv66ZIg1tu9hmQwAyuo5fOkXI2Yn+LariSHDoaaar+fZluytFXjlqX55n62nmyOJy8pQJZccBMFhzkp5ilacoWj/GqeSKMs8yw5+Pr0jaz2WqDxlKm+L0AVjL6JSh+dwNk/OiU1Dr8YAw2rIBqwMpC1OpnZ60HJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org; spf=pass smtp.mailfrom=wizardsworks.org; arc=none smtp.client-ip=24.234.38.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wizardsworks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wizardsworks.org
Received: from mail.wizardsworks.org (localhost [127.0.0.1])
	by constellation.wizardsworks.org (8.18.1/8.18.1) with ESMTP id 55ONIo8I012000;
	Tue, 24 Jun 2025 16:18:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Jun 2025 16:18:50 -0700
From: Greg Chandler <chandleg@wizardsworks.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Florian Fainelli
 <f.fainelli@gmail.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <2e30ae181acadd45da8cb91619326f37@wizardsworks.org>
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
 <alpine.DEB.2.21.2506200144030.37405@angie.orcam.me.uk>
 <2e30ae181acadd45da8cb91619326f37@wizardsworks.org>
Message-ID: <c56aabfb06cfc653ff3619da4eacb4c1@wizardsworks.org>
X-Sender: chandleg@wizardsworks.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/24 16:10, Greg Chandler wrote:
> On 2025/06/19 17:57, Maciej W. Rozycki wrote:
>> On Thu, 19 Jun 2025, Greg Chandler wrote:
>> 
>>> > > I am still not sure why I could not see that warning on by Cobalt Qube2
>>> > > trying
>>> > > to reproduce Greg's original issue, that is with an IP assigned on the
>>> > > interface yanking the cable did not trigger a timer warning. It could be
>>> > > that
>>> > > machine is orders of magnitude slower and has a different CONFIG_HZ value
>>> > > that
>>> > > just made it less likely to be seen?
>>> >
>>> >  Can it have a different PHY attached?  There's this code:
>>> >
>>> > 	if (tp->chip_id == PNIC2)
>>> > 		tp->link_change = pnic2_lnk_change;
>>> > 	else if (tp->flags & HAS_NWAY)
>>> > 		tp->link_change = t21142_lnk_change;
>>> > 	else if (tp->flags & HAS_PNICNWAY)
>>> > 		tp->link_change = pnic_lnk_change;
>>> 
>>> I'm not sure which of us that was directed at, but for my onboard 
>>> tulips:
>> 
>>  It was for Florian, as obviously your system does trigger the issue.
>> 
>>> I found a link to the datasheet (If needed), but have had mixed luck 
>>> with
>>> alldatasheets:
>>> https://www.alldatasheet.com/datasheet-pdf/pdf/75840/MICRO-LINEAR/ML6698CH.html
>> 
>>  There's no need to chase hw documentation as the issue isn't directly
>> related to it.
>> 
>>  As I noted in the earlier e-mail it seems a regression in the 
>> handling of
>> `del_timer_sync', perhaps deliberate, introduced sometime between 5.18 
>> and
>> 6.4.  I suggest that you try 5.18 (or 5.17 as it was 5.18.0-rc2 
>> actually
>> here that worked correctly) and see if it still triggers the problem 
>> and
>> if it does not then bisect it (perhaps limiting the upper bound to 6.4 
>> if
>> it does trigger it for you, to save an iteration or a couple).  Once 
>> you
>> know the offender you'll likely know the solution.  Or you can come 
>> back
>> with results and ask for one if unsure.
>> 
>>  HTH,
>> 
>>   Maciej
> 
> 
> I haven't had keyboard time in quite a few days, but I've been looking 
> over the code today.
> I removed the HAS_ACPI from the 21142 setup, only to find later it was 
> only used in a single function to deal with sleep mode stuff.
> As I was reading over the driver, I've been taking a look at what could 
> potentially drop in some of the debgugging statements, and loaded the 
> module with:
> 
> insmod ./tulip.ko tulip_debug=100
> 
> [16933.489376] tulip0: EEPROM default media type Autosense
> [16933.489376] tulip0: Index #0 - Media 10baseT (#0) described by a 
> 21142 Serial PHY (2) block
> [16933.489376] tulip0: Index #1 - Media 10baseT-FDX (#4) described by a 
> 21142 Serial PHY (2) block
> [16933.489376] tulip0: Index #2 - Media 100baseTx (#3) described by a 
> 21143 SYM PHY (4) block
> [16933.489376] tulip0: Index #3 - Media 100baseTx-FDX (#5) described by 
> a 21143 SYM PHY (4) block
> [16933.498165] net eth0: Digital DS21142/43 Tulip rev 65 at MMIO 
> 0xa120000, 08:00:2b:86:ab:b1, IRQ 29
> [16933.498165] tulip 0000:00:09.0 eth0: Restarting 21143 
> autonegotiation, csr14=0003ffff
> [16933.498165] tulip 0000:00:09.0: vgaarb: pci_notify
> [16933.498165] tulip 0000:00:0b.0: vgaarb: pci_notify
> [16933.498165] tulip 0000:00:0b.0: assign IRQ: got 30
> [16933.498165] tulip 0000:00:0b.0 (unnamed net_device) (uninitialized): 
> tulip_mwi_config()
> [16933.498165] tulip 0000:00:0b.0 (unnamed net_device) (uninitialized): 
> MWI config cacheline=16, csr0=01a09000
> [16933.498165] tulip 0000:00:0b.0: enabling bus mastering
> [16933.505001] tulip1: EEPROM default media type Autosense
> [16933.505001] tulip1: Index #0 - Media 10baseT (#0) described by a 
> 21142 Serial PHY (2) block
> [16933.505001] tulip1: Index #1 - Media 10baseT-FDX (#4) described by a 
> 21142 Serial PHY (2) block
> [16933.505001] tulip1: Index #2 - Media 100baseTx (#3) described by a 
> 21143 SYM PHY (4) block
> [16933.505001] tulip1: Index #3 - Media 100baseTx-FDX (#5) described by 
> a 21143 SYM PHY (4) block
> [16933.513790] net eth1: Digital DS21142/43 Tulip rev 65 at MMIO 
> 0xa121000, 08:00:2b:86:a8:5b, IRQ 30
> [16933.513790] tulip 0000:00:0b.0 eth1: Restarting 21143 
> autonegotiation, csr14=0003ffff
> [16933.513790] tulip 0000:00:0b.0: vgaarb: pci_notify
> [16933.609494] tulip 0000:00:09.0 eth109: renamed from eth0
> [16933.619259] tulip 0000:00:09.0 eth2: renamed from eth109
> 
> 
> 
> 
> This popped up when I bound an IP address to the interface (but not 
> before)
> 
> [17042.757875] tulip 0000:00:0b.0 eth1: tulip_up(), irq==30
> [17042.757875] tulip 0000:00:0b.0 eth1: Restarting 21143 
> autonegotiation, csr14=0003ffff
> [17042.757875] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17042.757875] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0660000
> [17042.757875] tulip 0000:00:0b.0 eth1: Done tulip_up(), CSR0 f9a09000, 
> CSR5 f0760000 CSR6 b2422202
> [17042.757875] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17042.757875] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0660000
> [17042.757875] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17042.757875] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0660000
> [17042.758852] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17042.758852] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0660000
> [17043.033266] tulip 0000:00:09.0 eth2: tulip_up(), irq==29
> [17043.033266] tulip 0000:00:09.0 eth2: Restarting 21143 
> autonegotiation, csr14=0003ffff
> [17043.033266] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17043.033266] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17043.034242] tulip 0000:00:09.0 eth2: Done tulip_up(), CSR0 f9a09000, 
> CSR5 f0760000 CSR6 b2422202
> [17043.034242] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17043.034242] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17043.034242] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17043.034242] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17043.035219] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17043.035219] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17043.330140] e1000: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow 
> Control: RX/TX
> [17044.690491] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0268010 new 
> csr5=0xf0260000
> [17044.690491] net eth2: 21143 link status interrupt cde1d2ce, CSR5 
> f0268010, fffbffff
> [17044.690491] net eth2: Switching to 100baseTx-FDX based on link 
> negotiation 01e0 & cde1 = 01e0
> [17044.690491] tulip 0000:00:09.0 eth2: 21143 non-MII 100baseTx-FDX 
> transceiver control 08af/00a0
> [17044.690491] tulip 0000:00:09.0 eth2: Setting CSR15 to 
> 08af0008/00a00008
> [17044.690491] tulip 0000:00:09.0 eth2: Using media type 100baseTx-FDX, 
> CSR12 is ce
> [17044.690491] tulip 0000:00:09.0 eth2:  Setting CSR6 83860200/b3862202 
> CSR12 cde1d2ce
> [17044.690491] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17044.690491] tulip 0000:00:09.0 eth2: Transmit error, Tx status 
> 7fffbc85
> [17044.690491] tulip 0000:00:09.0 eth2: Transmit error, Tx status 
> 7fffbc84
> [17044.690491] tulip 0000:00:09.0 eth2: Transmit error, Tx status 
> 7fffbc84
> [17044.690491] tulip 0000:00:09.0 eth2: Transmit error, Tx status 
> 7fffbc84
> [17044.690491] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17044.691468] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf8668000 new 
> csr5=0xf8668000
> [17044.691468] net eth2: 21143 link status interrupt cde1d2cc, CSR5 
> f8668000, fffbffff
> [17044.691468] net eth2: 21143 100baseTx-FDX link beat good
> [17044.691468] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17044.691468] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0668010 new 
> csr5=0xf0660000
> [17044.691468] net eth2: 21143 link status interrupt 000002c8, CSR5 
> f0668010, fffbff7f
> [17044.691468] net eth2: 21143 100baseTx-FDX link beat good
> [17044.691468] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17045.493225] tulip 0000:00:09.0 eth2: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17045.493225] tulip 0000:00:09.0 eth2: Transmit error, Tx status 
> 7fffb000
> [17045.493225] tulip 0000:00:09.0 eth2: exiting interrupt, 
> csr5=0xf0660000
> [17045.803772] net eth1: 21143 negotiation status 000021c6, 10baseT
> [17045.803772] net eth1: 21143 negotiation failed, status 000021c6
> [17045.803772] net eth1: Testing new 21143 media 100baseTx
> [17045.803772] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0208100 new 
> csr5=0xf0200000
> [17045.803772] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0260000
> [17045.803772] tulip 0000:00:0b.0 eth1: interrupt  csr5=0xf0670004 new 
> csr5=0xf0660000
> [17045.803772] tulip 0000:00:0b.0 eth1: Transmit error, Tx status 
> 7fffbc85
> [17045.803772] tulip 0000:00:0b.0 eth1: Transmit error, Tx status 
> 7fffbc84
> [17045.803772] tulip 0000:00:0b.0 eth1: Transmit error, Tx status 
> 7fffbc84
> [17045.803772] tulip 0000:00:0b.0 eth1: Transmit error, Tx status 
> 7fffbc84
> [17045.803772] tulip 0000:00:0b.0 eth1: Transmit error, Tx status 
> 7fffbc84
> [17045.803772] tulip 0000:00:0b.0 eth1: exiting interrupt, 
> csr5=0xf0660000
> [17045.805725] tulip 0000:00:0b.0 eth1: tulip_stop_rxtx() failed (CSR5 
> 0xf0660000 CSR6 0xb3862002)
> [17046.053772] net eth2: 21143 negotiation status 000002c8, 
> 100baseTx-FDX
> [17046.053772] net eth2: Using NWay-set 100baseTx-FDX media, csr12 
> 000002c8
> 
> 
> 
> I'm still working my way through the driver, but I figured I'd post the 
> additional debug info in case anyone wanted it.




As I hit send on that last mail, I noticed a line that has not shown up 
before:
[17044.690491] net eth2: Switching to 100baseTx-FDX based on link 
negotiation 01e0 & cde1 = 01e0

I looked down at the switch, and it was actually linked at 100MB/FDX, 
until now it has only linked at 10-Half

The interface worked even with the errors above (I brought the intel 
adapter hard down and unplugged the cable to check).

The only thing I have changed is the ACPI disable which should do 
litterally nothing in this case, and loading the module with a debug 
flag.
I am going to reboot the machine to clear out everything and see what 
exactly did this.  I can't beleive that turning on debugging fixed it, 
but I have seen much weirder stuff happen.


