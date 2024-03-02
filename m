Return-Path: <stable+bounces-25773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F286F113
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 17:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694461C20CB5
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CD18C19;
	Sat,  2 Mar 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="hWJDUgYv"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243818657
	for <stable@vger.kernel.org>; Sat,  2 Mar 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395831; cv=none; b=uaXIHYvr/z8Qgyr1dCXcPC6FaiUesN83sfwEmcHUpVrF7VXdGI60S4lvZhVJblSGrGtO/V6rDv/DKl1DAD2lvE9U0NC5i2ZMUbheijBWyLFuctHW0rGAmCLx8vKAeiyuxGBF5ipCHjGyzWAcKqDFnrlj5eLGwqjrgnkHm8FcU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395831; c=relaxed/simple;
	bh=r/gX/79V8+0qCTUFoJEv7lpIzrVY76rZxThwESkTnpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D03Sy4ZwErUIY2LN3WVvgO5uAlNpZ+Y8Yk6WPuq7YlSduX0ZFuxLNlg+KMIvbCTeTc/6do/Oy/qUuvifbnaP9F/vxwCbJLwrmhZXJnL8tXtbbqpxzpUvhh3vohb9pYjs0ruh49A7zXTQRgHXOnB12BsxK0Vt3jlrhRqy6yfqtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=hWJDUgYv; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 128232009A
	for <stable@vger.kernel.org>; Sat,  2 Mar 2024 16:10:21 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id E1C9A3E87F;
	Sat,  2 Mar 2024 17:10:12 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id DE13E400D0;
	Sat,  2 Mar 2024 16:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709395810;
	bh=r/gX/79V8+0qCTUFoJEv7lpIzrVY76rZxThwESkTnpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hWJDUgYvno7bYxiXLv7RM3dGJOK5z/JIn5TTxfUO18KdqJup4tCPniKGJkuJKP4mv
	 Z/fyiDY5wliwskH7tc8WrgCmQHntxP9/rpUeA/1OWeRzR6DX4T2Q+6zUS+C+AkO/3k
	 S9v2UyGSe1I74PL3YCxRZIbiiKlj4yAAtpqcYuDI=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 40F944097F;
	Sat,  2 Mar 2024 16:10:09 +0000 (UTC)
Message-ID: <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
Date: Sat, 2 Mar 2024 21:40:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DE13E400D0

Hello everyone,

On 3/2/24 20:47, Linux regression tracking (Thorsten Leemhuis) wrote> 
Thx for testing and glad to hear. Still: if you have any feedback how to
> make that guide even better, please let me know!

Yes, I have some improvements in mind.
Don't know if there is a Github repo where I can make a PR, but if not 
here's the gist:

1. The git clone/fetch instructions in the TLDR is easy to follow, but 
there are conflicting information later on in the main section and 
reference that taken together does not work. I think it would be better 
to not perform shallow clones or such advanced topics could be relegated 
to its own reference section.

Here's what I ended up using:
git clone -o mainline --no-checkout \
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
~/linux/
cd ~/linux/
git remote add -t master stable \
   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
git checkout --detach v6.0
git checkout --force --detach mainline/master
git remote set-branches --add stable linux-6.7.y
git fetch --verbose stable
git checkout --force --detach v6.7.7
git checkout --force --detach v6.7.5

2. The "installkernel" command is called "kernel-install" in OpenSuse, 
and it doesn't really perform all the steps to install kernel. It calls 
dracut to create initramfs though, but that's hardly much help.

I ended up doing:
sudo make modules_install
sudo install -m 0600 $(make -s image_name) /usr/lib/modules/$(make -s 
kernelrelease)/vmlinuz
sudo install -m 0600 System.map /usr/lib/modules/$(make -s 
kernelrelease)/System.map
sudo kernel-install add $(make -s kernelrelease) /usr/lib/modules/$(make 
-s kernelrelease)/vmlinuz
sudo ln -sf /boot/initrd-$(make -s kernelrelease) /boot/initrd
sudo ln -sf /usr/lib/modules/$(make -s kernelrelease)/vmlinuz 
/boot/vmlinuz-$(make -s kernelrelease)
sudo ln -sf /boot/vmlinuz-$(make -s kernelrelease) /boot/vmlinuz
sudo ln -sf /usr/lib/modules/$(make -s kernelrelease)/System.map 
/boot/System.map-$(make -s kernelrelease)
sudo update-bootloader

3. The dependencies for kernel building in OpenSuse and other major 
distros are incomplete, most of them have some form of package 
collection that can be provided as an alternative.
For example in OpenSuse, I installed the following patterns (collection 
of packages):
sudo zypper in -t pattern devel_basis devel_kernel devel_osc_build 
devel_rpm_build

4. The command to build RPM package (make binrpm-pkg) fails as the 
modules are installed into "/home/<user>/linux/.../lib" while depmod 
checks for modules in "/home/<user>/linux/.../usr/lib".

I think that's it, turned out not to be a gist after all. 🙂
Thank you very much for writing the updated guide, it was very helpful 
without which I don't think it would have been possible for someone like 
me to find/report this bug.

>> Full bisection done, culprit identified, and validated by reverting
>> commit on mainline.
> 
> I assume the latter meant "reverting the culprit on mainline fixed the
> problem"; if you meant something else, please let us know.

Clarification: reverting culprit commit on mainline fixed the problem.

Kind regards,
Pavin Joseph.

