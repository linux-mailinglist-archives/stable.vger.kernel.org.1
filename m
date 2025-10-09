Return-Path: <stable+bounces-183644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02605BC718F
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 03:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 908494E8E51
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 01:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3C2A1CA;
	Thu,  9 Oct 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b="gJDv7dzM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858234BA2C
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972796; cv=none; b=jht7Epc//wUMCDDpKaHWuzCsWZSG4l2Z6q9QqV/46dhnSlpxMc5UBsY65X5JzzgYD1JDoj2naTtpA8SFI1zalmBfY/3/IuD0QigfMOPnuLZU+W0/DviNLKnyPMcxe+/UucyPwHDMreHLqosk3+P4pneY9SjruTcapP5/NGzx5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972796; c=relaxed/simple;
	bh=ZxWdDT2cizErFSu2EavwIia11MxZf2+fzj9yc9DzoGE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=iAz11T+dOW1o7U/+nVj7+mZ56qyFzUm6dBwLLJFMc3gcQzL8NvukQsGuZGSkviAmgW8tQZHyBH4eVKBeKpLeuUbT1Lon4NY8YOTuiB18qiDY756BWmxWjmcOLjCdGEeLOUu/BCN7zopGXnpexeWXsvc85yHZg0z3D8oM5DphMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net; spf=pass smtp.mailfrom=qclibre.com; dkim=pass (1024-bit key) header.d=geoffthorpe.net header.i=@geoffthorpe.net header.b=gJDv7dzM; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geoffthorpe.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qclibre.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7970e8d1cfeso6194386d6.1
        for <stable@vger.kernel.org>; Wed, 08 Oct 2025 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geoffthorpe.net; s=myprefix; t=1759972793; x=1760577593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acR+s3oVDWyAwHDskgAsxeBcl+TGvm3f4GFFmuSPOck=;
        b=gJDv7dzMZLx+gEk3k7C6My8fzQJDOyjqwdZLA/4Q7CJb0JRZ/Px4hOZZ4UybzTqNWQ
         4pjgb7WIl1L49QlHQBkZFPHeS1b65M34B7cBGnix0gFdLCJ9tkTgGXHjiuc6teV0cItS
         i4aGy0H565CIlqOKHP/V+nNtNwnQOHNzjw8fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759972793; x=1760577593;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=acR+s3oVDWyAwHDskgAsxeBcl+TGvm3f4GFFmuSPOck=;
        b=F/tdgQwv+CshK9xtS4OOu+Fsj4618dPyf8z4KzyC9+SE1nvh0DW9SP6peR8l1aFKFg
         1V8VC1uY/R3MWGbdtdv1q5b1eIKh91UrQ7vHC5CY7M/QVK9otWTBEusD/TWoGOtLc7XH
         kPDMeo1UajUEGwO2VgG0UMMvk9r53K1xRhC/PkfJ+0UvkjEwPqHNiR8s/F6cZYjYSh6V
         ikTmHR9KYdYMhq45LBZVH6n8X89GkLI7bkEfVRiMW7X/E/2WCd27mFmflptmWiqJ88c1
         j3Tpf8beO234knVTfJJwxZeEqIGzdCrp5hu2g46YPJI9d1skl8v3N6cLuDg0ntxd6Nrv
         P4ug==
X-Gm-Message-State: AOJu0YwlpHvrU++9K/rje5xdOQD3Grj73JEfZPrTGShanW9HwItP98EB
	RagJtAi5IoceUIjVGHljw+0MMq6FOd6W23BfC1u7rZEQEVVJKhl21fe2JFnSiZ6pqsGh+zoaP0d
	Yt7cOsEwO2g==
X-Gm-Gg: ASbGncuYHtfBJ8rWQym1kmc9IPDdXCj7ehUdXdaC99HLIrE1o+VN4sxYUd5t37sQ7QX
	U3T1e3YytTVrv7sj2WmnwQBF1VCpuDkAbeQWXd6UciD0IGgpvqROIQ1zbsNOUFejhsYM/+ibwIb
	72aO+XyY8QRbbQzTQKVdv9oxHG49F2FO/ARAyvqwfTT9g3mlKlhd6luQUpOIY/nCd+3/Ud9lVc5
	Xj2NpCesby1c/SjPOcPJvjSaJYlEfK6THDLApATHMF/qWYxLBtoA8aL/GiqQGs7PV1Z4b0DnF8+
	DNG5D88a1bVw6AcGgvqIAdnYtswEGXey4Ioci6eNSI4IkJbfxndERU1+GcPnAGxrOcMm1X9b338
	i1mSp/iYAjlndu0FblX4ADy9hxPJ8GO3PbdCpQd0gHmlheDYYqR8cD0j2pfwVEAjjj0Z+nCKlKK
	OabeBR2D8keJKE7Q==
