Return-Path: <stable+bounces-179410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41667B55DEB
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F080AA052F3
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3708D1D416C;
	Sat, 13 Sep 2025 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuIzph8/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73126281
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757732750; cv=none; b=jzVNC343ZaDWyUHaZURa6MazepNkFfHNPUj0kXBe/mV59fOq4SFP6JdF00TOnsBjrXMc523Ne/kXOdpjDdj5Tb7/hrtceWlZGBE9Na5xgE64f9LZYmrCDYWkGs7IcS/558T+XMgaeSqYxTID7ni9VD8qfHkSicF6rKA4esQula4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757732750; c=relaxed/simple;
	bh=pUq/ET/7OoC/d6z0t4nVT64sAN6OjWKADFi/hqIiqag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOrbuOClYF7NLJCgqiIYDhIy0hNs1PDW+g8/2ukXkwN3PMV1gKpJTZQyBJ3epPxz9sf4YTjD7wH67KDjZFtykPPZij3j5/QYsGA73sYIXOzBIzP+C51+3Lc9RxMDWj8Nd0493PgoGrNaJPU0it5iHshAvbZGsN3wSbYNFKdsoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuIzph8/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07e081d852so76955766b.2
        for <stable@vger.kernel.org>; Fri, 12 Sep 2025 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757732746; x=1758337546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZNYaJHdKdym4x92LfIeJwjfVk9SQYhUdI5Z20nL+Fg=;
        b=XuIzph8/qKdkTggwwcdUbICu9oGpWDvAsXMt9hF/ziWohMji2WrAgTXHj+IeyXWie5
         NQGwYrqozDhNJg1h1fvgEQOP7Was7WqR4nOhYFuNOsBQ9GhYtlx7ElvVYwqu2H69yhyq
         AXWz3HoUA4YuZBvjBZVw0h2IdluYCBSQ5lG+kmhZrkDZoGEjq8u/h/hj4sSjrPmHkPKL
         5c0zYGFvaBH6b7l2pQvLXR82lfOG2LroOPWvqiwsTfDlIrj9HGEBEghKnNuErxTLeU7I
         ph8T4MYoN8gOFxSmZ4qO9u/3/BwTHLYsvipz0q//aRABXmrKyWH49vwhbRZttJ3pvZjz
         5SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757732746; x=1758337546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZNYaJHdKdym4x92LfIeJwjfVk9SQYhUdI5Z20nL+Fg=;
        b=bwslwssqy0vHbyeZLz0uf8EImNRBQGS6tf/h/Zuo4oODvyXc9D2zj+S5M0P/PQLRVI
         WStwYg9PyPG1tkFdNRzRve99JTWkwwnB0pTkKW65UVogH0GpOcpQy+uoivO/ovGk5bDh
         E1c0dkrPmHm1t6PQcbmUEhfYt9daaHXTUYPzFZvKiFaRNl8qXfWhKKhvZ0oyAuWvVPlt
         HcEhtPzKaHWzJ0BD8Rquuf/sD1xWap8Axmcb3xb9vqChOidYbhZBDSRBo1P5F1Xlc2mF
         K19j992ILbSZ3l/KWU82W6VO+aD4bkXjt7qAAV42mr7jaqA3kQv62PvskUJr7QOqHjb0
         vOMg==
X-Forwarded-Encrypted: i=1; AJvYcCWeGVyE3vzqs1LNu1CQXLOO5jwish7hh6Xh7MLLgkqWQCcpoML4EpXhhhkE5bPa60kLc+nAFsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGNJiXBqoiSm0J3noDMnqSyyQu2kEj3hz3Q6y+Pi2TGh3rVsn
	rMFoIDrXidTaOVHjxgjA+wMp2gV2HjX7lI0PK6OjXELU/GxR6SHdOACR
X-Gm-Gg: ASbGncu1GC3yMwf1ODy6Cz/ud3fVoX8EEpqDMvDWSp+CXIXzKmBT/JMvJu61fJmOjPr
	4u6qgwBoaurxz9pf6kKe7moaYj+UdCap1wpM+mi8f71qIyOtCZoCEzzCPpHIoheq5cecnY1yvpw
	kq6QXc1c6SsRV6ah/g21BK9Uwd2fbS3N6GkDwyZi7ZVdlgAd8B6a9ZwDvppBYVqsntM6No3bzHL
	IiwsXgKOQXm3Cgh09cK2NPeQJZKYNfl54D+oWLE8IPBXDAuLo2osVfMZIcHbmZZFRiTQuDt5tt8
	4Bt+gUIgaiTeBKHwTjt6F2WzKJpcPJsGonchOzpq6MeDBcIF5e1ZrNi94L9QfrFOtBkXtpCuN6f
	/7U7+3dmby/IfPuv8K4EX81DC5mEhw1U1OrhNYMACvXdUqnKYhsIf5vRc69gDWwl3LHVY1FOChD
	nceZFHHfhzgf4Z7arhOAPT3DY=
