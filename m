Return-Path: <stable+bounces-169377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69444B2495D
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE5C1BC54C9
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B9187332;
	Wed, 13 Aug 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MU03yWID"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243B126C1E
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087404; cv=none; b=KEDrMOLroW0PGr1f5wv/R4vYxwalgp1Njc+aomyuA79ZSD4tv4PipbVEAXVWeXh/mnqRYjcdrzwmwN/oU1Gh87R6xPkZ995q84B7FzRYikBPVQaG4VMaKuxGk7+QUmkh/0AFh7g+V7i9AsmPMV7rSJev/EuWXvj8WjXypRHuG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087404; c=relaxed/simple;
	bh=5/qgc59oD8soUgBaYKa9gXVnBOWyFLGpMZ+wpMO2kD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzPxwbU3k8B91Z45EYQZTRwCG5TgfV//a63krFygJk++mCT3/f2bYGh2pQh8aKgsXqg/4Gzu0dh6cXbqa+JWkHxjSzPFpwBYxezMjxGgQpKvkxGqSuS6TUhk2ZsTRsomc/hvo9bNWZP+WxrGkCImiWoh9LUvdbw+YqDdHAtpwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MU03yWID; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso5602438b3a.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755087400; x=1755692200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbnSBztKB/ky+HfHfoiCEKZibcC+VHhc0U9rmRsC39Q=;
        b=MU03yWIDeYtVHuUc80o9ZFdzCVZquy0SEmXRHmdB2xt7uom0jDg38ofZnTiGWD+xIV
         AyDe9bJjxYpsCnbGTM5hnUkuUTVGTeJKtPHoyTgdWZdR5vqftDElzqG0kXAJn5DG1q+z
         vQjPGJtBiAEAl8S3rViySW9d2Pp1s/8eWVx3FoacAVHBJM4p6RFCxkGWygbJzHPyqgT9
         3KGKbGG8UQzWvingJwXKJMu4BwflIB9b3D5fIWchC3Y0mNZNYakt1kJXAd8FWdyzMApS
         6b74hmY/9o+SMkhQJ5HE8/+iAltRy6GECe6Aj1iweM6PzC7ndR2seO0F1r4bEG/gMCT9
         ml2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755087400; x=1755692200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbnSBztKB/ky+HfHfoiCEKZibcC+VHhc0U9rmRsC39Q=;
        b=DIdgngUdjYJBnMQ/zv/E9TyhGbMXjJj+AjUQjL9/o/HkmV6OkbXIo0J9gp9xHwJ2nF
         oi850gYU2cF62PB8beCaq+LWWyAuJU1VLMaZqZKxDwHAC2ttlwaZ885r6Bt/zRl7SyHT
         kaOoEdyvHTJBlPEsv6IIOxCGryhx8k25O7BKuQIqZ3qGNthMrGUhPbQ+LdpwV8/J1VO5
         9ovcZJGxgoXUy5gGQq3CdatnEQq9toERhfrLl/TDGOydj8h61/9J1B+wsbt1/j3TagzC
         nFabx2TT5FxBpiDfeLwaPtEUzmuQlGr2pDY+uYQKl2941znLLTIbSI5IKkeQdq6Ci08u
         hkxA==
X-Gm-Message-State: AOJu0YyUWwTUoxUpJwqxO52fVM3EHcocMO1FeyzOo8TkCpW2fyfme4Bg
	JEQMMGsvck+HUjqNjygwHRy+4g2Q8/bVCE6NUosW15kDzhtNQ1VRWhdmF+AyS7Cek0ZbxI1Fo7+
	6PUCa/9PQL81WfmoKbMljnZPL6p5ohZs9y2qIpJF54w==
X-Gm-Gg: ASbGncvOobHwEryRp3R05evilLYg7TTN/GgVaDna08usf4dK2gpaKvkor223nEgyp0H
	gS27Elo4kyVOu5Hhh9kzDcD4TZmq5OuDOrp4qKuxBnYpBOeUk2Z6pfKxQpRQ7Jo6eyQJ55D4H15
	Kk+yVKnjnQby6xoHdyJ4UH45V31dDYZBx7qUHXyOcZGdSSqfvaK8ajA2qki1ilaST7Lh8mr96Oi
	gJ9XPWSUBmqMDJla7qZWp0z7i6OPWb1YmhTdA1P3pjVxmRN1z4=
X-Google-Smtp-Source: AGHT+IEqRlX1hXQvIAC8z4ap56R3F6zBfHl+FK5wqB5WBXqk2utT/Iy+dcR7aD5xv5GmvhMOoS30o/Rmi8/TkNbCz1I=
X-Received: by 2002:a17:902:fc47:b0:242:a0b0:3c28 with SMTP id
 d9443c01a7336-2430d262dd1mr40863255ad.51.1755087400321; Wed, 13 Aug 2025
 05:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 17:46:26 +0530
