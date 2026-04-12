Return-Path: <stable+bounces-235842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOjwDcHe22lMHgkAu9opvQ
	(envelope-from <stable+bounces-235842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:04:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB653E5536
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C152300CC8C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212935E92B;
	Sun, 12 Apr 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b="Q9G4Fy76"
X-Original-To: stable@vger.kernel.org
Received: from mailo.com (msg-3.mailo.com [213.182.54.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FC306D3F;
	Sun, 12 Apr 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017082; cv=none; b=Xf1VybTeBa2/l6ZkiyeJ7chJaxFk1x/iZkxISQEZgTtMVoV7KZ3WgXAsTD6cr1POX5s4GqSMhZOJv03HagBv+GRlv2K54qfe9TAe+UcATNZybDfL0ntK5PzjDVJlKDlFbPnB+//1F5SZecVqf21KnK2Hdhp43VGqxjsZxU/DVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017082; c=relaxed/simple;
	bh=zGtQNwdBpG7hGH3GJ3R5Yyk5zoQ8fadQOvnmQc9cQvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJ8SkeBo+p61tDEMddZRyheHj+wqViUqcjndhwAJKmXin0QLdwoCdHyUWB5r5OHCY3hTz7OhKwMmRIqWviTRWfHohNKC0Upt9Acdm2f1fm1UVlhdXtmaP0raL44/RgwWFH/z3EHYTGwUpK4m8q5ZyjAxBWoYz2nkyFNZNWB8084=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com; spf=pass smtp.mailfrom=mailo.com; dkim=pass (1024-bit key) header.d=mailo.com header.i=@mailo.com header.b=Q9G4Fy76; arc=none smtp.client-ip=213.182.54.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mailo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
	t=1776017043; bh=loomyRVspJJPOiGDTGgJ5VyDTwHaaRENDunEDfMh1tY=;
	h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=Q9G4Fy76eVx44jdFL79OTn3+/BKYtx0uPxoaA8M+npOJke7KYjT2WDrGsXv5hLekN
	 4EKbneQarI+guEiQ2ukb+BUpnRG96AjoBniAzSWAS//NCAdHdXiEqoO28TxNE4vU3y
	 PVlRqe13o7rF9Czs1tXirJlbMqVOqPfNKT5fHxBM=
Received: by b221-9.in.mailobj.net [192.168.90.29] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Sun, 12 Apr 2026 20:04:03 +0200 (CEST)
X-EA-Auth: 9db1yhh7x8IcLMwmwS2jLjz9b1Dd5xgugMOT61ALM+RMVIDpfz1eUoPt5AZ4Jb0jah5GhDhPddDSHfpb0da43kZN1L5uYLKtbEkAKGS/HrtC8O0T/Sm1KA==
Message-ID: <dd3c3358-de0f-4a56-9c81-04aceaab4058@mailo.com>
Date: Sun, 12 Apr 2026 20:04:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1131025: [6.12.y regression] Regression with 58130e7ce6cb
 ("PCI/ERR: Ensure error recoverability at all times"): echo vfio-pci
 >driver_override does not work for DVB Adapter
To: Bernd Schumacher <bernd@bschu.de>, Lukas Wunner <lukas@wunner.de>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 1131025@bugs.debian.org, Salvatore Bonaccorso <carnil@debian.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <ac0Y85OShbK6mHEV@monoceros>
 <8275e5b86696dec133889713258c2e158a443496.camel@bschu.de>
 <ac19pxEZKvQuQwFV@wunner.de>
 <7173609c404c5444e634dd3ab26f55f2788d82e4.camel@bschu.de>
 <ac_VqcBbKRDkHp69@wunner.de>
 <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
Content-Language: en-US
From: "Alexandre N." <an.tech@mailo.com>
In-Reply-To: <79618160f928d7ed4ba0a84f3ab420427c5b8d10.camel@bschu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mailo.com:s=mailo];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[an.tech@mailo.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235842-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailo.com:+]
X-Rspamd-Queue-Id: ECB653E5536
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 11:54, Bernd Schumacher wrote:
> Am Freitag, dem 03.04.2026 um 16:58 +0200 schrieb Lukas Wunner:
>> If you cherry-pick these two upstream commits onto v6.12.73,
>> does the issue go away?
>>
>>    4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
>> initializing")
>>    907a7a2e5bf4 ("PCI/PM: Set up runtime PM even for devices without
>> PCI PM")
>>
> 
> Yes, with the two patches together it works!!!
> 
> I am not sure, if you need the dmesg. But I have attached it.
> 
> Thanks!
> Bernd

Hi,

(This is my first post to a kernel mailing list, apologies if I've
made any formatting or etiquette mistakes.)

Independent confirmation on different hardware and a different
stable branch, plus test results for the proposed fix on 6.19.11.

   Hardware:   PCI 1b4b:9215  Marvell 88SE9215 PCIe 2.0 x1 4-port
               SATA 6 Gb/s controller, whole-device passthrough to a
               Windows 10 guest via QEMU/libvirt on
               an AMD Ryzen 7 7700 8-Core x86_64 host (Arch Linux).
   Last good:  linux 6.18.9
   First bad:  linux 6.18.13  (contains stable backport 71c50e60421b
                               of upstream a2f1e22390ac, "PCI/ERR:
                               Ensure error recoverability at all
                               times", first backported in 6.18.10)
   Also bad:   linux 6.19.11  (mainline carries a2f1e22390ac)

Confirmed by rolling linux back to 6.18.9 with everything else
untouched: problem vanishes. Rolling forward to 6.18.13 or any
later versions in 6.18/6.19 reproduces it everytime.

Symptom
-------
Guest side:

  * Stock Microsoft storahci.sys: Device Manager shows the controller
    with status "This device cannot start. (Code 10) An I/O adapter
    hardware error has occurred." None of the disks wired to the
    controller are visible.
  * Vendor Marvell 92xx storage driver: Device Manager reports the
    controller as healthy and the driver loads, but the physically
    attached disks are not detected.

Host side (before applying the pci-stub workaround described below),
a subsequent libvirt-managed detach/rebind cycle on VM shutdown
pagefaults the host in ahci's probe path:

   BUG: unable to handle page fault for address: ...
   RIP: 0010:ahci_save_initial_config+0x1aa/0x2e0
   Call Trace:
    ahci_init_one+0x3a7/0xbf0
    local_pci_probe+0x46/0xa0
    ...

virt-manager becomes unresponsive, any command to bind/unbind the
driver or reset the device will hang. When shutting down the host,
the system will log a shutdown sequence but will never actually
turn off. A hard shutdown (long press on the power button)
is necessary.

On 6.18.9 the same libvirt detach/rebind round trip through ahci
is clean, there's no page fault error, virt-manager is fine and
the host can shutdown properly.

Testing the proposed fix on 6.19.11
-----------------------------------
Cherry-picked both fix commits identified in this thread:

   4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
                  initializing")
   907a7a2e5bf4 ("PCI/PM: Set up runtime PM even for devices without
                  PCI PM")

onto v6.19.11. The resulting diff against the unpatched 6.19.11 tree
is minimal with only one added line (pm_runtime_enable after
pm_runtime_set_active in pci_pm_init). The guest-side regression
persists: still Code 10 with storahci, still empty SATA ports
with the Marvell vendor driver.

I'd be happy to help to test further patches if that would help
narrow down what the 88SE9215 additionally needs.

Workaround for other affected users searching for this symptom
--------------------------------------------------------------
Pin linux at a version before a2f1e22390ac was backported (6.18.9
in my case). Additionally, add  pci-stub.ids=1b4b:9215  to the
kernel command line, which ensures ahci driver does not load for
the SATA controller. On the pinned kernel, both the guest-side
and host-side symptoms are absent.

I can provide additional info or logs if you need.

Thanks!

Alexandre N.



