Return-Path: <stable+bounces-216204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC+DAwkuj2nTLgEAu9opvQ
	(envelope-from <stable+bounces-216204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:58:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C46F136D10
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC373010B90
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F735FF7D;
	Fri, 13 Feb 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQ4G0VZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830D1684BE;
	Fri, 13 Feb 2026 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990985; cv=none; b=kCdg8A8dciS7F43Pv/q4z49bHBL+gyi41/9I7Q1PJn6doqGIOZO4sq7t7bZSYSHKfGexwE1L7MUyaFEVmXH/bzpjrL/1uJllXzpOFTaC/kPeCLo5SMpgqkRxDOnHSYULvT91GooGeAXQcpmt9lFdwa6zi4WL/YGzu05/Qwv48Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990985; c=relaxed/simple;
	bh=lHokdNlt0spSp5kdXs5W3zy6VNEqF2uUEHglaPmhzVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ol7Fztap1pM7jtnnT0v1wr+x13bpdWcSZAVs25TtscmMkRizbGhvVcYY/uD97QJdvz5rRGxF1kV+ak1nr6Bw/SbCA57Xp71btTo397g1mRXxb0/Is7eszF+tz018IEP5MhM/NCF+SYG5OGP0NPf6iE3+nyK8OEMdBCZJC8+TztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQ4G0VZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11D8C116C6;
	Fri, 13 Feb 2026 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990985;
	bh=lHokdNlt0spSp5kdXs5W3zy6VNEqF2uUEHglaPmhzVI=;
	h=From:To:Cc:Subject:Date:From;
	b=OQ4G0VZzow5Dq5XMoqvc+Lr0ml05EoMF3y1A0DQ18U1xNaaEhDOfxM5x9w/gzYK/J
	 +0aBoSOjEzZpv1FecDzD+k6CXUzjvRHVUBxr1dyhEphzWtbt5+4NHgbJAGgZxPvAPP
	 4Hoo5uEhUZB0ZzarSSA0VoA1fXDsGmEPi/p1xsBE=
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
Subject: [PATCH 6.12 00/24] 6.12.72-rc1 review
Date: Fri, 13 Feb 2026 14:48:19 +0100
Message-ID: <20260213134704.728003077@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.72-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.12.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.12.72-rc1
X-KernelTest-Deadline: 2026-02-15T13:47+00:00
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-216204-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C46F136D10
X-Rspamd-Action: no action

This is the start of the stable review cycle for the 6.12.72 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.72-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.12.72-rc1

Danilo Krummrich <dakr@kernel.org>
    gpio: omap: do not register driver in probe()

Ali Tariq <alitariq45892@gmail.com>
    wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

Liu Song <liu.song13@zte.com.cn>
    PCI: endpoint: Avoid creating sub-groups asynchronously

Darrick J. Wong <djwong@kernel.org>
    xfs: fix UAF in xchk_btree_check_block_owner

Chao Yu <chao@kernel.org>
    erofs: fix UAF issue for file-backed mounts w/ directio option

Eric Dumazet <edumazet@google.com>
    mptcp: fix race in mptcp_pm_nl_flush_addrs_doit()

Daniele Palmas <dnlplm@gmail.com>
    bus: mhi: host: pci_generic: Add Telit FE990B40 modem support

Anil Gurumurthy <agurumurthy@marvell.com>
    scsi: qla2xxx: Query FW again before proceeding with login

Anil Gurumurthy <agurumurthy@marvell.com>
    scsi: qla2xxx: Free sp in error path to fix system crash

Anil Gurumurthy <agurumurthy@marvell.com>
    scsi: qla2xxx: Delay module unload while fabric scan in progress

Shreyas Deodhar <sdeodhar@marvell.com>
    scsi: qla2xxx: Allow recovery for tape devices

Anil Gurumurthy <agurumurthy@marvell.com>
    scsi: qla2xxx: Validate sp before freeing associated memory

Bitterblue Smith <rtl8821cerfe2@gmail.com>
    wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()

Edward Adam Davis <eadavis@qq.com>
    nilfs2: Fix potential block overflow that cause system hang

Bibo Mao <maobibo@loongson.cn>
    crypto: virtio - Remove duplicated virtqueue_kick in virtio_crypto_skcipher_crypt_req

Bibo Mao <maobibo@loongson.cn>
    crypto: virtio - Add spinlock protection with virtqueue notification

Kees Cook <kees@kernel.org>
    crypto: omap - Allocate OMAP_CRYPTO_FORCE_COPY scatterlists correctly

Thorsten Blum <thorsten.blum@linux.dev>
    crypto: octeontx - Fix length check to avoid truncation in ucode_load_store

Thorsten Blum <thorsten.blum@linux.dev>
    crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode

Zenm Chen <zenmchen@gmail.com>
    Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB

Gui-Dong Han <hanguidong02@gmail.com>
    driver core: enforce device_lock for driver_match_device()

Henrique Carvalho <henrique.carvalho@suse.com>
    smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix infinite loop caused by next_smb2_rcv_hdr_off reset in error paths

Henrique Carvalho <henrique.carvalho@suse.com>
    smb: client: split cached_fid bitfields to avoid shared-byte RMW races


-------------

Diffstat:

 Makefile                                           |  4 +--
 drivers/base/base.h                                |  9 +++++
 drivers/base/bus.c                                 |  2 +-
 drivers/base/dd.c                                  |  2 +-
 drivers/bluetooth/btusb.c                          |  2 ++
 drivers/bus/mhi/host/pci_generic.c                 | 13 +++++++
 drivers/crypto/intel/iaa/iaa_crypto_main.c         | 12 +++----
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c  |  2 +-
 drivers/crypto/omap-crypto.c                       |  2 +-
 drivers/crypto/virtio/virtio_crypto_core.c         |  5 +++
 .../crypto/virtio/virtio_crypto_skcipher_algs.c    |  2 --
 drivers/gpio/gpio-omap.c                           | 22 +++++++++---
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  1 +
 drivers/net/wireless/realtek/rtw88/main.c          |  4 +--
 drivers/pci/endpoint/pci-ep-cfs.c                  | 15 +++-----
 drivers/scsi/qla2xxx/qla_gs.c                      | 41 +++++++++++-----------
 drivers/scsi/qla2xxx/qla_init.c                    | 28 +++++++++------
 drivers/scsi/qla2xxx/qla_isr.c                     | 19 ++++++++--
 drivers/scsi/qla2xxx/qla_os.c                      |  3 +-
 fs/erofs/fileio.c                                  |  7 +++-
 fs/nilfs2/sufile.c                                 |  4 +++
 fs/smb/client/cached_dir.h                         |  8 ++---
 fs/smb/server/server.c                             |  6 ++--
 fs/smb/server/transport_tcp.c                      |  3 +-
 fs/xfs/scrub/btree.c                               |  7 ++--
 net/mptcp/pm_netlink.c                             | 16 +++++++--
 26 files changed, 159 insertions(+), 80 deletions(-)



