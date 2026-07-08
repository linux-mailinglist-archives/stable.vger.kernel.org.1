Return-Path: <stable+bounces-272571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GmiXE/EHTmrVBwIAu9opvQ
	(envelope-from <stable+bounces-272571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 10:18:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A592D723126
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 10:18:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=FLZbJMrT;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272571-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272571-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 999C5301A7E4
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8B3FE34E;
	Wed,  8 Jul 2026 08:12:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FF3D6CAA
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 08:12:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498374; cv=none; b=ajR++zGi7Gd/Vf/4np9yL6gk8b1FoieW6iNGCkJwa18bmY9dZ2o1A5BXyJW1Gg6T5ytpGIxusgd4spXbsmobmmYSiO/dNuBeVQxFW03n3Fk7H5+EVJ3IbluyvfBzziXc32vthG7l5gUG89drV1KUk8Lo49b3pObvqty4uOBYvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498374; c=relaxed/simple;
	bh=ymhXvroLX3CH4eR2SGkSdoQGnSfT5q1/U6mh3CKl768=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=gEQkCGiM+pNWIMRQU3ZRlAjyqrzczp0/WdwBXF50SbuvSqqYn7q7NsFgM2DHT/ZaqPlhUQV7R/u3FQ59wk6OSlAp7KO0AEVNuxg3FZDyQXRORXoIFtZPySAMivi4Hu5ZRdO0DsdwlGrPI23abufx8FQil/zsMRREiIUbKvAcyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FLZbJMrT; arc=none smtp.client-ip=203.205.221.173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783498340; bh=SnX/BxqxHOFgdRa7DP80F2nItStdQQssUzZaSW66+Yg=;
	h=From:To:Cc:Subject:Date;
	b=FLZbJMrT6siq6hYkGYFz+wElonRlV1a6OgCWuWQ7CPS3th82ys2pBSVv4OSD+XNc7
	 7IlvvfG5OPNOyI98UtJBgQQBdpv9WXuc2hzN7QwZzbl1GkDVr1taxGDjSURuFlLkcs
	 vF8Au8hvJQKJkar4EGR4DIPzdyHa7ExhWJG7fVuY=
Received: from ubuntu.. ([218.196.207.7])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 3079D4A5; Wed, 08 Jul 2026 16:12:07 +0800
X-QQ-mid: xmsmtpt1783498327ta8cpmedd
Message-ID: <tencent_E3622146846A84C75C31C7D32AC4D5AD0605@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb55+1pNaYaxXA4sA6k+xzHEMn2Zw9BM7Wy+uZla4RJct4it5QFmY
	 dFmHDdE3hGRCF/KI5OXHOTMZIjn6Haz33tVvMw5/ryNzZvvejZbLq2Du6c3tGT3gwerQc6tEhHsE
	 uqoekNzBQSdxmpf0qtgTd/7GvPI8kPS0HJxLyazbEqap5jyaLtww1cF1ooT0gpY8grF/318ZQO/J
	 F0yaVfwrp4E6I73y+Q+JnI+iuINaNADBsj0eCBJNqJvP+94UCXWvGjLpniGoGD3kLAxS3BSgZFsk
	 R3E8qNRjRnNXtVFZCrXhAtBRc67YunIvlUfyeHYr8v8Y79XRw6g8mv5PhiEVIUGsBNwvKlYmzwnz
	 C4I9Ly0jdq4By/DQgT4f9IgzqMnTebOC+QRQCQdEm9LHbuwWBWpCL1rHHQ4Dj/ux692cFH/fTNaV
	 3a5TGVGMzxtxy5c6JZJY6Z1ZzONHCjXwDM9iInXOqDCoKZNlkEIvzQFYR7VdTNTrVHJBQg9KeYTA
	 4TzM1jdFD7sw2OFkCL9z08i0TLUBekwVeXaxmdGiuh8TeBiK+5/ak0kJWQnPJKqYogBse8iaIBa5
	 AD9mOKol+MaeJoZfziPaqABommoj1NWjOLqi9RBJ7Eg4dYLBEHbO6enSVZkw4KOdNCnfY/P490nN
	 Fz8KnYe8HY02DMUjJ7l4qi727ebDC3i28qN3vDxpDqG0lMTslHqdNax4G5DpCxGRrEDK5PHxvhFM
	 AeLqNimNkAYYAnCiFYamp6izbI5MYejKH2mSWPF6aMYC/VEIzEtuAAC3RdubB60/40lqUz6+KlRt
	 FKe2bPpGwZBcYmt8xe5+bZwbidkZjgSyfdgeUEq28YWniQZWAcYQmpYYoOKJ2wMxD8+0HgptpE6d
	 4v60ElxGIqTQQeyj9fbuxRzZii6YOr56ye/qdP3otMKdIjEmFHNK4qhSrrmyJLjU+qJgQoMk8NUE
	 xMGEpZrgZ9wMW1fNXDKenCdv3nrg1UgwAQprr4QXYJhO86N/waiFzykld7zobkC0DqUjuRp+j40R
	 Yn8tMlBuLvaDvQjr6Dbwi41NEzbGYYFcL5U794EEPGndWmj3dB
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Guanghui Yang <3497809730@qq.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Guanghui Yang <3497809730@qq.com>
Subject: [PATCH] ext4: propagate errors from fast commit range replay
Date: Wed,  8 Jul 2026 08:12:04 +0000
X-OQ-MSGID: <20260708081204.924947-1-3497809730@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272571-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:libaokun@linux.alibaba.com,m:jack@suse.cz,m:ojaswin@linux.ibm.com,m:ritesh.list@gmail.com,m:yi.zhang@huawei.com,m:harshadshirwadkar@gmail.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:3497809730@qq.com,m:riteshlist@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,vger.kernel.org,qq.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qq.com:from_mime,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A592D723126

ext4_fc_replay() stops replaying fast commit tags only when a tag
handler returns a negative error. However, ext4_fc_replay_add_range()
and ext4_fc_replay_del_range() currently return 0 from their common
exit paths even after internal failures.

This hides errors from ext4_fc_record_modified_inode(),
ext4_map_blocks(), ext4_find_extent(), ext4_ext_insert_extent(),
ext4_ext_replay_update_ex(), and ext4_ext_remove_space(). As a result,
a failed ADD_RANGE or DEL_RANGE replay can be treated as successful and
the replay code may continue with subsequent fast commit tags.

This is particularly problematic for DEL_RANGE because it may already
have marked blocks as free before ext4_ext_remove_space() fails. If the
error is swallowed, replay may continue from a partially applied range
operation.

Return the saved error from the common exit paths and make the
ERR_PTR() cases in ADD_RANGE store PTR_ERR() before jumping to out.

Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/ext4/fast_commit.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 8e2259799614..fbb486d917b0 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -2196,8 +2196,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, path, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -2209,8 +2212,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 			path = ext4_ext_insert_extent(NULL, inode,
 						      path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			goto next;
 		}
 
@@ -2257,10 +2263,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	ext4_free_ext_path(path);
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -2320,9 +2327,10 @@ ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.34.1


