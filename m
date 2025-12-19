Return-Path: <stable+bounces-203107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C541BCD11B6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EB8E3029A80
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25131A575;
	Fri, 19 Dec 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mathematik.uni-marburg.de header.i=@mathematik.uni-marburg.de header.b="x0vTNqam"
X-Original-To: stable@vger.kernel.org
Received: from vhrz1173.hrz.uni-marburg.de (vhrz1173.HRZ.Uni-Marburg.DE [137.248.1.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86930C610;
	Fri, 19 Dec 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=137.248.1.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164836; cv=none; b=J2ISdgz0/mqGpdeUThKH+5lDm4ebTDg1mVOn19Eei7ovG5sv2DqM/T9EMGmZ4S/8cRQeL92CjFqMgKBpfRkod2je5+KIpLALs+KmEgl/CSjcTKFWZabL19X7y2PJ6tDG7UZdeccR5Fv9ihlLG+wjLMuaNo0DLsdDCaxx3gdWRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164836; c=relaxed/simple;
	bh=cPBEh00fgKNw/ntamUaTH96OVCc3mCrdtjHLoxeLylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FLnfZXXQDkidRU1BKVIVCVNeOdzF5LeXebPpYKyxOk3RPKJQ1yrw7Kp/KoUKORPnYK/IZSoBqIcaLVjAMx1w0YAUSdRivStzT7svhz2/3svfgh/aLd47soCAlNAerFaL3QrNB9NA/QxlyLvUyOrCsYzmf7kMyiih0SXcwWS4DNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mathematik.uni-marburg.de; spf=pass smtp.mailfrom=mathematik.uni-marburg.de; dkim=pass (1024-bit key) header.d=mathematik.uni-marburg.de header.i=@mathematik.uni-marburg.de header.b=x0vTNqam; arc=none smtp.client-ip=137.248.1.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mathematik.uni-marburg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mathematik.uni-marburg.de
Received: from vhrz1173.hrz.uni-marburg.de (vhrz1173.HRZ.Uni-Marburg.DE [137.248.1.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by vhrz1865.HRZ.Uni-Marburg.DE (Postfix) with ESMTPS id 4dXvKV5Kl6zyg3;
	Fri, 19 Dec 2025 18:14:38 +0100 (CET)
Authentication-Results: smtpd-out;
	dkim=pass header.d=mathematik.uni-marburg.de header.s=default header.b=x0vTNqam;
	spf=pass (smtpd-out: domain of rschwarzkopf@mathematik.uni-marburg.de designates 137.248.1.43 as permitted sender) smtp.mailfrom=rschwarzkopf@mathematik.uni-marburg.de
Received: from pc12216.mathematik.uni-marburg.de (pc12216.Mathematik.Uni-Marburg.DE [137.248.123.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vhrz1865.HRZ.Uni-Marburg.DE (Postfix) with ESMTPS id 4dXvKH5K7HzyhT;
	Fri, 19 Dec 2025 18:14:27 +0100 (CET)
Received: from [137.248.109.88] (mvpn2188.VPN.Uni-Marburg.DE [137.248.109.88])
	(authenticated bits=0)
	by pc12216.mathematik.uni-marburg.de (8.14.4/8.14.4) with ESMTP id 5BJHEOEn088785
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Dec 2025 18:14:25 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 pc12216.mathematik.uni-marburg.de 5BJHEOEn088785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mathematik.uni-marburg.de; s=default; t=1766164467;
	bh=2ymR/MBpNuFIRThwX8ZYZ+U/ecsF7BfXRXD3pwLbnvY=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=x0vTNqamgS5LpOw2laVYBjb+zWIsr6IFahCEBdCni/kDz5a341gNeosp8E5UUG40k
	 UuTKfTOqlSetWtzqRNi3u4TWRWcF1FPZNq4YlIWe68ig6ZQMjrWyGuSXT4fvisIG0V
	 fwMnBQhmrfi0Y80T4c/oDgrqvH6Qq1jHL+XKCxaU=
Message-ID: <10af99d0-9a52-4ae0-9ee9-a02b5370f034@mathematik.uni-marburg.de>
Date: Fri, 19 Dec 2025 18:14:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 5.10.y] Libvirt can no longer delete macvtap devices
 after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete support
 flag") to 5.10.y series (Debian 11)
To: Salvatore Bonaccorso <carnil@debian.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
 <aUMEVm1vb7bdhlcK@eldamar.lan>
 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
 <176608738558.457059.16166844651150713799@eldamar.lan>
Content-Language: en-US
From: Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>
Cc: debian-kernel@lists.debian.org, Ben Hutchings <benh@debian.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
In-Reply-To: <176608738558.457059.16166844651150713799@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Score: -6.23 / 12.00 / 15.00
X-Rspamd-Queue-Id: 4dXvKV5Kl6zyg3

Hi all,

On 12/18/25 20:50, Salvatore Bonaccorso wrote:
> Hi all,
>
> Roland Schwarzkopf reported to the Debian mailing list a problem which
> he encountered once updating in Debian from 5.10.244 to 5.10.247. The
> report is quoted below and found in
> https://lists.debian.org/debian-kernel/2025/12/msg00223.html
>
> Roland did bisect the changes between 5.10.244 to 5.10.247 and found
> that the issue is introduced with 1550f3673972 ("net: rtnetlink: add
> bulk delete support flag") which is the backport to the 5.10.y series.
>
> On Thu, Dec 18, 2025 at 02:59:55PM +0100, Roland Schwarzkopf wrote:
>> Hi Salvatore,
>>
>> On 12/17/25 20:28, Salvatore Bonaccorso wrote:
>>> Hi Roland,
>>>
>>> I'm CC'ing Ben Hutchings directly as well as he takes care of the
>>> Debian LTS kernel updates. Idellly we make this as well a proper bug
>>> for easier tracking.
>>>
>>> On Wed, Dec 17, 2025 at 01:35:54PM +0100, Roland Schwarzkopf wrote:
>>>> Hi there,
>>>>
>>>> after upgrading to the latest kernel on Debian 11
>>>> (linux-image-5.10.0-37-amd64) I have an issue using libvirt with qemu/kvm
>>>> virtual machines and macvtap networking. When a machine is shut down,
>>>> libvirt can not delete the corresponding macvtap device. Thus, starting the
>>>> machine again is not possible. After manually removing the macvtap device
>>>> using `ip link delete` the vm can be started again.
>>>>
>>>> In the journal the following message is shown:
>>>>
>>>> Dec 17 13:19:27 iblis libvirtd[535]: error destroying network device macvtap0: Operation not supported
>>>>
>>>> After downgrading the kernel to linux-image-5.10.0-36-amd64, the problem
>>>> disappears. I tested this on a fresh minimal install of Debian 11 - to
>>>> exclude that anything else on my production machines is causing this issue.
>>>>
>>>> Since the older kernel does not have this issue, I assume this is related to
>>>> the kernel and not to libvirt?
>>>>
>>>> I tried to check for bug reports of the kernel package, but the bug tracker
>>>> finds no reports and even states that the package does not exist (I used the
>>>> "Bug reports" link on
>>>> https://packages.debian.org/bullseye/linux-image-5.10.0-37-amd64). This left
>>>> me a bit puzzled. Since I don't have experience with the debian bug
>>>> reporting process, I had no other idea than writing to this list.
>>> You would need to search for inhttps://bugs.debian.org/src:linux ,
>>> but that said I'm not aware of any bug reports in that direction.
>>>
>>> Would you be in the position of bisecting the problem as you can say
>>> that 5.10.244 is good and 5.10.247 is bad and regressed? If you can do
>>> that that would involve compiling a couple of kernels to narrow down
>>> where the problem is introduced:
>>>
>>>       git clone --single-branch -b linux-5.10.yhttps://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>>>       cd linux-stable
>>>       git checkout v5.10.244
>>>       cp /boot/config-$(uname -r) .config
>>>       yes '' | make localmodconfig
>>>       make savedefconfig
>>>       mv defconfig arch/x86/configs/my_defconfig
>>>
>>>       # test 5.10.244 to ensure this is "good"
>>>       make my_defconfig
>>>       make -j $(nproc) bindeb-pkg
>>>       ... install the resulting .deb package and confirm it successfully boots / problem does not exist
>>>
>>>       # test 5.10.247 to ensure this is "bad"
>>>       git checkout v5.10.247
>>>       make my_defconfig
>>>       make -j $(nproc) bindeb-pkg
>>>       ... install the resulting .deb package and confirm it fails to boot / problem exists
>>>
>>> With that confirmed, the bisection can start:
>>>
>>>       git bisect start
>>>       git bisect good v5.10.244
>>>       git bisect bad v5.10.247
>>>
>>> In each bisection step git checks out a state between the oldest
>>> known-bad and the newest known-good commit. In each step test using:
>>>
>>>       make my_defconfig
>>>       make -j $(nproc) bindeb-pkg
>>>       ... install, try to boot / verify if problem exists
>>>
>>> and if the problem is hit run:
>>>
>>>       git bisect bad
>>>
>>> and if the problem doesn't trigger run:
>>>
>>>       git bisect good
>>>
>>> . Please pay attention to always select the just built kernel for
>>> booting, it won't always be the default kernel picked up by grub.
>>>
>>> Iterate until git announces to have identified the first bad commit.
>>>
>>> Then provide the output of
>>>
>>>       git bisect log
>>>
>>> In the course of the bisection you might have to uninstall previous
>>> kernels again to not exhaust the disk space in /boot. Also in the end
>>> uninstall all self-built kernels again.
>> I just did my first bisection \o/ (sorry)
>>
>> Here are the results:
>>
>> git bisect start
>> # bad: [f964b940099f9982d723d4c77988d4b0dda9c165] Linux 5.10.247
>> git bisect bad f964b940099f9982d723d4c77988d4b0dda9c165
>> # good: [863b76df7d1e327979946a2d3893479c3275bfa4] Linux 5.10.244
>> git bisect good f52ee6ea810273e527a5d319e5f400be8c8424c1
>> # good: [dc9fdb7586b90e33c766eac52b6f3d1c9ec365a1] net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
>> git bisect good dc9fdb7586b90e33c766eac52b6f3d1c9ec365a1
>> # bad: [2272d5757ce5d3fb416d9f2497b015678eb85c0d] phy: cadence: cdns-dphy: Enable lower resolutions in dphy
>> git bisect bad 2272d5757ce5d3fb416d9f2497b015678eb85c0d
>> # bad: [547539f08b9e3629ce68479889813e58c8087e70] ALSA: usb-audio: fix control pipe direction
>> git bisect bad 547539f08b9e3629ce68479889813e58c8087e70
>> # bad: [3509c748e79435d09e730673c8c100b7f0ebc87c] most: usb: hdm_probe: Fix calling put_device() before device initialization
>> git bisect bad 3509c748e79435d09e730673c8c100b7f0ebc87c
>> # bad: [a6ebcafc2f5ff7f0d1ce0c6dc38ac09a16a56ec0] net: add ndo_fdb_del_bulk
>> git bisect bad a6ebcafc2f5ff7f0d1ce0c6dc38ac09a16a56ec0
>> # good: [b8a72692aa42b7dcd179a96b90bc2763ac74576a] hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
>> git bisect good b8a72692aa42b7dcd179a96b90bc2763ac74576a
>> # good: [2b42a595863556b394bd702d46f4a9d0d2985aaa] m68k: bitops: Fix find_*_bit() signatures
>> git bisect good 2b42a595863556b394bd702d46f4a9d0d2985aaa
>> # good: [9d9f7d71d46cff3491a443a3cf452cecf87d51ef] net: rtnetlink: use BIT for flag values
>> git bisect good 9d9f7d71d46cff3491a443a3cf452cecf87d51ef
>> # bad: [1550f3673972c5cfba714135f8bf26784e6f2b0f] net: rtnetlink: add bulk delete support flag
>> git bisect bad 1550f3673972c5cfba714135f8bf26784e6f2b0f
>> # good: [c8879afa24169e504f78c9ca43a4d0d7397049eb] net: netlink: add NLM_F_BULK delete request modifier
>> git bisect good c8879afa24169e504f78c9ca43a4d0d7397049eb
>> # first bad commit: [1550f3673972c5cfba714135f8bf26784e6f2b0f] net: rtnetlink: add bulk delete support flag
>>
>> Is there anything else I can do to help?
> Is there soemthing missing?
>
> Roland I think it would be helpful if you can test as well more recent
> stable series versions to confirm if the issue is present there as
> well or not, which might indicate a 5.10.y specific backporting
> problem.

I tested this on some newer kernel versions: stable 6.18.2 and 6.17.13 
as well as mainline 6.19-rc1. With all three kernel versions, a 
different problem occurs: I can't even start the virtual machine.

The relevant journal entry is:

Dec 19 17:25:41 iblis libvirtd[438]: error creating macvtap interface 
macvtap0@eno1 (08:00:27:25:16:0c): Operation not supported

I then searched in the commit log for the upstream commit of the one I 
found when bisecting the issue. It is a6cec0bcd342, which git describe 
says is v5.18-rc1-423-ga6cec0bcd342. Therefore I decided to also test 
the two longterm versions before and after that commit was introduced: 
5.15.197 and 6.1.159. With both kernel versions I found the same 
behavior as with the stable and mainline versions.

So on all newer kernel versions I tested behave identical, but different 
than the latest release in the 5.10.y branch.

I'm not sure if I caused this behaviour by making a mistake during 
building the kernels - I don't have much experience in that area. I used 
the same steps Salvatore gave me for bisecting the issue for the 
different versions, i.e.,

      cp /boot/config-$(uname -r) .config
      yes '' | make localmodconfig
      make savedefconfig
      mv defconfig arch/x86/configs/my_defconfig
      make my_defconfig
      make -j $(nproc) bindeb-pkg

Best regards,

Roland

>
> #regzbot introduced: 1550f3673972c5cfba714135f8bf26784e6f2b0f
>
> Regards,
> Salvatore

-- 
Dr. Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>
Dept. of Mathematics and Computer Science, IT Solutions
University of Marburg, Hans-Meerwein-Str. 6, D-35032 Marburg, Germany
Tel: +4964212821523, Fax: +4964212821573