X-Google-Smtp-Source: AGHT+IFJnL+20g9iD9lSRPr+IlLcwoT2ifmvpzpD+xXQ3ygMnVts5REQ89+wyWeEA+IGXwhfUP9MMg==
X-Received: by 2002:a17:907:8687:b0:b04:38f2:9059 with SMTP id a640c23a62f3a-b07c381bc58mr485935066b.42.1757732746127;
        Fri, 12 Sep 2025 20:05:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd5bfsm477698466b.63.2025.09.12.20.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:05:45 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Leah Rumancik <leah.rumancik@gmail.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH CANDIDATE 5.15, 6.1, 6.6] xfs: Increase XFS_QM_TRANS_MAXDQS to 5
Date: Sat, 13 Sep 2025 05:05:02 +0200
Message-ID: <20250913030503.433914-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

[ Upstream  commit f103df763563ad6849307ed5985d1513acc586dd ]

With parent pointers enabled, a rename operation can update up to 5
inodes: src_dp, target_dp, src_ip, target_ip and wip.  This causes
their dquots to a be attached to the transaction chain, so we need
to increase XFS_QM_TRANS_MAXDQS.  This patch also add a helper
function xfs_dqlockn to lock an arbitrary number of dquots.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

[amir: backport to kernels prior to parent pointers to fix an old bug]

A rename operation of a directory (i.e. mv A/C/ B/) may end up changing
three different dquot accounts under the following conditions:
1. user (or group) quotas are enabled
2. A/ B/ and C/ have different owner uids (or gids)
3. A/ blocks shrinks after remove of entry C/
4. B/ blocks grows before adding of entry C/
5. A/ ino <= XFS_DIR2_MAX_SHORT_INUM
6. B/ ino > XFS_DIR2_MAX_SHORT_INUM
7. C/ is converted from sf to block format, because its parent entry
   needs to be stored as 8 bytes (see xfs_dir2_sf_replace_needblock)

When all conditions are met (observed in the wild) we get this assertion:

XFS: Assertion failed: qtrx, file: fs/xfs/xfs_trans_dquot.c, line: 207

The upstream commit fixed this bug as a side effect, so decided to apply
it as is rather than changing XFS_QM_TRANS_MAXDQS to 3 in stable kernels.

The Fixes commit below is NOT the commit that introduced the bug, but
for some reason, which is not explained in the commit message, it fixes
the comment to state that highest number of dquots of one type is 3 and
not 2 (which leads to the assertion), without actually fixing it.

The change of wording from "usr, grp OR prj" to "usr, grp and prj"
suggests that there may have been a confusion between "the number of
dquote of one type" and "the number of dquot types" (which is also 3),
so the comment change was only accidentally correct.

Fixes: 10f73d27c8e9 ("xfs: fix the comment explaining xfs_trans_dqlockedjoin")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christoph,

This is a cognitive challenge. can you say what you where thinking in
2013 when making the comment change in the Fixes commit?
Is my speculation above correct?

Catherine and Leah,

I decided that cherry-pick this upstream commit as is with a commit
message addendum was the best stable tree strategy.
The commit applies cleanly to 5.15.y, so I assume it does for 6.6 and
6.1 as well. I ran my tests on 5.15.y and nothing fell out, but did not
try to reproduce these complex assertion in a test.

Could you take this candidate backport patch to a spin on your test
branch?

What do you all think about this?

Thanks,
Amir.

 fs/xfs/xfs_dquot.c       | 41 ++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_dquot.h       |  1 +
 fs/xfs/xfs_qm.h          |  2 +-
 fs/xfs/xfs_trans_dquot.c | 15 ++++++++++-----
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index c15d61d47a06..6b05d47aa19b 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1360,6 +1360,47 @@ xfs_dqlock2(
 	}
 }
 
