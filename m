Return-Path: <stable+bounces-25788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2586F336
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927C41C20D8E
	for <lists+stable@lfdr.de>; Sun,  3 Mar 2024 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B25197;
	Sun,  3 Mar 2024 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="g3PCavdO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347D7F;
	Sun,  3 Mar 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709424495; cv=none; b=Lbl1oRIGvaqj3ZJZT4eeFrTJ+VDOpmJ4zT8xrtMifljdaBVNaItiqsDHYgRPcPtidT0ZyUUkZ1uWziG6xedY2i38/xAIaWUgiOlFNTAAvsbspp7gtuIh9SyCKVLIply4QsvNmm+V4LEEhuRGV4cTWl7Xb5zY94s0Z3sAotf9zEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709424495; c=relaxed/simple;
	bh=0hxhne77JDOLEpa6IW5J7+kRFyIxiuDO/E1gJbovLDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jDV14vmcSwNkeWxKwAdBvKvwigJBS+NeLI+x6kMHLvEyEAkH24DIQtJxDo9yM1Wfe8nLYuJSV4qLe8/pCDU3DkCre3zAnMzwYcrFhANTb2qkIpoz6Mbvk1lRlO5L25qrfu3K+JxZzrsVEPGh9/m8I8rZdW4i4UKOIq+3dRzUPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=g3PCavdO; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 422GWgZk016853;
	Sun, 3 Mar 2024 00:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=3m+UYNMt8ETxWgy5M3AArHzDpmCY5jCJlJnGcdC2HfM=;
 b=g3PCavdOr+pF6hIDz+6VOTm4Z9fQ3FYVp+T9P72eJmhGXp/SndBn1B3Xt4nMXHQtnOiz
 Smz3z7sePVxli/8bW4qfrmAJVSJxk+nVaS09fgisuYpp2fIpmmWwLn6uX5exNn3wlAZx
 lJROVQcbj+AiZMWLkkyQQtbT3Vta+dtYeyoiBkMpDHGYicajwb4SsALHL6MvXd98nIjv
 AS6iwo5BhHvVFzosPt3c9oAb6Ctr7CyJfWEVe4ohsMnMwavVp7mBPV7+PQ7rI01ddYUf
 0gxnf/kPRc+prp5/v8oioVXO8iQqOgL5wPx0pXHOACPQQdF74iodaWTQR6mOMLGlGRyk Ow== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wksmbuqjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Mar 2024 00:00:45 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C33751308C;
	Sun,  3 Mar 2024 00:00:34 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 71AA4802BAE;
	Sun,  3 Mar 2024 00:00:33 +0000 (UTC)
Date: Sat, 2 Mar 2024 18:00:31 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZeO9n6oqXosX1I6C@swahl-home.5wahls.com>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
X-Proofpoint-GUID: xAWpGMjvdjduSw06SLjHeYb1yP1y3PXj
X-Proofpoint-ORIG-GUID: xAWpGMjvdjduSw06SLjHeYb1yP1y3PXj
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-02_06,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403020207

On Sat, Mar 02, 2024 at 09:40:06PM +0530, Pavin Joseph wrote:
> Hello everyone,
> 
> On 3/2/24 20:47, Linux regression tracking (Thorsten Leemhuis) wrote> Thx
> for testing and glad to hear. Still: if you have any feedback how to
> > make that guide even better, please let me know!
> 
> Yes, I have some improvements in mind.
> Don't know if there is a Github repo where I can make a PR, but if not
> here's the gist:
> 
> 1. The git clone/fetch instructions in the TLDR is easy to follow, but there
> are conflicting information later on in the main section and reference that
> taken together does not work. I think it would be better to not perform
> shallow clones or such advanced topics could be relegated to its own
> reference section.
> 
> Here's what I ended up using:
> git clone -o mainline --no-checkout \
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> ~/linux/
> cd ~/linux/
> git remote add -t master stable \
>   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> git checkout --detach v6.0
> git checkout --force --detach mainline/master
> git remote set-branches --add stable linux-6.7.y
> git fetch --verbose stable
> git checkout --force --detach v6.7.7
> git checkout --force --detach v6.7.5
> 
> 2. The "installkernel" command is called "kernel-install" in OpenSuse, and
> it doesn't really perform all the steps to install kernel. It calls dracut
> to create initramfs though, but that's hardly much help.
> 
> I ended up doing:
> sudo make modules_install
> sudo install -m 0600 $(make -s image_name) /usr/lib/modules/$(make -s
> kernelrelease)/vmlinuz
> sudo install -m 0600 System.map /usr/lib/modules/$(make -s
> kernelrelease)/System.map
> sudo kernel-install add $(make -s kernelrelease) /usr/lib/modules/$(make -s
> kernelrelease)/vmlinuz
> sudo ln -sf /boot/initrd-$(make -s kernelrelease) /boot/initrd
> sudo ln -sf /usr/lib/modules/$(make -s kernelrelease)/vmlinuz
> /boot/vmlinuz-$(make -s kernelrelease)
> sudo ln -sf /boot/vmlinuz-$(make -s kernelrelease) /boot/vmlinuz
> sudo ln -sf /usr/lib/modules/$(make -s kernelrelease)/System.map
> /boot/System.map-$(make -s kernelrelease)
> sudo update-bootloader
> 
> 3. The dependencies for kernel building in OpenSuse and other major distros
> are incomplete, most of them have some form of package collection that can
> be provided as an alternative.
> For example in OpenSuse, I installed the following patterns (collection of
> packages):
> sudo zypper in -t pattern devel_basis devel_kernel devel_osc_build
> devel_rpm_build
> 
> 4. The command to build RPM package (make binrpm-pkg) fails as the modules
> are installed into "/home/<user>/linux/.../lib" while depmod checks for
> modules in "/home/<user>/linux/.../usr/lib".
> 
> I think that's it, turned out not to be a gist after all. 🙂
> Thank you very much for writing the updated guide, it was very helpful
> without which I don't think it would have been possible for someone like me
> to find/report this bug.
> 
> > > Full bisection done, culprit identified, and validated by reverting
> > > commit on mainline.
> > 
> > I assume the latter meant "reverting the culprit on mainline fixed the
> > problem"; if you meant something else, please let us know.
> 
> Clarification: reverting culprit commit on mainline fixed the problem.
> 
> Kind regards,
> Pavin Joseph.