X-Google-Smtp-Source: AGHT+IHAxpEM7+GoT5/HGr1UNF25QOlBKyFcd4LEScvHTr+MLbISRd2I+c6acOdxday8/kU61JUo1Q==
X-Received: by 2002:a05:6214:c65:b0:79a:6359:14c6 with SMTP id 6a1803df08f44-87b2efc2dc6mr70392156d6.40.1759972793560;
        Wed, 08 Oct 2025 18:19:53 -0700 (PDT)
Received: from [10.0.0.3] (modemcable155.19-201-24.mc.videotron.ca. [24.201.19.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb91sm170468636d6.60.2025.10.08.18.19.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 18:19:53 -0700 (PDT)
Message-ID: <643333a0-f434-42fb-82ac-d25a0b56f3b7@geoffthorpe.net>
Date: Wed, 8 Oct 2025 21:19:52 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geoffrey Thorpe <geoff@geoffthorpe.net>
Subject: regression in hostfs (ARCH=um)
To: stable@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Any trivial usage of hostfs seems to be broken since commit cd140ce9 
("hostfs: convert hostfs to use the new mount API") - that's what it 
bisected down to.

Steps to reproduce;

The following assumes that the ARCH=um kernel has already been compiled 
(and the 'vmlinux' executable is in the local directory, as is the case 
when building from the top directory of a source tree). I built mine 
from a fresh clone using 'defconfig'. The uml_run.sh script creates a 
bootable root FS image (from debian, via docker) and then boots it with 
a hostfs mount to demonstrate the regression. This should be observable 
with any other bootable image though, simply pass "hostfs=<hostpath>" to 
the ./vmlinux kernel and then try to mount it from within the booted VM 
("mount -t hostfs none <guestpath>").

The following 3 text files are used, and as they're small enough for 
copy-n-paste I figured (hoped) it was best to inline them rather than 
post attachments.

uml_run.sh:
#!/bin/bash
set -ex
cat Dockerfile | docker build -t foobar:foobar -
docker export -o foobar.tar \
     `docker run -d foobar:foobar /bin/true`
dd if=/dev/zero of=rootfs.img \
     bs=$(expr 2048 \* 1024 \* 1024 / 512) count=512
mkfs.ext4 rootfs.img
sudo ./uml_root.sh
cp rootfs.img temp.img
dd if=/dev/zero of=swapfile bs=1M count=1024
chmod 600 swapfile
mkswap swapfile
./vmlinux mem=4G ubd0=temp.img rw ubd1=swapfile \
     hostfs=$(pwd)

uml_root.sh:
#!/bin/bash
set -ex
losetup -D
LOOPDEVICE=$(losetup -f)
losetup ${LOOPDEVICE} rootfs.img
mkdir -p tmpmnt
mount -t auto ${LOOPDEVICE} tmpmnt/
(cd tmpmnt && tar xf ../foobar.tar)
umount tmpmnt
losetup -D

Dockerfile:
FROM debian:trixie
RUN echo 'debconf debconf/frontend select Noninteractive' | \
     debconf-set-selections
RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get -y full-upgrade
RUN echo "US/Eastern" > /etc/timezone
RUN chmod 644 /etc/timezone
RUN cd /etc && rm -f localtime && \
     ln -s /usr/share/zoneinfo/US/Eastern localtime
RUN apt-get install -y systemd-sysv kmod
RUN echo "root:root" | chpasswd
RUN echo "/dev/ubdb swap swap defaults 0 0" >> /etc/fstab
RUN mkdir /hosthack
RUN echo "none /hosthack hostfs defaults 0 0" >> /etc/fstab
RUN systemctl set-default multi-user.target

Execute ./uml_run.sh to build the rootfs image and boot the VM. This 
requires a system with docker, and will also require a sudo password 
when creating the rootfs. The boot output indicates whether the hostfs 
mount succeeds or not - the boot should degrade to emergency mode if the 
mount fails, otherwise a login prompt indicates success. (Login is 
root:root, e.g. if you prefer to go in and shutdown the VM gracefully.)

Please let me know if I can/should provide anything else.

Cheers,
Geoff




