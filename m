Return-Path: <stable+bounces-240935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKXlBAp062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60445F92A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 939BA3039C62
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C863D5645;
	Fri, 24 Apr 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FwUI0eXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09993386C0A;
	Fri, 24 Apr 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038218; cv=none; b=iahqiax5tzrqMUMwwn4R+U9p4WQZUBcS8qmZYMSSbgrPqaYnrUGl3pZN0cJgJyF+LTBNovnRqhxtQ2IN3wI5pbXZwWqaeU4TPhO2auP6wDsSCobfmDsdwajy1SpkbvIvlWMxapjj9F1joq14u8WgLGd8t6GAInFBVX7qguV4ZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038218; c=relaxed/simple;
	bh=Et5lmH5+lbzyCdtKW0xEiKHFDUp/zxY2IficvWMR7JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2kclhE7VohSOkm60aF6S/JFfzqy044DamigpOOSgcGAHCtu5pZWO4guhy6xr7+iFR2rxKZvVFIyaDbBPrPtihNzjQpGUj5SAffU6CeIWZ2yrWUNu4IGxnRZmfNa6nfCWXak4eaOjSt/jS+3CoCXj2cY5w9d5Uq4Yz7L/fJPq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FwUI0eXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E5C19425;
	Fri, 24 Apr 2026 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038217;
	bh=Et5lmH5+lbzyCdtKW0xEiKHFDUp/zxY2IficvWMR7JA=;
	h=From:To:Cc:Subject:Date:From;
	b=FwUI0eXT0YlW1XQeZTnOw+xtFosmpyVvPhFIJM4QL8QGYnMc15O5+xs+L3wVd6D4G
	 JLUMaUDsIB1TZRN2SWhcQpeMcLxdU16GXO/mHya0zp2pfyFaH2++dO6u6dhKGSoKG7
	 w1qDOdmlSLn46WXG/kb4BGxQedxwKc7La7oKKBWA=
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
	pavel@nabladev.com,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com
Subject: [PATCH 6.12 00/35] 6.12.84-rc1 review
Date: Fri, 24 Apr 2026 15:31:07 +0200
Message-ID: <20260424132411.427029259@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.84-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.12.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.12.84-rc1
X-KernelTest-Deadline: 2026-04-26T13:24+00:00
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C60445F92A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-240935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is the start of the stable review cycle for the 6.12.84 release.
There are 35 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.84-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.12.84-rc1

Anderson Nascimento <anderson@allelesecurity.com>
    rxrpc: Fix missing validation of ticket length in non-XDR key preparsing

Sean Christopherson <seanjc@google.com>
    crypto: ccp: Don't attempt to copy ID to userspace if PSP command failed

Sean Christopherson <seanjc@google.com>
    crypto: ccp: Don't attempt to copy PDH cert to userspace if PSP command failed

Sean Christopherson <seanjc@google.com>
    crypto: ccp: Don't attempt to copy CSR to userspace if PSP command failed

Bingquan Chen <patzilla007@gmail.com>
    net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()

Berk Cem Goksel <berkcgoksel@gmail.com>
    ALSA: caiaq: take a reference on the USB device in create_card()

Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
    ALSA: usb-audio: apply quirk for MOONDROP JU Jiu

George Saad <geoo115@gmail.com>
    f2fs: fix use-after-free of sbi in f2fs_compress_write_end_io()

Tristan Madani <tristan@talencesecurity.com>
    ksmbd: use check_add_overflow() to prevent u16 DACL size overflow

Tristan Madani <tristan@talencesecurity.com>
    ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment

Michael Bommarito <michael.bommarito@gmail.com>
    ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()

Michael Bommarito <michael.bommarito@gmail.com>
    ksmbd: validate response sizes in ipc_validate_msg()

Michael Bommarito <michael.bommarito@gmail.com>
    smb: client: fix OOB read in smb2_ioctl_query_info QUERY_INFO path

Michael Bommarito <michael.bommarito@gmail.com>
    smb: client: require a full NFS mode SID before reading mode bits

DaeMyung Kang <charsyam@gmail.com>
    smb: server: fix max_connections off-by-one in tcp accept path

Michael Bommarito <michael.bommarito@gmail.com>
    smb: server: fix active_num_conn leak on transport allocation failure

