Return-Path: <stable+bounces-224773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IFWKJwFsmnXHwAAu9opvQ
	(envelope-from <stable+bounces-224773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:15:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FE26B8DB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004A0310BD70
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D13282F07;
	Thu, 12 Mar 2026 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4rGmvrl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8C282F00
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274493; cv=none; b=GHv5houEm74VYpFUEsx40HVknMBrAqByAme+HJUtwY42+bE5FS3Y+iI+Db+BsnTtxfqXH0I7sNZR13kDIUa12Zctt2MLeF/x6RZR/V5z+eXiFLopgdEfTfrclFCUZnvD4GvyM2RvyBLCep/cywq8bbO6LAO3sxn5gLY+kuNoNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274493; c=relaxed/simple;
	bh=VU9hS4DshrqjC9KyJtG7jj7YVnllYQOO9wjLpFxgylA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0CAcoIKy/7amSCfTfG50vGwajJ1T6hhFLEDEmaIvdBJDX0qwFciEy/47U6CULGnA8P6WzNdThWhvZJO3fD3nkF7WSaCtinuYKCm6UgN3u9PER1I9gCjZGBnbVecYQH90fJTi7tQlusnOIeuT/0qNsh9ZmNMvyVuRTtsFr9aqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4rGmvrl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae505619baso3315585ad.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773274491; x=1773879291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGcYYewbh7c7rM4xdHWS6lIG0/xScOPJj7plS5pDbyU=;
        b=e4rGmvrl93bdeF5oLhBinfUWAL/b3rcPQCtTBSFIcOzxxfKDBxT45bmFCoplzdWG2F
         8L4sEUG7dLIRpyDFOhi5/ozMYyIFLnj1MV0tHblvmtJrmdv0mU22E4FK14QTGsBc5USG
         JbT4Wynsqxer8t826NexplNlLt2S7rC6z6Jc1dHrWygrVLHzEouC4P6zD0/oMhqs0PQi
         kvaHrOPFbFmt3aAtTMMkmT70ulsmYdTc0Og2IHfeUG3IKgcaG08h8SPme2R9g4LNSRs8
         TO4+4AG6TFU2pBgKhGuAl+5ilgqtDCQ08RWQdgHHX3WQfpmdpZr42zs3vXMQK0lv1zz8
         4LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274491; x=1773879291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGcYYewbh7c7rM4xdHWS6lIG0/xScOPJj7plS5pDbyU=;
        b=YKc/Z1meF8zS3dfny9zZV/gMIagkL0VI+23NInx9m5QefdzN6oD4mIba/KwOR6xPvA
         CHDX9WTvf255bbE5vrJ7SG6gv4DNSQhpemtA83abraDdkEq4EcMDJnmWCFDvguZbYmnI
         K7uL6Hxwom5H4OQo60HwJNacQAdCIlEcTfRQ3wSQDhNKfoHyjqi0yFUgCHaNxdWpg2Zt
         8Jpud7Xnmt0Fqg31PJQwQw8K6zBuELlviVr7d25IblQzWxDil+/t4rSZmr4MVu6uZA6O
         /gq5Aom/J1hCRsPKrxW3U5BA2yxYHLrKGeNkfe9Kuyv0IPZ6u62Eo+3T+fnLyppcvMik
         1QAA==
X-Forwarded-Encrypted: i=1; AJvYcCV5b65HoHwLlVYSlrxtarI9lzNjRziG5zaOx5gEzoGLoTKUhSH6Gk3BLYdcd0E3KPMBDiD49kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliJTRqLIcY6e+KrrMjKo1OQipUL2qUguMId2oweYG1B8Wz7e3
	mwX5n6O4d5OPQQBfonDyGZChGbbp8MYDueoNTOl395rizZWvjMmVK/sD
X-Gm-Gg: ATEYQzxH3OPXAaisda0UswcKTpvrD1Z4Xb5CvMJC89oe0zj2bjpn1yqu2Brj5mvs8uo
	GaY5VgHbvxiZi8/mVjOl3MbSoHygWMeRk854EkoHEJRTLuqRuPbyGdEjD6EzZU06Obl0SuPYrNa
	wcimj8djydSbefMMFv4vIeWrANueBwzRwcwlKnaQ+UXxGkxqUJJhDyv+5HBSaUrbAuDalCfSxlM
	QJMu80mZC9sfVn7v/k3aW76aVXB1WRx5mWU17o+u/RQr+fNMvmd4wJPiQDBrIR7AV55s63TZt6i
	jo9UxrXJUlD75kWH7G894nC23dSBGA93vN/Y35wEBm+xsNSsesR9hB7n/jn8IIP43P8wKlkkjq8
	xszTMyZ5GhX7Et/BvXemG8go9qsrqtbD8SBv+9tLzYc2BaDQ2/A85v++0kknQIHSdAy2zF2yQqu
	/iAjx92LbM15CfaJHLxE6cKcZoK7d3JGLXD3x7C7GnaYjWgAOHlY9p4swyHA8auJN0Obi0OQ==
X-Received: by 2002:a17:903:8c4:b0:2ae:4dce:7e92 with SMTP id d9443c01a7336-2aeae7cb944mr44962445ad.14.1773274491119;
        Wed, 11 Mar 2026 17:14:51 -0700 (PDT)
Received: from kernel-fuzz.. ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae35f0dbsm34835275ad.69.2026.03.11.17.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 17:14:50 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: dsterba@suse.com,
	clm@fb.com,
	wqu@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] btrfs: reject root items with drop_progress and zero drop_level