Pavin,

I have just now built and installed 6.7.7 and succesfully kexec'd in
this fashion:

------------------------------
sph-185:~ # kexec -l /boot/vmlinuz-6.7.7-wahl --initrd=/boot/initrd-6.7.7-wahl --reuse-cmdline
sph-185:~ # systemctl kexec
...
[  OK  ] Reached target Late Shutdown Services.
         Starting Reboot via kexec...
[  493.056708][    T1] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
[  493.089271][    T1] systemd-shutdown[1]: Unmounting file systems.
[  493.096285][T14707] (sd-remount)[14707]: Remounting '/' read-only in with options 'attr2,inode64,logbufs=8,logbsize=32k,noquota'.
[  493.113587][    T1] systemd-shutdown[1]: All filesystems unmounted.
[  493.119913][    T1] systemd-shutdown[1]: Deactivating swaps.
[  493.126612][    T1] systemd-shutdown[1]: All swaps deactivated.
[  493.132584][    T1] systemd-shutdown[1]: Detaching loop devices.
[  493.138718][    T1] systemd-shutdown[1]: All loop devices detached.
[  493.145036][    T1] systemd-shutdown[1]: Stopping MD devices.
[  493.150838][    T1] systemd-shutdown[1]: All MD devices stopped.
[  493.156894][    T1] systemd-shutdown[1]: Detaching DM devices.
[  493.162785][    T1] systemd-shutdown[1]: All DM devices detached.
[  493.168930][    T1] systemd-shutdown[1]: All filesystems, swaps, loop devices, MD devices and DM devices detached.
[  493.221975][    T1] systemd-shutdown[1]: Syncing filesystems and block devices.
[  493.229354][    T1] systemd-shutdown[1]: Rebooting with kexec.
[  493.303438][T14716] qla2xxx [0003:61:00.0]-fffa:14: Adapter shutdown
[  493.309930][T14716] qla2xxx [0003:61:00.0]-00af:14: Performing ISP error recovery - ha=00000000ae891d2f.
[  493.330535][T14716] qla2xxx [0003:61:00.0]-fffe:14: Adapter shutdown successfully.
[  494.114055][T14716] mana 0000:61:00.1: Shutdown was called
[  494.643693][T14716] kvm: exiting hardware virtualization
[  494.649419][T14716] kexec_core: Starting new kernel


Invalid physical address chosen!




Physical KASLR disabled: no suitable memory region!

[    0.000000][    T0] Linux version 6.7.7-wahl (root@sph-185) (gcc (SUSE Linux) 7.5.0, GNU ld (GNU Binutils; SUSE Linux Enterprise 15) 2.41.0.20230908-150100.7.46) #1 SMP PREEMPT_DYNAMIC Sat Mar  2 17:22:28 CST 2024
------------------------------

This was on SLES, not open Suse.

The machines I work on are large, though.  Can you give specifics on
exactly how you are performing your kexec, and what hardware you are
using when you hit this (especially memory size)?  Have you made any
special arrangements for the size of memory reserved for kexec on your
system?

The patch can use slightly more memory to create the identity maps,
and the only thing I can think of right now is that little bit causing
you to run out of memory.

Thank you!

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise

