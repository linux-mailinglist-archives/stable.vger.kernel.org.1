Return-Path: <stable+bounces-227419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKa8Gke7vGkd2gIAu9opvQ
	(envelope-from <stable+bounces-227419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:13:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8EC2D55EB
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133D230BC7DC
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670812E22B5;
	Fri, 20 Mar 2026 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J72F7E6l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3862DD60E
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 03:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976373; cv=none; b=aZA31+hyFJ5BSTvJAGHITPUUsRlVhDLUPvAgd+9EoTtwughy+qOEkuvriog9ClVU2TEO5/a7DywiVi2j3uUWZabD6eSa/E4PPQ4C314oAXlaQfUPis0RAfsFHpeL3u0odzwjPwV3UR30n5+4+zEL5aaL907Y2PoNJLMrW8ZDpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976373; c=relaxed/simple;
	bh=NvV+h593Ou5IBnxtUlqtw1Pyy++rLNAuvH0B1AJ01CI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FLOsuNABGgT4d9hWPZt1biQaH99ROjdmPDhhapYoyzgAbjl96AuC93I8MBfUKzSJAjiVqLd0YNcDgzFa1JBxZs+Xb86V8FI449uPofG7fAXt02eR5EpjpB6CWVJuvlYKnHYDA2e2QxvE8VZCTwKvsk0ZNejtIaciLs11F1B+xFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J72F7E6l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so19724725ad.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 20:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773976370; x=1774581170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4I6B8Rx4hDXdmswJxNp2RjYpERKWQN7pv7OUIlU9OXM=;
        b=J72F7E6l2u5ftLiq8lu2Nf13vGpquLSXaBwhQ9O9g7NEDaBvAUGjKPFvLX7xvspe8g
         EaGry8PsI97ZptjuIgCIfVYScXFq/x+cg9vce/bRNhSNdcXdUKT+2j5X9KGasqT2F/oO
         uCV0n7V/E7zhLtT8RE3fmMnpBDv/lRUz+g+fmldFfylwWWs0TViCG3zPae6pviv5E0qF
         rTB57PYJ2B1H7qS8E5EydNSd67FeToeuJdbUZwT4nmxjbNohFsq5Tl4YmPZpyfAlwrVN
         x8fn7FOmgBbpotHgBVYqjbxJl3df2Ra7/qo9ekRsry8UUC2afcUYy8d8HV27BAhSWGVz
         tVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773976370; x=1774581170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I6B8Rx4hDXdmswJxNp2RjYpERKWQN7pv7OUIlU9OXM=;
        b=q9G2tnUEMW2bo+xB67y7KpzAWiz4iY9YXAhWuJ+Zrv/legjdadgdpmslrei0Nfckq6
         +B6LQIQ1EZVbHau0kOLNnwFDBPO4fVjGpwcL6PW5joUpFT+ZLDCtUel+U/eDhVUaNNRk
         6OQveBhueCqqw/mFSMVBmOVKxq46MN6CyUlrC2UfXkuK/sPPZB74hcSuS9vpvyYPmvXC
         uDu3cCCkW2PRRfh8Iq1SsooR6zk7WKl5Xzq++491uH63vz2VxmdagaBTyeEXVZbRyDAx
         yk7yx9eYAQ+Ifkf3fQpwf5hfNe60Ae3u+0Gpq27TQmwsOmeP43pAuLszFfZouKcDOr0H
         VJCg==
X-Forwarded-Encrypted: i=1; AJvYcCXEiHsPBaQGws+3aJc7wBDr/wgy2BOCjqRyMpAyImPz2GwZKZ3/5S/Q/QV7VVGYAC0yu/DcR6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gJHjIBg3P/il/0NlNG4tXH0xN6ylC9LuJjtOlmFg5F8CsYeE
	7p9scjsuINx9L0u04T8OxdMPEL1pSzwyiNYfYISm7HgMOxWTCLQ/bygM
X-Gm-Gg: ATEYQzx//n6jpXhs0dL2P43+jI0l5SgRGqwhm9R6UKp9G4qiUlSXi33JM5KtctcOy4Y
	RRCnMnoyWn1dx6i+OJMhZJAQFfsFCo8G3PZhTKij3NsPm4VHZX1YJEytxhqTylGozVa9QKOLOID
	1a1IdsxUioJogD7U62wB2ort0sIIUiUi2GDUnNKcZnxIQNByn9sNzQgUPmfsGgoV8FmXb31mBWw
	iNy6ggvm2EX6tkRHgzIGmhcODyZgBaHIxIrZtJmWHPvXshwRPNLGXtLqmVI2Si4FtaiydwLBpHX
	JGlTaVaE+W5iyo9l4XTW5xqdAJ7Y1MwqTHhTGNH7fOG2gIryq1dLmRCnYH8ddM6++fXBWaIsdnV
	mz+G2mIlTP2SAnPwu4XiJs7CkzBTD+nC0u+lnbSs3KUqHwnIXFo/D7HJyIY25gZtGnxSnW0TEAA
	xolSd3CravCp5IC1B6AQ==
X-Received: by 2002:a17:903:32c6:b0:2ae:55eb:f82d with SMTP id d9443c01a7336-2b0826d751dmr12591125ad.1.1773976370299;
        Thu, 19 Mar 2026 20:12:50 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656df5sm7259535ad.44.2026.03.19.20.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 20:12:49 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: cem@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: annotate data race on li_lsn in CIL formatting vs AIL insertion
Date: Fri, 20 Mar 2026 10:55:07 +0800
Message-Id: <20260320025507.3331221-1-zzzccc427@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227419-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.955];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB8EC2D55EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfs_inode_item_format_core() reads lip->li_lsn without holding any lock
to embed the last on-disk LSN into the log dinode during CIL commit:

    xfs_inode_to_log_dinode(ip, dic, ip->i_itemp->ili_item.li_lsn);