Date: Thu, 12 Mar 2026 08:14:43 +0800
Message-ID: <20260312001443.3011961-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-224773-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E8FE26B8DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
When recovering relocation at mount time, merge_reloc_root() and
btrfs_drop_snapshot() both use BUG_ON(level == 0) to guard against
an impossible state: a non-zero drop_progress combined with a zero
drop_level in a root_item, which can be triggered:

------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:1545!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 283 ... Tainted: 6.18.0+ #16 PREEMPT(voluntary) 
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Ubuntu 24.04 PC v2, BIOS 1.16.3-debian-1.16.3-2
RIP: 0010:merge_reloc_root+0x1266/0x1650 fs/btrfs/relocation.c:1545
Code: ffff0000 00004589 d7e9acfa ffffe8a1 79bafebe 02000000
Call Trace:
 merge_reloc_roots+0x295/0x890 fs/btrfs/relocation.c:1861
 btrfs_recover_relocation+0xd6e/0x11d0 fs/btrfs/relocation.c:4195
 btrfs_start_pre_rw_mount+0xa4d/0x1810 fs/btrfs/disk-io.c:3130
 open_ctree+0x5824/0x5fe0 fs/btrfs/disk-io.c:3640
 btrfs_fill_super fs/btrfs/super.c:987 [inline]
 btrfs_get_tree_super fs/btrfs/super.c:1951 [inline]
 btrfs_get_tree_subvol fs/btrfs/super.c:2094 [inline]
 btrfs_get_tree+0x111c/0x2190 fs/btrfs/super.c:2128
 vfs_get_tree+0x9a/0x370 fs/super.c:1758
 fc_mount fs/namespace.c:1199 [inline]
 do_new_mount_fc fs/namespace.c:3642 [inline]
 do_new_mount fs/namespace.c:3718 [inline]
 path_mount+0x5b8/0x1ea0 fs/namespace.c:4028
 do_mount fs/namespace.c:4041 [inline]
 __do_sys_mount fs/namespace.c:4229 [inline]
 __se_sys_mount fs/namespace.c:4206 [inline]
 __x64_sys_mount+0x282/0x320 fs/namespace.c:4206
 ...
RIP: 0033:0x7f969c9a8fde
Code: 0f1f4000 48c7c2b0 fffffff7 d8648902 b8ffffff ffc3660f
---[ end trace 0000000000000000 ]---

[CAUSE]
A non-zero drop_progress.objectid means an interrupted
btrfs_drop_snapshot() left a resume point on disk, and in that case
drop_level must be greater than 0 because the checkpoint is only
saved at internal node levels.

Although this invariant is enforced when the kernel writes the root
item, it is not validated when the root item is read back from disk.
That allows on-disk corruption to provide an invalid state with
drop_progress.objectid != 0 and drop_level == 0.

When relocation recovery later processes such a root item,
merge_reloc_root() reads drop_level and hits BUG_ON(level == 0). The
same invalid metadata can also trigger the corresponding BUG_ON() in
btrfs_drop_snapshot().

[FIX]
Fix this by validating the root_item invariant in tree-checker when
reading root items from disk: if drop_progress.objectid is non-zero,
drop_level must also be non-zero. Reject such malformed metadata with
-EUCLEAN before it reaches merge_reloc_root() or btrfs_drop_snapshot()
and triggers the BUG_ON.

The bug is reproducible on 7.0.0-rc2-next-20260310 with our dynamic
metadata fuzzing tool that corrupts btrfs metadata at runtime. After
the fix, the same corruption is correctly rejected by tree-checker
and the BUG_ON is no longer triggered.

Fixes: 259ee7754b67 ("btrfs: tree-checker: Add ROOT_ITEM check")
Cc: stable@vger.kernel.org # 5.3+
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
[CHANGELOG]
v2:
- Split out the error message fix from the previous patch, as requested
  during review.
---
 fs/btrfs/tree-checker.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index dd274f67ad7f..1e052c3303b3 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1260,6 +1260,23 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
+	/*
+	 * If drop_progress.objectid is non-zero, a btrfs_drop_snapshot() was
+	 * interrupted and the resume point was recorded in drop_progress and
+	 * drop_level.  In that case drop_level must be >= 1: level 0 is the
+	 * leaf level and drop_snapshot never saves a checkpoint there (it
+	 * only records checkpoints at internal node levels in DROP_REFERENCE
+	 * stage).  A zero drop_level combined with a non-zero drop_progress
+	 * objectid indicates on-disk corruption and would cause a BUG_ON in
+	 * merge_reloc_root() and btrfs_drop_snapshot() at mount time.
+	 */
+	if (unlikely(btrfs_disk_key_objectid(&ri.drop_progress) != 0 &&
+		     btrfs_root_drop_level(&ri) == 0)) {
+		generic_err(leaf, slot,
+			    "invalid root drop_level 0 with non-zero drop_progress objectid %llu",
+			    btrfs_disk_key_objectid(&ri.drop_progress));
+		return -EUCLEAN;
+	}
 
 	/* Flags check */
 	if (unlikely(btrfs_root_flags(&ri) & ~valid_root_flags)) {
-- 
2.43.0


