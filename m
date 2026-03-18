Return-Path: <stable+bounces-226992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEMjFwVcumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:02:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F228D2B7683
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5408306A832
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683F371042;
	Wed, 18 Mar 2026 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoM/z0qM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3FC35DA7F
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820735; cv=none; b=j0F0oe1oYyCKaVF1AK0FRuf4+RO02HayJSGKq9gsm2vVlfFtsXEwfp34rOmlzTndJTzcpMkqB252Xy1xV7D3GQ5kVevNoCrz5cGijSh1rNTwzqL0xzDpaTim26r4AqaIPs+tF8dkpQBlZaXHhLGd+UPS05fLOq/OkEpo1UzQFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820735; c=relaxed/simple;
	bh=+dxtWE1DwIgIzEHxMwSi9pwNrnQxZQGBzo8VT4ntRIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usouQcPqPeFZBCumrGFemeOeA5O21Qz96UB44QVy4g3vG8J19ul1y96ONIZlRm9NsEp0ooAs7O4kG+p7lQ9NNZ+odsoifujB+PIM44sBrVDmvc6ELuqtErob8PDeMGjcp0ZPtO4TJulXcDD0LXxBjSxHV+UwNtRawPdqt3KvzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoM/z0qM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b04fc8851cso36685055ad.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773820734; x=1774425534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HhVqm7dtmhIq5iMPEQ+RzAXpBXYN81Z6Q4RNXVVrMG8=;
        b=CoM/z0qMtFbq4/X7gHeRUYnGPf7z71khDevB8UwzCbpapQS3MkEBad5FtT2zX3uG9Y
         zQglQo5lHySGcmEUHSPYt/eLt0CuaCqPxb1yQAF1FAWCespFDwgpUaZicXTd7Snwdc2G
         a+CcR6/sozaWws4XASUidDNUFEMgdOf2j7gZjP6Fnd09OV72qoBotPz9lrjiHJ5MxHFD
         0vIgIAyaarNBNVbVUKy7N37CmlIbrAfMGgQTthKG/g+SXqt86RxqsZzzdKO5ARQND5Iv
         EBLcVS+MxFyTqJJ88k3T+b/AKmiHgNc8d6Ov32EAzkIggfGS6tDgdR3zzYNKEyEbXbTi
         pJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820734; x=1774425534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhVqm7dtmhIq5iMPEQ+RzAXpBXYN81Z6Q4RNXVVrMG8=;
        b=SnLj24qMgHIIcWLNuhx/4hSuDHfmaPrvrcn3nV/7B7L7yotQJyJ/vOdm8GH227ksAI
         le/T2K3x5wttrgtYWnIJWrPSJpHDEvjTMZOyswRmJJODk8WSI4k+SPk8wEL1yAmMn7uT
         aUwsq+r5ZxkYQ+fQWrETmEzTHDhvsaQg06KAYb4XxImXlJeDX9DBd4ZIM12GoimfLUml
         R9ssU3xfDfWVs31Myhw2Ul2BTC/TcHAcQ41XHJiUGGtD3+bouLgjlhiUIjYZYarXDcgY
         EZ7WQdh/S2AMM/d80Xzr94StsxA12LG3DBUfba8u5nx9hdTzxwrjxcugovD0KWA4C0V2
         yWtw==
X-Forwarded-Encrypted: i=1; AJvYcCUfTAkbyQod4J8YCRhtQvDzN/l0tGDCH8dhiRW01aoXTRkzrP7NeRudaFyh7CtP318Y966ankQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANkfxdqn36A31g7YfFz0bGVXOlIX1sePBNc492jsU2DcbCweq
	BuOrNmQVG7ylHOvFKrxsXezqRbhxLM4+PbWgZFqnveBE7LnZQbqJ99OO
X-Gm-Gg: ATEYQzzP5Z4Ja65QVu2BZDU/IaeAHGDwljPhfNbOEGA/jXxDNqDnHUIxMrSz+T+h4zb
	jJNSMHmakC16KxHLMl6bur8WCxfv7tuQDdHzPfYINaldDQa8un3ARkmP7bqAeESEpy/Dl8+lukU
	/BTOXKYJNW6VtkcuTT2jYqfWVBZYEmC4Leq5o+wWSVsL9DrxlHtt72ZQeuqqSQVFvrnW7Zivy8b
	uhe0UoOopCm8hddAuLuWNknSovKJv5ncaWho+iix+HsYF34DDiPh2eXmpZvacwMmBv3C3oXXJfu
	b4dxtRDdxGvGpLuGbBikUDaheo6qA+Xu+jwSeamhDEk+K3JR+K+Ym5YT51KkENiUAIIBg/3KKa/
	Au3bPCBJhelZjc5kspM8ragPK0Ewiad37+EAlFm0F+XrPybY0FKzA86PsEXsdAy0Tz5lUsg8B5C
	haw1cVfSe0mspss7HHoWv7/Qv5y0MI8BsesxGkp0LtqCBRALTV8g9qajfCWsT8k5rQCHKtyJI=
X-Received: by 2002:a17:902:ce11:b0:2ad:d5d7:bad2 with SMTP id d9443c01a7336-2b06e43709fmr25696775ad.48.1773820733922;
        Wed, 18 Mar 2026 00:58:53 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e41aad6sm17610545ad.16.2026.03.18.00.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:58:53 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	tahsin@google.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: xattr: fix out-of-bounds access in ext4_xattr_set_entry
