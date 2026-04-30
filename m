Return-Path: <stable+bounces-241978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GINLXK38mm3tgEAu9opvQ
	(envelope-from <stable+bounces-241978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:59:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE149C2A0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 03:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50346301725C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA822282F04;
	Thu, 30 Apr 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEZL2rK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6A28150F
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514335; cv=none; b=rKrhayl0HLIRTiOQ7WW4pD3a6jnBl88cTerO1o709JndxdR4tR2oGBVSmtAQtEeubvctfagql1a2ezQUuUIETczEpKmwbBAnnJbBA2ostlNe8LP41NnfClsKisb0YYiizK/qjAftlDksHM25gzFZ6yC5ftNcxAk0oahlZLmnAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514335; c=relaxed/simple;
	bh=c6ift3KG8VqG+AYwdm3A32tSCHb1XCoZc8BvLKOxJ9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6LNFlJL2y3IJ5hicdoxMpBI+zz1V8jMYlgcC2t3l66b0MUKh4C3BJvGvp9XKLwfIeSHUxKAOOHDxDfWyjfxH5qtehfWQWZdL02FoqbZeJ9z2uGfA5WoPgt6ITDL0pFjdHLQDzZa6F+SuWonq7ugRM/k1t8bDxUJ18kyKHL5bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEZL2rK5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b4583f0a1aso2404045ad.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777514333; x=1778119133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSj58RXndV+ZMCznyP7DAqXYF3qFvr9/LzNWk6EzYIk=;
        b=lEZL2rK5yBuKcH8VnYH1HZXOmmokOK640axFMXXtFaCXMNN5INUrvOB9M4tE6SzrS1
         f3a6289CUFEA8Cqe92UsrQqbe2t6XJbZj4CFuw8Nx0/f5R2lToIy6zg0ERmMtIcgFtAj
         2/3z1lfhGbUiV5SjSuGvA+/cpJnVYxXRHolUlH8AgHxargrjFNPw6t7Tyhp1nAThcj8s
         07mF6uYZLFORw2j2fJI1NTKjhb/d/kfQiXWYxcTMlYnPYn/lIF+UGVA8cm5QeToiFskj
         Vx6suCPA1T+SMS/DbU38hychu1ihHoBVq6G1I7kYMAMXg8Ffgz/eGZUyzfgDJIW8mcaE
         hrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777514333; x=1778119133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSj58RXndV+ZMCznyP7DAqXYF3qFvr9/LzNWk6EzYIk=;
        b=YwpR2uEkha4vihaFVbzTUTUh3IsnkdhCNBFgC6iKNF6+o+PDgw6x9GBs1nN86PKDXU
         QuLgectB06ed5d1Epgps83MC4WE8ir54ZFMENjbgOAjU254BTQ3Yf23WI/J0gN81RMLq
         m0Iqr4WrrvlEl/6gftme6HFXEOIj2Keup5lRfcYbsvBE+IVw1SC2FY0mze3Npw0bWVu0
         +7oSl2Dten8oAuNKjTdxhLloQYGUzEpyBlH61xQFzFamBa8c42lb89rFw6B8UmC1QATk
         EUzicBaveQjoE+qMOwDsw/F+jomO/CMkcpRd+1iJSTQ0Ekj8WhZxsEYtNJV97Q6BwCCq
         3rSw==
X-Forwarded-Encrypted: i=1; AFNElJ+sHPbvHC1TzThwdZ2NOnGXaRgCZ+fMsHe5ASr+ZvWXuH4GJIUKELn+bozed6+wGumTL9nOL2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYG2PFPLBuVgHGhJVvGgoRhe6vo9SAa7V9sPLavOAJv7uX5V/G
	q39sztSCeoWKfO7e0v2bTHkWvLH5vb7VVtPfR9UjRvq7FpP86/IfDZjp
X-Gm-Gg: AeBDietPyu1n2kzIC1Vcbyi+BKz1ufFMTvFvJWN6NvpOmnHZSjUPu31MDIjvj/QQiW8
	Sg5MwuClzYaTsVwF3qkdMG+33GvDYZ/Uur6VNC9i9BlaVTVs+0bp3qbCsUieolwjlAEsxpHoB1R
	fGk/xBeNQAwaCZR+Bk9wXqY2hDjU6pbnqmlnyv0mP0k4PT2qNSJKCZgZglMAa4G4qDFvk8kFo3p
	MGB/k3VQVukr5b5R7WemI1KP+nCrhC/rESjcphDU71w+tKs1t7sVr8ccDzhzA5knDd2hpLsKMa6
	OTZXTPszMn0zTtVGLuOqdAmcZoozTCZYxxg9aZgCh36IT9iDR95zpxEewKjZb5wJz0VR6V1GMMe
	m0B2E8dXosl7JiUT849DhwxLPvwThkXrthI1PmMH5lO4b0gtTg3WPVesdwAayP8KjPBPlbfXgpg
	GKLvv1dqxQ2rO+pA6FOGQ8WpOzrHbzyjkk66PFLlTyHEFw6/tbYcuCOYlok/5Mu6R/Yn7glkvN5
	FZwuEcYU0O+MlYl+w==
X-Received: by 2002:a17:902:ed8b:b0:2b2:420a:b48a with SMTP id d9443c01a7336-2b9a2504f3fmr5931325ad.32.1777514333366;
        Wed, 29 Apr 2026 18:58:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:e9bf:615b:4859:6e22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988772e79sm34977765ad.12.2026.04.29.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 18:58:52 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers
Date: Thu, 30 Apr 2026 07:28:47 +0530
Message-ID: <20260430015847.110800-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3ACE149C2A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241978-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,62f0f99d2f2bb8e3bbd7];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


