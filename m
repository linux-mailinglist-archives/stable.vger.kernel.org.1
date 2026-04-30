Return-Path: <stable+bounces-241994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK4UIwfv8mlevwEAu9opvQ
	(envelope-from <stable+bounces-241994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:56:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2C49DC8F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 542D9301E7E4
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F536C9C2;
	Thu, 30 Apr 2026 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Dekq4rQV"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291353E0B;
	Thu, 30 Apr 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528577; cv=none; b=k6M561q/imGxNLDP32wQy8jjHBz8HwiN2XWaNnacTw1fxCM1vtfosHfSqOTEiGFDO1GNl7OwSAhLqm6SJlx3GTFvAiD8JhgJ+f6Ul8rYW76BIf6QL7xIsToeczZTTlhe3lDSIo92+FY83aSWXVK5fCqLsbeSwYhcWEszpCdI6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528577; c=relaxed/simple;
	bh=U6fxagwHLcKtOCRSDiSeAWOI9uQ2CMCjwPzhF3NDnac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PzyTRwN/YWMmLhiJBEMFkuDsk6XN3xh5sWxFh4bd9Jpw0xgrnakr4AZU208NvxFTxV55fHHluheWzBQgg9ndFP+KtALmt7kKr+l3VVDY/I8Y8F6L7mHE3AUPxGlaFFouA50B1/TKD1VQ1Scc2Kw39bu/XyrAb024zeVoAHQyJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Dekq4rQV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yn
	clYEHMnZKnDuIPo2n9BQiZ58N4eEpmcQRG0s/jhx4=; b=Dekq4rQVv2ajPfh9s+
	a06+YRLsTf+LCPiMkzC7cv72sCqIllpmPkBedjJ3DwIhCDi1QGuTEg/ic/ibAZhi
	PlBaePZqJiSvoFx+8mQkgc75muCmAdB7pxwq0KVv7n7MagFtnPw841eLG/DpqfJ5
	Kzd6HqlKmhJh7F/P7K/JAA4nk=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n2na7vJpe9ZHCg--.9955S2;
	Thu, 30 Apr 2026 13:55:38 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] f2fs: fix to detect potential corrupted nid in free_nid_list
Date: Thu, 30 Apr 2026 13:55:37 +0800
Message-Id: <20260430055537.2105721-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n2na7vJpe9ZHCg--.9955S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1rtF15Cw13GrWxAr4ruFg_yoW8KrW5pF
	13Jas8GrW8Wrn7W397GF4j9FyfJ3y8Wr17K393u3WIvw12vr1Fqr4kt34jqF1ftryDu3W3
	ZFn7C348Cw4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zM1vaUUUUUU=
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5RoJdGny7tpdIAAA3Q
X-Rspamd-Queue-Id: 0BD2C49DC8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,163.com,lists.sourceforge.net,vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]

As reported, on-disk footer.ino and footer.nid is the same and
out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
any potential corruption in free_nid_list.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/f2fs/node.c          | 17 ++++++++++++++++-
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2555787c79bb..06c94680ae4e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -27,12 +27,17 @@ static struct kmem_cache *free_nid_slab;
 static struct kmem_cache *nat_entry_set_slab;
 static struct kmem_cache *fsync_node_entry_slab;
 
+static inline bool is_invalid_nid(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	return nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid;
+}
+
 /*
  * Check whether the given nid is within node id range.
  */
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	if (unlikely(nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid)) {
+	if (unlikely(is_invalid_nid(sbi, nid))) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: out-of-range nid=%x, run fsck to fix.",
 			  __func__, nid);
@@ -2593,6 +2598,16 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
+
+		if (unlikely(is_invalid_nid(sbi, i->nid))) {
+			spin_unlock(&nm_i->nid_list_lock);
+			f2fs_err(sbi, "Corrupted nid %u in free_nid_list",
+								i->nid);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_CORRUPTED_NID);
+			return false;
+		}
+
 		*nid = i->nid;
 
 		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c61d8fc1deb3..26c7daca9959 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -81,6 +81,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_CORRUPTED_SUMMARY,
 	STOP_CP_REASON_UPDATE_INODE,
 	STOP_CP_REASON_FLUSH_FAIL,
+	STOP_CP_REASON_CORRUPTED_NID,
 	STOP_CP_REASON_MAX,
 };
 
-- 
2.34.1