Date: Wed, 18 Mar 2026 15:58:42 +0800
Message-ID: <20260318075842.3341370-1-gality369@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-226992-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F228D2B7683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
KASAN reports show out-of-bounds and use-after-free memory accesses when
ext4_xattr_set_entry() processes corrupted on-disk xattr entries:

  BUG: KASAN: slab-out-of-bounds in ext4_xattr_set_entry+0xfc2/0x1f40 fs/ext4/xattr.c:1735
  Write of size 12 at addr ffff88801a249af4 [slab OOB]
  Call Trace:
    ...
    ext4_xattr_set_entry+0xfc2/0x1f40 fs/ext4/xattr.c:1735
    ext4_xattr_ibody_set+0x396/0x5a0 fs/ext4/xattr.c:2268
    ext4_destroy_inline_data_nolock+0x25e/0x560 fs/ext4/inline.c:463
    ext4_convert_inline_data_nolock+0x186/0xa80 fs/ext4/inline.c:1105
    ext4_try_add_inline_entry+0x58e/0x960 fs/ext4/inline.c:1224
    ext4_add_entry+0x6d2/0xce0 fs/ext4/namei.c:2389
    ext4_rename+0x133c/0x2490 fs/ext4/namei.c:3929
    ext4_rename2+0x1de/0x2c0 fs/ext4/namei.c:4208
    vfs_rename+0xd42/0x1d50 fs/namei.c:5216
    do_renameat2+0x715/0xb60 fs/namei.c:5364
    ...

  BUG: KASAN: use-after-free in ext4_xattr_set_entry+0xfd3/0x1f40 fs/ext4/xattr.c:1736
  Write of size 65796 at addr ffff88802feb6ee8 [UAF across page boundary]

[CAUSE]
During inode load, xattr_check_inode() validates the ibody xattr entries
found in the inode at that time, and ext4_read_inode_extra() sets
EXT4_STATE_XATTR after the validation succeeds.

Later, when updating an ibody xattr, ext4_xattr_ibody_find() does not rely
on those already validated contents. It calls ext4_get_inode_loc() and
reads the inode table block again, so the entry eventually passed to
ext4_xattr_set_entry() comes from a new on-disk read. xattr_find_entry()
may return that entry based on its name, but does not revalidate its
e_value_offs and e_value_size before they are dereferenced.

Therefore, if the inode table block is modified between inode load and the
later xattr update, the code ends up validating one version of the xattr
data and using another. ext4_xattr_set_entry() may then consume corrupted
e_value_offs/e_value_size fields from the newly read entry, which can cause
out-of-bounds accesses, size_t underflow, and use-after-free.

[FIX]
Fix this by validating the target entry's value offset and size in
ext4_xattr_set_entry() before using them. Reject invalid entries
with -EFSCORRUPTED, consistent with the checks already enforced by
check_xattrs() for ibody xattrs.

Fixes: dec214d00e0d7 ("ext4: xattr inode deduplication")
Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/ext4/xattr.c | 58 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ce7253b3f549..3ebfe2dfcae9 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1638,6 +1638,48 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 			EXT4_XATTR_SIZE(le32_to_cpu(here->e_value_size)) : 0;
 	new_size = (i->value && !in_inode) ? EXT4_XATTR_SIZE(i->value_len) : 0;
 
+	/* Compute min_offs and last. */
+	last = s->first;
+	for (; !IS_LAST_ENTRY(last); last = next) {
+		next = EXT4_XATTR_NEXT(last);
+		if ((void *)next >= s->end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		if (!last->e_value_inum && last->e_value_size) {
+			size_t offs = le16_to_cpu(last->e_value_offs);
+
+			if (offs < min_offs)
+				min_offs = offs;
+		}
+	}
+
+	/*
+	 * Validate the value range before dereferencing e_value_offs / e_value_size.
+	 * This mirrors check_xattrs() for the entry we are about to touch.
+	 */
+	if (!s->not_found && !here->e_value_inum && here->e_value_size) {
+		u16 offs = le16_to_cpu(here->e_value_offs);
+		size_t size = le32_to_cpu(here->e_value_size);
+		void *value;
+
+		if (offs > s->end - s->base) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entry: invalid value offset");
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+
+		value = s->base + offs;
+		if (value < (void *)last + sizeof(__u32) ||
+		    size > s->end - value ||
+		    EXT4_XATTR_SIZE(size) > s->end - value) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entry: invalid value range");
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+	}
+
 	/*
 	 * Optimization for the simple case when old and new values have the
 	 * same padded sizes. Not applicable if external inodes are involved.
@@ -1657,22 +1699,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		goto update_hash;
 	}
 
-	/* Compute min_offs and last. */
-	last = s->first;
-	for (; !IS_LAST_ENTRY(last); last = next) {
-		next = EXT4_XATTR_NEXT(last);
-		if ((void *)next >= s->end) {
-			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-		if (!last->e_value_inum && last->e_value_size) {
-			size_t offs = le16_to_cpu(last->e_value_offs);
-			if (offs < min_offs)
-				min_offs = offs;
-		}
-	}
-
 	/* Check whether we have enough space. */
 	if (i->value) {
 		size_t free;
-- 
2.43.0


