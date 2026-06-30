Return-Path: <stable+bounces-269939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /bV0FjWVQ2q/cgoAu9opvQ
	(envelope-from <stable+bounces-269939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:06:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E38526E29F3
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 12:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nbCkmdtv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269939-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269939-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55F4A300598B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F673EB10C;
	Tue, 30 Jun 2026 10:06:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E33E44E0
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:06:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814000; cv=none; b=nFZqfYc7ecCSOrkou6bN2Idrl6X0ikX9xwMmh3N6VyHxzVlHXxYqTeAP8krg1hYJHshFmSZHhnP7sslFtl6QRJI18xP0NgGsmXAAc6kScuem97POO9lEFJAx3gKMiSaVRoSBWvKm2GaV3lOZirZjbxIwL1Agx8Vs0peC0//pQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814000; c=relaxed/simple;
	bh=jLHPncpWDl0+2GMPq5aycjfL2hE5xvIsIfTOWjV86Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlcg2NfciB5ATfekA7SO0tovTsTdHCDkglcRjytnewgMrsgxG7rz5W5XxNoWrJAzX0ZOp6RO1aUpiMS2ebW/lIEyKyRYKKNR5bjXs576R2ED6Xs0oXMK1Tjk10a6xiue2thdQ291q8GfZzg+Qe9ajw8o4z3+jzdOlzhKBlRVFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbCkmdtv; arc=none smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80cbb0688c8so28670247b3.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813998; x=1783418798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMhrCDxHf7aAooYY94uRPeuetG8ov61hCXcWeNIKwUg=;
        b=nbCkmdtvH7U3XjDz65UKLKoc1LpXnyacN4uuQciKW28jvtyioLkOVJgKznMwD6KzEJ
         5rsub8axUdBD/0Zg6cc+kHCGPqCk/OwS9tvaQn7LiWV7QrjLs3JmLlbxMW1Pnutqeo5A
         kmVnmwO9G0LeFjNw/kp0uXyC7M6d/cEt0fZK5j4VMozrqFMvb27jVLDbEa7Ofjzvpdu4
         WIXVYZKhfAvnDAKsPRAIMIMaThyEwk6s7wvRbeaGxB4SgxW1SUFHq4vkxpVNrBCGSg0b
         12gUeUoZTmmb7qgLZoutdb4dXyB5GunghT03gAnjonPAeX99H5PmNKVsu0VyMyLHlbuv
         pSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813998; x=1783418798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMhrCDxHf7aAooYY94uRPeuetG8ov61hCXcWeNIKwUg=;
        b=eDkL2SCrl2QGrt1SoeBqOVA528g+Msr/U2QYRdAaNp0yFDwiwzWIMrjtXA+bJiqRlg
         DJz41BOK1hD0zjl1oIvotq0IrsvUs9Pyv84mgj9HanDdpaAjNH2sl4xHGVXenpK4qbYr
         sVf1LjmggQ0FYnuNvrKClVTknVLenBJNt65jmB3dktSqyLnU2wjdqVAS7NdR4qfk2RZM
         wm9NZTJvlshPjh5NeEWiC+khHlQJqALQH4xaVW1+ZOMnTeP3rWYDoz52F0cx4GSx4vzk
         gq5kr54ct5c+H8ahSJy2Giyzf9iLVRsaa78HRFFdGiSHQrJvE4I/U/i0kTypU0k/NqOQ
         dXOA==
X-Forwarded-Encrypted: i=1; AHgh+RozTwOlQUXw799dBdAE2a94KcXcOREPCONUBmLCa30UcgpZqbLrsydRWDJXuLJVW2uL7PmG3rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKeHdxsDZ/35NcIhcgizdeN0j5qcourpYPywm/LxlZW0JfYuPd
	rfKqHCoq1b1w7ZSIFnx+wzOSMQn8E8HJS92VREf3y1nKYm2XzTR72bg6pxilyejsEY0=
X-Gm-Gg: AfdE7ck77ZmsZQju6TAHEl902CmZ4AZq6g7uAjFyauMMbPSOPXNRG5wjQPOz1s3MpER
	O1Nr+pYFf8rznPUGQcp3AtI0iIVjCt6yenFsV6HzFu6/w47wS8NaWquSnISJCSSwZ8ZM6Rp/TGY
	1Kubx45yLw1aOhrkdUDblU8CGMzKucFx1aAM3K6QLNn+bPU7nZtjmWjhwAk0HbQUIlJpoE6tANw
	YtoARuqC/ErdTd6vKnMUF7DGkr/+d/XOvHsU0h/cNAKWuxNUFBc/eG0RNLUlNQbI0cHcPZczRar
	Nzf0d0n1hlWSoL9wOz0LPwBD/0bK766ZQ8nNw9D6VDJ5/gBjMvUJKHgcJXNDBYWqX83DjiGYEGY
	b+E30NmNtB6O42Bb2qICdK3hp2dynq9MvfG1axx9nxFFjuSDA37hqHQLGdm8SY1YzbaaIPtw5MN
	slwP5sy/NrSTlSJzzoHeWW2qSGBYNKO50kiuaQ
X-Received: by 2002:a05:690c:e373:b0:80c:72a1:fca3 with SMTP id 00721157ae682-810d7ebe061mr34389197b3.16.1782813998261;
        Tue, 30 Jun 2026 03:06:38 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e7c6e9f3sm8837187b3.19.2026.06.30.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:06:37 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v2] xfs: zero newly allocated btree root space
