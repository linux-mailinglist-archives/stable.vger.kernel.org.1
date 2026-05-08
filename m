Return-Path: <stable+bounces-244751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD5JLiDe/Wn0jwAAu9opvQ
	(envelope-from <stable+bounces-244751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F64F6A6E
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD17301944B
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4E3E0C6F;
	Fri,  8 May 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="KNn0xtR2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833093E0C67
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245148; cv=none; b=EHIt7QDZvR9mGBrQyBZXJxQ7rc6nXjdC5wAZOFQnjd0KlLxbEedFqYSvdjdZSeyt+8tSZ87EoiJXMKyjp7k64jFgYCHtlMBUV+WqYi/Ud0bEtCbnKll/LzKgO6beWK4M60AHh0a7y5D8FMQz1qCgCL6z4TQwU3Et3AROsPGgHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245148; c=relaxed/simple;
	bh=492pnth8FX5r9c5d/fLKxM4aqzPKBhKHL61vb5yF+Rc=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=j2IJP1GPjw/VsZWXlW9uZdrce15eB+PWIbcEqkRySFRmgMDIXz23w0/zilG6JAteZmkL8P6V4SgQOKXJp9FseghT+6zCbnxhi5Yd+bgU5OP6iA9kj6+5ffgiOKZGUVkbu+mey0KvNU5llKYL3XMmwHmKHbt0/Dqk3/576IBXLAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=KNn0xtR2; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3625216eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778245145; x=1778849945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUH0RYV4aqq+y8EhTWWZ4Ne3pQYPIGrr6kAObvWZsMM=;
        b=KNn0xtR2TwF8VUkkW1ZzSN3Gd7EMUjEp5ZDSJT2rBKtGFFOI+8EEUmW04YdRzPbi61
         yzITUtRtP1i93J2xfMRkjZDt0CiV+6xeiOHgwvnui4m6YA5ASSfEeOWSV3yl62YS9Ihr
         SDbgeDgeBqlIzHkPJeWNFHb7JtxWFVeLqWFr/vFuVRmuG3GWH+9+znyfJU4thtTu3r3q
         mp+RsO7ztno8+c3rIXPurcYhcLJ9l8Y1zkOz+TvXKG9jiWIXJkxJmtx+xSektCqv9Fo0
         RELeQ+EdgaUlHPTkGz2Ve90vtCrAHCrb0DqZCAuesVLdAsGeucslyxNVP/3VYuSTTmT4
         ZqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778245145; x=1778849945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUH0RYV4aqq+y8EhTWWZ4Ne3pQYPIGrr6kAObvWZsMM=;
        b=GmvRkycLAzsKF1BnkDHjWR2uqG0kmr9O+VEX8vfHURSp1c5sTfzVj/5ZL3AUlI1Y2a
         E4IOsptPRV5Hd+xVhvyc3WCOCVzkoMfl2xNSx/7t/1kI5klkYl8uvKJdpvJ4eiloIkzb
         RuLpWTnuaOEDGnA0iktPf0CN68k/YVpFAe9Fv9pPKqiNSnru/u8OyqEgbb/mJwD4zQMZ
         iqVlP1C/q3GopsdnpFy/jqtIad+mxfqXQBoYRSekSH1GiczWU/nBgtG4U/XSCpltcjZ5
         zYmVxUXhjEefUUloV8zn+BqZk5lG7fYmqbeWya7Z0+2E3+HXSHjh5hj4fzdPFzf3dpI/
         79zw==
X-Forwarded-Encrypted: i=1; AFNElJ/d0kwiba7JxCXEfyihlYxSjQ9aGmgAw5dNrDxe/A3lM6XH6+CTl0he++tZXkK7zV4G43Y1Oy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyRCrSG5lmhAeM/xm9BNSAbA3jcfL201UZspAO4C8JrPtdvBNb
	28FKvJM/OhvUI4moj8cSvzepPRQ0Kt9vkOltlo+7NWluptdV71KP7UnsoILW9Ua94YA=
X-Gm-Gg: Acq92OEoJEQQo/mE/4tQxKffLvEblz3Iylw3GKFf5K//Iwhavs3IZChV08EObvOa7Ep
	C3sHumyvzcN1AEoSi2dUkVCcRW/QxA6iZconS2VVwW4fVzQFJBbGVnioAvat8t9wEHLvxlwY7o6
	cV90V88nhNT3mzWvWjmOBM9aCD6AkKCD285LgAIOLQAhR2Wrv6ZXDCGQO2UfPMvstvP2UeH1IlW
	djbliWC1Co9iPHi4AFEEVGZcmpApqtw+Fjq7qNRfBsi2wmM6be6/m3tAQ5p9TvuHZn4c4VAJ0k0
	IuPUdHNG7O5atkhOV+GRcS6jHmJ3HBXgeQUX+kF9YvZ6h/2vrFhoeEHy3Kp1AF9fTVWDRhMyJ66
	JpZMej+POn9lB4BPYjfkacIIxf4CaF98kBgCXk4kd7iNtOMYq/pwWcyc7CsuGI88ZCbn4Ljgilm
	F99fuG/t4vhH42nG8E
X-Received: by 2002:a05:7300:f191:b0:2c4:61be:1d33 with SMTP id 5a478bee46e88-2f54d69b008mr5987430eec.6.1778245145353;
        Fri, 08 May 2026 05:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm2034890eec.28.2026.05.08.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.qHdqrp (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 12:59:04 -0000
Message-ID: <177824514401.4192.5464075814934177075@997d03828cfd>
X-Rspamd-Queue-Id: 312F64F6A6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernelci.org,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244751-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernelci.org:s=google];
	DKIM_TRACE(0.00)[kernelci.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	NEURAL_HAM(-0.00)[-0.874];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,f8000000:email]
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.qHdqrp (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:171554a7149a464f2f55b98ce95c6285e2074c6b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  7e75ef31ddc90089f78a67b7327c9552fd3786d8
- tags: v5.15.205

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- defconfig
scripts/kconfig/merge_config.sh -m -O /tmp/kci/artifacts/build /tmp/kci/artifacts/build/.config /tmp/kci/artifacts/build/0.config /tmp/kci/artifacts/build/1.config
Using /tmp/kci/artifacts/build/.config as base
Merging /tmp/kci/artifacts/build/0.config
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
Value of CONFIG_NVME_CORE is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_NVME_CORE=m
New value: CONFIG_NVME_CORE=y
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_BLK_DEV_NVME=m
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_XFS_FS is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_XFS_FS is not set
New value: CONFIG_XFS_FS=y
Value of CONFIG_DEBUG_INFO is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: CONFIG_DEBUG_INFO=y
New value: CONFIG_DEBUG_INFO=n
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
/tmp/kci/linux/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:460.3-52: Warning (pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not configuration space
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- Image.gz
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778242249 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs
rm -rf /tmp/kci/artifacts/build/dtbsinstall
mkdir -p /tmp/kci/artifacts/build/dtbsinstall/dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_DTBS_PATH=/tmp/kci/artifacts/build/dtbsinstall/dtbs ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- dtbs_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778242249 --clamp-mtime -caf /tmp/kci/artifacts/build/dtbs.tar.xz -C /tmp/kci/artifacts/build/dtbsinstall dtbs
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- binrpm-pkg
Building target platforms: aarch64
Building for target aarch64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.Zz0Cfb
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.qHdqrp
+ umask 022
+ cd ./kernel-5.15.205-build
+ /usr/bin/rm -rf ./kernel-5.15.205-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.15.205-build
+ /usr/bin/mkdir ./kernel-5.15.205-build/BUILDROOT
+ mkdir -p ./kernel-5.15.205-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:669: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.15.205-build/BUILDROOT/boot/vmlinuz-5.15.205
cp: missing destination file operand after './kernel-5.15.205-build/BUILDROOT/boot/vmlinuz-5.15.205'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.qHdqrp (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## defconfig+aws-ec2 on (arm64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fdcd310e4ee292cbef1eee


#kernelci issue maestro:171554a7149a464f2f55b98ce95c6285e2074c6b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