X-Gm-Features: Ac12FXybqNMQTflDlQz__4h-ypQooKNx0q_GNsw0wCT1xS6QPkD-sG6dIOKmaWc
Message-ID: <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

LKFT found three regressions on stable-rc 6.16.1-rc1.

Short version:
1) Pef build regressions on x86_64 and i386
2) LTP syscalls failures with 64k Page size on qemu-arm64
3) Kernel warning at fs/jbd2/transaction.c start_this_handle x86, qemu-arm64

Long story:
1)
The perf gcc-13 build failed on x86_64 and i386.

Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
fallocate failed.

> Ian Rogers <irogers@google.com>
>     perf topdown: Use attribute to see an event is a topdown metic or slots

Build error:

arch/x86/tests/topdown.c: In function 'event_cb':
arch/x86/tests/topdown.c:53:25: error: implicit declaration of
function 'pr_debug' [-Werror=implicit-function-declaration]
   53 |                         pr_debug("Broken topdown information
for '%s'\n", evsel__name(evsel));
      |                         ^~~~~~~~
cc1: all warnings being treated as errors

2)

The following list of LTP syscalls failure noticed on qemu-arm64 with
stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.

Most failures report ENOSPC (28) or mkswap errors, which may be related
to disk space handling in the 64K page configuration on qemu-arm64.

The issue is reproducible on multiple runs.

* qemu-arm64, ltp-syscalls - 64K page size test failures list,

  - fallocate04
  - fallocate05
  - fdatasync03
  - fsync01
  - fsync04
  - ioctl_fiemap01
  - swapoff01
  - swapoff02
  - swapon01
  - swapon02
  - swapon03
  - sync01
  - sync_file_range02
  - syncfs01

Reproducibility:
 - 64K config above listed test fails
 - 4K config above listed test pass.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
fallocate failed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

swapoff01:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapoff01.c:44: TINFO: create a swapfile with 65536 block numbers
swapoff01.c:44: TCONF: Insufficient disk space to create swap file

swapoff02:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapoff02.c:88: TINFO: create a swapfile size of 1 megabytes (MB)

swapon01:
libswap.c:198: TINFO: create a swapfile size of 1 megabytes (MB)
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapon01.c:39: TINFO: create a swapfile size of 128 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

swapon02:
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
swapon02.c:52: TINFO: create a swapfile size of 1 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

swapon03:
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
libswap.c:218: TFAIL: mkswap on ext2/ext3/ext4 failed
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
swapon03.c:51: TINFO: create a swapfile size of 1 megabytes (MB)
tst_cmd.c:111: TBROK: 'mkswap' exited with a non-zero code 1 at tst_cmd.c:111

sync01:
sync01.c:49: TFAIL: Synced 11403264, expected 33554432

syncfs01:
syncfs01.c:53: TFAIL: Synced 4096, expected 33554432

sync_file_range02:
sync_file_range02.c:60: TFAIL: sync_file_range() failed: ENOSPC (28)

fdatasync03:
fdatasync03.c:43: TFAIL: fdatasync(fd) failed: ENOSPC (28)

fsync01:
tst_test.c:1888: TINFO: === Testing on ext4 ===
tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fsyX4HNML/mntpoint fstyp=ext4 flags=0
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)
fsync01.c:28: TFAIL: fsync failed: ENOSPC (28)

fsync04:
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_fsydyQA53/mnt_point fstyp=ext4 flags=0
fsync04.c:43: TFAIL: fsync(fd) failed: ENOSPC (28)

fallocate04:
fallocate04.c:198: TFAIL: fallocate failed: ENOSPC (28)

fallocate05:
tst_fill_fs.c:53: TBROK: fsync(4) failed: ENOSPC (28)

ioctl_fiemap01
tst_test.c:1217: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.47.2 (1-Jan-2025)
tst_test.c:1229: TINFO: Mounting /dev/loop0 to
/tmp/LTP_iocjRR3ot/mntpoint fstyp=ext4 flags=0
ioctl_fiemap01.c:74: TPASS: ioctl(fd, FS_IOC_FIEMAP, fiemap) : EBADR (53)
ioctl_fiemap01.c:77: TPASS: ioctl(fd, FS_IOC_FIEMAP, fiemap) passed
ioctl_fiemap01.c:79: TPASS: Expect: Empty file should have 0 extends mapped
ioctl_fiemap01.c:86: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: ENOSPC (28)
ioctl_fiemap01.c:41: TFAIL: Expect: extent fm_mapped_extents is 1
ioctl_fiemap01.c:50: TFAIL: (extent->fe_flags & fe_mask) (0) != fe_flags (1)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (4702687395951105107) !=
fe_length (1024)
ioctl_fiemap01.c:96: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: ENOSPC (28)
ioctl_fiemap01.c:41: TFAIL: Expect: extent fm_mapped_extents is 3
ioctl_fiemap01.c:50: TPASS: (extent->fe_flags & fe_mask) == fe_flags (0)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (4702687395951105107) !=
fe_length (1024)
ioctl_fiemap01.c:50: TPASS: (extent->fe_flags & fe_mask) == fe_flags (0)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (5136714152143953955) !=
fe_length (1024)
ioctl_fiemap01.c:50: TFAIL: (extent->fe_flags & fe_mask) (0) != fe_flags (1)
ioctl_fiemap01.c:51: TPASS: Expect: fe_physical > 1
ioctl_fiemap01.c:52: TFAIL: extent->fe_length (8387236464277024288) !=
fe_length (1024)