Michael Bommarito <michael.bommarito@gmail.com>
    ksmbd: require minimum ACE size in smb_check_perm_dacl()

Darrick J. Wong <djwong@kernel.org>
    fuse: quiet down complaints in fuse_conn_limit_write

Bernd Schubert <bschubert@ddn.com>
    fuse: Check for large folio with SPLICE_F_MOVE

Samuel Page <sam@bynar.io>
    fuse: reject oversized dirents in page cache

Chao Yu <chao@kernel.org>
    f2fs: fix to avoid memory leak in f2fs_rename()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    fs/ntfs3: validate rec->used in journal-replay file record check

Wang Jie <jiewang2024@lzu.edu.cn>
    rxrpc: only handle RESPONSE during service challenge

Nathan Chancellor <nathan@kernel.org>
    scripts/dtc: Remove unused dts_version in dtc-lexer.l

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger

Max Boone <mboone@akamai.com>
    mm/pagewalk: fix race between concurrent split and refault

Tamir Duberstein <tamird@kernel.org>
    scripts: generate_rust_analyzer.py: define scripts

Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
    drm/amdgpu: replace PASID IDR with XArray

Daniel Golle <daniel@makrotopia.org>
    net: ethernet: mtk_eth_soc: initialize PPE per-tag-layer MTU registers

Miguel Ojeda <ojeda@kernel.org>
    rust: warn on bindgen < 0.69.5 and libclang >= 19.1

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Steven Chen <chenste@linux.microsoft.com>
    ima: do not copy measurement list to kdump kernel

Steven Chen <chenste@linux.microsoft.com>
    ima: verify if the segment size has changed

Koichiro Den <den@valinux.co.jp>
    PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

Jianhui Zhou <jianhuizzzzz@gmail.com>
    mm/userfaultfd: fix hugetlb fault mutex hash calculation


-------------

Diffstat:

 Makefile                                           |  4 +-
 drivers/crypto/ccp/sev-dev.c                       | 19 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            | 39 +++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 22 +++++++-
 drivers/net/ethernet/mediatek/mtk_ppe.c            | 30 +++++++++++
 drivers/net/ethernet/mediatek/mtk_ppe.h            |  1 +
 drivers/net/wireless/ath/ath9k/channel.c           |  6 +--
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  1 -
 drivers/pci/endpoint/functions/pci-epf-vntb.c      | 18 +------
 fs/f2fs/compress.c                                 | 14 +++--
 fs/f2fs/namei.c                                    |  1 +
 fs/fuse/control.c                                  |  4 +-
 fs/fuse/dev.c                                      |  3 ++
 fs/fuse/readdir.c                                  |  4 ++
 fs/ntfs3/fslog.c                                   | 12 ++++-
 fs/smb/client/cifsacl.c                            |  1 +
 fs/smb/client/smb2ops.c                            |  6 +++
 fs/smb/server/mgmt/user_config.c                   |  6 ---
 fs/smb/server/smb2pdu.c                            |  2 +
 fs/smb/server/smbacl.c                             | 61 +++++++++++++++++-----
 fs/smb/server/transport_ipc.c                      | 16 ++++--
 fs/smb/server/transport_tcp.c                      |  4 +-
 fs/smb/server/vfs_cache.c                          | 41 +++++++++++----
 include/linux/hugetlb.h                            | 17 ++++++
 include/net/mac80211.h                             |  4 +-
 mm/pagewalk.c                                      | 24 ++++++++-
 mm/userfaultfd.c                                   |  2 +-
 net/mac80211/tx.c                                  |  4 +-
 net/packet/af_packet.c                             | 21 +++++---
 net/rxrpc/conn_event.c                             | 14 ++++-
 net/rxrpc/key.c                                    |  4 ++
 scripts/dtc/dtc-lexer.l                            |  3 --
 scripts/generate_rust_analyzer.py                  | 14 ++++-
 scripts/rust_is_available.sh                       | 15 ++++++
 .../rust_is_available_bindgen_libclang_concat.h    |  3 ++
 scripts/rust_is_available_test.py                  | 34 +++++++++++-
 security/integrity/ima/ima_kexec.c                 | 13 +++++
 sound/usb/caiaq/device.c                           |  4 +-
 sound/usb/mixer.c                                  |  7 +++
 39 files changed, 389 insertions(+), 109 deletions(-)



