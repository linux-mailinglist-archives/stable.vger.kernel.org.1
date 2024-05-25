Return-Path: <stable+bounces-46139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C808CEF73
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAC28195C
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090E59161;
	Sat, 25 May 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aupvpf59"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD45914C;
	Sat, 25 May 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648664; cv=none; b=qKZg3j677JMitEF7a4P/fMkCQux017vHAzNRx0X6/wlL+IUf772uzQYQ7VBDg5HFtrVQFFKU51tPCGwRs8xRkNjpU2xSSga3wSYJlF9aOjXGUuNa75Sm5oX7hDcTAIPDBtp/vKxL3S20Gz0eUC2X3ZBiHF3gbyO+CuaAzMBHT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648664; c=relaxed/simple;
	bh=ozwkNb/Iz4Z0DrFrug3+849GYXwaSL0X1nIC0TGk7PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDVEEDlbHzqu+ZviVwq5Z3S9LL7LzqWaFrpIPGH+brTh3gpViI6NmbUo3BZqyENmDKNrgxEcnIQNR4GXiRvuKQKcuSZiYn/KXtrr4PUjD+4FVo3hzpLgZOoFFI+bOLBpUi7TXMW2H5e5/PPf9DN7WIz9klGL7y5IH3OX8gG6ZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aupvpf59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3121C2BD11;
	Sat, 25 May 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648664;
	bh=ozwkNb/Iz4Z0DrFrug3+849GYXwaSL0X1nIC0TGk7PI=;
	h=From:To:Cc:Subject:Date:From;
	b=aupvpf59qo6bhnkgpeNsh0oSI+qeDPEpmu2SUa2gL+dBwGHZGrXXMxaq3t2qvVKTZ
	 EEeMnHZrgNDJh0KG54XUHlAH4sQBHSzUaNHmFhISTimsuRAqoV7u/39V/sy9WlGw2Z
	 NX67ZgcEldWkS2kcVRclRzGn6DGlsIB7wcXta8Gw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.92
Date: Sat, 25 May 2024 16:50:59 +0200
Message-ID: <2024052500-padding-limpness-7136@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.92 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 
 Documentation/sphinx/kernel_include.py                |    1 
 Makefile                                              |    2 
 arch/arm64/Kconfig                                    |    1 
 arch/arm64/include/asm/lse.h                          |    1 
 drivers/android/binder.c                              |    2 
 drivers/android/binder_internal.h                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c               |    3 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c           |    7 
 drivers/mfd/stpmic1.c                                 |    5 
 drivers/mmc/core/mmc.c                                |    9 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c         |   22 -
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c    |    3 
 drivers/net/ethernet/micrel/ks8851_common.c           |   18 -
 drivers/net/usb/ax88179_178a.c                        |   37 +-
 drivers/pinctrl/core.c                                |   14 
 drivers/remoteproc/mtk_scp.c                          |   10 
 drivers/tty/serial/kgdboc.c                           |   30 ++
 drivers/usb/dwc3/gadget.c                             |    4 
 drivers/usb/typec/tipd/core.c                         |   45 ++-
 drivers/usb/typec/tipd/tps6598x.h                     |   11 
 drivers/usb/typec/ucsi/displayport.c                  |    4 
 fs/iomap/buffered-io.c                                |  254 +++++++++++++++++-
 fs/iomap/iter.c                                       |   19 +
 fs/nfs/callback.c                                     |    9 
 fs/nfsd/nfs4proc.c                                    |    5 
 fs/nfsd/nfssvc.c                                      |   12 
 fs/xfs/libxfs/xfs_bmap.c                              |    8 
 fs/xfs/libxfs/xfs_errortag.h                          |   12 
 fs/xfs/libxfs/xfs_refcount.c                          |  146 +++++++++-
 fs/xfs/libxfs/xfs_sb.c                                |    7 
 fs/xfs/xfs_aops.c                                     |   37 +-
 fs/xfs/xfs_bmap_util.c                                |   10 
 fs/xfs/xfs_bmap_util.h                                |    2 
 fs/xfs/xfs_buf.c                                      |    1 
 fs/xfs/xfs_buf_item.c                                 |    2 
 fs/xfs/xfs_error.c                                    |   27 +
 fs/xfs/xfs_file.c                                     |    2 
 fs/xfs/xfs_fsops.c                                    |    4 
 fs/xfs/xfs_icache.c                                   |    6 
 fs/xfs/xfs_inode.c                                    |   16 -
 fs/xfs/xfs_ioctl.c                                    |    4 
 fs/xfs/xfs_iomap.c                                    |  177 +++++++-----
 fs/xfs/xfs_iomap.h                                    |    6 
 fs/xfs/xfs_log.c                                      |   53 +--
 fs/xfs/xfs_mount.c                                    |   15 +
 fs/xfs/xfs_pnfs.c                                     |    6 
 include/linux/iomap.h                                 |   47 ++-
 net/sunrpc/svc_xprt.c                                 |   16 -
 security/keys/trusted-keys/trusted_tpm2.c             |   25 +
 50 files changed, 865 insertions(+), 298 deletions(-)