Links,
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470720/suite/ltp-syscalls/tests/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/test/sync01/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470720/suite/ltp-syscalls/test/fdatasync03/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29470711/suite/ltp-syscalls/test/swapon01/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.16.y/build/v6.16-628-gcd8771110407/testrun/29471488/suite/ltp-syscalls/tests/


3)

Test regression: stable-rc 6.16.1-rc1 WARNING fs jbd2 transaction.c
start_this_handle

Kernel warning noticed on this stable-rc 6.16.1-rc1 this regression was
reported last month on the Linux next,

- https://lore.kernel.org/all/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/

Kernel warnings:

------------[ cut here ]------------
[   34.805150] WARNING: CPU: 1 PID: 627 at fs/jbd2/transaction.c:334
start_this_handle (fs/jbd2/transaction.c:334 (discriminator 1))
[   34.807683] Modules linked in: btrfs blake2b_generic xor xor_neon
raid6_pq zstd_compress sm3_ce sha3_ce sha512_ce fuse drm backlight
ip_tables x_tables
[   34.809152] CPU: 1 UID: 0 PID: 627 Comm: io_control01 Not tainted
6.16.1-rc1 #1 PREEMPT
[   34.809652] Hardware name: linux,dummy-virt (DT)
[   34.809961] pstate: 63402009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   34.810205] pc : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
[   34.810395] lr : start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1))
[   34.810798] sp : ffff800080e2f7e0
[   34.810962] x29: ffff800080e2f820 x28: fff00000c4b43000 x27: ffffa9c145dca000
[   34.811259] x26: 0000000000000658 x25: 0000000000000629 x24: 0000000000000002
[   34.811507] x23: 0000000000000629 x22: 0000000000000c40 x21: 0000000000000008
[   34.811750] x20: fff00000d0800348 x19: fff00000d0800348 x18: 0000000000000000
[   34.811992] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   34.812234] x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000000000
[   34.812858] x11: 0000000000000000 x10: ffffa9c1456a8c08 x9 : ffffa9c142b54b84
[   34.813572] x8 : ffff800080e2f408 x7 : 0000000000000000 x6 : 0000000000000001
[   34.814462] x5 : ffffa9c145629000 x4 : ffffa9c1456293d0 x3 : 0000000000000000
[   34.815093] x2 : 0000000000000000 x1 : fff00000c4fd0000 x0 : 0000000000000050
[   34.815812] Call trace:
[   34.816213] start_this_handle (fs/jbd2/transaction.c:334
(discriminator 1)) (P)
[   34.816719] jbd2__journal_start (fs/jbd2/transaction.c:501)
[   34.817124] __ext4_journal_start_sb (fs/ext4/ext4_jbd2.c:117)
[   34.817687] ext4_do_writepages (fs/ext4/ext4_jbd2.h:242 fs/ext4/inode.c:2847)
[   34.818109] ext4_writepages (fs/ext4/inode.c:2954)
[   34.818549] do_writepages (mm/page-writeback.c:2636)
[   34.818983] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
[   34.819520] __filemap_fdatawrite_range (mm/filemap.c:420)
[   34.819942] file_write_and_wait_range (mm/filemap.c:794)
[   34.820349] ext4_sync_file (fs/ext4/fsync.c:154)
[   34.820486] vfs_fsync_range (fs/sync.c:188)
[   34.820624] do_fsync (fs/sync.c:201 fs/sync.c:212)
[   34.820743] __arm64_sys_fsync (fs/sync.c:215)
[   34.820882] invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
[   34.821046] do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
[   34.821172] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:165 (discriminator 1)
arch/arm64/kernel/entry-common.c:178 (discriminator 1)
arch/arm64/kernel/entry-common.c:768 (discriminator 1))
[   34.821307] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:787)
[   34.821460] el0t_64_sync (arch/arm64/kernel/entry.S:600)
[   34.821712] ---[ end trace 0000000000000000 ]---

Link:
 -  https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.16.y/v6.16-628-gcd8771110407/log-parser-test/exception-warning-cpu-pid-at-fsjbd2transaction-start_this_handle/

--
Linaro LKFT
https://lkft.linaro.org

