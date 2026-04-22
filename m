Return-Path: <stable+bounces-240322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE5EMVW46GmgPAIAu9opvQ
	(envelope-from <stable+bounces-240322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:00:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF99445A80
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00040301B06E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D53D1CD2;
	Wed, 22 Apr 2026 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cTPiECwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4128346AD3;
	Wed, 22 Apr 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859220; cv=none; b=cI0BpiXd+dlGZ+ofKtqhD53GdLs5WpoY3UJ7NtbR6h+u2tlBc8CCjK4SgFeu9oJc9QlijMXOY0qFcgtDHkeLDoXO+PK97B6iGTj3s0RzSHTj/oeMHCvUY18ZdDWA2OiQF8AfXIErxerDBtEKgi5tDcISskm3rovTjI5r54obBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859220; c=relaxed/simple;
	bh=ptRiNCj2qZIyeLkGjnRPBISApr2+R4xIqpAyMqkfQ3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fwrVO/L7dbEpHhriN+F0hCKnLieRuvy2+7ePjYLlCRUKlR2pCBONcpH7LEKnn6+PrImjpjelRNvL7YWchAmK8iRxtnbJq2YOuZOH3Fi5VgW4PY8pmzvK4YSEngn5RTzriR5k0RpqwZxTV86n1j5+z665v7FSkiFRG6inokDpOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cTPiECwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4EC2BCAF;
	Wed, 22 Apr 2026 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776859219;
	bh=ptRiNCj2qZIyeLkGjnRPBISApr2+R4xIqpAyMqkfQ3Q=;
	h=From:To:Cc:Subject:Date:From;
	b=cTPiECwFEvsz20xrE/PPHbSJNre1GSZoYK2vM8/ENv90Tn8NoEJFrDBvbL6wvQgLc
	 n4NRLEVLtVPiZAHBa7fN1QR3EU/wL983/d06kukrqGlgBYqQISMEffrWsXKd4z3TQP
	 igewhBXmoAkde4wfo7eVKPnE4FlqfaZDmVgIzdqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.0.1
Date: Wed, 22 Apr 2026 14:00:12 +0200
Message-ID: <2026042213-wish-lizard-f678@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240322-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8BF99445A80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 7.0.1 kernel.

All users of the 7.0 kernel series must upgrade.

The updated 7.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/mm/damon/lru_sort.rst                     |    4 
 Documentation/admin-guide/mm/damon/reclaim.rst                      |    4 
 Makefile                                                            |    2 
 arch/arm64/include/asm/pgtable-prot.h                               |    2 
 arch/arm64/include/asm/pgtable.h                                    |    9 -
 arch/arm64/include/asm/uaccess.h                                    |    2 
 arch/arm64/mm/mmu.c                                                 |    4 
 arch/arm64/mm/pageattr.c                                            |   50 +++---
 arch/arm64/mm/trans_pgd.c                                           |   42 -----
 arch/powerpc/include/asm/uaccess.h                                  |    3 
 arch/powerpc/lib/pmem.c                                             |   11 -
 arch/x86/include/asm/msr-index.h                                    |    3 
 arch/x86/include/asm/uaccess.h                                      |    2 
 arch/x86/include/asm/uaccess_32.h                                   |    8 
 arch/x86/include/asm/uaccess_64.h                                   |   16 +
 arch/x86/kernel/cpu/amd.c                                           |    3 
 arch/x86/kvm/svm/sev.c                                              |   46 +++--
 arch/x86/kvm/x86.c                                                  |   14 +
 arch/x86/lib/copy_user_uncached_64.S                                |    6 
 arch/x86/lib/usercopy_32.c                                          |    9 -
 arch/x86/lib/usercopy_64.c                                          |   12 -
 drivers/gpu/drm/i915/i915_gem.c                                     |    2 
 drivers/gpu/drm/qxl/qxl_ioctl.c                                     |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                      |   14 +
 drivers/hid/hid-alps.c                                              |    3 
 drivers/hid/hid-core.c                                              |    3 
 drivers/hwmon/powerz.c                                              |    8 
 drivers/i2c/busses/i2c-s3c2410.c                                    |    7 
 drivers/infiniband/sw/rdmavt/qp.c                                   |    8 
 drivers/md/bcache/super.c                                           |    7 
 drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c |    9 +
 drivers/media/test-drivers/vidtv/vidtv_bridge.c                     |    4 
 drivers/media/test-drivers/vidtv/vidtv_channel.c                    |    4 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                        |    4 
 drivers/media/test-drivers/vidtv/vidtv_ts.c                         |   48 ++---
 drivers/media/test-drivers/vidtv/vidtv_ts.h                         |    4 
 drivers/media/usb/as102/as102_usb_drv.c                             |    2 
 drivers/media/usb/em28xx/em28xx-video.c                             |   14 +
 drivers/media/usb/hackrf/hackrf.c                                   |    7 
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c                      |    1 
 drivers/net/usb/cdc-phonet.c                                        |    7 
 drivers/net/wireguard/device.c                                      |    8 
 drivers/net/wireless/realtek/rtw88/usb.c                            |    3 
 drivers/ntb/ntb_transport.c                                         |    7 
 drivers/pci/endpoint/functions/pci-epf-vntb.c                       |   20 --
 drivers/staging/rtl8723bs/core/rtw_security.c                       |    2 
 drivers/staging/sm750fb/sm750.c                                     |    3 
 drivers/usb/class/cdc-acm.c                                         |   53 +++++-
 drivers/usb/core/port.c                                             |    1 
 drivers/usb/gadget/function/f_hid.c                                 |   15 +
 drivers/usb/gadget/function/f_ncm.c                                 |    4 
 drivers/usb/gadget/function/f_phonet.c                              |    9 +
 drivers/usb/gadget/udc/renesas_usb3.c                               |    7 
 drivers/usb/serial/option.c                                         |    2 
 drivers/usb/storage/unusual_devs.h                                  |    7 
 drivers/usb/typec/tcpm/fusb302.c                                    |    5 
 drivers/usb/usbip/usbip_common.c                                    |   12 +
 drivers/vfio/pci/xe/main.c                                          |   43 +++--
 drivers/video/fbdev/tdfxfb.c                                        |    3 
 drivers/video/fbdev/udlfb.c                                         |    3 
 fs/dcache.c                                                         |    4 
 fs/nilfs2/dat.c                                                     |    3 
 fs/ocfs2/aops.c                                                     |    3 
 fs/ocfs2/mmap.c                                                     |    7 
 fs/ocfs2/ocfs2_trace.h                                              |   10 -
 fs/ocfs2/resize.c                                                   |   10 -
 fs/smb/client/smb2file.c                                            |   20 +-
 fs/smb/client/smb2inode.c                                           |    2 
 fs/smb/client/smbdirect.c                                           |    8 
 fs/smb/server/connection.c                                          |    1 
 fs/smb/server/smb2pdu.c                                             |    7 
 fs/smb/server/smbacl.c                                              |    3 
 fs/smb/server/transport_rdma.c                                      |    8 
 include/linux/hugetlb.h                                             |   17 ++
 include/linux/kvm_host.h                                            |   10 +
 include/linux/uaccess.h                                             |   11 -
 kernel/time/clockevents.c                                           |    7 
 kernel/time/tick-broadcast.c                                        |    1 
 lib/iov_iter.c                                                      |    4 
 mm/backing-dev.c                                                    |    5 
 mm/filemap.c                                                        |    3 
 mm/internal.h                                                       |    1 
 mm/kasan/init.c                                                     |    8 
 mm/truncate.c                                                       |    6 
 mm/userfaultfd.c                                                    |    2 
 net/can/raw.c                                                       |   11 +
 net/nfc/digital_technology.c                                        |    6 
 net/nfc/llcp_core.c                                                 |    2 
 scripts/checkpatch.pl                                               |   10 +
 scripts/gdb/linux/symbols.py                                        |    2 
 scripts/generate_rust_analyzer.py                                   |    3 
 sound/firewire/fireworks/fireworks_command.c                        |    5 
 sound/pci/ctxfi/ctvmem.h                                            |    2 
 sound/soc/qcom/qdsp6/q6apm.c                                        |   14 +
 sound/usb/6fire/chip.c                                              |   17 +-
 sound/usb/usx2y/us144mkii.c                                         |    6 
 tools/objtool/check.c                                               |    2 
 tools/testing/selftests/kvm/x86/sev_migrate_tests.c                 |    2 
 tools/testing/selftests/mm/hmm-tests.c                              |   83 +---------
 99 files changed, 585 insertions(+), 358 deletions(-)

Abd-Alrhman Masalkhi (1):
      media: vidtv: fix pass-by-value structs causing MSAN warnings

Abhishek Kumar (1):
      media: em28xx: fix use-after-free in em28xx_v4l2_open()

Alexey Charkov (1):
      usb: typec: fusb302: Switch to threaded IRQ handler

Alistair Popple (1):
      selftests/mm: hmm-tests: don't hardcode THP size to 2MB

Benjamin Berg (1):
      scripts/gdb/symbols: handle module path parameters

Berk Cem Goksel (1):
      ALSA: 6fire: fix use-after-free on disconnect

Borislav Petkov (AMD) (1):
      x86/CPU: Fix FPDSS on Zen1

Breno Leitao (1):
      mm: blk-cgroup: fix use-after-free in cgwb_release_workfn()

Daniel Brát (1):
      usb: storage: Expand range of matched versions for VL817 quirks entry

Dave Carey (1):
      USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen

Deepanshu Kartikey (1):
      nilfs2: fix NULL i_assoc_inode dereference in nilfs_mdt_save_to_shadow_map

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FN990A MBIM composition

Fan Wu (1):
      media: mediatek: vcodec: fix use-after-free in encoder release path

Greg Kroah-Hartman (20):
      i2c: s3c24xx: check the size of the SMBUS message before using it
      HID: alps: fix NULL pointer dereference in alps_raw_event()
      HID: core: clamp report_size in s32ton() to avoid undefined shift
      net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
      NFC: digital: Bounds check NFC-A cascade depth in SDD response handler
      drm/vc4: platform_get_irq_byname() returns an int
      bnge: return after auxiliary_device_uninit() in error path
      ALSA: usx2y: us144mkii: fix NULL deref on missing interface 0
      ALSA: fireworks: bound device-supplied status before string array lookup
      fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      usb: gadget: f_ncm: validate minimum block_len in ncm_unwrap_ntb()
      usb: gadget: f_phonet: fix skb frags[] overflow in pn_rx_complete()
      usb: gadget: renesas_usb3: validate endpoint index in standard request handlers
      smb: client: fix off-by-8 bounds check in check_wsl_eas()
      smb: client: fix OOB reads parsing symlink error response
      ksmbd: validate EaNameLength in smb2_get_ea()
      ksmbd: require 3 sub-authorities before reading sub_auth[2]
      ksmbd: fix mechToken leak when SPNEGO decode fails after token alloc
      fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
      Linux 7.0.1

Harin Lee (1):
      ALSA: ctxfi: Limit PTP to a single page

Jeongjun Park (2):
      media: as102: fix to not free memory after the device is registered in as102_usb_probe()
      media: hackrf: fix to not free memory after the device is registered in hackrf_probe()

Jianhui Zhou (1):
      mm/userfaultfd: fix hugetlb fault mutex hash calculation

Johan Hovold (1):
      wifi: rtw88: fix device leak on probe failure

Joseph Qi (1):
      ocfs2: fix possible deadlock between unlink and dio_end_io_write

Junrui Luo (1):
      staging: sm750fb: fix division by zero in ps_to_hz()

Junxi Qian (1):
      nfc: llcp: add missing return after LLCP_CLOSED checks

Koichiro Den (2):
      PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

Lin YuChen (1):
      staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Linus Torvalds (3):
      x86-64: rename misleadingly named '__copy_user_nocache()' function
      x86: rename and clean up __copy_from_user_inatomic_nocache()
      x86-64/arm64/powerpc: clean up and rename __copy_from_user_flushcache

Matthew Wilcox (Oracle) (1):
      mm: call ->free_folio() directly in folio_unmap_invalidate()

Michael Zimmermann (1):
      usb: gadget: f_hid: don't call cdev_init while cdev in use

Michał Winiarski (1):
      vfio/xe: Reorganize the init to decouple migration from reset

Mingzhe Zou (1):
      bcache: fix cached_dev.sb_bio use-after-free and crash

Nathan Rebello (1):
      usbip: validate number_of_packets in usbip_pack_ret_submit()

Ritesh Harjani (IBM) (1):
      mm/kasan: fix double free for kasan pXds

Ruslan Valiyev (2):
      media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
      media: vidtv: fix nfeeds state corruption on start_streaming failure

Ryan Roberts (1):
      arm64: mm: Handle invalid large leaf mappings correctly

Samuel Page (1):
      can: raw: fix ro->uniq use-after-free in raw_rcv()

Sanman Pradhan (1):
      hwmon: (powerz) Fix use-after-free on USB disconnect

Sasha Levin (1):
      checkpatch: add support for Assisted-by tag

Sean Christopherson (7):
      KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in SEV-ES migrate test
      KVM: SEV: Reject attempts to sync VMSA of an already-launched/encrypted vCPU
      KVM: SEV: Protect *all* of sev_mem_enc_register_region() with kvm->lock
      KVM: SEV: Disallow LAUNCH_FINISH if vCPUs are actively being created
      KVM: SEV: Lock all vCPUs when synchronzing VMSAs for SNP launch finish
      KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
      KVM: x86: Use scratch field in MMIO fragment to hold small write values

SeongJae Park (2):
      Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
      Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race

Shardul Bankar (1):
      wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit

Srinivas Kandagatla (1):
      ASoC: qcom: q6apm: move component registration to unmanaged version

Stefan Metzmacher (2):
      smb: client: avoid double-free in smbd_free_send_io() after smbd_send_batch_flush()
      smb: server: avoid double-free in smb_direct_free_sendmsg after smb_direct_flush_send_list()

Tamir Duberstein (1):
      scripts: generate_rust_analyzer.py: avoid FD leak

Tejas Bharambe (1):
      ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

Thomas Gleixner (1):
      clockevents: Add missing resets of the next_event_forced flag

Xu Yang (1):
      usb: port: add delay after usb_hub_set_port_power()

ZhengYuan Huang (1):
      ocfs2: handle invalid dinode in ocfs2_group_extend

Zhihao Cheng (1):
      dcache: Limit the minimal number of bucket to two