Aidan MacDonald (1):
      mfd: stpmic1: Fix swapped mask/unmask in irq chip

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

Darrick J. Wong (8):
      xfs: fix incorrect error-out in xfs_remove
      xfs: invalidate block device page cache during unmount
      xfs: attach dquots to inode before reading data/cow fork mappings
      xfs: hoist refcount record merge predicates
      xfs: estimate post-merge refcounts correctly
      xfs: invalidate xfs_bufs when allocating cow extents
      xfs: allow inode inactivation during a ro mount log recovery
      xfs: fix log recovery when unknown rocompat bits are set

Dave Chinner (10):
      xfs: write page faults in iomap are not buffered writes
      xfs: punching delalloc extents on write failure is racy
      xfs: use byte ranges for write cleanup ranges
      xfs,iomap: move delalloc punching to iomap
      iomap: buffered write failure should not truncate the page cache
      xfs: xfs_bmap_punch_delalloc_range() should take a byte range
      iomap: write iomap validity checks
      xfs: use iomap_valid method to detect stale cached iomaps
      xfs: drop write error injection is unfixable, remove it
      xfs: fix off-by-one-block in xfs_discard_folio()

Eric Sandeen (1):
      xfs: short circuit xfs_growfs_data_private() if delta is zero

Greg Kroah-Hartman (1):
      Linux 6.1.92

Guo Xuenan (2):
      xfs: wait iclog complete before tearing down AIL
      xfs: fix super block buf log item UAF during force shutdown

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Hironori Shiina (1):
      xfs: get root inode correctly at bulkstat

Jacob Keller (2):
      ice: pass VSI pointer into ice_vc_isvalid_q_id
      ice: remove unnecessary duplicate checks for VF VSI ID

Jarkko Sakkinen (2):
      KEYS: trusted: Fix memory leak in tpm2_key_encode()
      KEYS: trusted: Do not use WARN when encode fails

Javier Carrasco (1):
      usb: typec: tipd: fix event checking for tps6598x

Jose Fernandez (1):
      drm/amd/display: Fix division by zero in setup_dsc_config

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix link status when link is set to down/up

Long Li (2):
      xfs: fix sb write verify for lazysbcount
      xfs: fix incorrect i_nlink caused by inode racing

Mark Rutland (1):
      arm64: atomics: lse: remove stale dependency on JUMP_LABEL

Mengqi Zhang (1):
      mmc: core: Add HS400 tuning in HS400es initialization

NeilBrown (1):
      nfsd: don't allow nfsd threads to be signalled.

Prashanth K (1):
      usb: dwc3: Wait unconditionally after issuing EndXfer command

Ronald Wahl (1):
      net: ks8851: Fix another TX stall caused by wrong ISR flag handling

Sergey Shtylyov (1):
      pinctrl: core: handle radix_tree_insert() errors in pinctrl_register_one_pin()

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()

Thomas Weißschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET


