Return-Path: <stable+bounces-121546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95EA57BC4
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA747A77EC
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E942D1B424E;
	Sat,  8 Mar 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b="tuxZ78A8"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381F1B21B4;
	Sat,  8 Mar 2025 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449805; cv=none; b=VrOUWIA7IEWTd1zgB6eIka0bqiTrqwrPyNdBzVtxoGDzeaIx0Vo8lozZDeITOD65Dmg+SDXXrZYqL9bcyDdMJKHLEqgn6ePhbUGcB2kC5uPofgozOUEpd7VfM0/11mbynlRyiTKiWRAfTZooZZ7Z6gAEwZD3FHt5PDTRvMUNhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449805; c=relaxed/simple;
	bh=CcyPJSdT7v0lx+RJUF5l6lpRgEgDQSWMYvtp9S4Soes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfmZp3HtZ1OnrEc/f7p3xyWqDHoa1u7dzlU4YD6TmFk/EV7b2JipmxiYaDee2fbJeXZHV/peJSMyzJ4ZdUz0MxNPj0VdbE+v73/a4KmrgifAFOPozdviNiK2QxFFL/44BIwyQ+BGO1CAehI5iUVHzHAiNb5Zwz+nqsYqQdh6Yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=jvpeetz@web.de header.b=tuxZ78A8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741449792; x=1742054592; i=jvpeetz@web.de;
	bh=471NOtV+uqpxsfeJ9KelICVljMieSLQf54akSdE5xsM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tuxZ78A8TwZ+FnT75M92y6bJrrh/HpgY83813ows7db2lKq9D8ijpVqJ04EqZz9G
	 VYy1evBpFLEuBox+LYk4w+DT0A9mSG7zoHzB20EmiJgjU4WKCj+0a3U5sw0OleVAF
	 /bL6kOq5TtQOl6zWuSCvTNGNo1J5k1Dor1QSQzK1/VaY0PTF1rkQj5H88K6Fg89tC
	 3SykMl9xelgaRCwUrB8ADRyQ9ABTdrBJyFs+QNfszPyjiDsyxdr1bbH26O4kqMNjM
	 5HfgGvJO7JT/EvLYbgvrz8wcFUSTeYDDBmKY1SEDgQm5suipXRByx5yIQJ19bBxC/
	 o+bDj3Cu0E6brgW2ag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from uruz.dynato.kyma ([91.5.111.65]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1tIi1E3ToB-00lP3p; Sat, 08
 Mar 2025 17:03:11 +0100
Received: from [127.0.0.1]
	by uruz.dynato.kyma with esmtp (Exim 4.98)
	(envelope-from <jvpeetz@web.de>)
	id 1tqwdo-0000000010L-3mcL;
	Sat, 08 Mar 2025 17:03:08 +0100
Message-ID: <1b3ea3ce-7754-494c-a87b-0b70b2d25f99@web.de>
Date: Sat, 8 Mar 2025 17:03:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.13.6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org, x86@kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
Newsgroups: gmane.linux.kernel.stable,gmane.linux.kernel
References: <2025030751-mongrel-unplug-83d8@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rg-Volker_Peetz?= <jvpeetz@web.de>
In-Reply-To: <2025030751-mongrel-unplug-83d8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bCBURvFjf40I0ai4sPiOv+aJfwFYTxZzQFFNzvOe9O9oZlOp8CK
 zzKF8rYNyAhb+K5sNDZg3dkeX1VHRK6X1nMaYUywaJqe40ffHLMkQC3fCGgdR7Zc2uhhJXi
 ZjbbHxsOXs1THeWvcD+hTL7mph97H5QYJf1agDvzLFj7T42VVyxF+uOX7+GoV9dYaics4Wt
 TXd/9wnSJ4X6dugHbu4Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:64MDx3yeKHk=;otVhtLdeEfGO5qcslIfYq3rd0LN
 R2fki4qPKSpCb/w9f9wnIGOHjiVuGq3KbAFPIwYqqtg6bwvQsPOIQhnMTrGWQSHQ009Psk4q9
 bfCo2zvySYTrKSrM9bGs6q+2Gfv2GdmJWcN0IxId1pqEhqoEgpWTcM3C+80gu2iw62u3ZSGsq
 k7H1jOev0EreUjM2wtUodaaRYw6ZEmpAk805/JVHQGyK3R/whcifm/CvIb4KciN6Ys9YDNov3
 EMRP8FJzvueCOXnVC2JaQFNwV3MKvxHLW6jyXCagfbzVsUF8ESulAzKiHMY5Ft84uo2e6Bz1z
 cocjWsp6+N+99ssArGBv+yW+qFb1iO/7ti8YaNy4A6TA3Gn6dkhVOO8qOjy2P5fG0+8EAlV/S
 +yf22cmNtvKxzveoy9ccAO/XFRwnmkg31Co5SjtoG6vyy9FL2yVFhfQDi0+MYrV7svzkX1o7B
 EfRYxKaGg4565On1okOwDETHG/xYOKkI8ggSGGBNLQonQWHW4EXXHkh/HL+UMsAwMninpREcs
 ZNEp7xo+Og2zkjYyjH/G7TB3iQS7ecjbMr1MPsaFM+1WxMOPVrGofIht5r6qljh0WBpI0HElz
 rclpXWL4zBlZ/2G/0xvLYxJ3jCsWk8p6/EHBcYv0JbwHDa4G4qlfihnoVa+rh4gda8ZfQedMa
 3c426DgSkwmBK1RqGeAKcG2LeLjlE6folaR7Kylicpo4gleEF7eIOdVdtQLhd0FYx1Ba2blfz
 B7vLQloHXNHGfDjDWewhGayC5Ox+x+v5zSOBLsVji0FDxlhlOdgmviEV3wCbdL7Xh0TWZnYAe
 oUjDcuC1c0tUXS8J7XxKn/KxEd/zyRr1sGPwHBVRY12003YTiHAZ4qLV8TvIHL7be3v26UmMU
 G4rEcP04fRI+thZ2Y5dctasmXOMOJ/AXR3MLH0SKFdBy+gDKvKLmx77JWjpVsXEIQ0l3Cnm6Y
 Fiu+HesRfMZ75571sCcZyMO+eSGsRs9Z9XOFMYgyZglwILmYp/ZoDRDigF/z+qT2u8AZ3xgtN
 LNlSL8pCDv7e4V9/E3+6noJkQYh2u4ZLSt5f+mVbii+p5xarbwj6eTAeiWSYiTM6/xu1kgdN1
 4s7AWPdnzeZmRlnzmp82iE1p7AFGmr1IwA8qdT0QjQdL4VR2hjHY650XxZ6GiQxt+wpDRXGHj
 uRlrwBmv+eJuxPy+iSBzZ/TEPwSwHLB4T0qubRhtgn0/w9nti6lmfn65wRKQ4O9PwGJSG/FDe
 pEBqiUlBo0qxmK1e7DDA1gfjs0IMpUjHweWGdIT9Mxm/bbNG9t9MsOiRrFVGrZYFHOchD3q2V
 ERgOcvIz+8V31d5VNH8qN/2GNl0NoDlL12F98G3RVk68MLQYA/OQY667yXY+RMnZsJPsRowvJ
 4dXBJkSDQSIqXYrh03zA7dgV8ZmEn5zhx9sV2Dq3GzzbkagoOr/8VYqCj/

Greg Kroah-Hartman wrote on 07/03/2025 18:52:
> I'm announcing the release of the 6.13.6 kernel.
>
> All users of the 6.13 kernel series must upgrade.
>

Thank you all for the new stable kernel. Unfortunately, the following mess=
ages
appear in dmesg on my system:

[    0.000000] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.000000] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.000000] Linux version 6.13.6 (root@uruz) (gcc (Debian 14.2.0-17) 14=
.2.0,
GNU ld (GNU Binutils for Debian) 2.44) #1 SMP Fri Mar  7 19:40:58 CET 2025
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz root=3DPARTUUID=3D=
cb5df131-01
random.trust_cpu=3Don amd_pstate=3Dactive spec_rstack_overflow=3Doff

