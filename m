Return-Path: <stable+bounces-46142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0638CEF79
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238B7281A06
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A85D903;
	Sat, 25 May 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n6CWkg0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB75A7AB;
	Sat, 25 May 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648687; cv=none; b=jipIs/cnsp3epry5hFPx8t5fpke5nTTeEweAgrCjmp2PiKeUdXfIPsQeU+LPt5fjJuxDo6FA/o9DWNTKyxZV0BOkKB2SggZi/7lpYRB30KTXuyaypT/6+sDNy7W+mSxFS7un+hTWq2i5gW2FDoAQDJoeTdOpWlrPPuQESp9CQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648687; c=relaxed/simple;
	bh=C0mlHS3R2SDhsgjK35aAV5iDyGhlZwyyyuwBrCU82QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5TwVgh/+foemXNxG432s5sjbgNqe/ysduJnHxpQHFWnTm7TgnYMqHOVYpvpvTeWQxl4SM5bcq2EGhh2x8l8Kd52mEPjRRMmKotQPWskjXy7FxwpPQGudIrD6BM7NrOGLVhmWLPGwuzw/fsSgGG2KGG2fw8pZp9h+5ddFVhmD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n6CWkg0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4D4C32786;
	Sat, 25 May 2024 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648687;
	bh=C0mlHS3R2SDhsgjK35aAV5iDyGhlZwyyyuwBrCU82QA=;
	h=From:To:Cc:Subject:Date:From;
	b=n6CWkg0tWRXeCqiajj1KeXQLu2LmjARxNUf/i/CR6/gkNnw8mDVvc6zQZciFoH+zK
	 tEBAj0BoOLi5hbyFDP7dayQhZCmYUpTUrIhfr+fOPTIPn87lgNj0ojob1YsHHn+N4Y
	 h67Yw6K6dJUfV/dwH3R+x2VNV5jQN8bkS5k+gmqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.32
Date: Sat, 25 May 2024 16:51:09 +0200
Message-ID: <2024052510-prowling-harmonica-27df@gregkh>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.6.32 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/stable/sysfs-block                  |   10 
 Documentation/admin-guide/hw-vuln/core-scheduling.rst |    4 
 Documentation/admin-guide/mm/damon/usage.rst          |    2 
 Documentation/sphinx/kernel_include.py                |    1 
 Makefile                                              |    2 
 block/genhd.c                                         |   15 
 block/partitions/core.c                               |    5 
 drivers/android/binder.c                              |    2 
 drivers/android/binder_internal.h                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c               |    3 
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c           |    7 
 drivers/mmc/core/mmc.c                                |    9 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c         |   22 
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c    |    3 
 drivers/net/ethernet/micrel/ks8851_common.c           |   18 
 drivers/net/usb/ax88179_178a.c                        |   37 
 drivers/remoteproc/mtk_scp.c                          |   10 
 drivers/tty/serial/kgdboc.c                           |   30 
 drivers/usb/dwc3/gadget.c                             |    4 
 drivers/usb/typec/tipd/core.c                         |   45 
 drivers/usb/typec/tipd/tps6598x.h                     |   11 
 drivers/usb/typec/ucsi/displayport.c                  |    4 
 fs/erofs/internal.h                                   |    7 
 fs/erofs/super.c                                      |  124 -
 fs/smb/client/Makefile                                |    2 
 fs/smb/client/cached_dir.c                            |   24 
 fs/smb/client/cifs_debug.c                            |   38 
 fs/smb/client/cifsfs.c                                |   10 
 fs/smb/client/cifsglob.h                              |   93 -
 fs/smb/client/cifsproto.h                             |   39 
 fs/smb/client/cifssmb.c                               |   18 
 fs/smb/client/connect.c                               |   57 
 fs/smb/client/dir.c                                   |   14 
 fs/smb/client/file.c                                  |   39 
 fs/smb/client/fs_context.c                            |   43 
 fs/smb/client/fs_context.h                            |   13 
 fs/smb/client/fscache.c                               |    7 
 fs/smb/client/inode.c                                 |  235 +--
 fs/smb/client/ioctl.c                                 |    6 
 fs/smb/client/link.c                                  |   41 
 fs/smb/client/misc.c                                  |   47 
 fs/smb/client/ntlmssp.h                               |    4 
 fs/smb/client/readdir.c                               |   32 
 fs/smb/client/reparse.c                               |  532 ++++++
 fs/smb/client/reparse.h                               |  113 +
 fs/smb/client/sess.c                                  |   73 
 fs/smb/client/smb1ops.c                               |   80 -
 fs/smb/client/smb2glob.h                              |   27 
 fs/smb/client/smb2inode.c                             | 1396 +++++++++++-------
 fs/smb/client/smb2maperror.c                          |    2 
 fs/smb/client/smb2misc.c                              |   10 
 fs/smb/client/smb2ops.c                               |  589 ++-----
 fs/smb/client/smb2pdu.c                               |  336 +++-
 fs/smb/client/smb2pdu.h                               |   46 
 fs/smb/client/smb2proto.h                             |   37 
 fs/smb/client/smb2status.h                            |    2 
 fs/smb/client/smb2transport.c                         |    2 
 fs/smb/client/smbdirect.c                             |    4 
 fs/smb/client/smbencrypt.c                            |    7 
 fs/smb/client/trace.h                                 |  137 +
 fs/smb/common/smb2pdu.h                               |  116 -
 fs/smb/common/smbfsctl.h                              |    6 
 fs/smb/server/auth.c                                  |   14 
 fs/smb/server/ksmbd_netlink.h                         |   36 
 fs/smb/server/mgmt/user_session.c                     |   28 
 fs/smb/server/mgmt/user_session.h                     |    3 
 fs/smb/server/misc.c                                  |    1 
 fs/smb/server/oplock.c                                |   96 +
 fs/smb/server/oplock.h                                |    7 
 fs/smb/server/smb2misc.c                              |   26 
 fs/smb/server/smb2ops.c                               |    6 
 fs/smb/server/smb2pdu.c                               |  338 +++-
 fs/smb/server/smb2pdu.h                               |   31 
 fs/smb/server/transport_tcp.c                         |    2 
 fs/smb/server/vfs.c                                   |   28 
 fs/smb/server/vfs_cache.c                             |  137 +
 fs/smb/server/vfs_cache.h                             |    9 
 include/linux/blkdev.h                                |   13 
 include/linux/bpf_types.h                             |    3 
 include/net/bluetooth/hci.h                           |    9 
 include/net/bluetooth/hci_core.h                      |    1 
 net/bluetooth/hci_conn.c                              |   71 
 net/bluetooth/hci_event.c                             |   31 
 net/bluetooth/iso.c                                   |    2 
 net/bluetooth/l2cap_core.c                            |   38 
 net/bluetooth/sco.c                                   |    6 
 security/keys/trusted-keys/trusted_tpm2.c             |   25 
 tools/testing/selftests/kselftest.h                   |   14 
 88 files changed, 3907 insertions(+), 1722 deletions(-)

