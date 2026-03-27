Return-Path: <stable+bounces-230657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ly7Ge6IxmlELgUAu9opvQ
	(envelope-from <stable+bounces-230657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF073456F6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB01630E4E00
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287030F7EA;
	Fri, 27 Mar 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmz+k6px"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87E42FF15B
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618288; cv=none; b=mRNS7nOh5T0Bcyoes8B/uM7EPnVVgUGQxrlTObB++RzSgJDw8M5ac6F927HBUhbKHPh+wRT3ol4oguuBL+venTHZKv11YvwW/0gov1szWC5ZIOtvTN/0tbK7u4EBUccDOiuEZU/x4vdN9lcbj6qQSJ6kl77Iu5xtBa2pQ4/zjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618288; c=relaxed/simple;
	bh=aWFKLLyrUGMfgtno2wrwFP6oJ6cGkB7K195WAeAuroI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAvFE2F0eCwX25PXdB3tcHY/fbH8tF2kUD8Yb1LGHuArXOcb4bmT+boOpGAm68w8oxq4Xsxr1PL0Kxsl+fY8ehiM7Y5MQQROrPjiY+7KJKa5sr8QG4x1BRybH2LgPf3lzkivbUQ5S3/h0IQoPDzF4qSTHe+VMzGR70az8X925Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pmz+k6px; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab46931cf1so23998765ad.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774618286; x=1775223086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vc6JenAuJhhJEAB101jmrcNR8nhg35SI5zHqwXmhxIE=;
        b=Pmz+k6pxijLRP0cqjUp4Mzd/CeOYtCzKGWpNev4OgJQNGGo7qaWLOmCTLYBOk5eOFV
         ZMmqNzB46TGnaHOiRqd+/6/bFv1wqehOe2Nylo4VtYa2ZkLVWgRSM0V7goVACfRHLSJ2
         GdKMvzaYScN2Zksrl/NN8iBhZKgAY7FGnzjmwUMo6hz8/fuaxnuF+gwvbqvZxQqQHKFN
         4oF+u2Hxh7ZG/lzHmMmzdeWGieixAU4feglexR73RZsryZYUzSYcz6XWXiGueFySlnHB
         Fz9T5Xdlqf1OAvFWv3/eTHDNPK7bOGmih+xwMfZlgIcZQYkeJwWTLrQS+T/oKqEpce3O
         9fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774618286; x=1775223086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc6JenAuJhhJEAB101jmrcNR8nhg35SI5zHqwXmhxIE=;
        b=At6C6vWKAxndhmCWKphyvTUDBBqCIAhQVAM/YDODiOZinFduNRy/C4GFLopqsnhuMP
         K5hiQ7sTEG+OZ9cqEtvp+Qf8wyYan6maakB5sJnkVm9rWlXQNDyzI6LB7ICQjg9e9WSQ
         Wm8WTD1eWrcnq1qucU7M5yqevjNdEYgtIkaqkdCcgvmg9ifWqhPRSUxOED0yU+lQNlAv
         rxpfktpkebs3l/P+RqEVVcidZK0USTIGVgNyoUy3pf7e8H/rA4Wwu97kf4HpsQIu3JGs
         LJRmsXXe9BwhZ5n1vGKMeJeX6N3GbqM2Y39S45roc83/T78OjLRMiHIs8GFBEk4bAeR7
         fY6w==
X-Forwarded-Encrypted: i=1; AJvYcCUmkVz39yCA2CCZQ/GvWQUFfqBoTjHocEpSlcKSUf7wWSZlfSzpsmzwZuLz4x7xL4/xNwIHTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZWqsDfGkM7FhTQbps7hVWVhlva/K6/QCGf5YMwMj20XzKM75
	8Ic1JUtGWZPKyvR+JCHZJQqxk16oipOq4Vc/++Bf7U8MOsEMIplLrt0R
X-Gm-Gg: ATEYQzyhVqEY22TK8P9q/tTi18bBqOn3eb0nSB3vfHYdAJ3Ag8HxUXHdI1JxMu3BtMO
	E4i7BVdD4mqEjiC3yRZAueY084cR3lJ+u/iS1GUCPmEQop6xHoz0ESCb1fM3beI753VMd91qHD2
	bPssQA7j3Rv4GQC50Bl0eWf29ysF0Zn85+aPenO+l5+aoeuDbAI9qLijda2nuEDItEveuJVXW7f
	LcjoFSYhhdXHc04mxHdVbQ0rwxJk1d+pafT4mM/apZQoB5RSxVhiWmw4vXRhZs69fOPfb+qV1XV
	ePOjOzUTmFSsImVQvyiuCtS/VGQfmNt7ji+ZuTCTgfdbm4yntMrEjVPgO4NTvjhmYh/wd9WYkJq
	FOj6WZb+NtqwWHwvMSDJZ0Qmv4Nh0lTY54ndfBBaCpSETyQjPA9+SfYo5ugJep2f15nCvqbqN8m
	qVAoi2p/VW2LCdjVJxpA==
X-Received: by 2002:a17:902:d4cf:b0:2b0:51f6:d469 with SMTP id d9443c01a7336-2b0ce5d7ee7mr25182795ad.23.1774618286084;
        Fri, 27 Mar 2026 06:31:26 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76bc66sm60170955ad.13.2026.03.27.06.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 06:31:25 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: annotate lockless b_flags read in xfs_buf_lock
Date: Fri, 27 Mar 2026 21:11:52 +0800
Message-Id: <20260327131152.155617-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230657-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFF073456F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfs_buf_lock() reads bp->b_flags before acquiring the buffer semaphore
to check whether a stale, pinned buffer needs a log force:

    if (atomic_read(&bp->b_pin_count) && (bp->b_flags & XBF_STALE))

This races with xfs_trans_dirty_buf(), which modifies b_flags while
the buffer is locked by a transaction on another CPU.

The pre-semaphore check is a performance hint: if a stale pinned
buffer is detected, forcing the log avoids a long wait on the
semaphore.  Either outcome of the race is benign -- a false positive
triggers a harmless log force, and a false negative simply means the
caller blocks on the semaphore and the log force happens later.

Annotate the lockless read with READ_ONCE().

Fixes: ed3b4d6cdc81 ("xfs: Improve scalability of busy extent tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/xfs/xfs_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index d2f3c50d80e7..6819477307bd 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -988,7 +988,7 @@ xfs_buf_lock(
 {
 	trace_xfs_buf_lock(bp, _RET_IP_);
 
-	if (atomic_read(&bp->b_pin_count) && (bp->b_flags & XBF_STALE))
+	if (atomic_read(&bp->b_pin_count) && (READ_ONCE(bp->b_flags) & XBF_STALE))
 		xfs_log_force(bp->b_mount, 0);
 	down(&bp->b_sema);
 
-- 
2.34.1


