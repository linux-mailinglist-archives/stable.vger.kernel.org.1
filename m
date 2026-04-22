Return-Path: <stable+bounces-240354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJQGDWLw6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:59:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683B448326
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BEC93034E0D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC7375F87;
	Wed, 22 Apr 2026 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAi5i+VD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC492737E3
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873544; cv=none; b=SWRzNMH9sOZOZdmnN6A2rlWuY8jUx/WaNGaqz4PRPkobNRwZCetsTGN+76PXtiD9Efde7s/q3D6wAaILpVjOP64DeaUy7hzitF5lvXZXBAt+F7dv6Yu/Xm9p1rMdCJSJDkhhxBjZioEaPn3oEFvXnAj6VEwRK2cmCUiUUhRbVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873544; c=relaxed/simple;
	bh=1EyxcKO/nUApGhARmp1AedGru9RgJuydJVerpTfmZPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gcm2KoORf8i2ENEmYocdyUCjGyFaX+bJPBd6dYA27b0ot3ZItloH8JgXjsLpn3BjnMnMK73ab6DbFHdzs4oRGWoaOc2hHgtkO/hJd3uawsN0BbHStOg2tVaS/Bx9Krm4jOdGOC4J7+ArcGAetiNvy+6J3DQf4xitX/cE8ATQXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAi5i+VD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ec9f099fc6so309157685a.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873541; x=1777478341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkTj2C9YliubRyWKE8nCInm/VBiYVrnMT7BPVcl4dBw=;
        b=kAi5i+VDkwGNcovTuJR8aeog2qupFbdR30y0/17VxvEhBhkQkmbR16cipYs+AmUXTk
         o/mh98OgmkDY0dmJ45tGP84t0Sz8pDaMK2U/9R6h/sbKq5sHXx1jfbB8OPjBMxSAZa+i
         eQJiPatNL6ZaR/SnoXYJuq4liGsvVGCxME0vFoNghcl4hIt2YcbBHtK4RXF4mSueQNy/
         0aKmTgAVjInAaIoiAoYkTMk9hiVk/9CJzNrXD2khBejk3tHxSKS35S1Q6c4mqeGn5gBw
         +4rprbkwt42M9jF8akFgHwpuX9qd71sY0OTySsA6B4VHcdBqrl4nQKNPzJ/CV5KdCS2C
         LkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873541; x=1777478341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkTj2C9YliubRyWKE8nCInm/VBiYVrnMT7BPVcl4dBw=;
        b=iGlvmRjBVrkalojN0GnXaiKLV6TqIdX4/sZaVro3dDKPjntUgA1d2/AvX44ZuDlfQu
         AK6bG4bi8l4xUhNvPX7SlSK7OShTc1oO4VW7Ch0T4fEIwojDqTMfw9soh2suUvh1ULbI
         hTzeavxCJK5bC9ja5W7WajeChcAUNG9uoQQY2c1QiTU8wvCVe8XIfwdFOnBJZCbdEtRt
         q7rC4NrgCfJKw37e9bzNNs6XGhRMZ5R1E+CaHVaXfh91Rlu6XuRAPG31ZbZQ3GpWSj5M
         bvX4aubWVb+1gjfxuPSKrhl3o+aB0e2tdkBgDL7Or57HmNlMEv2EngDB/3jCiz8rclkI
         j5JA==
X-Forwarded-Encrypted: i=1; AFNElJ+l0D/jQxqEnjim6BKALEajGQQrnvYZc7hCYLYco+QQiCYyaaSBqTAdz+s5SHIWkNTJQcb2G9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgZOdFgAKlVbjlWnAVbEr+2cQYyl1CN28LXPD+mDuwe59pvPA
	GZEV2hdWlJBiK4dlqA5Y1TwFCzt1AHfpqGHZtls2egzUfVLDMg1FdvD7
