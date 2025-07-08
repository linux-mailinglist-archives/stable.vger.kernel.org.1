Return-Path: <stable+bounces-161327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C3AAFD5D3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D371AA3F64
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0E12E6D1A;
	Tue,  8 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i5dxdJ+s"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B32E5B2A
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997550; cv=none; b=BKDTPLegqpwxdxIJuBEr1T8CnkByi/f1R7x5YBccdn15Z+jmevwDvarTpAlBNIaWTK81bC9zU+vetNazSTifjIuy05+IWg1nSULfOnRn/rUh5y2mkj+XfrvdTL9Pg4/sZhAZCiVBlytZVYMgJ3dgyeVWNC3W66FwexNom+S/cvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997550; c=relaxed/simple;
	bh=pUEyY2FQLLsAxZ7v3sxgbwnidiLMZwyP0U4ZmPGu+2s=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=PYY223nxDJj4jodJufRyoKGsk+fDCrsqFvQY81u2bc9B0i6qDB22C6idj99tcDxLQNp0BpLQdgsy53TvE9qgOJHfo+SLypPgJGhpRLd/waeRruL4wgYQSWnhQofnLmCqMpKSnh0LAK8urUUYEqYEhBPIlGP1UcuupVtwz7WKG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=i5dxdJ+s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e767ce72eso43491267b3.1
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997547; x=1752602347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSpq934xkP+tDrZqO9QT0/EJ3yUd8uAL1TLTkUSB+us=;
        b=i5dxdJ+sl3jjZQteKTL/vxx7aFHP7xd4pTPQpAMg8hAJyRXkR1lUFX+VX1iyy6mLxG
         EioUxKX8BwBnscfucsyIf0aO5euWicCIgKscwd1SJVFDG07camTh+y6kS/P+EFHEKBoR
         bXsqSdFUK9Mw/3jDXUAQovinA/xikLD9dapBMPlA8CvePCV2JOZTWtdoq/nr+vrEUrft
         5++B4L4tXcYoAAHWskUD6JPRKMmbzdb+M1RSurF7ZF6doAp3hbkYwpdYBQI5bMb96ssH
         /wFSOjNVWm3SEEtWasj5lTVuPzVlzlQAcuMSsEJtbWepFBIX63Q3x31IiiKDNMMlFBJ2
         coZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997547; x=1752602347;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSpq934xkP+tDrZqO9QT0/EJ3yUd8uAL1TLTkUSB+us=;
        b=nSKdMZoz1/adlabdC8IJHBjqiqQpFPGrhGllZNSgXemBN3ItGgpIZNS1CZLFa4+yR6
         qyc3jRXG8wvc5vkZjVOb5DzgXr7yCXZQ3L5O4Yhz2QBrh/36YH3t2FmDPS+6AxPRNW3X
         i3ru3EktkcYLx4iiNi8ATetgCpI3tALlkLbcco9mnoTO1IYxE7elBU1OUo5R82w/AL5j
         kFs6vMTh7cHM81czx/D9nF0s7ph9Visf1dgIPLpPDf/Y3UPchJMr9kBL/oCEJLKwKWpk
         MBTpzLNI+g64txlqqIBHd5/PYfTBdsZof5FK/DgAb/k/lOlx7zWDfDiW7ucShaU92GWq
         rmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX73puy8tiRZdWV/2ZMmG6YK0k7TKqCbjdJ8JtNnFb3NiKV7m4p+aq9PWfjwmFV7pWlzoCdvrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mGvYJbqMvph19KhRwZQPanTaikMG84csfqm0KLFZBzta5uyS
	80ExWGI4EImDBNxkF12kR/NNFaUB0/dqWM1FwBIKZhzQ68LOBiKfFtwMdSHOjpRyTnnLNwM70++
	B61zF6cETGjbPRkt+DSY7dpXUcrufXdToE1ZYkeqXHQ==
X-Gm-Gg: ASbGncvQ+dwxAsuVSR6AuX1f9Wjf59R3KBqhL0k1O+Wpx3xYXwA3q7YmZCXE8TakkGu
	F1tBpD3nAC03RapHLJ4n/Jysj2TlGFOui6J5xpJfheyuILkoCpdmJe9Jpd3BFxfbDUTpctwn4Y7
	XyZf2uC7DxZWI6/qgpxqXLuig32NUDb56sUpaI4NT1Fw==
