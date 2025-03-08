Return-Path: <stable+bounces-121547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3AEA57BC7
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBBE3B02AA
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3191DD0D6;
	Sat,  8 Mar 2025 16:08:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575717C77
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450104; cv=none; b=pcfKWUWnonjeA7jPCzVjFxmDDlxhI2Zt1lcpCpLkRK3WI+cSRg7Oux08NcX4iyKhEs2LWQTltsDXy4N6UySYTAa9y6eWl4jkAGlTsnNJjLJet2pf5WDtotH7io8UK4hMZrZ7gj0uFAwN0CGqxmMnKI0kfJgx8M5GKLsbDLA9fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450104; c=relaxed/simple;
	bh=gA36K2BotjA0RTU83+DIzGkyuqTpo0KqZIIvpD70iZM=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:In-Reply-To:Cc; b=XqTWW3baizqtFeHFP4jTu7pYvRWkeO+b0RoFiHKw2Rcmj54LTpyiH8QrNrNEj/BnTCxaHOKnRKOY8wP876Tw6F1jzpUUbFGnZQLzUtGK4jIIktJj609TQswwT7vhsLDk1q4TxYw8sRmyaLldEJGr7lK/zyrLyh+iMKHzZN0teBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glks-stable4@m.gmane-mx.org>)
	id 1tqwdt-0009zZ-F5
	for stable@vger.kernel.org; Sat, 08 Mar 2025 17:03:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: stable@vger.kernel.org
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 6.13.6
Date: Sat, 8 Mar 2025 17:03:08 +0100
Message-ID: <1b3ea3ce-7754-494c-a87b-0b70b2d25f99@web.de>
References: <2025030751-mongrel-unplug-83d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <2025030751-mongrel-unplug-83d8@gregkh>
Cc: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote on 07/03/2025 18:52:
> I'm announcing the release of the 6.13.6 kernel.
> 
> All users of the 6.13 kernel series must upgrade.
> 

Thank you all for the new stable kernel. Unfortunately, the following messages 
appear in dmesg on my system:

[    0.000000] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.000000] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.000000] Linux version 6.13.6 (root@uruz) (gcc (Debian 14.2.0-17) 14.2.0, 
GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Fri Mar  7 19:40:58 CET 2025
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz root=PARTUUID=cb5df131-01 
random.trust_cpu=on amd_pstate=active spec_rstack_overflow=off

...

[    0.295153] smpboot: CPU0: AMD Ryzen 7 5700G with Radeon Graphics (family: 
0x19, model: 0x50, stepping: 0x0)
[    0.295308] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.295386] ... version:                0
[    0.295442] ... bit width:              48
[    0.295499] ... generic registers:      6
[    0.295555] ... value mask:             0000ffffffffffff
[    0.295617] ... max period:             00007fffffffffff
[    0.295678] ... fixed-purpose events:   0
[    0.295735] ... event mask:             000000000000003f
[    0.295838] signal: max sigframe size: 2976
[    0.295921] rcu: Hierarchical SRCU implementation.
[    0.295981] rcu: 	Max phase no-delay instances is 1000.
[    0.296062] Timer migration: 2 hierarchy levels; 8 children per group; 2 
crossnode level
[    0.296192] smp: Bringing up secondary CPUs ...
[    0.296286] smpboot: x86: Booting SMP configuration:
[    0.296346] .... node  #0, CPUs:        #1  #2  #3  #4
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.296783]   #5
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.296817]   #6
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.296817]   #7
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.310182]   #8
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.310682]   #9
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.310978]  #10
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.311265]  #11
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.311553]  #12
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.311842]  #13
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.312134]  #14
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.312424]  #15
[    0.015631] microcode: You should not be seeing this. Please send the 
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500011
[    0.313521] Spectre V2 : Update user space SMT mitigation: STIBP always-on
[    0.328817] smp: Brought up 1 node, 16 CPUs
[    0.330152] smpboot: Total of 16 processors activated (121422.53 BogoMIPS)
[    0.331117] Memory: 61612104K/62798720K available (10240K kernel code, 922K 
rwdata, 2264K rodata, 1248K init, 1564K bss, 1173300K reserved, 0K cma-reserved)

Before this, I used stable kernel 6.13.4 which didn't show these lines.

Regards,
Jörg.



