Return-Path: <stable+bounces-3659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3E800E76
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A88281AF6
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19384A99D;
	Fri,  1 Dec 2023 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i16rKcyX"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB49F1
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 07:20:40 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id A625E20B74C0;
	Fri,  1 Dec 2023 07:20:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A625E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701444039;
	bh=D/rZRpvfD4iS7KhhjO6V7zcvNWb6yYTrJYovFhcGDBI=;
	h=From:To:Cc:Subject:Date:From;
	b=i16rKcyXgil+7MbKxEGAdZCGPjIZ73gAwmnQM7J67VvX0ySuiR+rJ1MmHJuMBNO6y
	 ZD42eKxl786QIoeD8heWDAvFwo5AInt8zQVWb5hYaXZLe8h7HKfKpOhrq+yKegYx92
	 8ASuwNV8gebul2PfBClO4+e4WBIIigJHC4nokJ70=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 5.15.y v1 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date: Fri,  1 Dec 2023 16:19:55 +0100
Message-Id: <20231201151957.682381-1-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!


The second patch of this series caused some troubles on 5.15.y, I apologize
about it [1].
When I tested it locally, I needed to set CONFIG_LIVEPATCH, so
kallsyms_on_each_symbol() would be known at link time.
To cope with this problem, we need to backport the first patch of this series as
pointed by Guenter Roeck [2].
This patch is only needed for 5.15, indeed the dependencies on CONFIG_LIVEPATCH
for kallsyms_on_each_symbol() was added in 3e3552056ab4
("kallsyms: only build {,module_}kallsyms_on_each_symbol when required").
This commit was first added to kernel 5.12, as git indicates it:
$ git name-rev --tags --name-only 3e3552056ab4
v5.12-rc1~67^2~8
Moreover, the first patch of this series, i.e. d721def7392a
("kallsyms: Make kallsyms_on_each_symbol generally available") was first added
in:
$ git name-rev --tags --name-only d721def7392a
v5.19-rc1~159^2~4^2~38^2~4
So, my patch only needs the first patch for the 5.15 kernel.

Regarding these two patches, I built and tested the series for several
architectures:
* i386:
  $ make ARCH=i386 defconfig kvm_guest.config
  ...
  $ make ARCH=i386 -j$(nproc)
  ...
    Kernel: arch/x86/boot/bzImage is ready  (#1)
  $ bash run_extern_kernel.sh i386
  ...
  root@vm-i386:~# uname -mr
  5.15.140+ i686
  root@vm-i386:~# echo 'p:myprobe name_show' > /sys/kernel/tracing/kprobe_events
  -bash: echo: write error: Cannot assign requested address
* x86_64:
  $ make x86_64_defconfig kvm_guest.config
  ...
  $ make -j$(nproc)
  ...
    Kernel: arch/x86/boot/bzImage is ready  (#9)
  $ bash run_extern_kernel.sh
  ...
  root@vm-amd64:~# uname -rm
  5.15.140+ x86_64
  root@vm-amd64:~# echo 'p:myprobe name_show' > /sys/kernel/tracing/kprobe_events
  -bash: echo: write error: Cannot assign requested address
* arm:
  $ make ARCH=arm defconfig kvm_guest.config
  ...
  $ make ARCH=arm menuconfig
  # Add CONFIG_KPROBES
  $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j$(nproc)
  ...
    Kernel: arch/arm/boot/zImage is ready
  $ bash run_extern_kernel.sh armel
  ...
  root@vm-armel:~# uname -mr
  5.15.140-00002-gd3fdc3ca50b5 armv7l
  root@vm-armel:~# echo 'p:myprobe name_show' > /sys/kernel/tracing/kprobe_events
  -bash: echo: write error: Cannot assign requested address
* arm64:
  $ make ARCH=arm64 defconfig kvm_guest.config
  # Add CONFIG_KPROBES
  ...
  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
  ...
    OBJCOPY arch/arm64/boot/Image
    GZIP    arch/arm64/boot/Image.gz
  $ bash run_extern_kernel.sh arm64
  ...
  root@vm-arm64:~# uname -mr
  5.15.140-00002-gd3fdc3ca50b5 aarch64
  root@vm-arm64:~# echo 'p:myprobe name_show' > /sys/kernel/tracing/kprobe_events
  -bash: echo: write error: Cannot assign requested address

If you see any ways to improve this patch, please share your feedback.

Francis Laniel (1):
  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
    symbols

Jiri Olsa (1):
  kallsyms: Make kallsyms_on_each_symbol generally available

 include/linux/kallsyms.h    |  7 +++-
 kernel/kallsyms.c           |  2 -
 kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_probe.h  |  1 +
 4 files changed, 81 insertions(+), 3 deletions(-)


Best regards.
---
[1]: https://lore.kernel.org/stable/CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com/
[2]: https://lore.kernel.org/stable/06deae26-c59c-4746-867d-ab6f5852b0af@roeck-us.net/
--
2.34.1


