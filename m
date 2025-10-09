Return-Path: <stable+bounces-183651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD0BC73B6
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 04:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E7E3B004F
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 02:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024C71BEF7E;
	Thu,  9 Oct 2025 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6DT9Q9RF"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86851C5F27
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 02:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977771; cv=none; b=aY2FeAvy6LLLUfjfrerQMxbaXUkAMbNHOam9L2g9pzOci1zpQxRoVY6rz/6QYusIf6sXTRYe+VnK3q5ntliJD+r93oX9EdZFW4kzx7xDyYfQopN5EwndJhtFREQVfnMHYgI6o+H0AhQMd0tTB7caoAdXMGoNKgyYQE0jw2GnVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977771; c=relaxed/simple;
	bh=Irk2LAwiEbhFQ5Gas1sCBqCMcEIBxE3FISDjq6ubDDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BotlmGVCOWMQUkE9JLuvyv9FLcwdgdVaoyHSsOkmJwPihxFfqSg9H9JTBdYpDovu3yfzjLaO+eQXn8plfMw1IqKlRlAlDv+b4YsvUnIuZg6/bX1aFnM9Hs4vkw2XFptACmJ1m9h/JH9yBy6Hc99adlr39z6ioHwFgUEmnwRoPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6DT9Q9RF; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Vs2XXJjQkKCZi+dKb++6zBCTsSXm5Gzrlj9FRbYRbtM=;
	b=6DT9Q9RFHYwml7r4hcuzEvTVfybbclbfN12n+x7lTx6wo+uwdk28iTjktc4KjPVU/R9HdtCQC
	q92ksioTt2Fu5Ppt5+Z2nEj3m8jc68Dvym7GiasCMVc8OGvirYGdOgfkeZXf4Q8rwSdi1OfiqnE
	IPzCkNaQqA1LMPuieWaRWJM=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4chvKy65WQzRjyQ;
	Thu,  9 Oct 2025 10:42:30 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B94A1400D4;
	Thu,  9 Oct 2025 10:42:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Oct 2025 10:42:46 +0800
Message-ID: <75a53a17-b5fe-441e-8953-8c1d5e7ca47a@huawei.com>
Date: Thu, 9 Oct 2025 10:42:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression in hostfs (ARCH=um)
To: Geoffrey Thorpe <geoff@geoffthorpe.net>, <stable@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>, <regressions@lists.linux.dev>
References: <CAH2n15x389Uv_PuQ8Crm7gg4VC0UZ3kJg+eEfHMy8A6rzUtUAA@mail.gmail.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAH2n15x389Uv_PuQ8Crm7gg4VC0UZ3kJg+eEfHMy8A6rzUtUAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)


Hi Geoffrey,

On 2025/10/9 7:22, Geoffrey Thorpe wrote:
> Any trivial usage of hostfs seems to be broken since commit cd140ce9 
> ("hostfs: convert hostfs to use the new mount API") - I bisected it down 
> to this commit to make sure.
> 

Sorry to trouble you, can you provide your information about mount 
version and kernel version (use mount -v and uname -ar) ?

Thanks,
Hongbo

> Steps to reproduce;
> 
> The following assumes that the ARCH=um kernel has already been compiled 
> (and the 'vmlinux' executable is in the local directory, as is the case 
> when building from the top directory of a source tree). I built mine 
> from a fresh clone using 'defconfig'. The uml_run.sh script creates a 
> bootable root FS image (from debian, via docker) and then boots it with 
> a hostfs mount to demonstrate the regression. This should be observable 
> with any other bootable image though, simply pass "hostfs=<hostpath>" to 
> the ./vmlinux kernel and then try to mount it from within the booted VM 
> ("mount -t hostfs none <guestpath>").
> 
> The following 3 text files are used, and as they're small enough for 
> copy-n-paste I figured (hoped) it was best to inline them rather than 
> post attachments.
> 
> uml_run.sh:
> #!/bin/bash
> set -ex
> cat Dockerfile | docker build -t foobar:foobar -
> docker export -o foobar.tar \
>      `docker run -d foobar:foobar /bin/true`
> dd if=/dev/zero of=rootfs.img \
>      bs=$(expr 2048 \* 1024 \* 1024 / 512) count=512
> mkfs.ext4 rootfs.img
> sudo ./uml_root.sh
> cp rootfs.img temp.img
> dd if=/dev/zero of=swapfile bs=1M count=1024
> chmod 600 swapfile
> mkswap swapfile
> ./vmlinux mem=4G ubd0=temp.img rw ubd1=swapfile \
>      hostfs=$(pwd)
> 
> uml_root.sh:
> #!/bin/bash
> set -ex
> losetup -D
> LOOPDEVICE=$(losetup -f)
> losetup ${LOOPDEVICE} rootfs.img
> mkdir -p tmpmnt
> mount -t auto ${LOOPDEVICE} tmpmnt/
> (cd tmpmnt && tar xf ../foobar.tar)
> umount tmpmnt
> losetup -D
> 
> Dockerfile:
> FROM debian:trixie
> RUN echo 'debconf debconf/frontend select Noninteractive' | \
>      debconf-set-selections
> RUN apt-get update
> RUN apt-get install -y apt-utils
> RUN apt-get -y full-upgrade
> RUN echo "US/Eastern" > /etc/timezone
> RUN chmod 644 /etc/timezone
> RUN cd /etc && rm -f localtime && \
>      ln -s /usr/share/zoneinfo/$$MYTZ localtime
> RUN apt-get install -y systemd-sysv kmod
> RUN echo "root:root" | chpasswd
> RUN echo "/dev/ubdb swap swap defaults 0 0" >> /etc/fstab
> RUN mkdir /hosthack
> RUN echo "none /hosthack hostfs defaults 0 0" >> /etc/fstab
> RUN systemctl set-default multi-user.target
> 
> Execute ./uml_run.sh to build the rootfs image and boot the VM. This 
> requires a system with docker, and will also require a sudo password 
> when creating the rootfs. The boot log indicates whether the hostfs 
> mount succeeds or not - the boot should degrade to emergency mode if the 
> mount fails, otherwise a login prompt should indicate success. (Login is 
> root:root, e.g. if you prefer to go in and shutdown the VM gracefully.)
> 
> Please let me know if I can/should provide anything else.
> 
> Cheers,
> Geoff
> 