X-Google-Smtp-Source: AGHT+IFY5Sy7jc6k1roVzwP3nKH6aHHBK6p3yvi3QYXStoa40+9V2QJO+NOhBoq6z8YrO0nnV0DjPUjJRh0oiAVm/gs=
X-Received: by 2002:a05:690c:6aca:b0:711:7128:114f with SMTP id
 00721157ae682-71668d1f922mr240047417b3.12.1751997546891; Tue, 08 Jul 2025
 10:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:04 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:04 -0700
X-Gm-Features: Ac12FXwVmyx6pmG3bnikR6Sy_FLjdDjazQKC3rP9teTUy4i-8sbvbxCLgsASLeg
Message-ID: <CACo-S-2Zr2teu3ctsi8i-rBR9bvgj-YRk+sBRs+OacvGV0=ZEA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) ld.lld: error: undefined
 symbol: cpu_show_tsa in vmlinux (scripts/...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 ld.lld: error: undefined symbol: cpu_show_tsa in vmlinux
(scripts/Makefile.vmlinux:34) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:6b1157158f4d95650fb3e4447503581fbc3320c8
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  16a0c0f862e842e4269c2142fabfece05c2380b1



Log excerpt:
=====================================================
.lds
....+...+..+.  HDRTEST usr/include/linux/if_x25.h
..............  CC      arch/arm64/kernel/debug-monitors.o
+.........  HDRTEST usr/include/linux/msg.h
....+.....+.......+..  HDRTEST usr/include/linux/sonypi.h
.+........+...+  CC      mm/kasan/generic.o
.+..  HDRTEST usr/include/linux/const.h
...+...+..............  HDRTEST usr/include/linux/affs_hardblocks.h
..+...........+...+....  HDRTEST usr/include/linux/loadpin.h
........+.+............  HDRTEST usr/include/linux/route.h
+.....+.+..+............  HDRTEST usr/include/linux/v4l2-subdev.h
+.+..+....+...+..  HDRTEST usr/include/linux/if_eql.h
.........+....+..+....  HDRTEST usr/include/linux/netfilter_ipv4.h
.....+.......+........+...  HDRTEST usr/include/linux/smiapp.h
......+......+.......+  HDRTEST usr/include/linux/bsg.h
...+..+............+.  HDRTEST usr/include/linux/agpgart.h
.........+..+............  HDRTEST usr/include/linux/aspeed-p2a-ctrl.h
.........+.............+.....  CC      init/do_mounts_initrd.o
+  HDRTEST usr/include/linux/media-bus-format.h
..........+..+...+....  HDRTEST usr/include/linux/fiemap.h
..+...+............+....  HDRTEST usr/include/linux/vfio_zdev.h
..+.........+......+..................+.+  HDRTEST usr/include/linux/socket.h
........+.......+...+..  HDRTEST usr/include/linux/lp.h
.+..............+.+.....  HDRTEST usr/include/linux/serio.h
...............+...+....+  HDRTEST usr/include/linux/vbox_vmmdev_types.h
..+.+...+.....+.....  HDRTEST usr/include/linux/seg6_genl.h
..............+......+..  HDRTEST
usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
........................+...  HDRTEST usr/include/linux/netfilter_ipv4/ipt_ah.h
+.+.....+.+...........+  HDRTEST usr/include/linux/netfilter_ipv4/ipt_TTL.h
.......+..+......+...  HDRTEST usr/include/linux/netfilter_ipv4/ipt_ecn.h
.+...+..+..............  HDRTEST usr/include/linux/netfilter_ipv4/ipt_LOG.h
.....+..+....+.....+  HDRTEST usr/include/linux/netfilter_ipv4/ipt_ECN.h
............................+  HDRTEST
usr/include/linux/netfilter_ipv4/ipt_REJECT.h
..+...+......+.......  HDRTEST usr/include/linux/netfilter_ipv4/ipt_ttl.h
........................+......+...........  HDRTEST
usr/include/linux/netfilter_ipv4/ip_tables.h
....+...+..+  AR      fs/notify/fanotify/built-in.a
....+...+.  CC      fs/notify/fsnotify.o
....+  HDRTEST usr/include/linux/serial.h
......+.+........+.....  HDRTEST usr/include/linux/btf.h
.+.......+.........+...  HDRTEST usr/include/linux/batadv_packet.h
...+..+...+...+.........  HDRTEST usr/include/linux/filter.h
...........................+  HDRTEST usr/include/linux/fsi.h
...............+....+..  HDRTEST usr/include/linux/sysctl.h
...+++++++++++  HDRTEST usr/include/linux/smc.h
+++  AS      arch/arm64/kernel/entry.o
++++++  HDRTEST usr/include/linux/dqblk_xfs.h
++++++++++++++++++++++  HDRTEST usr/include/linux/apm_bios.h
++++++++++  HDRTEST usr/include/linux/virtio_bt.h
++++++++++  HDRTEST usr/include/linux/major.h
+++
......+....+.....+.+........+.+......+........+....+.....+.......+...+......+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+.........
HDRTEST usr/include/linux/loop.h
......  CC      arch/arm64/kernel/irq.o
..........+..+  CC      init/initramfs.o
......  HDRTEST usr/include/linux/if_macsec.h
....+...+......+..+...  HDRTEST usr/include/linux/misc/bcm_vk.h
.......+.....+...............+...+....+.  HDRTEST usr/include/linux/kcmp.h
..+.........+....  CC      ipc/shm.o
..+.........+..............+.+.  HDRTEST usr/include/linux/fsverity.h
.....+............+......+.........+  HDRTEST usr/include/linux/fsmap.h
.....+.+..+.........+....+..............+.......+  HDRTEST
usr/include/linux/ip_vs.h
.....+..........+.....+  HDRTEST usr/include/linux/fdreg.h
......+.......+........+  HDRTEST usr/include/linux/virtio_input.h
.............+.........  HDRTEST usr/include/linux/rseq.h
...+...+..+.......+...  CC      kernel/sched/fair.o
..  HDRTEST usr/include/linux/veth.h
.....................+...  HDRTEST usr/include/linux/reboot.h
............+......+..  HDRTEST usr/include/linux/nsfs.h
..+..+....+..........  HDRTEST usr/include/linux/nfc.h
........+..+  CC      mm/kasan/report_generic.o
.+........  HDRTEST usr/include/linux/nfs4_mount.h
....+..+...............+...  HDRTEST usr/include/linux/nfsd/debug.h
.+.....+....+............+.  HDRTEST usr/include/linux/nfsd/cld.h
..+...+....................+  HDRTEST usr/include/linux/nfsd/stats.h
...............+...............+.  HDRTEST usr/include/linux/nfsd/export.h
......+............+.........+  HDRTEST usr/include/linux/utime.h
..+...+..........+..+  HDRTEST usr/include/linux/bt-bmc.h
.......+...+........+  HDRTEST usr/include/linux/oom.h
.+........+........  HDRTEST usr/include/linux/ioam6.h
.....+..+............+.  HDRTEST usr/include/linux/wmi.h
...............+........  HDRTEST usr/include/linux/gameport.h
....+......+++++++++++++  HDRTEST usr/include/linux/rxrpc.h
++++++++++++  HDRTEST usr/include/linux/surface_aggregator/dtx.h
+++++++++  HDRTEST usr/include/linux/surface_aggregator/cdev.h
+++++++++  HDRTEST usr/include/linux/if_link.h
++++++  CC      arch/arm64/kernel/fpsimd.o
++++  HDRTEST usr/include/linux/fib_rules.h
++++++++++  HDRTEST usr/include/linux/zorro.h
++
-----
ld.lld: error: undefined symbol: cpu_show_tsa
>>> referenced by cpu.c
>>>               drivers/base/cpu.o:(dev_attr_tsa) in archive vmlinux.a

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:686d49d034612746bbb51fb8

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:686d49cb34612746bbb51fb2


#kernelci issue maestro:6b1157158f4d95650fb3e4447503581fbc3320c8

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

