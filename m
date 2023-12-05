Return-Path: <stable+bounces-4755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09B805E33
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 19:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317731C21089
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E468B7C;
	Tue,  5 Dec 2023 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ADFcGdck"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F414EC0
	for <stable@vger.kernel.org>; Tue,  5 Dec 2023 10:58:16 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr [85.170.33.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7A91B20B74C0;
	Tue,  5 Dec 2023 10:58:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A91B20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1701802696;
	bh=1+fl0awipaZ/qBDcpX0GwgjVw/65KphubT8l7Plm/N8=;
	h=From:To:Cc:Subject:Date:From;
	b=ADFcGdckwyWI96L+h9ZX5JXiDO5C4jFiK3msXlVL25QnQpRy2s5Mnkg7jAxj7f7Fz
	 a/qWO067aOBq7/VqhhOmhuyv6dyxF+i3YQDgK3Ji1QSp4KEAxkl76cie34PeDAFF/a
	 g+wq4hwE7qH/eJY9eJryTI7AX/B/USHtpPnfx0uo=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>
Subject: [PATCH 5.15.y v2 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date: Tue,  5 Dec 2023 19:57:47 +0100
Message-Id: <20231205185749.130183-1-flaniel@linux.microsoft.com>
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
As a consequence, I was asked to build and test all the stable kernels with this
patch for several architectures [2].
I would nonetheless like to emphasize this is the first time I sent a patch to
the stable kernel and the problem is the result of lack of experience
(Do I need to change the config? Do I need to change the patch? Do I need to
find another patch solving the CONFIG_LIVEPATCH dependencies? were the type of
questions I had in mind before sending it) rather than a desire to harm.

Regarding the series, the first patch is only needed on kernel 5.15.
Indeed the dependencies on CONFIG_LIVEPATCH
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
Using this patch as a solution for mine was pointed by Guenter Roeck [3].

So, I decided to build and test the stable kernels with this patch for several
architectures.
Regarding building, I did so using the following script:
------------------------------------------
for release in 4.14 4.19 5.4 5.10 5.15; do
	git checkout "linux-${release}.y"

	for arch in $(tuxmake build -A -r docker); do
		outdir="$(git rev-parse --abbrev-ref HEAD)/${arch}"
		mkdir -p $outdir

		tuxmake -q -r docker -a $arch --kconfig-add kvm_guest.config --kconfig-add CONFIG_KPROBES=y -o $outdir
	done
done
------------------------------------------
Note that, the branches were prepared before running the script with the patch
applied.
I obtained the following, i.e. there were no build errors:
------------------------------------------
../stable:
linux-4.14.y  linux-4.19.y  linux-5.10.y  linux-5.15.y  linux-5.4.y
../stable/linux-4.14.y:
arc  arm  arm64  armv5  hexagon  i386  loongarch  m68k  mips  openrisc  parisc  powerpc  riscv  s390  sh  sparc  um  x86_64
../stable/linux-4.14.y/arc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-4.14.y/arm:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.14.y/arm64:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.14.y/armv5:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.14.y/hexagon:
../stable/linux-4.14.y/i386:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.14.y/loongarch:
../stable/linux-4.14.y/m68k:
../stable/linux-4.14.y/mips:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-4.14.y/openrisc:
../stable/linux-4.14.y/parisc:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.14.y/powerpc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.14.y/riscv:
build-debug.log  build.log  metadata.json
../stable/linux-4.14.y/s390:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz
../stable/linux-4.14.y/sh:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.14.y/sparc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.14.y/um:
build-debug.log  build.log  config  linux  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.14.y/x86_64:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y:
arc  arm  arm64  armv5  hexagon  i386  loongarch  m68k  mips  openrisc  parisc  powerpc  riscv  s390  sh  sparc  um  x86_64
../stable/linux-4.19.y/arc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-4.19.y/arm:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.19.y/arm64:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/armv5:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.19.y/hexagon:
../stable/linux-4.19.y/i386:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/loongarch:
../stable/linux-4.19.y/m68k:
../stable/linux-4.19.y/mips:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-4.19.y/openrisc:
../stable/linux-4.19.y/parisc:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/powerpc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.19.y/riscv:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/s390:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/sh:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.19.y/sparc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-4.19.y/um:
build-debug.log  build.log  config  linux  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-4.19.y/x86_64:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y:
arc  arm  arm64  armv5  hexagon  i386  loongarch  m68k  mips  openrisc  parisc  powerpc  riscv  s390  sh  sparc  um  x86_64
../stable/linux-5.10.y/arc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.10.y/arm:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.10.y/arm64:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/armv5:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.10.y/hexagon:
../stable/linux-5.10.y/i386:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/loongarch:
../stable/linux-5.10.y/m68k:
../stable/linux-5.10.y/mips:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.10.y/openrisc:
../stable/linux-5.10.y/parisc:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/powerpc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.10.y/riscv:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/s390:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/sh:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.10.y/sparc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.10.y/um:
build-debug.log  build.log  config  linux  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.10.y/x86_64:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y:
arc  arm  arm64  armv5  hexagon  i386  loongarch  m68k  mips  openrisc  parisc  powerpc  riscv  s390  sh  sparc  um  x86_64
../stable/linux-5.15.y/arc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.15.y/arm:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.15.y/arm64:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/armv5:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.15.y/hexagon:
../stable/linux-5.15.y/i386:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/loongarch:
../stable/linux-5.15.y/m68k:
../stable/linux-5.15.y/mips:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.15.y/openrisc:
../stable/linux-5.15.y/parisc:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/powerpc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.15.y/riscv:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/s390:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/sh:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.15.y/sparc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.15.y/um:
build-debug.log  build.log  config  linux  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.15.y/x86_64:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y:
arc  arm  arm64  armv5  hexagon  i386  loongarch  m68k  mips  openrisc  parisc  powerpc  riscv  s390  sh  sparc  um  x86_64
../stable/linux-5.4.y/arc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.4.y/arm:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.4.y/arm64:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/armv5:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.4.y/hexagon:
../stable/linux-5.4.y/i386:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/loongarch:
../stable/linux-5.4.y/m68k:

../stable/linux-5.4.y/mips:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  uImage.gz  vmlinux.xz
../stable/linux-5.4.y/openrisc:
../stable/linux-5.4.y/parisc:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/powerpc:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.4.y/riscv:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  Image.gz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/s390:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/sh:
build-debug.log  build.log  config  dtbs.tar.xz  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.4.y/sparc:
build-debug.log  build.log  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz  zImage
../stable/linux-5.4.y/um:
build-debug.log  build.log  config  linux  metadata.json  modules.tar.xz  System.map  vmlinux.xz
../stable/linux-5.4.y/x86_64:
build-debug.log  build.log  bzImage  config  headers.tar.xz  metadata.json  modules.tar.xz  System.map  vmlinux.xz
------------------------------------------
Some directories, like hexagon, are empty. This is perfectly normal as there is
no gcc toolchain for these architectures.

Regarding testing, I only tested for arm and x86_64 for several reasons:
1. My script supports a few architectures (e.g. sparc is not supported) [4].
2. Some of the supported architecture does not handle correctly ssh (I still
need to polish this).
3. For arm64, I did not have the /sys/kernel/tracing available despite having
CONFIG_KPROBES. I may have forgotten a CONFIG_ for this kernel, thus I did not
test it.
The following script was used to test:
------------------------------------------
declare -A kernel_arches=( ['armel']='arm' ['amd64']='x86_64')
declare -A kernel_images=( ['armel']='zImage' ['amd64']='bzImage')

for release in 4.14 4.19 5.4 5.10 5.15; do
	for qemu_arch in "${!kernel_arches[@]}"; do
		kernel_arch=${kernel_arches[${qemu_arch}]}

		kernel_image=${kernel_images[${qemu_arch}]}

		bash run_extern_kernel.sh $qemu_arch ../stable/linux-${release}.y/$kernel_arch/$kernel_image

		sleep 30

		ssh -p 10022 root@localhost uname -mr
		ssh -p 10022 root@localhost bash -c "echo 'p:myprobe name_show' > /sys/kernel/tracing/kprobe_events"
		ssh -p 10022 root@localhost poweroff

		sleep 30
	done
done
------------------------------------------
And it gave the corresponding output, which proves everything works as expected:
------------------------------------------
4.14.331-00002-g7aa12df051fa armv7l
bash: line 1: echo: write error: Cannot assign requested address
4.14.331+ x86_64
bash: line 1: echo: write error: Cannot assign requested address
4.19.300-00001-g7cac16479cd7 armv7l
bash: line 1: echo: write error: Cannot assign requested address
4.19.300+ x86_64
bash: line 1: echo: write error: Cannot assign requested address
5.4.262-00001-g74ca00e4af8f armv7l
bash: line 1: echo: write error: Cannot assign requested address
5.4.262+ x86_64
bash: line 1: echo: write error: Cannot assign requested address
5.10.202-00001-gfff8e5c3be26 armv7l
bash: line 1: echo: write error: Cannot assign requested address
5.10.202+ x86_64
bash: line 1: echo: write error: Cannot assign requested address
5.15.141-00002-gfe40e56ab1f0 armv7l
bash: line 1: echo: write error: Cannot assign requested address
5.15.141+ x86_64
bash: line 1: echo: write error: Cannot assign requested address
------------------------------------------

I hope the proof given here would lead this patch to be merged in the stable
kernel.
If this is not enough, I will do my best to provide more.

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


Best regards and thank you in advance.
---
[1]: https://lore.kernel.org/stable/CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com/
[2]: https://lore.kernel.org/stable/2023120533-washtub-data-f661@gregkh/
[3]: https://lore.kernel.org/stable/06deae26-c59c-4746-867d-ab6f5852b0af@roeck-us.net/
[4]: https://gitlab.com/eiffel/qemu-scripts
--
2.34.1


