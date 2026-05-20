Return-Path: <stable+bounces-250002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONN0FgHQDWo53gUAu9opvQ
	(envelope-from <stable+bounces-250002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751B35909C3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50A5F306A729
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC73BCD3A;
	Wed, 20 May 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLgdMYOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C17241665
	for <stable@vger.kernel.org>; Wed, 20 May 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289220; cv=none; b=mv5rWrk7gqWWzPa3vMBhj/qIKLKkca1YcsnzpPhh9N1JCsR1Oy/19hOxYH54Nkp2Zh8mq+le2RxG+8FxxrzcQsb2BoAq2DLSvhTL19Uqtzr0EVIzniFG7ZzmBArA7Ern1EdWY9+yKY3urbwVppLEMGTtEpvkARc2qQ5CbeJXyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289220; c=relaxed/simple;
	bh=zZZCnrcsFl2cpH9VFln9g6E+dU3xtOv85oK7UzyrC04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XB32q94MeHK//BXbjEPhtpTJYkGYlbKRKefYjQPpJdhQmcdP5knv6yx+4gOzHOTvCzoZb7rYXJ0rnFsJjG/2RpEVoalZe1700PfG8fI4R9QXegymqSPNrZw3YhvTgCIOJGsupChlQT2MqT1jOkut31H3AAoi0O1h6T3FAbw81mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLgdMYOF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F5C1F00894;
	Wed, 20 May 2026 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779289217;
	bh=5/4A7FCQ0HqLF/BX5u8v5HNclM1YPhrayt4h7ZuKnT0=;
	h=Subject:To:Cc:From:Date;
	b=eLgdMYOFpbPf/kZMRfxkP92j7lJ7NNVDLvuXZNDLUCvHxePHFsDQC4Wg06kMKPMOO
	 Y8dqjZcEW/cQHUM2Y1Cm7M0E7p4YXzLK7Tg18QrtVWt4bguUAExC3DWDqp45jBPy9X
	 djPZ7zFqBReNPdSYqUEjjMXrZoUzRrP7AeJLFOJs=
Subject: FAILED: patch "[PATCH] ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale" failed to apply to 6.1-stable tree
To: Slava.Dubeyko@ibm.com,amarkuze@redhat.com,idryomov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 17:00:19 +0200
Message-ID: <2026052019-prowler-ferret-1f7f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250002-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[ibm.com,redhat.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: 751B35909C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c22d9511cbde746622f8e4c11aaa63fe76d45f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052019-prowler-ferret-1f7f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c22d9511cbde746622f8e4c11aaa63fe76d45f9 Mon Sep 17 00:00:00 2001
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Date: Thu, 9 Apr 2026 12:43:40 -0700
Subject: [PATCH] ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale
 blob size

The generic/642 test-case can reproduce the kernel crash:

[40243.605254] ------------[ cut here ]------------
[40243.605956] kernel BUG at fs/ceph/xattr.c:918!
[40243.607142] Oops: invalid opcode: 0000 [#1] SMP PTI
[40243.608067] CPU: 7 UID: 0 PID: 498762 Comm: kworker/7:1 Not tainted 7.0.0-rc7+ #3 PREEMPT(full)
[40243.609700] Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[40243.611820] Workqueue: ceph-msgr ceph_con_workfn
[40243.612715] RIP: 0010:__ceph_build_xattrs_blob+0x1b8/0x1e0
[40243.613731] Code: 0f 84 82 fe ff ff e9 cf 8e 56 ff 48 8d 65 e8 31 c0 5b 41 5c 41 5d 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc <0f> 0b 4c 8b 62 08 41 8b 85 24 07 00 00 49 83 c4 04 41 89 44 24 fc
[40243.616888] RSP: 0018:ffffcc80c4d4b688 EFLAGS: 00010287
[40243.617773] RAX: 0000000000010026 RBX: 0000000000000001 RCX: 0000000000000000
[40243.618928] RDX: ffff8a773798dee0 RSI: 0000000000000000 RDI: 0000000000000000
[40243.620158] RBP: ffffcc80c4d4b6a0 R08: 0000000000000000 R09: 0000000000000000
[40243.621573] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a75f3b58000
[40243.622907] R13: ffff8a75f3b58000 R14: 0000000000000080 R15: 000000000000bffd
[40243.624054] FS:  0000000000000000(0000) GS:ffff8a787d1b4000(0000) knlGS:0000000000000000
[40243.625331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40243.626269] CR2: 000072f390b623c0 CR3: 000000011c02a003 CR4: 0000000000372ef0
[40243.627408] Call Trace:
[40243.627839]  <TASK>
[40243.628188]  __prep_cap+0x3fd/0x4a0
[40243.628789]  ? do_raw_spin_unlock+0x4e/0xe0
[40243.629474]  ceph_check_caps+0x46a/0xc80
[40243.630094]  ? __lock_acquire+0x4a2/0x2650
[40243.630773]  ? find_held_lock+0x31/0x90
[40243.631347]  ? handle_cap_grant+0x79f/0x1060
[40243.632068]  ? lock_release+0xd9/0x300
[40243.632696]  ? __mutex_unlock_slowpath+0x3e/0x340
[40243.633429]  ? lock_release+0xd9/0x300
[40243.634052]  handle_cap_grant+0xcf6/0x1060
[40243.634745]  ceph_handle_caps+0x122b/0x2110
[40243.635415]  mds_dispatch+0x5bd/0x2160
[40243.636034]  ? ceph_con_process_message+0x65/0x190
[40243.636828]  ? lock_release+0xd9/0x300
[40243.637431]  ceph_con_process_message+0x7a/0x190
[40243.638184]  ? kfree+0x311/0x4f0
[40243.638749]  ? kfree+0x311/0x4f0
[40243.639268]  process_message+0x16/0x1a0
[40243.639915]  ? sg_free_table+0x39/0x90
[40243.640572]  ceph_con_v2_try_read+0xf58/0x2120
[40243.641255]  ? lock_acquire+0xc8/0x300
[40243.641863]  ceph_con_workfn+0x151/0x820
[40243.642493]  process_one_work+0x22f/0x630
[40243.643093]  ? process_one_work+0x254/0x630
[40243.643770]  worker_thread+0x1e2/0x400
[40243.644332]  ? __pfx_worker_thread+0x10/0x10
[40243.645020]  kthread+0x109/0x140
[40243.645560]  ? __pfx_kthread+0x10/0x10
[40243.646125]  ret_from_fork+0x3f8/0x480
[40243.646752]  ? __pfx_kthread+0x10/0x10
[40243.647316]  ? __pfx_kthread+0x10/0x10
[40243.647919]  ret_from_fork_asm+0x1a/0x30
[40243.648556]  </TASK>
[40243.648902] Modules linked in: overlay hctr2 libpolyval chacha libchacha adiantum libnh libpoly1305 essiv intel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit kvm_intel kvm irqbypass joydev ghash_clmulni_intel aesni_intel rapl input_leds mac_hid psmouse vga16fb serio_raw vgastate floppy i2c_piix4 pata_acpi bochs qemu_fw_cfg i2c_smbus sch_fq_codel rbd dm_crypt msr parport_pc ppdev lp parport efi_pstore
[40243.654766] ---[ end trace 0000000000000000 ]---

Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
maximum xattr size") moved the required_blob_size computation to before
the __build_xattrs() call, introducing a race.

__build_xattrs() releases and reacquires i_ceph_lock during execution.
In that window, handle_cap_grant() may update i_xattrs.blob with a
newer MDS-provided blob and bump i_xattrs.version.  When
__build_xattrs() detects that index_version < version, it destroys and
rebuilds the entire xattr rb-tree from the new blob, potentially
increasing count, names_size, and vals_size.

The prealloc_blob size check that follows still uses the stale
required_blob_size computed before the rebuild, so it passes even when
prealloc_blob is too small for the now-larger tree. After __set_xattr()
adds one more xattr on top, __ceph_build_xattrs_blob() is called from
the cap flush path and hits:

    BUG_ON(need > ci->i_xattrs.prealloc_blob->alloc_len);

Fix this by recomputing required_blob_size after __build_xattrs()
returns, using the current tree state. Also re-validate against
m_max_xattr_size to fall back to the sync path if the rebuilt tree now
exceeds the MDS limit.

Cc: stable@vger.kernel.org
Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index c6fcbf428317..e773be07f767 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1254,6 +1254,22 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
+	/*
+	 * __build_xattrs() may have released and reacquired i_ceph_lock,
+	 * during which handle_cap_grant() could have replaced i_xattrs.blob
+	 * with a newer MDS-provided blob and bumped i_xattrs.version. If that
+	 * caused __build_xattrs() to rebuild the rb-tree from the new blob,
+	 * count/names_size/vals_size may now be larger than when
+	 * required_blob_size was computed above. Recompute it here so the
+	 * prealloc_blob size check below reflects the current tree state.
+	 */
+	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
+	if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
+		doutc(cl, "sync (size too large): %d > %llu\n",
+		      required_blob_size, mdsc->mdsmap->m_max_xattr_size);
+		goto do_sync;
+	}
+
 	if (!ci->i_xattrs.prealloc_blob ||
 	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
 		struct ceph_buffer *blob;