+static int
+xfs_dqtrx_cmp(
+	const void		*a,
+	const void		*b)
+{
+	const struct xfs_dqtrx	*qa = a;
+	const struct xfs_dqtrx	*qb = b;
+
+	if (qa->qt_dquot->q_id > qb->qt_dquot->q_id)
+		return 1;
+	if (qa->qt_dquot->q_id < qb->qt_dquot->q_id)
+		return -1;
+	return 0;
+}
+
+void
+xfs_dqlockn(
+	struct xfs_dqtrx	*q)
+{
+	unsigned int		i;
+
+	BUILD_BUG_ON(XFS_QM_TRANS_MAXDQS > MAX_LOCKDEP_SUBCLASSES);
+
+	/* Sort in order of dquot id, do not allow duplicates */
+	for (i = 0; i < XFS_QM_TRANS_MAXDQS && q[i].qt_dquot != NULL; i++) {
+		unsigned int	j;
+
+		for (j = 0; j < i; j++)
+			ASSERT(q[i].qt_dquot != q[j].qt_dquot);
+	}
+	if (i == 0)
+		return;
+
+	sort(q, i, sizeof(struct xfs_dqtrx), xfs_dqtrx_cmp, NULL);
+
+	mutex_lock(&q[0].qt_dquot->q_qlock);
+	for (i = 1; i < XFS_QM_TRANS_MAXDQS && q[i].qt_dquot != NULL; i++)
+		mutex_lock_nested(&q[i].qt_dquot->q_qlock,
+				XFS_QLOCK_NESTED + i - 1);
+}
+
 int __init
 xfs_qm_init(void)
 {
diff --git a/fs/xfs/xfs_dquot.h b/fs/xfs/xfs_dquot.h
index 6b5e3cf40c8b..0e954f88811f 100644
--- a/fs/xfs/xfs_dquot.h
+++ b/fs/xfs/xfs_dquot.h
@@ -231,6 +231,7 @@ int		xfs_qm_dqget_uncached(struct xfs_mount *mp,
 void		xfs_qm_dqput(struct xfs_dquot *dqp);
 
 void		xfs_dqlock2(struct xfs_dquot *, struct xfs_dquot *);
+void		xfs_dqlockn(struct xfs_dqtrx *q);
 
 void		xfs_dquot_set_prealloc_limits(struct xfs_dquot *);
 
diff --git a/fs/xfs/xfs_qm.h b/fs/xfs/xfs_qm.h
index 442a0f97a9d4..f75c12c4c6a0 100644
--- a/fs/xfs/xfs_qm.h
+++ b/fs/xfs/xfs_qm.h
@@ -121,7 +121,7 @@ enum {
 	XFS_QM_TRANS_PRJ,
 	XFS_QM_TRANS_DQTYPES
 };
-#define XFS_QM_TRANS_MAXDQS		2
+#define XFS_QM_TRANS_MAXDQS		5
 struct xfs_dquot_acct {
 	struct xfs_dqtrx	dqs[XFS_QM_TRANS_DQTYPES][XFS_QM_TRANS_MAXDQS];
 };
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index 955c457e585a..99a03acd4488 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -268,24 +268,29 @@ xfs_trans_mod_dquot(
 
 /*
  * Given an array of dqtrx structures, lock all the dquots associated and join
- * them to the transaction, provided they have been modified.  We know that the
- * highest number of dquots of one type - usr, grp and prj - involved in a
- * transaction is 3 so we don't need to make this very generic.
+ * them to the transaction, provided they have been modified.
  */
 STATIC void
 xfs_trans_dqlockedjoin(
 	struct xfs_trans	*tp,
 	struct xfs_dqtrx	*q)
 {
+	unsigned int		i;
 	ASSERT(q[0].qt_dquot != NULL);
 	if (q[1].qt_dquot == NULL) {
 		xfs_dqlock(q[0].qt_dquot);
 		xfs_trans_dqjoin(tp, q[0].qt_dquot);
-	} else {
-		ASSERT(XFS_QM_TRANS_MAXDQS == 2);
+	} else if (q[2].qt_dquot == NULL) {
 		xfs_dqlock2(q[0].qt_dquot, q[1].qt_dquot);
 		xfs_trans_dqjoin(tp, q[0].qt_dquot);
 		xfs_trans_dqjoin(tp, q[1].qt_dquot);
+	} else {
+		xfs_dqlockn(q);
+		for (i = 0; i < XFS_QM_TRANS_MAXDQS; i++) {
+			if (q[i].qt_dquot == NULL)
+				break;
+			xfs_trans_dqjoin(tp, q[i].qt_dquot);
+		}
 	}
 }
 
-- 
2.47.1


