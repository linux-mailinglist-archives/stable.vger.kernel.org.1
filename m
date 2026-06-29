Return-Path: <stable+bounces-269722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vDS8BWROQmoB4gkAu9opvQ
	(envelope-from <stable+bounces-269722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:52:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F16D9105
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:52:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smail.nju.edu.cn header.s=iohv2404 header.b=DB4cDEwn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269722-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269722-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=smail.nju.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F014A3030129
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09163624A8;
	Mon, 29 Jun 2026 10:51:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BF352C52;
	Mon, 29 Jun 2026 10:51:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730303; cv=none; b=GNevidijmK0VYnYU/84sqn1JeHfMcQbAywJJC2nNa+DMcKrheoo3/Z3nnss82edZSEr2epnG3E8FFb57trSHwdekunfQ8pK3n7+PWXZkY2RmAn/iii3Ck+uv0UGcgsxDE1XQpwhqhdslX0X+aXbBaTGcXe4zsG/vKmSD3TKogf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730303; c=relaxed/simple;
	bh=l+pwPZ3mH88cvUR9ynAx9YtSbA2M7oTw0A/rnSyGd8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gas2rSgn/ahY5iBwfhvMAfyqlaRxateKYmHk5ZCaENMMMuCYEBpZNHwA93/BOb1AB8IBWktWbMHKuH6EJiWVZYXgjv+2hvs5XC9IqHzBUtSOYDpOxs3xm+z91HoD1tHUpXQExTgTiR4ayORUxv577Ae/gFVbsHrk6awshHuwQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=DB4cDEwn; arc=none smtp.client-ip=54.207.19.206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782730261;
	bh=pEl6slmbG03HLbMen+dJ3Wx5FOBpw1nFQYLZ/jkz7AQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DB4cDEwnBlsUsrL1G8fFmn+XzszvY4d04dLXiXl4lRJukYr9/wr8X0TQqIFE1zioN
	 BItwClShOchG4641eKaaO3hegEUz0JLze4IpGA9u1xM2owFYaNojRUXDiRshunBs3T
	 MGmp3wetLHgD3+Y8SwUtp1RnRVCA2bTRDaZKu+UU=
X-QQ-mid: zesmtpgz4t1782730256t0db3bca9
X-QQ-Originating-IP: 0/RmKe9hjSb4z5yuXVq0/ri8sUzq8k4cl/q9Fbf1GSU=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 18:50:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 639159883977955067
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: syzkaller@googlegroups.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: fix mrec_lock ABBA deadlock in rename
Date: Mon, 29 Jun 2026 18:50:36 +0800
Message-ID: <53BDDD94CF346272+20260629105036.2137914-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NS6VT4aJZuBZQANqNJvC3QKzDa8BVmjK8mWkrSFRWw40u7fBMuURA3li
	Sxm+T2crs7LV5SPtdd8W+j0jC5dVHg0NXnFdQWtzUoEFOlu1I8gFoczmnkMqsbhr0jtyuLW
	9PbFGjPZOG0EDIKEb4bDn3hc/7a3UxhgG2OsvmTWQnGr0t7oat6bsmLIyq0WcfWvfDhgjGt
	dKuG/BcaoaVnDGRosZGQhHoFoHnOTMJC1JBHx+UTpgyE0RhHwRsXJvJLwRZ8dICNRDFaIij
	tdy2N00gmVmiwsZrdCw1SZurOog9pd7ITc8h/GPzYRScrGTSsLAotAIKD+1lBkmHPur5YGz
	Zf4mU+/rXQgrIneXdglTxLq1CA6J/swcclWZJzgUF09sQxNbdaWdEyJUpDc3djiMVs0IcNP
	9ZlRO08aQ8+cc83mCtfd2ZMSxK/6xQCKysConXdeTqrCU8auEXqeNtoK7Id/uRZmaIVAClB
	98Ey9P47uAdxnBP7C6WXzgQtUJ+w9+RAShUnxYhio7IIzu7Xw3Hae/SHOfgF/E7pSAfUjq0
	eHDZXdxN/w6OaARXvpu5XiKvC8UJbhHOq320NkHeDixLYaYz+K3FosPGJhwHyYvwP1uQODo
	DUxPxMBj/843TEUFcyy/rpY2Fde1e15q/Lv9Hjqzl2/AiLL2DbKKgA7nqU+VCUXDzNjuK+3
	Alp6YEDx+29PrvjJZJgmE09I49++F6Eh0jSt7wzeFSMjUD5NLD2sapUtRylu5zy9ic4W6o1
	fj+XB568/kLUhWTvdSq2vGL0W1kzUZq//4cC5+Sn4Vyv5sOFLSp+dcfggZS/7tMBb+JV4py
	8DsCOxuLFB/EXR+22Hfd0keCyplAOx3qLk3yDg4vBCtpXxP4jhQUplwteZOegdb7WPHmRWv
	Q2cG4j0uGqD083G/4L1ZjSy/j3BPjHQ/bmE1I3GtYdnsQE7yqqTIy5ChExDfiiyUROcE1V0
	r5bIaDGtHcRdH4VY+5OrHtfPGdeD0xb6C/XcahkHexuYc+5c3Zjw54zQTiF7Gk1FiLqT8QS
	gQBQVxAk7NkmB++DgRgPILl5PM9HSUOz1xF90ldcDkcU7DyVQTWZDRO8sGw7RuDnt+9xijC
	znoG6vkxFRXRab7hQNKNc4TLKvlHTFJLZLQ9hMDmMQ6+j3E9fvwXiGFC7WjsUIO7qPBGBpl
	5jv2uqUGHfmW9/Q=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linkinjeon@kernel.org,m:hyc.lee@gmail.com,m:syzkaller@googlegroups.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269722-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nju.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B96F16D9105

ntfs_file_fsync(), ntfs_dir_fsync() and __ntfs_write_inode() lock an
inode's mrec_lock before taking the mrec_lock of its parent directory.

ntfs_rename() takes old_ni->mrec_lock and old_dir_ni->mrec_lock
before taking new_ni->mrec_lock for an existing target, or
new_dir_ni->mrec_lock for a cross-directory rename.
This can deadlock when ntfs_file_fsync() or __ntfs_write_inode() holds
the target inode, or when ntfs_dir_fsync() holds a child target
directory, while rename() holds the parent directory and waits for the
target.

Fix this by locking the existing target inode before taking any parent
directory mrec_lock. For cross-directory renames where the target parent
is a descendant of the source parent, lock the target parent before the
source parent so the directory order matches the child-to-parent order used
by ntfs_file_fsync(), ntfs_dir_fsync(), and __ntfs_write_inode().

Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Closes: https://lore.kernel.org/all/C4D296F0E9F3D66C+9397ffbc-eb55-44bb-9b3f-5da4809e7955@smail.nju.edu.cn/
Fixes: af0db57d4293 ("ntfs: update inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
 fs/ntfs/namei.c | 60 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a19626a135bd..43f5f306a4fc 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1266,6 +1266,7 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct ntfs_volume *vol = NTFS_SB(sb);
 	struct ntfs_inode *old_ni, *new_ni = NULL;
 	struct ntfs_inode *old_dir_ni = NTFS_I(old_dir), *new_dir_ni = NTFS_I(new_dir);
+	bool new_dir_first = false;
 
 	if (NVolShutdown(old_dir_ni->vol))
 		return -EIO;
@@ -1301,36 +1302,37 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	old_ni = NTFS_I(old_inode);
+	if (new_inode)
+		new_ni = NTFS_I(new_inode);
 
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	mutex_lock_nested(&old_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL);
-	mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	if (new_ni)
+		mutex_lock_nested(&new_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
 
-	if (NInoBeingDeleted(old_ni) || NInoBeingDeleted(old_dir_ni)) {
+	if (old_dir == new_dir) {
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	} else if (d_ancestor(old_dentry->d_parent, new_dentry->d_parent)) {
+		mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+		new_dir_first = true;
+	} else {
+		mutex_lock_nested(&old_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+		mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+	}
+
+	if (NInoBeingDeleted(old_ni) || NInoBeingDeleted(old_dir_ni) ||
+	    (new_ni && NInoBeingDeleted(new_ni)) ||
+	    (old_dir != new_dir && NInoBeingDeleted(new_dir_ni))) {
 		err = -ENOENT;
-		goto unlock_old;
+		goto err_out;
 	}
 
 	is_dir = S_ISDIR(old_inode->i_mode);
 
 	if (new_inode) {
-		new_ni = NTFS_I(new_inode);
-		mutex_lock_nested(&new_ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
-		if (old_dir != new_dir) {
-			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
-			if (NInoBeingDeleted(new_dir_ni)) {
-				err = -ENOENT;
-				goto err_out;
-			}
-		}
-
-		if (NInoBeingDeleted(new_ni)) {
-			err = -ENOENT;
-			goto err_out;
-		}
-
 		if (is_dir) {
 			struct mft_record *ni_mrec;
 
@@ -1348,14 +1350,6 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		err = ntfs_delete(new_ni, new_dir_ni, uname_new, new_name_len, false);
 		if (err)
 			goto err_out;
-	} else {
-		if (old_dir != new_dir) {
-			mutex_lock_nested(&new_dir_ni->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
-			if (NInoBeingDeleted(new_dir_ni)) {
-				err = -ENOENT;
-				goto err_out;
-			}
-		}
 	}
 
 	err = __ntfs_link(old_ni, new_dir_ni, uname_new, new_name_len);
@@ -1386,13 +1380,17 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	inode_inc_iversion(new_dir);
 
 err_out:
-	if (old_dir != new_dir)
+	if (old_dir == new_dir) {
+		mutex_unlock(&old_dir_ni->mrec_lock);
+	} else if (new_dir_first) {
+		mutex_unlock(&old_dir_ni->mrec_lock);
 		mutex_unlock(&new_dir_ni->mrec_lock);
-	if (new_inode)
+	} else {
+		mutex_unlock(&new_dir_ni->mrec_lock);
+		mutex_unlock(&old_dir_ni->mrec_lock);
+	}
+	if (new_ni)
 		mutex_unlock(&new_ni->mrec_lock);
-
-unlock_old:
-	mutex_unlock(&old_dir_ni->mrec_lock);
 	mutex_unlock(&old_ni->mrec_lock);
 	if (uname_new)
 		kmem_cache_free(ntfs_name_cache, uname_new);

base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
-- 
2.43.0