Concurrently, xfs_trans_ail_update_bulk() writes lip->li_lsn under
ail_lock when inserting items into the AIL after log IO completion:

    lip->li_lsn = lsn;

The CIL context lock (xc_ctx_lock) and the AIL lock (ail_lock) are
independent and provide no mutual exclusion between these paths.

Under simple interleaving on 64-bit architectures this is benign since
li_lsn monotonically increases and both old/new values are valid
checkpoint LSNs.  However, on 32-bit architectures the 64-bit xfs_lsn_t
can be torn into two 32-bit loads, producing a bogus LSN that could
cause log recovery to make incorrect replay decisions.  XFS already
acknowledges this concern via the xfs_trans_ail_copy_lsn() helper which
takes ail_lock on 32-bit.

Annotate with READ_ONCE()/WRITE_ONCE() to prevent compiler-level
tearing on all architectures.

Fixes: 93f958f9c41f ("xfs: cull unnecessary icdinode fields")
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/xfs/xfs_inode_item.c | 2 +-
 fs/xfs/xfs_trans_ail.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 8913036b8024..ef0a0889c580 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -624,7 +624,7 @@ xfs_inode_item_format_core(
 	struct xfs_log_dinode	*dic;
 
 	dic = xlog_format_start(lfb, XLOG_REG_TYPE_ICORE);
-	xfs_inode_to_log_dinode(ip, dic, ip->i_itemp->ili_item.li_lsn);
+	xfs_inode_to_log_dinode(ip, dic, READ_ONCE(ip->i_itemp->ili_item.li_lsn));
 	xlog_format_commit(lfb, xfs_log_dinode_size(ip->i_mount));
 }
 
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 923729af4206..3a0e0c65ebc5 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -831,7 +831,7 @@ xfs_trans_ail_update_bulk(
 		} else {
 			trace_xfs_ail_insert(lip, 0, lsn);
 		}
-		lip->li_lsn = lsn;
+		WRITE_ONCE(lip->li_lsn, lsn);
 		list_add_tail(&lip->li_ail, &tmp);
 	}
 
-- 
2.34.1


