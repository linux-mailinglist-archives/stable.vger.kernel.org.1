Return-Path: <stable+bounces-226985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAszGxJZumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:49:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AC2B736A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8A03019C9A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5936AB50;
	Wed, 18 Mar 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF7gwhIh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F836AB73
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820174; cv=none; b=XdX0PXmD0blyVzi+G4slirRWx4hPTX5uQu6YSR5325cUhkzA/z4mJz9YV++sgrf14RW+twnHKK7jWM8xb9AaPHqWZ3AuLc+94p80TtBHB3B3nojGCydJdNk2sHf5GiLgBCqm+Z9aeeH+GPJAzmfZrfxU03wt0PSdXbLgteNdYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820174; c=relaxed/simple;
	bh=Wajn5p3gSwmM1hWhbn7Na6BCbaCSf3OexdnxUOucPdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a5lHkIIqbwBcJyw/Qm+ypPlSnDpurd+b3KU+kiJ6V/dpMR9q2fePUCsqpCgyY2YPtqi3w+em56jjwe9Fo6URP0kjVQW5kDubSbtmKsOW66vQMJGm7LV7oD0RmgWNwLcaYUi790XjyGA3ob0NEqSwqHnT3FseCGfbzezIshtz064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF7gwhIh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so3164805ad.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773820171; x=1774424971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TaWUN2xZ6ZNLkJtyGAWp0KGRb8y1SHDUdrDq8BJZywg=;
        b=LF7gwhIh3Jy0TmidlpSRxUbaLoe2qoNpVEwkRyHnva09kt2QshVIx3UgYOy7Ls9Z0i
         juZUV6esbBcvtqxOFQE9keaPDJb48IQcyyyUs3StWnOhb68s3AmLOR2CQDJzPR5cHrbc
         o3b5wlhl31p61bDp2scxs9ar5LtLdoFtz0n3cjzw+0ailJqoz9R2sPTCew9D/35/Th08
         mOMoSTuF4GcNPSYF6zNKWyaKnoOPQjLjQvqaF/da282shDc4DhiMhQBBF11BZwmJ+jZR
         j6aK2/lN52l7Zl9taxvggPYfkdrNF4d5izJjVOz4h1t57KtmxmAlbzxc0OmR3j/F9Kv+
         hNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773820171; x=1774424971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaWUN2xZ6ZNLkJtyGAWp0KGRb8y1SHDUdrDq8BJZywg=;
        b=bPWSCfqKZCm0zWxUtNrvNDBKy8vagktxtk+RuBqFEC79u/95OpfvuZeMfQRLuBVOij
         FWA4bh2QDM+15cn9QXdGS5xt71ma1tLdTrR0SixZjJglGaJy2UW1ifCY5dWzMXD7wVLB
         uAIpSsve70jxWovE4NnnSbxZDX5ms/cvcv499BF2uYuvBRC5GF7sFB9zx2bgY8+kgJRF
         86nFd2KbXUz5J7uf/SV7EPEWkw+LmpjWoqjuXwqBKFbTT10XjMEmda15HU7hIh8Fk24a
         jdviRI4Pjm5zVDNt5KZ7U6GOKQVaWiP9O1VFiRhZQSVdhZabIf44KblX84+lUKK+YCCf
         HObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmJppA3ZbUyElTy8BtfM9KuuO+n1+o99FnMngQIMLvRt1UX9ndpkIl/rEndzyWFc3dAFbgqQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya8UkV0slEGlsQoW6tEF1SWlkkOI2p5MscGOkBwaRQbzaAT7YN
	j8hdT+CqC/ehwtGFsyr1FfoFCjmpXM2XsCXm+QjtfbTAQCXJ/AFPvgMQ
X-Gm-Gg: ATEYQzyQJlAipndzOf3YObakb1gxl+/hoesFBzSg4EWn0SoBJWjwBcGxsi49soa1583
	74EQIDUFlmZM/1pJ9QE+xnkzbF2AquwrpAbGuCv6KGzN/aiUP5FPH8q3Sk+dBaAlsdYBELnJNKB
	kD/CtLrtWR9x+amRe/oIvOwfXNryi97N62xcAp+nyl9EJQpmfU++CsG/pooFTIk9AE/IS24zU1Q
	xmGZAvz5kKJnj4aAU/D6Do81FqPxGKhHr84ce6z6z0GTLb8zuQNZ1qP69PJ6YuRXNp8GV19QX58
	C70D98CToEUSadBmgNOzt8NOHvrazazXiLRP2OV+HRMZLvxmGkBAVceit8TP2a7heXQIQcPB0x2
	IcKCsQ6iqy5VzP9+msYxIOj9IwbxUSc9MRTUyvWnREfVu8JGpx5Km1+92mYZtaHlunCZ3m1v7f+
	VW/Dl2zw8cwWzoXLop7g==
X-Received: by 2002:a17:903:1a67:b0:2b0:48ca:a641 with SMTP id d9443c01a7336-2b06e3c3abdmr23929835ad.25.1773820171046;
        Wed, 18 Mar 2026 00:49:31 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e604e7bsm23349425ad.63.2026.03.18.00.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 00:49:30 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: add READ_ONCE() for i_blocks in f2fs_update_inode()
Date: Wed, 18 Mar 2026 15:32:53 +0800
Message-Id: <20260318073253.3108313-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226985-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 369AC2B736A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f2fs_update_inode() reads inode->i_blocks without holding i_lock to
serialize it to the on-disk inode, while concurrent truncate or
allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
u64, this risks torn reads on 32-bit architectures.

Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
potential compiler-induced tearing.

Fixes: 19f99cee206c ("f2fs: add core inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 078874db918c..73b913dbe02a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -694,7 +694,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
 
 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
-- 
2.34.1