Akira Yokosawa (1):
      docs: kernel_include.py: Cope with docutils 0.21

Alexey Dobriyan (1):
      smb: client: delete "true", "false" defines

AngeloGioacchino Del Regno (1):
      remoteproc: mediatek: Make sure IPI buffer fits in L2TCM

Baokun Li (1):
      erofs: get rid of erofs_fs_context

Bharath SM (2):
      cifs: defer close file handles having RH lease
      cifs: remove redundant variable assignment

Carlos Llamas (1):
      binder: fix max_thread type inconsistency

Christian Brauner (1):
      erofs: reliably distinguish block based and fscache mode

Christoph Hellwig (2):
      block: add a disk_has_partscan helper
      block: add a partscan sysfs attribute for disks

Colin Ian King (2):
      cifs: remove redundant variable tcon_exist
      ksmbd: Fix spelling mistake "connction" -> "connection"

Dan Carpenter (1):
      smb: client: Fix a NULL vs IS_ERR() check in wsl_set_xattrs()

Daniel Thompson (1):
      serial: kgdboc: Fix NMI-safety problems from keyboard reset code

David Howells (2):
      cifs: Pass unbyteswapped eof value into SMB2_set_eof()
      cifs: Add tracing for the cifs_tcon struct refcounting

Enzo Matsumiya (3):
      smb: client: negotiate compression algorithms
      smb: common: fix fields sizes in compression_pattern_payload_v1
      smb: common: simplify compression headers

Eric Biggers (1):
      smb: use crypto_shash_digest() in symlink_hash()

Greg Kroah-Hartman (1):
      Linux 6.6.32

Gustavo A. R. Silva (1):
      smb: smb2pdu.h: Avoid -Wflex-array-member-not-at-end warnings

Heikki Krogerus (1):
      usb: typec: ucsi: displayport: Fix potential deadlock

Jacob Keller (2):
      ice: pass VSI pointer into ice_vc_isvalid_q_id
      ice: remove unnecessary duplicate checks for VF VSI ID

Jarkko Sakkinen (2):
      KEYS: trusted: Fix memory leak in tpm2_key_encode()
      KEYS: trusted: Do not use WARN when encode fails

