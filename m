Return-Path: <stable+bounces-240403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MjnqJQyQ6Wl9dgIAu9opvQ
	(envelope-from <stable+bounces-240403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D7744C7F0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 05:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F4123006450
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE12F5485;
	Thu, 23 Apr 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="loYnWwfF"
X-Original-To: stable@vger.kernel.org
Received: from out30-85.freemail.mail.aliyun.com (out30-85.freemail.mail.aliyun.com [115.124.30.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27F1B86C7
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776914440; cv=none; b=PJX1In8tU+eTzqg67tVNY6thkLvPXj4VwOvggGKeKERrVFFiU8D9HzsPFuAu58unpG3Fev0KUeAQLDXBuY+uy/anJ0K4LUhfxpe0OAI8jFGc5T9TxkyfsA+LP3KKBK/m4q+mzRLk/3JFB4xt/QtLxGffGX6C30CMdD0dwY+vXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776914440; c=relaxed/simple;
	bh=I8hELIny7FNKUVBOWrMq/lhxyBAmeuZhX2S/0Uv9MEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJrI08pBb3yyd2oN8fLQTJh2oX15XdMOazMpFXTy+lXPSpRa/VN91LQQq56fc4hxLXvHe+SihtNzmkzhy51oEqihucwyiSBOuUiCaPIZbPyn8Rz86Qw442DWCqr0Sa3/KhSFo9PXBvndD6kVFdALlXSxsJhh3D+yo7GFrCyYBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=loYnWwfF; arc=none smtp.client-ip=115.124.30.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1776914436; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1TVO0IAj8sUuaMrJ+zElAkcm6qSIuAxDoIvGoa6chdA=;
	b=loYnWwfF+N2eZO+YalKpAcW4VAQWth3zerOwCTeyMx6YtEF5pDXLsnr3K6Rare9yS4qa+V5mzbobSEtXxbPAp3EZAUlmO3XNe92I3GfzboK/RDKTKeQ/U+fo03JOn7OgAjI0fEb3ToBsz/Zs+kL3sL2Uom7K3lQTOok5gWI9EVE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07358088|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0586597-0.00734281-0.933998;FP=6914912296662133975|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=ruohanlan@aliyun.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---0X1YFzfZ_1776914426;
Received: from China-team(mailfrom:ruohanlan@aliyun.com fp:SMTPD_---0X1YFzfZ_1776914426 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 11:20:36 +0800
From: Ruohan Lan <ruohanlan@aliyun.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: gfs2@lists.linux.dev,
	Andrew Price <anprice@redhat.com>,
	syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Ruohan Lan <ruohanlan@aliyun.com>
Subject: [PATCH 5.10.y] gfs2: Validate i_depth for exhash directories
Date: Thu, 23 Apr 2026 11:20:02 +0800
Message-Id: <20260423032002.2803528-1-ruohanlan@aliyun.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240403-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,syzkaller.appspotmail.com,aliyun.com];
	DKIM_TRACE(0.00)[aliyun.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruohanlan@aliyun.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[aliyun.com];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,4708579bb230a0582a57];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 29D7744C7F0
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
[ To maintain consistency in error handling in gfs2_dinode_in(),
use "goto corrupt" in v5.10. ]
Signed-off-by: Ruohan Lan <ruohanlan@aliyun.com>
---
 fs/gfs2/dir.c   | 6 ++----
 fs/gfs2/glops.c | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 4517ffb7c13d..7b11f7b7151a 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -60,6 +60,7 @@
 #include <linux/crc32.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -910,7 +911,6 @@ static int dir_make_exhash(struct inode *inode)
 	struct qstr args;
 	struct buffer_head *bh, *dibh;
 	struct gfs2_leaf *leaf;
-	int y;
 	u32 x;
 	__be64 *lp;
 	u64 bn;
@@ -977,9 +977,7 @@ static int dir_make_exhash(struct inode *inode)
 	i_size_write(inode, sdp->sd_sb.sb_bsize / 2);
 	gfs2_add_inode_blocks(&dip->i_inode, 1);
 	dip->i_diskflags |= GFS2_DIF_EXHASH;
-
-	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
-	dip->i_depth = y;
+	dip->i_depth = ilog2(sdp->sd_hash_ptrs);
 
 	gfs2_dinode_out(dip, dibh->b_data);
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 87f811088466..a4050468fecc 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/posix_acl.h>
 #include <linux/security.h>
+#include <linux/log2.h>
 
 #include "gfs2.h"
 #include "incore.h"
@@ -452,6 +453,9 @@ static int gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
 	depth = be16_to_cpu(str->di_depth);
 	if (unlikely(depth > GFS2_DIR_MAX_DEPTH))
 		goto corrupt;
+	if ((ip->i_diskflags & GFS2_DIF_EXHASH) &&
+	    depth < ilog2(sdp->sd_hash_ptrs))
+		goto corrupt;
 	ip->i_depth = (u8)depth;
 	ip->i_entries = be32_to_cpu(str->di_entries);
 
-- 
2.43.0


