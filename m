Return-Path: <stable+bounces-69447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8F956278
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD01C214D9
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB815278E;
	Mon, 19 Aug 2024 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWiqtsm4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F455150996;
	Mon, 19 Aug 2024 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040805; cv=none; b=n58v5LXywDb2W1KMqFPgcdD/QiDw6iLbTO+mTtmYhNEZtQ1Ee8rjZzlHfUrfRskSBzgNsoiFLjVs9IKW8sMOMK8t/7lq+N23hCy6YL7sD15JeYHSzYEEe3G1XA4IEHg6XZPOnEwzzfmzID4aTlFF12uiGe9wbVhRSk5E/FD/29o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040805; c=relaxed/simple;
	bh=bufCGpF0tavvVmmIRPzlEHT2vlydoMS4G2lbjIISYtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOIxesmrUam0NDTm2bY6HZNVexADVoIoknWgFCTyhPEmXYzPCZTWWo2q6eeazNdKOT9JOS+o4J/38m04Sap3uzQ6Ujf4AI5JjEvrPpjF5s0TnsMg9pvawAn05iXba4rQNmusIzfVu1AXd9PZOjhUEi7Ba1u7eTj9ATbkDv4hK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWiqtsm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75143C4AF0C;
	Mon, 19 Aug 2024 04:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040804;
	bh=bufCGpF0tavvVmmIRPzlEHT2vlydoMS4G2lbjIISYtg=;
	h=From:To:Cc:Subject:Date:From;
	b=zWiqtsm4YiXy/oGqoOYBaqB9Uxr5Bsfu3fLBDN3CpOVi77ox2TcBivGGyZKG8CrYM
	 246RifphkKvm2WL464Z0VyJlbHrXKKnWuizlazGr7EXQUO8RCwy5XxDoGLn84eadYk
	 Fv/bRQ0FNlik2MB68DCrgRkTiiVXtXL70fpzMzMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.6
Date: Mon, 19 Aug 2024 06:13:14 +0200
Message-ID: <2024081914-curable-gladly-6d01@gregkh>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.6 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                    |    2 
 arch/loongarch/include/uapi/asm/unistd.h                    |    1 
 drivers/ata/libata-scsi.c                                   |   15 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   14 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |  232 ++++--------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c     |    6 
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c             |   90 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h                  |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c     |    2 
 drivers/media/usb/dvb-usb/dvb-usb-init.c                    |   35 -
 drivers/nvme/host/pci.c                                     |    7 
 drivers/platform/x86/Kconfig                                |    1 
 drivers/platform/x86/amd/pmf/spc.c                          |   32 -
 drivers/platform/x86/ideapad-laptop.c                       |  148 ++++++-
 drivers/platform/x86/ideapad-laptop.h                       |    9 
 drivers/platform/x86/lenovo-ymc.c                           |   60 ---
 fs/binfmt_flat.c                                            |    4 
 fs/exec.c                                                   |    8 
 fs/f2fs/extent_cache.c                                      |   48 --
 fs/f2fs/f2fs.h                                              |    2 
 fs/f2fs/gc.c                                                |   10 
 fs/f2fs/inode.c                                             |   10 
 fs/jfs/jfs_dmap.c                                           |    2 
 fs/jfs/jfs_dtree.c                                          |    2 
 fs/ntfs3/frecord.c                                          |   75 +++
 net/core/filter.c                                           |    8 
 net/ipv4/fou_core.c                                         |    2 
 sound/soc/codecs/cs35l56-shared.c                           |    1 
 sound/usb/mixer.c                                           |    7 
 29 files changed, 486 insertions(+), 355 deletions(-)

Chao Yu (2):
      f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC
      f2fs: fix to cover read extent cache access with lock

Edward Adam Davis (1):
      jfs: fix null ptr deref in dtInsertEntry

Fangzhi Zuo (1):
      drm/amd/display: Prevent IPX From Link Detect and Set Mode

Gergo Koteles (3):
      platform/x86: ideapad-laptop: introduce a generic notification chain
      platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
      platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands

Greg Kroah-Hartman (2):
      Revert "drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()"
      Linux 6.10.6

Harry Wentland (1):
      drm/amd/display: Separate setting and programming of cursor

Huacai Chen (1):
      LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h

Kees Cook (2):
      exec: Fix ToCToU between perm check and set-uid/gid usage
      binfmt_flat: Fix corruption when not offsetting data start

Konstantin Komarov (1):
      fs/ntfs3: Do copy_to_user out of run_lock

Niklas Cassel (1):
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error"

Pei Li (1):
      jfs: Fix shift-out-of-bounds in dbDiscardAG

Sean Young (1):
      media: Revert "media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()"

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Fix to Update HPD Data When ALS is Disabled

Simon Trimmer (1):
      ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value

Srinivasan Shanmugam (1):
      drm/amdgpu/display: Fix null pointer dereference in dc_stream_program_cursor_position

Takashi Iwai (1):
      ALSA: usb: Fix UBSAN warning in parse_audio_unit()

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

Wayne Lin (2):
      drm/amd/display: Defer handling mst up request in resume
      drm/amd/display: Solve mst monitors blank out problem after resume

Willem de Bruijn (1):
      fou: remove warn in gue_gro_receive on unsupported protocol

yunshui (1):
      bpf, net: Use DEV_STAT_INC()


