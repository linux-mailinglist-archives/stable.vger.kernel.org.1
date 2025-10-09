Return-Path: <stable+bounces-183652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A4BC73B9
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79E9A4E7DC5
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECB10957;
	Thu,  9 Oct 2025 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gY5jZI3D"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31C1B4F1F
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977864; cv=none; b=Q3gTv0nkUchJaNfi6yzTmDw/bAVYnaVRNVfOGRXLG5GnmpLw3d7lW/ooMtSAC8CBp2mA9NYEqHw3lPTQWhNuFrH19zBUFdehJ7rzqJvFG+IyZHzTXqBtfUm+V98Ie1ww+TkLESKiee6HKdeQuTtnN1VdjvugORpFEFWiwAfxVZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977864; c=relaxed/simple;
	bh=oI1Jn0YBXYu5KtHxXso48hxSMGUIWA/7qeScAetrKB0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=noiOM96fAz6xdc4rEy65ECY0y3Djm7938miua/B63PmZd0tiy1/eyeysvNipXJsQa+Gpwj/+qacIf2laIZ1BHGd/hp68WfQOBJz1IeEJKPBeJCgD/7N3Bm5FD8apwg8d60ZQS65F3orv5A1gFTOuf2m6Y6MuXsOuLxVxPxw9qao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gY5jZI3D; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DUtRzioJH+QUbhN03m+2mQKjKOgAi2V22A0inzZfaP0=;
	b=gY5jZI3Dl9eP8xnDevz5IURg8lPq+NdA24WkPtua6nrnuFrhRbKBojNudrtVR81+asS0ov9k5
	0zNaPcJfJr/j2F+WYBwrHvhwEfszWZruCr7/HikfB1ecuj9MIw494N2wu2r5W/nBz440+wAG7hG
	GeQGLubkuWkbIU8+i0FteC8=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4chvM670Lpz12LJY;
	Thu,  9 Oct 2025 10:43:30 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F24E180064;
	Thu,  9 Oct 2025 10:44:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 10:44:19 +0800
Message-ID: <296837df-b8ed-466a-8694-dbd69aad8bb0@huawei.com>
Date: Thu, 9 Oct 2025 10:44:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression in hostfs (ARCH=um)
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
To: Geoffrey Thorpe <geoff@geoffthorpe.net>, <stable@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>, <regressions@lists.linux.dev>
References: <CAH2n15x389Uv_PuQ8Crm7gg4VC0UZ3kJg+eEfHMy8A6rzUtUAA@mail.gmail.com>
 <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
In-Reply-To: <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)



On 2025/10/9 10:42, Hongbo Li wrote:
> 
> Hi Geoffrey,
> 
> On 2025/10/9 7:22, Geoffrey Thorpe wrote:
>> Any trivial usage of hostfs seems to be broken since commit cd140ce9 
>> ("hostfs: convert hostfs to use the new mount API") - I bisected it 
>> down to this commit to make sure.
>>
> 
> Sorry to trouble you, can you provide your information about mount 
> version and kernel version (use mount -v and uname -ar) ?

Sorry, is mount --version

> 
> Thanks,
> Hongbo
> 
>> Steps to reproduce;
>>
>> The following assumes that the ARCH=um kernel has already been 
>> compiled (and the 'vmlinux' executable is in the local directory, as 
>> is the case when building from the top directory of a source tree). I 
>> built mine from a fresh clone using 'defconfig'. The uml_run.sh script 
>> creates a bootable root FS image (from debian, via docker) and then 
>> boots it with a hostfs mount to demonstrate the regression. This 
>> should be observable with any other bootable image though, simply pass 
>> "hostfs=<hostpath>" to the ./vmlinux kernel and then try to mount it 
>> from within the booted VM ("mount -t hostfs none <guestpath>").
>>
>> The following 3 text files are used, and as they're small enough for 
>> copy-n-paste I figured (hoped) it was best to inline them rather than 
>> post attachments.
>>
>> uml_run.sh:
>> #!/bin/bash
>> set -ex
>> cat Dockerfile | docker build -t foobar:foobar -
>> docker export -o foobar.tar \
>>      `docker run -d foobar:foobar /bin/true`
>> dd if=/dev/zero of=rootfs.img \
>>      bs=$(expr 2048 \* 1024 \* 1024 / 512) count=512
>> mkfs.ext4 rootfs.img
>> sudo ./uml_root.sh
>> cp rootfs.img temp.img
>> dd if=/dev/zero of=swapfile bs=1M count=1024
>> chmod 600 swapfile
>> mkswap swapfile
>> ./vmlinux mem=4G ubd0=temp.img rw ubd1=swapfile \
>>      hostfs=$(pwd)
>>
>> uml_root.sh:
>> #!/bin/bash
>> set -ex
>> losetup -D
>> LOOPDEVICE=$(losetup -f)
>> losetup ${LOOPDEVICE} rootfs.img
>> mkdir -p tmpmnt
>> mount -t auto ${LOOPDEVICE} tmpmnt/
>> (cd tmpmnt && tar xf ../foobar.tar)
>> umount tmpmnt
>> losetup -D
>>
>> Dockerfile:
>> FROM debian:trixie
>> RUN echo 'debconf debconf/frontend select Noninteractive' | \
>>      debconf-set-selections
>> RUN apt-get update
>> RUN apt-get install -y apt-utils
>> RUN apt-get -y full-upgrade
>> RUN echo "US/Eastern" > /etc/timezone
>> RUN chmod 644 /etc/timezone
>> RUN cd /etc && rm -f localtime && \
>>      ln -s /usr/share/zoneinfo/$$MYTZ localtime
>> RUN apt-get install -y systemd-sysv kmod
>> RUN echo "root:root" | chpasswd
>> RUN echo "/dev/ubdb swap swap defaults 0 0" >> /etc/fstab
>> RUN mkdir /hosthack
>> RUN echo "none /hosthack hostfs defaults 0 0" >> /etc/fstab
>> RUN systemctl set-default multi-user.target
>>
>> Execute ./uml_run.sh to build the rootfs image and boot the VM. This 
>> requires a system with docker, and will also require a sudo password 
>> when creating the rootfs. The boot log indicates whether the hostfs 
>> mount succeeds or not - the boot should degrade to emergency mode if 
>> the mount fails, otherwise a login prompt should indicate success. 
>> (Login is root:root, e.g. if you prefer to go in and shutdown the VM 
>> gracefully.)
>>
>> Please let me know if I can/should provide anything else.
>>
>> Cheers,
>> Geoff
>>

