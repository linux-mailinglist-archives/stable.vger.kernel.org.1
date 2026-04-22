Return-Path: <stable+bounces-240309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHXcCZml6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:40:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94955444D16
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9D93073D4A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88D3C13FD;
	Wed, 22 Apr 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="JrurM3Bc"
X-Original-To: stable@vger.kernel.org
Received: from out30-73.freemail.mail.aliyun.com (out30-73.freemail.mail.aliyun.com [115.124.30.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAB43C063F
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854282; cv=none; b=GJF9TDSHmRD9pToYbAchXlJab0FDGmk51i5vRig2JCa60OVWBOtm1bbV/Jl/DqnA9ZVr+OmzUwfiGc4VtpwDxoUOs87bNS1rwVjV1WwOJyeoUh/ZTnDIEKNd4XJU3L4F2mVMVIefV3BikH90e0zzSdZSTMBusPoOcInN2+DJaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854282; c=relaxed/simple;
	bh=vd8/gCUCgi4rVzEjVgzGFjGvoliM3N5zSWIgA+GmPm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erER5z2nTZ0xKtz9/RSRbbphuCq9dZiDD9eibx3G/VaZ24igXGU9nWgJa4DgzBmGfsnKcHOQ6ekPwnTmWR+o3SFxSMbPQbMYUedi+uTDLy9TcMl1rMCXq5PEL2fl4u/mzZ3jE0a2U5QyGUQi6mA/3u3D/mRryImXSqmEhF0Txlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=JrurM3Bc; arc=none smtp.client-ip=115.124.30.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776854277; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/ZuZS0UevaizPDdgKMu+YC+tzvXWJ6x4ZHNoj/yNQIc=;
	b=JrurM3BcquNjkXjaGULVknUST1FD/yBB5IY6teeywLhNCcvO2e8MsQWh056BgWizn60BvKvou8Lr8DMkzFDlkof7+YHFFw3XgnD/+7lt68MQ+VO2fDUp6EEKEMrBwxmWUBqeo1nMomGEWZzEF1aij1Wpn3GC+lGkyiwjHXK7pEs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07358602|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0505156-0.00404833-0.945436;FP=11456792416704195799|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1Vu77v_1776854275;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1Vu77v_1776854275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 18:37:57 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 6.1.y 2/2] gfs2: Validate i_depth for exhash directories
Date: Wed, 22 Apr 2026 18:37:17 +0800
Message-ID: <20260422103717.613-2-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422103717.613-1-ruohanlan@aliyun.com>
References: <20260422103717.613-1-ruohanlan@aliyun.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,syzkaller.appspotmail.com,aliyun.com];
	TAGGED_FROM(0.00)[bounces-240309-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,4708579bb230a0582a57];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:email,aliyun.com:dkim,aliyun.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94955444D16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrew Price <anprice@redhat.com>

[ Upstream commit 557c024ca7250bb65ae60f16c02074106c2f197b ]

A fuzzer test introduced corruption that ends up with a depth of 0 in
dir_e_read(), causing an undefined shift by 32 at:

  index = hash >> (32 - dip->i_depth);

As calculated in an open-coded way in dir_make_exhash(), the minimum
depth for an exhash directory is ilog2(sdp->sd_hash_ptrs) and 0 is
invalid as sdp->sd_hash_ptrs is fixed as sdp->bsize / 16 at mount time.

So we can avoid the undefined behaviour by checking for depth values
lower than the minimum in gfs2_dinode_in(). Values greater than the
maximum are already being checked for there.

Also switch the calculation in dir_make_exhash() to use ilog2() to
clarify how the depth is calculated.

Tested with the syzkaller repro.c and xfstests '-g quick'.

Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Signed-off-by: Andrew Price <anprice@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 fs/gfs2/dir.c   | 6 ++----
 fs/gfs2/glops.c | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 96924af95c8e..3716d89d8af6 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -60,6 +60,7 @@
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -912,7 +913,6 @@ static int dir_make_exhash(struct inode *inode)
 	struct qstr args;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_leaf *leaf;
-	int y;
 	u32 x;
 	__be64 *lp;
 	u64 bn;
@@ -979,9 +979,7 @@ static int dir_make_exhash(struct inode *inode)
 	i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
 	gfs2_add_inode_blocks(&dip->i_inode, 1);
 	dip->i_diskflags |= GFS2_DIF_EXHASH;
-
-	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
-	dip->i_depth = y;
+	dip->i_depth = ilog2(sdp->sd_hash_ptrs);
 
 	gfs2_dinode_out(dip, dibh->b_data);
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index f4bd487a9b3b..e7904c1c985f 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -458,6 +459,11 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 		gfs2_consist_inode(ip);
 		return -EIO;
 	}
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) &&
+	    depth < ilog2(sdp->sd_hash_ptrs)) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-- 
2.43.0


