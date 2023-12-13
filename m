Return-Path: <stable+bounces-6443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA780EB39
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264181F21C92
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98F5DF3C;
	Tue, 12 Dec 2023 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ysL421X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED4D5DF30;
	Tue, 12 Dec 2023 12:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED45EC433C8;
	Tue, 12 Dec 2023 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702382706;
	bh=ESTzSJJ7/rLv2BGu31Y5Yc3pLMcmjSxqifZVMoG9XBo=;
	h=From:To:Cc:Subject:Date:From;
	b=0ysL421XgG5CQ8mWXoUqy//av9LgvM0W51b6XYlcI7xo8LSzrrYeZSQgu+EAmSc3k
	 sSLxmpTclb77rcwZqYwoBLEtzqcPjpC7LX6cGasIDkav2xuxktb24/U845tZisPnHO
	 pUtytssks0wbBKvBDyW+mz4IsLKnAYcK9sjXKDgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 4.14 00/24] 4.14.333-rc2 review
Date: Tue, 12 Dec 2023 13:05:03 +0100
Message-ID: <20231212120146.831816822@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.333-rc2
X-KernelTest-Deadline: 2023-12-14T12:01+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.14.333 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.333-rc2

Ido Schimmel <idosch@nvidia.com>
    drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ido Schimmel <idosch@nvidia.com>
    psample: Require 'CAP_NET_ADMIN' when joining "packets" group

Ido Schimmel <idosch@nvidia.com>
    genetlink: add CAP_NET_ADMIN test for multicast bind

Ido Schimmel <idosch@nvidia.com>
    netlink: don't call ->netlink_bind with table lock held

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix missing error check for sb_set_blocksize call

Claudio Imbrenda <imbrenda@linux.ibm.com>
    KVM: s390/mm: Properly reset no-dat

Ronald Wahl <ronald.wahl@raritan.com>
    serial: 8250_omap: Add earlycon support for the AM654 UART controller

Daniel Mack <daniel@zonque.org>
    serial: sc16is7xx: address RX timeout interrupt errata

Cameron Williams <cang1@live.co.uk>
    parport: Add support for Brainboxes IX/UC/PX parallel cards

Daniel Borkmann <daniel@iogearbox.net>
    packet: Move reference count in packet_sock to atomic_long_t

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a possible race when disabling buffered events

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix incomplete locking when disabling buffered events

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Always update snapshot buffer size

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Jason Zhang <jason.zhang@rock-chips.com>
    ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Dinghao Liu <dinghao.liu@zju.edu.cn>
    scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Fix a warning when allocating buffered events fails

Armin Wolf <W_Armin@gmx.de>
    hwmon: (acpi_power_meter) Fix 4.29 MW bug

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Correct module description string

Eric Dumazet <edumazet@google.com>
    tcp: do not accept ACK of bytes we never sent

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: fix fake link up on xge port

YuanShang <YuanShang.Mao@amd.com>
    drm/amdgpu: correct chunk_ptr to a pointer to chunk.

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Increment tx_dropped in tg3_tso_bug()

Alex Pakhunov <alexey.pakhunov@spacex.com>
    tg3: Move the [rt]x_dropped counters to tg3_napi


-------------

Diffstat:

 Makefile                                          |  4 +--
 arch/s390/mm/pgtable.c                            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/hwmon/acpi_power_meter.c                  |  4 +++
 drivers/infiniband/hw/bnxt_re/main.c              |  2 +-
 drivers/net/ethernet/broadcom/tg3.c               | 42 ++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h               |  4 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 29 +++++++++++++++
 drivers/parport/parport_pc.c                      | 21 +++++++++++
 drivers/scsi/be2iscsi/be_main.c                   |  1 +
 drivers/tty/serial/8250/8250_early.c              |  1 +
 drivers/tty/serial/sc16is7xx.c                    | 12 +++++++
 fs/nilfs2/sufile.c                                | 44 ++++++++++++++++++-----
 fs/nilfs2/the_nilfs.c                             |  6 +++-
 include/net/genetlink.h                           |  3 ++
 kernel/trace/trace.c                              | 42 +++++++++++-----------
 net/core/drop_monitor.c                           |  4 ++-
 net/ipv4/tcp_input.c                              |  6 +++-
 net/netlink/af_netlink.c                          |  4 +--
 net/netlink/genetlink.c                           | 35 ++++++++++++++++++
 net/packet/af_packet.c                            | 16 ++++-----
 net/packet/internal.h                             |  2 +-
 net/psample/psample.c                             |  3 +-
 sound/core/pcm.c                                  |  1 +
 24 files changed, 232 insertions(+), 58 deletions(-)