Syzbot reported a hung task in nilfs_transaction_begin() where multiple
tasks performing chmod() on a nilfs2 mount blocked for over 143 seconds
waiting to acquire ns_segctor_sem for read:

  INFO: task syz.0.17:5918 blocked for more than 143 seconds.
  Call Trace:
   schedule+0x164/0x360
   rwsem_down_read_slowpath+0x6d9/0x940
   down_read+0x99/0x2e0
   nilfs_transaction_begin+0x364/0x710 fs/nilfs2/segment.c:221
   nilfs_setattr+0x124/0x2c0 fs/nilfs2/inode.c:921
   notify_change+0xc1a/0xf40
   chmod_common+0x273/0x4a0
   do_fchmodat+0x12d/0x230

The writer holding ns_segctor_sem was a concurrent NILFS_IOCTL_CLEAN_SEGMENTS
caller, stuck inside printk while emitting per-element warnings from
nilfs_sufile_updatev():

   __nilfs_msg+0x373/0x450 fs/nilfs2/super.c:78
   nilfs_sufile_updatev+0x21c/0x6d0 fs/nilfs2/sufile.c:186
   nilfs_sufile_freev fs/nilfs2/sufile.h:93 [inline]
   nilfs_free_segments fs/nilfs2/segment.c:1140 [inline]
   nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1261 [inline]
   nilfs_segctor_do_construct+0x1f55/0x76c0
   nilfs_clean_segments+0x3bd/0xa50
   nilfs_ioctl_clean_segments fs/nilfs2/ioctl.c:922 [inline]
   nilfs_ioctl+0x261f/0x2780

The root cause is that user-supplied segment numbers are not validated
before nilfs_clean_segments() begins doing work; the range check on
each segnum is performed deep inside the call chain by
nilfs_sufile_updatev(), which emits a nilfs_warn() per invalid entry
while still holding the segctor lock and the sufile mi_sem.  Under load
(repeated invocations across multiple mounts saturating the global
printk path), the cumulative printk latency keeps ns_segctor_sem held
long enough to trip the hung_task watchdog, blocking concurrent
operations such as chmod() that need ns_segctor_sem for read.

Fix by validating the contents of kbufs[4] in nilfs_clean_segments()
immediately after acquiring ns_segctor_sem via nilfs_transaction_lock().
Holding ns_segctor_sem serializes the check against
nilfs_ioctl_resize(), which can modify ns_nsegments, so the validation
uses a consistent value.  Out-of-range segment numbers are rejected
with -EINVAL before any segment-cleaning work begins, so the bad
entries never reach the per-element diagnostic path inside
nilfs_sufile_updatev().

Reported-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62f0f99d2f2bb8e3bbd7
Fixes: 4f6b828837b4 ("nilfs2: fix lock order reversal in nilfs_clean_segments ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v3:
  - Move validation from nilfs_ioctl_clean_segments() into
    nilfs_clean_segments(), under ns_segctor_sem held for write
    by nilfs_transaction_lock(), to serialize against
    nilfs_ioctl_resize() which can modify ns_nsegments
    (Ryusuke Konishi)
  - Introduce local variables segnumv and nfreesegs for readability,
    rather than open-coding casts of kbufs[4] (Ryusuke Konishi)
  - Emit nilfs_err() once on the first out-of-range segnum and bail
    out, instead of nilfs_warn() per element (Ryusuke Konishi)
  - Add bail_unlock label for the early-failure path, parallel to
    the existing out_unlock structure (Ryusuke Konishi)

Changes in v2:
  - Reuse existing 'n' loop variable instead of introducing a new
    one (Slava Dubeyko)
  - Add dedicated out_free_segnums label so the validation-failure
    path falls through the existing cleanup ladder rather than
    duplicating kfree(kbufs[4]) inline (Slava Dubeyko)
---
 fs/nilfs2/segment.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 1491a4d4b1e1..dc54643866ce 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2512,12 +2512,33 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 	struct nilfs_sc_info *sci = nilfs->ns_writer;
 	struct nilfs_transaction_info ti;
 	int err;
+	size_t i, nfreesegs = argv[4].v_nmembs;
+	__u64 *segnumv = kbufs[4];
 
 	if (unlikely(!sci))
 		return -EROFS;
 
 	nilfs_transaction_lock(sb, &ti, 1);
 
+	/*
+	 * Validate segment numbers under ns_segctor_sem (held for write
+	 * by nilfs_transaction_lock above) so the check is serialized
+	 * against nilfs_ioctl_resize(), which can modify ns_nsegments.
+	 * Rejecting bad input here, before any segment-cleaning work
+	 * begins, avoids the per-element diagnostic path inside
+	 * nilfs_sufile_updatev() that would otherwise run under this
+	 * same lock and stall concurrent readers.
+	 */
+	for (i = 0; i < nfreesegs; i++) {
+		if (segnumv[i] >= nilfs->ns_nsegments) {
+			nilfs_err(sb,
+				 "Segment number %llu to be freed is out of range",
+				 (unsigned long long)segnumv[i]);
+			err = -EINVAL;
+			goto bail_unlock;
+		}
+	}
+
 	err = nilfs_mdt_save_to_shadow_map(nilfs->ns_dat);
 	if (unlikely(err))
 		goto out_unlock;
@@ -2558,6 +2579,7 @@ int nilfs_clean_segments(struct super_block *sb, struct nilfs_argv *argv,
 	sci->sc_freesegs = NULL;
 	sci->sc_nfreesegs = 0;
 	nilfs_mdt_clear_shadow_map(nilfs->ns_dat);
+ bail_unlock:
 	nilfs_transaction_unlock(sb);
 	return err;
 }
-- 
2.43.0



