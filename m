Return-Path: <stable+bounces-241985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PG4AuTV8mnIugEAu9opvQ
	(envelope-from <stable+bounces-241985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:09:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827B49D351
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 243D43011C73
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BF363C7C;
	Thu, 30 Apr 2026 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLjpXUhJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFB35A93C
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522033; cv=none; b=Pt4nyORB1sNHtj2SEbR5tzTHxLYOxdII8kvd6wqx/SYnzwcfvZ/zdci75Q+tcwrnk75NxH9RETzf4UnPXNqg9RA0HdMEzBLttyyNKdrOqWgVm+KNuTJb5IsdZfjpjD60czAEyA6WQ4NoyNSwbfXhfYGsI7zT9ih/v6rPh0cjKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522033; c=relaxed/simple;
	bh=qAQK+k1/cFh8xK496xBgAoE1NTaxbAGL+2QmAbrBLe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRn08xRlgGCns75vMrXhziN8po5/QVU4xgnN5G8ND7BB79jqtf0XwVwtu7UeBlqJq6KXoHtbG/vkM6OB5DB5uXvOKp52MaH7mssaeJroc240iRicsoy/tZ0G3C7+YN6fsyvMkUOdiCK5FCTFeUG+AaF29TYufWjGVojgsaJLWcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLjpXUhJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c79467f11abso250193a12.2
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777522031; x=1778126831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/wjRyTJ9aYm0fg4TFEq5rsq+yvGFZ1pVdZXbpzLTXo=;
        b=GLjpXUhJ/uwONAue6m+BIDaUul5eJMJA+pwQvfa6p4I/NIIlim5NrwAskV0CogOz35
         v2m09Zg5C6pu29Q5PMS8yhtjleN3OehSgYKq7/YZ0Q96BGJUWFgVdE7uMWR7h1/cL7Y8
         dBlpa4hvSOKzDqB23Nt2k0Mvk1GjYLl1SAdxDfzJggmWOIiHtvdHbHozOfWu4dcg1ZJW
         lFK9QBhiAl6dQDMOU0wRMwg/FN8YTHrQ4NEeDycMpZ24RTTerETkWxBfZrGs6b35QprQ
         UQjVXusKZoKfGfR3TDwQdxsz0EfOeBdphJ4ZPF1zvSh7fLToSwzJJLiADqhwIw1zPrLW
         4vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777522031; x=1778126831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/wjRyTJ9aYm0fg4TFEq5rsq+yvGFZ1pVdZXbpzLTXo=;
        b=WyE6Dhsmqcsj6si32IlWd1/tntHzMR7VxVzUAdfSAbY0ckOj29ODWcuRahnFessCIw
         umr8sOvEC0LK9uvutiVmSTcwZA6TRUS4P/9rjl8WQxdx7Pda7eKEXBg8SdwFjRb3+JZ6
         S576AOJ2b1/6m2PgrNOPdFNX09lQaCZtibWsZ2q2KFnJ7p7DCwDIQorUNnV99g2efPu/
         EZWtcfq+F7QgjfLtgEo+9nmoStxdQRS/ozB7kjLh3P1TZu+DfQbqVN18sm2pUpEO7P1S
         j7I31GOXHgnZsc1aBjbuuACSpOIt+KPdlSKS8A09AH8GuLfc8A/pEoxmTOXMfd/U7ZLz
         rKng==
X-Forwarded-Encrypted: i=1; AFNElJ/pM01yxoD5c6X570YecGDDmwCJQA9T+ZalHiF+owGPkxI5HGVpRsz2gMzmf2ybFwCk/AEOfBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLuW/iGiul6lxIF/CdFkliSt/UDEg666sruA2fS5aTWGtbYTE
	mHIDVbKuc0grKz4f07dN/b2yfl7LHOZsmTN6nFw6H2UM6+IvTzdMlHzg
X-Gm-Gg: AeBDieuiMdqCcHmtEBW+Sc/UTiK0Pl49+cJEXwIUeArz5q77PiPHMuZ2kwxEiZWbTRY
	Ssoxezjsd71ZL15L7XnHGqogeI5ZcitHB2Ng1m+n/Ni3DBCiPqtOo+pAxx3uKC6OhBp9KQwlTeR
	aIdcNgIeDX0noVLDCgSCXwIGTl1wtjosAVXtzAHTdItRHXGLrsdg+HGiJNBHAWQEbFJ+W2epAc0
	aty5oYbsw+k8t477jtEfkLUlr1wS98ISQ6lZiq+6gz1APcmxWvibD+HH6LLX0vK3jfMF4WtrWD3
	kaTEqRizodzBSH3fb/MDtQhG32PS1Ir5LAIQ1gQNhVTm8JKG+6N4Fi+exL0H+jZi9KpoVx73mJg
	ZnWx6qvlJ4qJPwPp+CVG8utefzQS54i3l7Mq4R4dyvW9YnBDNGSnoHl3Nn17WT5KvDiJ1L3JeU4
	W/w9NwHMl5rx469PvDzQ1GrxJj6DvdKoKHRgnxOdyAeFOzB3U8GVBZU3CN2jp0gimGM6CZpwmdX
	ffKoo3dl+8PQSSsAQ==
X-Received: by 2002:a05:6a20:3ca3:b0:39b:d937:8010 with SMTP id adf61e73a8af0-3a3cf82c8a5mr1440198637.45.1777522031416;
        Wed, 29 Apr 2026 21:07:11 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:e9bf:615b:4859:6e22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cf7d4sm4353894b3a.23.2026.04.29.21.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:07:10 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: konishi.ryusuke@gmail.com,
	slava@dubeyko.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers
Date: Thu, 30 Apr 2026 09:37:04 +0530
Message-ID: <20260430040704.113622-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6827B49D351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241985-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,62f0f99d2f2bb8e3bbd7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]

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

The writer holding ns_segctor_sem was a concurrent 
NILFS_IOCTL_CLEAN_SEGMENTS caller, stuck inside printk while emitting 
per-element warnings from nilfs_sufile_updatev():

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
Tested-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
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



