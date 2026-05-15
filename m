Return-Path: <stable+bounces-247784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QInbHhErB2ppsQIAu9opvQ
	(envelope-from <stable+bounces-247784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:17:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D7551374
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C9533036C07
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B55382F28;
	Fri, 15 May 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="cdE72aEL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE763D1AAA
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853550; cv=none; b=P5/LIe6a5b+xPrZKGkCXM+7Rms/poUiOyz7s0qraOiKj2qMUYzJR6Ppe34UCQ0b/BrpPd/4bvIGcLEht9aD3xZKCK18BLIcBrr+AhjJ/WBIVzWGkX6ZCwXvmC/Zry1yrge4JdWuMjFowa2rczIDz5xvIlFULB4HXXqykz+/Vgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853550; c=relaxed/simple;
	bh=uy2+i6SH7jhcYJBD6YuvH1qZGSoVrlJUvW5UcVb6Kpw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=KBTnjGs3SJ+MLJjQy/4Zxd5zoJk4df1tHc17r1tfTvcyNGpygngghF8/+zh/a0EVHQrfOOFb6kVIU36JYoIFnlAHr/k33dT6tULUrE0cmfG8P+4heSg+C29H+ScYJakL1ecJPfP1bdtYbCnW0nhdpimUGOYsC3cbFnhp1W/wsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=cdE72aEL; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so14974784eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778853548; x=1779458348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYD5HzyzSspYzMB6yC+Dnnba0M8Yd/rXetpYp0BGk3U=;
        b=cdE72aELHwE92o2DRfuN2YdY0Rpyx3LZ2SCxCHKlkCujxGcVfJhh/Hi7m9yXqxEQeq
         QVX2teI3O7QWIUXr0mVDNN7cZr7VbE5eIqkbq0GXocKyCKXSaoHkoO8VPmNxClWsqMAq
         TUjlGyzDCW9NiGhL2/Xtl0RNhK19e3CRoAkWlcbQy+bnjqs/kh31VJQWz279JglHQ9tJ
         hPnLc/AtvDztgT0JLbO2gbgTGappn3fH+yHtK1XjSZzt72jO9WdOAxmQJlP8LANj1D6t
         5/IWm8tx2E/EwXbAfK1gpipq+5hSGKwnYU3bRChlbRJTCkbOHKNjran2WiDRnrN8Z66g
         6/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853548; x=1779458348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYD5HzyzSspYzMB6yC+Dnnba0M8Yd/rXetpYp0BGk3U=;
        b=cWc3iH7e3O7y0+oqN3NV5jYsg8pctDKvCa4269ulxCebcnRYkKW6HEJcQFAVlQW44o
         H5VgVPf7y6uK9hwoMicqsy+krOH453VIBRc/feaC1idXvZ4POLZ2RX9CsbT9DiGXy8Zg
         uuhSvjLgPzSgl2HRHJ1b8bLucYpKfdTlbBSm56ioJjReqnz1Q0qnKneim9Pugmck3u9S
         Kk0zOjVpEZxfH+Y7rwCts/7/qZ8KTPeLitUlm8b0am9Zji87diMRm9yI+Q2IswOQnkVr
         nGKuj6nrmCda1ZMEhvVwCHrjRgWAU5GxxjafOFKXL3xBihygwwGX8eoyYTpOVOMwt1uA
         VIuQ==
X-Forwarded-Encrypted: i=1; AFNElJ89EXVnH0JAexrokHlUO6NbzN/EcPdE+Ukc8UEkBhJhcX3GN707/vuFWq+063z8d2SqxmmDsSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZdX+jbXQWmUl6yt8i1jnzP+ZCcvr6QwQGNePTLmi+rj0QSrD
	hU6/eqnKjABD7QoHWywb4pQGQf2qp338Aprx9Q38KoRx7Q0MOaWm1OV+VOuCRs+PEUan5nRUl61
	ykIBQ
X-Gm-Gg: Acq92OEmHfvA+6rBjFroEzXnDoutBcaobEVpPYreEmvEvB7PqX1qXu0vVrXVY+EtfBp
	CvRY17uzqLGeRIAKBwIzNpv7OnJfkUM3lX0q7w6s4PUCOc4zCtZngfwXYY6sKtzw/0RksEbrgGz
	Yd//BuCPX5ged0mS8CfzHIOfQDOtQzphy47sbhorre31Sj2qkyuD7UQjKt4QeIASH/sol9/U7fz
	uSIZk3nveB2ShRPAw2cUo2JoIAAF4TWXvPHYsMCPhvb6VdiiL4j4WhH7rAZe3sRoULPimXWD1VD
	ftp9jHFWgYuYei4b4x+zKImsCkMWRNt6BoDP8rSNh6warL6KlDAfiPVk6SGUDWKPeKfscFFy0dL
	oFP+R+7XPqdJD2uTjzl+iDidndoB4gqVJSxY8gu/sVgyDD7Eo7LCSmOxPCyfq4kbDnZCicx8l3b
	ZRvMnIJFOiuq/N9nfa
X-Received: by 2002:a05:7300:ec18:b0:2da:1874:f3bd with SMTP id 5a478bee46e88-30398618bccmr1865288eec.16.1778853548421;
        Fri, 15 May 2026 06:59:08 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm7869798eec.15.2026.05.15.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-5.10.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.XGQbLa (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 15 May 2026 13:59:07 -0000
Message-ID: <177885354720.985.12606794941175621652@330cfa3079ca>
X-Rspamd-Queue-Id: AB4D7551374
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-247784-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,kernelci.org:email,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-5.10.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.XGQbLa (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:68) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:f7f76917c91e3e82c343364a060fdc6dde124bea
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  6b2498787ec6803cf0d0a983321796babe5392d4
- tags: v5.10.256

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- x86_64_defconfig
scripts/kconfig/merge_config.sh -m -O /tmp/kci/artifacts/build /tmp/kci/artifacts/build/.config /tmp/kci/artifacts/build/0.config /tmp/kci/artifacts/build/1.config
Using /tmp/kci/artifacts/build/.config as base
Merging /tmp/kci/artifacts/build/0.config
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_BLK_DEV_NVME is not set
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_XFS_FS is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_XFS_FS is not set
New value: CONFIG_XFS_FS=y
Value of CONFIG_VIRTIO_PCI is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_VIRTIO_PCI is not set
New value: CONFIG_VIRTIO_PCI=y
Value of CONFIG_DEBUG_INFO is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_DEBUG_INFO is not set
New value: CONFIG_DEBUG_INFO=n
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- bzImage
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778852390 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64
Building for target x86_64
warning: line 19: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.Z3SMvL
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.XGQbLa
+ umask 022
+ cd ./kernel-5.10.256-build
+ /usr/bin/rm -rf ./kernel-5.10.256-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-5.10.256-build
+ /usr/bin/mkdir ./kernel-5.10.256-build/BUILDROOT
+ mkdir -p ./kernel-5.10.256-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:656: include/config/auto.conf: No such file or directory
+ cp ./kernel-5.10.256-build/BUILDROOT/boot/vmlinuz-5.10.256
cp: missing destination file operand after './kernel-5.10.256-build/BUILDROOT/boot/vmlinuz-5.10.256'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.XGQbLa (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a0721560ed99f002e8dee70


#kernelci issue maestro:f7f76917c91e3e82c343364a060fdc6dde124bea

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