...

[    0.295153] smpboot: CPU0: AMD Ryzen 7 5700G with Radeon Graphics (fami=
ly:
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
[    0.296062] Timer migration: 2 hierarchy levels; 8 children per group; =
2
crossnode level
[    0.296192] smp: Bringing up secondary CPUs ...
[    0.296286] smpboot: x86: Booting SMP configuration:
[    0.296346] .... node  #0, CPUs:        #1  #2  #3  #4
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.296783]   #5
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.296817]   #6
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.296817]   #7
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.310182]   #8
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.310682]   #9
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.310978]  #10
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.311265]  #11
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.311553]  #12
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.311842]  #13
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.312134]  #14
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.312424]  #15
[    0.015631] microcode: You should not be seeing this. Please send the
following couple of lines to x86-<at>-kernel.org
[    0.015631] microcode: CPUID(1).EAX: 0xa50f00, current revision: 0xa500=
011
[    0.313521] Spectre V2 : Update user space SMT mitigation: STIBP always=
-on
[    0.328817] smp: Brought up 1 node, 16 CPUs
[    0.330152] smpboot: Total of 16 processors activated (121422.53 BogoMI=
PS)
[    0.331117] Memory: 61612104K/62798720K available (10240K kernel code, =
922K
rwdata, 2264K rodata, 1248K init, 1564K bss, 1173300K reserved, 0K cma-res=
erved)

Before this, I used stable kernel 6.13.4 which didn't show these lines.

Regards,
J=C3=B6rg.