Date: Tue, 30 Jun 2026 12:06:21 +0200
Message-ID: <20260630100621.7173-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269939-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cem@kernel.org,m:djwong@kernel.org,m:linux-xfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com,m:alhouseenyousef@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,97f2c05378c5d68dcb8c];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E38526E29F3

xfs_broot_realloc() preserves the existing in-inode btree root while
growing its allocation, but leaves the added bytes uninitialized.  The
inode log formatter copies if_broot_bytes bytes into the journal, so those
bytes reach the log record and its CRC calculation before every location
has necessarily been overwritten by btree updates.

Request __GFP_ZERO for the initial allocation and every subsequent
allocation or reallocation, as required by krealloc() semantics.  This
keeps stale heap contents out of the filesystem log without a separate
memset after each growth.

Fixes: 6c1c55ac3c05 ("xfs: refactor the inode fork memory allocation functions")
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: syzbot+97f2c05378c5d68dcb8c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97f2c05378c5d68dcb8c
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Use __GFP_ZERO instead of an explicit memset after krealloc().
- Apply __GFP_ZERO consistently across the allocation lifetime.

 fs/xfs/libxfs/xfs_inode_fork.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 606a36526ce2..dc05540fa85b 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -384,7 +384,8 @@ xfs_broot_alloc(
 	ASSERT(ifp->if_broot == NULL);
 
 	ifp->if_broot = kmalloc(new_size,
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL |
+				__GFP_ZERO);
 	ifp->if_broot_bytes = new_size;
 	return ifp->if_broot;
 }
@@ -417,7 +418,8 @@ xfs_broot_realloc(
 	if (ifp->if_broot_bytes > 0 && ifp->if_broot_bytes > new_size) {
 		struct xfs_btree_block	*old_broot = ifp->if_broot;
 
-		ifp->if_broot = kmalloc(new_size, GFP_KERNEL | __GFP_NOFAIL);
+		ifp->if_broot = kmalloc(new_size,
+					GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
 		ifp->if_broot_bytes = new_size;
 		memcpy(ifp->if_broot, old_broot, new_size);
 		kfree(old_broot);
@@ -429,7 +431,7 @@ xfs_broot_realloc(
 	 * object.
 	 */
 	ifp->if_broot = krealloc(ifp->if_broot, new_size,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
 	ifp->if_broot_bytes = new_size;
 	return ifp->if_broot;
 }
-- 
2.54.0

