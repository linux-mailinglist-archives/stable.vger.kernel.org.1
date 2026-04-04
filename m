Return-Path: <stable+bounces-233287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH5xHI8W0WkUFAcAu9opvQ
	(envelope-from <stable+bounces-233287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 15:47:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF839B3EE
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 15:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4058F3006025
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16224264619;
	Sat,  4 Apr 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/V+D/OU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A36A248F57
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310473; cv=none; b=UmF9nsjp3kFCs3a5OOg3T0qbKLDvtDy8UJktncPx3RaTO3pVjNX/Ef6OY9zT/h6V3TBZpAH2jDv/exeizK3Mx2b7SHwxIm+zQJqZWGPERYQ27bEYZdHNQwhGnE6/k6pKcfeivZ5sTfNSIwwvwKKn+S9YGIOzgSZ0nbKAp/6JRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310473; c=relaxed/simple;
	bh=uq0ekskcm1LLoYGE+0NzPOrNZYjEyHzQo7kQCHFrxeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxmN6jztB9lzmK8e8x/a9O0CC2htYpm7XXqXnk34JJV/Nv+ucWtH6NYQ/2nXbLdjUrRrwKBW8yAE2F0hPB3xZG0G4aA1fMExQSzM+DDsgds306PN5BSZGVSCqWHiFKDCIpFRnJNwNauXZFlpJD8Fauad9ey2DXGDViFWf2836uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/V+D/OU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso22451655e9.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775310471; x=1775915271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKsbChh/VnKTH+OmKvRes4T+gJ5uz/EkfVx8lzU6MpQ=;
        b=M/V+D/OU//6VDzZOaakxu4VylIsXYP1VEDtKxXxOl6x6XcLfPYuSKJQK1e/RWN7GTM
         bCWnDOVIJ3ohI+CUuwxxmDZnXUl/zLqHDEaSP4ptV0wbRXYww2v1qFLj8+D5R+vSYTcn
         6ifWgaNIig55fmCCHDFw/ohpJlmLSTRkkGpjDf2Ys8prl2AE6NRWA1FLT7dvbrR7mr0L
         z5TFj+lXbUi/Oo7UdPkdovwAnyEmv9WKagjZCH/Eae23JZQwrI+/0Hm+R5it9HvafP67
         LE5d5VXsM+u6YhpwmuKBXmsAL8txQg8z4ToqD71iidf2nWf+gInZJO70OK5ta9dBKmRm
         zKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775310471; x=1775915271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKsbChh/VnKTH+OmKvRes4T+gJ5uz/EkfVx8lzU6MpQ=;
        b=fwJngKFoVDfz1H7gRC/50pFJEUgSYJNefnAU5SCHu1THM8BaxSEiy4SS46z4K6ED+Q
         eSDfWV+TMPVE7lsoAK4cKVylUOBQiOtTqAThrYn2lBHmgoaQLxGkm7UIu/bZ/wLsUn1U
         GoPWAHWUQ5ref4LIMI1zGhaucg91KFqaxP5S8/EfWq55y9jJbUVsOvEK8Y+UdNhn8Kze
         4Xfa56TaLFeqvXmXWOaqBfCvia75gopZ34LqqN+O1of+UdS257xwP/pDuNzN3hnNlNov
         XVn6OsD1PtlFd3b3MQQ42q9iwnJc1inW2+2AAcQuYi8uFBCR5EfrYUCZHbfzBawwMGz1
         ch0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxaz9JxfLwZdERa1GabpF7sPqVpTM21LtwgloB4xCX9DlJiSXpBP3n5IS1sC6UR/Qhxc0/Kr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrU1lkLV3ErHcA5F3kQpOpKFZCg4EiLQBIOC7IcA3nC8F9umCZ
	m5tT3qk/a9aL1l0MhIB55gjV4nj1QDzCwf5xA+war6dYpfnabkTJkqcW
X-Gm-Gg: AeBDieuouwhxVBD90bpx6bVOHJn3LePrekA3sV4MZ0wPoFXQUqLouKu4Mf4+dxEuJjM
	EvipOJftb3GJo1UIzvnFEBup1vkW+rVP2IC2HWmDtOc41+aLh7Fb6UVyQh8yQf/4GRtebIMvOgF
	wE5a+SHEzoSKfQBappgTaVcHNGECsRnj7Y+2zIui9M6X+mgwG1hJSdg+CZgth2Olu76xRFR6whO
	1v3r3HTd69YPa6/K5PnRmDKqrjJ1Kko/vw64BOAHCGw5BSL74zxXAyMCcfYYRSHjmVQGIvTrOD5
	Ma4Q2raENbHFq9bNdfAVQOPLclI1thE4T4w9DY5pWAlcQUP6vuO6MbHCtOuFTYukZfCrrx+h9Ga
	jBmhTttHQhiJT8/3V8CxQMWTOhJKdpcWbqVmbPr5DgPbNc/Fh8W54FORyoQ6Mk6EwosJP3HSUx1
	o/XUKW1M45qkanXPVIc7WJ7d4T33VdXUj+LQTHPI5JfEjuCxUwTjHPe/ats2QYbV+rymNkAidcw
	NysKTx7LgkK
X-Received: by 2002:a05:600c:4e0b:b0:488:869c:eda6 with SMTP id 5b1f17b1804b1-488997d6b8dmr109572865e9.29.1775310470482;
        Sat, 04 Apr 2026 06:47:50 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a8d6e27csm24056165e9.6.2026.04.04.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:47:50 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	kaleshsingh@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracefs: fix default permissions not being applied on initial mount
Date: Sat,  4 Apr 2026 14:47:47 +0100
Message-ID: <20260404134747.98867-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[efficios.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233287-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EEF839B3EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit e4d32142d1de ("tracing: Fix tracefs mount options") moved the
option application from tracefs_fill_super() to tracefs_reconfigure()
called from tracefs_get_tree(). This fixed mount options being ignored
on user-space mounts when the superblock already exists, but introduced
a regression for the initial kernel-internal mount.

On the first mount (via simple_pin_fs during init), sget_fc() transfers
fc->s_fs_info to sb->s_fs_info and sets fc->s_fs_info to NULL. When
tracefs_get_tree() then calls tracefs_reconfigure(), it sees a NULL
fc->s_fs_info and returns early without applying any options. The root
inode keeps mode 0755 from simple_fill_super() instead of the intended
TRACEFS_DEFAULT_MODE (0700).

Furthermore, even on subsequent user-space mounts without an explicit
mode= option, tracefs_apply_options(sb, true) gates the mode behind
fsi->opts & BIT(Opt_mode), which is unset for the defaults. So the
mode is never corrected unless the user explicitly passes mode=0700.

Restore the tracefs_apply_options(sb, false) call in tracefs_fill_super()
to apply default permissions on initial superblock creation, matching
what debugfs does in debugfs_fill_super().

Fixes: e4d32142d1de ("tracing: Fix tracefs mount options")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index edfdf139cb02..36058ba5ee48 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -491,6 +491,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	tracefs_apply_options(sb, false);
 	set_default_d_op(sb, &tracefs_dentry_operations);
 
 	return 0;
-- 
2.53.0


