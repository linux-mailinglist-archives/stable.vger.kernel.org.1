Return-Path: <stable+bounces-6641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C8811E09
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 20:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA4F282C23
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BC67B65;
	Wed, 13 Dec 2023 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bLqc3MZK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB267B60
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 19:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760CAC43391;
	Wed, 13 Dec 2023 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702494344;
	bh=r89+7htyHkX5d01hxevZpYpK1vGj/49NDc8UGc0+0q0=;
	h=From:To:Cc:Subject:Date:From;
	b=bLqc3MZKwj49EYo705QpdWII1KDl9YTP/VRTKXkpYYTtEzbsfFr5ndBY4IfqqPEt0
	 CjSKyvKwklTxtvoWdmbDfCAZhQDx1jxHy7NKpYgsjmVmwxbR5ItsXr6t/iErtBhmTb
	 anqoKMVELVovtbnwOsfXDNZbWpb+pRt0EUZNpARg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.14.333
Date: Wed, 13 Dec 2023 20:05:39 +0100
Message-ID: <2023121339-scrunch-puppy-042f@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.14.333 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 -
 arch/s390/mm/pgtable.c                            |    2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |    2 -
 drivers/hwmon/acpi_power_meter.c                  |    4 ++
 drivers/infiniband/hw/bnxt_re/main.c              |    2 -
 drivers/net/ethernet/broadcom/tg3.c               |   42 ++++++++++++++++++----
 drivers/net/ethernet/broadcom/tg3.h               |    4 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |   29 +++++++++++++++
 drivers/parport/parport_pc.c                      |   21 +++++++++++
 drivers/scsi/be2iscsi/be_main.c                   |    1 
 drivers/tty/serial/8250/8250_early.c              |    1 
 drivers/tty/serial/sc16is7xx.c                    |   12 ++++++
 fs/nilfs2/sufile.c                                |   42 ++++++++++++++++++----
 fs/nilfs2/the_nilfs.c                             |    6 ++-
 include/net/genetlink.h                           |    3 +
 kernel/trace/trace.c                              |   38 +++++++++----------
 net/core/drop_monitor.c                           |    4 +-
 net/ipv4/tcp_input.c                              |    6 ++-
 net/netlink/af_netlink.c                          |    4 +-
 net/netlink/genetlink.c                           |   35 ++++++++++++++++++
 net/packet/af_packet.c                            |   16 ++++----
 net/packet/internal.h                             |    2 -
 net/psample/psample.c                             |    3 +
 sound/core/pcm.c                                  |    1 
 24 files changed, 228 insertions(+), 54 deletions(-)

Alex Pakhunov (2):
      tg3: Move the [rt]x_dropped counters to tg3_napi
      tg3: Increment tx_dropped in tg3_tso_bug()

Armin Wolf (1):
      hwmon: (acpi_power_meter) Fix 4.29 MW bug

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Claudio Imbrenda (1):
      KVM: s390/mm: Properly reset no-dat

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Dinghao Liu (1):
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()

Eric Dumazet (1):
      tcp: do not accept ACK of bytes we never sent

Greg Kroah-Hartman (1):
      Linux 4.14.333

Ido Schimmel (4):
      netlink: don't call ->netlink_bind with table lock held
      genetlink: add CAP_NET_ADMIN test for multicast bind
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Petr Pavlu (3):
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a possible race when disabling buffered events

Ronald Wahl (1):
      serial: 8250_omap: Add earlycon support for the AM654 UART controller

Ryusuke Konishi (2):
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()
      nilfs2: fix missing error check for sb_set_blocksize call

Steven Rostedt (Google) (1):
      tracing: Always update snapshot buffer size

Yonglong Liu (1):
      net: hns: fix fake link up on xge port

YuanShang (1):
      drm/amdgpu: correct chunk_ptr to a pointer to chunk.


