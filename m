Return-Path: <stable+bounces-266691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qOdsJxRoMmolzgUAu9opvQ
	(envelope-from <stable+bounces-266691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:25:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E8697E0C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 11:25:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=JNVbKqjW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266691-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266691-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1234300A601
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A63A380F;
	Wed, 17 Jun 2026 09:23:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB73A4539
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:22:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688183; cv=none; b=VkFXb5R0qc9HGw1R12MBWHAhlebIkFbP3YjUcCEjDYyCDeAvm+VZM1zXixoiN/cHDatC9EBBU41hKc7aEJ7Us7NqeubzKKwRn3DUHkBMIOT6A+FnoPYNO5zymS9ddF0XfEz09pMWi+y6ied/RN9Ddil3FJ+BbenAEE8EEcKIm/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688183; c=relaxed/simple;
	bh=liFDqSGLsFRV+8NH5P3wFjhjjK2slQDQ3iLuLnnghN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqdD06WE338EkXODNSWvfgj7Q+PHkJEWZgRte3ZHedKE5yrFEGeABtmJootz0NKsZ8FbHOLNxefmiqRkrC292GrDl9gW7dXfOLDVmd8Zif/AGVUt1DBYa2zcS9VnQbXQk+4tomLZ1kgxZzBfn61dz/8CgbTjrLWfRsM60EYzz7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JNVbKqjW; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8423f1d8902so2605188b3a.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781688179; x=1782292979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4Mt2Iqchc17KPwGM0drtBt2mRhj/4CUcfdGwg0LVw4=;
        b=JNVbKqjWCYRx4zIrFdeYRYZ9R38sPN3bVtQieuByhGVjVG0eB1lB1vp3zqNVQqCMBj
         +UuN22Pekfs5MaExIGV76wnVb9R/R024PqdGGtOzNukKle8bksCpdCTIjrieUISzyzVl
         VEiznhrfaA0Bl2omGKmzCzFxAEOpF+rp9qXjZt4hosaYTxPLfl/cNqj+0/Tm3kUnE/8m
         AW1o/WOAx8Jgz0iqGz8SY03F0sjLhMhL2MySBADgntq9j3rUhMoh2T0dIi2Q6pX72uqs
         h/cMaE82mHSmMr55BuZolXFu49tTKL1Oiozx1/rgQJ6P188wrKmv+Sa6cM0XJU8wLSEn
         54jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688179; x=1782292979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4Mt2Iqchc17KPwGM0drtBt2mRhj/4CUcfdGwg0LVw4=;
        b=YCAaZnB4uw5DjyBp6ivgTFuCbbz6KZ5Uo4geieElo2DEShBv7k68tuOU1ZeK/Yvrnf
         p01PWUve5sRrP1SqHVez9b9wuWkqWki6858k/h6une9C7+PbnpI38plYc/shvfoOk9Hw
         jfpCYqHKbND6XAxqBQcRSDuZ5AwSI0W5k66J+FDBxfHw2yPw6DSwesDk5H88dBSpW9Rb
         U5+TWxmsPNdtrjL+cjRdC4F6eNTzia8thBILMMjGzvD0SoOM94ootOmm8xNqeKmfn+Xh
         EIO5T2MdYKQMXnnT8kl07Hg/ekD1npIFnWjSqFfWjGXStG7ZRCBoFAatJtSGjnjQqGP0
         fxkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZYeMh23syf1lZB4GXih6lutMHX+x7Sjs3MukUXfOD/IKbMWTeWej603iO+U+cZ0r2bWA2OaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1r6tdfn3vi8Lk4wqjCVUNnLCzQkt+dEYWjdynQVFuwnADwZR
	OEV9kgmly99A798kSfk6/Iz3KBkfvfodItwauVcJfP9YEsCFnDpQFlA4zq1PqelSZQ==
X-Gm-Gg: Acq92OG5eMWXvYCmNpP7A+Bit9MYLow8DYTOPuy/wInId3qddIKoJzKOXF5FPn9YJaA
	3IeP7RZ0Inix9BZgxsQggU1JYgXp4os6Batlme5iP3miA10G0LFpJ3Qswd9GgfGEM4u2gwkx0r1
	Ml8vt65zNtblf+aa/jqAwiEXltXcY5LaHms23mMnfAAT5PtzZFqWO0Nqt9Ul4W1lPeKkYEuOz8b
	Zv1vFjoUTJPuJb71gshYHnFVww1Kf8b+n+s6TVwSoiYGEjorQxZQnCjBVW07TV9JajYZmWuknwP
	LvQE/I+GFoENku1jIWGDmNBgBATKDB5DzbXwRPOjWt8cMu8pWAhzOeG3J5FJnM+wgg6sWuYWKYt
	xtKqdjvm8yyG85oBMfPWSFyqrL3EVx7gkxBFdgALRNyPIABtqvCPAgRy5DkUsDtxpGlu+Dw==
X-Received: by 2002:a05:6a00:2d28:b0:842:569d:b105 with SMTP id d2e1a72fcca58-84524562663mr3071526b3a.34.1781688178670;
        Wed, 17 Jun 2026 02:22:58 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9dc5esm14636685b3a.10.2026.06.17.02.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:22:58 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	security@kernel.org
Cc: Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs/ntfs3: validate dirty page table on log replay
Date: Wed, 17 Jun 2026 02:22:34 -0700
Message-ID: <20260617092235.99610-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617092235.99610-1-xmei5@asu.edu>
References: <20260617092235.99610-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266691-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,asu.edu,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:almaz.alexandrovich@paragon-software.com,m:security@kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF6E8697E0C

Each DIR_PAGE_ENTRY ends in a page_lcns[] array whose length is the on-disk
lcns_follow field. check_rstbl() validates the table bookkeeping but never
checks that this array fits in the entry, so a crafted lcns_follow lets the
v0->v1 conversion memmove and later replay passes run off the entry.

Add check_dp_table() to reject, right after check_rstbl(), any entry larger
than its size claims via struct_size() (the same expression used to allocate
these entries, so the check is overflow-safe by construction). All consumers
can then trust lcns_follow as the real capacity. This covers every
page_lcns[] access whose index is bounded by the entry itself (the
conversion memmove, the HotFix store via find_dp(), and the self-bounded
scan loops). Accesses whose index comes from the log record need a separate
bound and are handled in a follow-up patch.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 fs/ntfs3/fslog.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401..b1ca84d83de5 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -778,6 +778,20 @@ static bool check_rstbl(const struct RESTART_TABLE *rt, size_t bytes)
 	return true;
 }
 
+static bool check_dp_table(const struct RESTART_TABLE *dptbl)
+{
+	u32 rsize = le16_to_cpu(dptbl->size);
+	struct DIR_PAGE_ENTRY *dp = NULL;
+
+	while ((dp = enum_rstbl((struct RESTART_TABLE *)dptbl, dp))) {
+		if (struct_size(dp, page_lcns, le32_to_cpu(dp->lcns_follow)) >
+		    rsize)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * free_rsttbl_idx - Free a previously allocated index a Restart Table.
  */
@@ -4209,6 +4223,11 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}
 
+	if (!check_dp_table(rt)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	dptbl = kmemdup(rt, t32, GFP_NOFS);
 	if (!dptbl) {
 		err = -ENOMEM;
-- 
2.43.0