Javier Carrasco (1):
      usb: typec: tipd: fix event checking for tps6598x

Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

Jose Fernandez (1):
      drm/amd/display: Fix division by zero in setup_dsc_config

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix link status when link is set to down/up

Marios Makassikis (1):
      ksmbd: fix possible null-deref in smb_lazy_parent_lease_break_close

Mark Brown (1):
      kselftest: Add a ksft_perror() helper

Markus Elfring (1):
      smb3: Improve exception handling in allocate_mr_list()

Meetakshi Setiya (4):
      cifs: Add client version details to NTLM authenticate message
      smb: client: reuse file lease key in compound operations
      smb: client: retry compound request without reusing lease
      cifs: fixes for get_inode_info

Mengqi Zhang (1):
      mmc: core: Add HS400 tuning in HS400es initialization

Namjae Jeon (5):
      ksmbd: mark SMB2_SESSION_EXPIRED to session when destroying previous session
      ksmbd: add support for durable handles v1/v2
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
      ksmbd: fix potencial out-of-bounds when buffer offset is invalid
      ksmbd: add continuous availability share parameter

Paulo Alcantara (17):
      smb: client: allow creating symlinks via reparse points
      smb: client: cleanup smb2_query_reparse_point()
      smb: client: handle special files and symlinks in SMB3 POSIX
      cifs: get rid of dup length check in parse_reparse_point()
      smb: client: don't clobber ->i_rdev from cached reparse points
      smb: client: handle path separator of created SMB symlinks
      smb: client: get rid of smb311_posix_query_path_info()
      smb: client: introduce reparse mount option
      smb: client: move most of reparse point handling code to common file
      smb: client: fix potential broken compound request
      smb: client: reduce number of parameters in smb2_compound_op()
      smb: client: add support for WSL reparse points
      smb: client: parse uid, gid, mode and dev from WSL reparse points
      smb: client: set correct d_type for reparse DFS/DFSR and mount point
      smb: client: return reparse type in /proc/mounts
      smb: client: fix NULL ptr deref in cifs_mark_open_handles_for_deleted_file()
      smb: client: instantiate when creating SFU files

Pierre Mariani (1):
      smb: client: Fix minor whitespace errors and warnings

Prashanth K (1):
      usb: dwc3: Wait unconditionally after issuing EndXfer command

Randy Dunlap (2):
      ksmbd: auth: fix most kernel-doc warnings
      ksmbd: vfs: fix all kernel-doc warnings

Ritvik Budhiraja (1):
      cifs: fix use after free for iface while disabling secondary channels

Ronald Wahl (1):
      net: ks8851: Fix another TX stall caused by wrong ISR flag handling

SeongJae Park (1):
      Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter matching sysfs file

Shyam Prasad N (6):
      cifs: print server capabilities in DebugData
      cifs: pick channel for tcon and tdis
      cifs: new nt status codes from MS-SMB2
      cifs: new mount option called retrans
      cifs: commands that are retried should have replay flag set
      cifs: set replay flag for retries of write command

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()

Steve French (23):
      SMB3: clarify some of the unused CreateOption flags
      Add definition for new smb3.1.1 command type
      smb3: minor RDMA cleanup
      smb3: more minor cleanups for session handling routines
      smb3: minor cleanup of session handling code
      Missing field not being returned in ioctl CIFS_IOC_GET_MNT_INFO
      smb: client: introduce cifs_sfu_make_node()
      smb: client: extend smb2_compound_op() to accept more commands
      smb: client: allow creating special files via reparse points
      smb: client: optimise reparse point querying
      cifs: fix in logging in cifs_chan_update_iface
      cifs: remove unneeded return statement
      cifs: minor comment cleanup
      cifs: update the same create_guid on replay
      smb3: update allocation size more accurately on write completion
      smb: client: parse owner/group when creating reparse points
      smb: client: do not defer close open handles to deleted files
      smb: client: introduce SMB2_OP_QUERY_WSL_EA
      smb3: add dynamic trace point for ioctls
      cifs: Move some extern decls from .c files to .h
      smb311: correct incorrect offset field in compression header
      smb311: additional compression flag defined in updated protocol spec
      smb3: add trace event for mknod

Sungwoo Kim (2):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
      Bluetooth: L2CAP: Fix div-by-zero in l2cap_le_flowctl_init()

Thomas Weißschuh (1):
      admin-guide/hw-vuln/core-scheduling: fix return type of PR_SCHED_CORE_GET

Yang Li (2):
      smb: Fix some kernel-doc comments
      ksmbd: Add kernel-doc for ksmbd_extract_sharename() function