X-Gm-Gg: AeBDiet7Jlp82BGXAaqSy/bwP3a1Yw0dMthjd3Dm4OHtWnBSk5zBXbQ0aOzwTkfvBM0
	EAJZU3Ku4I+moz0rJ23RTWbzpqhomBaWFtde8kSiBd06Ixc475i5Pdbp5DWIw2+4wpj67kplVW9
	naSowskDdeDPm1k/czJyZ47Z75U4sklXK7c+M+x+mgfdsHosi4M8VF28dm5KF5NVuteDWpb67WE
	HN4P0qu0JI+SnnPHnBj8+uvHi8n1c/sN+4LuwYfsVzZRQmu8FvguqOg+wu+efecENi6Zgh1NEs8
	DRYCene4u4zES88+BIyqw+oMNDqC7hS9+pp1GTjGTNOQimeSJlkGazzTU35vyp93kjgi9C78Lwt
	l3ekx7HXVzSxJIJ1F+/22IziJjEEsZfd+ih7juJEJMRO1mLmX7ATWOfVK8kegW7c5p+PT0VmLgk
	sk4EqJxX081JujAsGzeSQAwgsQd1uNCjS4fB1tPEBHh+/6ArOJvdsuuDCBD3EjgHnImmf/xOUy+
	ouf4vmLX6dYXGG6aEzbByN2Iz+fdPI=
X-Received: by 2002:a05:620a:46a9:b0:8cf:d70d:cf0e with SMTP id af79cd13be357-8e79236d606mr3376452385a.47.1776873540726;
        Wed, 22 Apr 2026 08:59:00 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ee585e9fcdsm496696885a.16.2026.04.22.08.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:59:00 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] exfat: fix potential use-after-free in exfat_find_dir_entry()
Date: Wed, 22 Apr 2026 11:58:44 -0400
Message-ID: <20260422155844.1967148-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240354-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9683B448326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In exfat_find_dir_entry(), the buffer_head obtained from
exfat_get_dentry() is released with brelse(bh) before the fall-through
TYPE_EXTEND branch reads the directory entry through ep (which points
into bh->b_data):

	brelse(bh);
	if (entry_type == TYPE_EXTEND) {
		...
		len = exfat_extract_uni_name(ep, entry_uniname);
		...
	}

After brelse() drops our reference, nothing guarantees that the
underlying page backing bh->b_data remains valid for the subsequent
exfat_extract_uni_name() read. This is the same pattern fixed in
commit fc961522ddbd ("exfat: Fix potential use after free in
exfat_load_upcase_table()").

Move brelse(bh) so it runs after ep is no longer dereferenced on
each branch.

Confirmed on QEMU x86_64 with CONFIG_KASAN=y + CONFIG_DEBUG_PAGEALLOC=y
+ CONFIG_PAGE_POISONING=y on linux-next, using a crafted exFAT image
(long filename with same-hash collisions forcing the TYPE_EXTEND path).
With a debug-only invalidate_bdev() inserted between brelse(bh) and
the ep read to make the stale-deref window deterministic, the
unpatched kernel faults:

  BUG: KASAN: use-after-free in exfat_find_dir_entry+0x133b/0x15a0
  BUG: unable to handle page fault for address: ffff88801a5fa0c2
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  RIP: 0010:exfat_find_dir_entry+0x1188/0x15a0

With this patch applied, the same instrumented harness completes
cleanly under the same sanitizer stack. I have not reproduced a
crash on an uninstrumented kernel under ordinary reclaim; the
instrumented A/B establishes the lifetime violation and that the
patch closes it, not an unaided triggerability claim.

Fixes: ca06197382bd ("exfat: add directory operations")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/exfat/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index ac008ccaa97d..561fd2349218 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1027,12 +1027,12 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				continue;
 			}
 
-			brelse(bh);
 			if (entry_type == TYPE_EXTEND) {
 				unsigned short entry_uniname[16], unichar;
 
 				if (step != DIRENT_STEP_NAME ||
 				    name_len >= MAX_NAME_LENGTH) {
+					brelse(bh);
 					step = DIRENT_STEP_FILE;
 					continue;
 				}
@@ -1043,6 +1043,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 					uniname += EXFAT_FILE_NAME_LEN;
 
 				len = exfat_extract_uni_name(ep, entry_uniname);
+				brelse(bh);
 				name_len += len;
 
 				unichar = *(uniname+len);
@@ -1061,6 +1062,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				continue;
 			}
 
+			brelse(bh);
 			if (entry_type &
 					(TYPE_CRITICAL_SEC | TYPE_BENIGN_SEC)) {
 				if (step == DIRENT_STEP_SECD) {
-- 
2.53.0


