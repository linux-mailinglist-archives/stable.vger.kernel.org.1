Return-Path: <stable+bounces-230870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAzILYvYyGk0rgUAu9opvQ
	(envelope-from <stable+bounces-230870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:45:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B039351249
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0195130055C4
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B12D73AD;
	Sun, 29 Mar 2026 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bbaSE6jt"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F2D3EE5
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774770307; cv=none; b=k+raesFr8Oh8sERHhZfY1gnwQcqHxrsTt+vvLxrumNdIsrUz4rEDGTNdF/dL9HM+1x8XynNrZJW8VaZCK2jL8iyOT7DyYAlGXuyFcL4+e2yEcxWTZwKPuq06ZPeKoInLZP2r9HUgE6VNi3kQFw7hOvA4XacQrHkJzp/14yN9j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774770307; c=relaxed/simple;
	bh=adlydW56b1snN02x62dy+pparjcOAWGySRNbWMdh4J8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=kobqpbDA6huvj0zOI7qCrXEpYWW0g7FaR5MOyskgEku2CCzb80mJbFyEXymFO1YvqB9TxsWZoRzkXmzJUR4DLId4SreuQsX5r3FS5xI+ozSpMyB1SOO9YX9uKU5gbzb95RMP3RpK1OTgEAaFOA6Wos2IlB0FYNETQcBcqHF+JTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bbaSE6jt; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774770294; bh=26/AEwqSvpOKnnOhA59M4j0AcvT/CoB1DEqcq6uuMdc=;
	h=From:To:Cc:Subject:Date;
	b=bbaSE6jtiQLNLDcLqBN5te0bSuVF2CNJX+ZWzqvwkwIS4Jv+LtAUA9Qq/jJQGnS0n
	 9FvnMEBDZXubmAHoPUMTxVz8I0Nw/51MU6HeifiWwC9ILmpNXj70HHyPPqLCbPO5lF
	 HNX+gyC2TgQ9IveGqT+d/+2JEgCoX8TjcXlV8TqE=
Received: from shy-Super-Server.. ([220.168.100.40])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B33B2097; Sun, 29 Mar 2026 15:44:51 +0800
X-QQ-mid: xmsmtpt1774770291tjkuqf2o4
Message-ID: <tencent_2A43212936E23BCA7ED345CADA51A8B2390A@qq.com>
X-QQ-XMAILINFO: MEPikTuqc1/xJ0hr2oXTY23guzu5Nqy7vYLWE9v9U7E01lBz8CQj8Yt16WGcv1
	 cpTzdXPQFG29e3NVmPTO8+CJjs/gnaUWlIURVR1JOvkOECbyiuPsag73URaV1D54cTF5vBAX5Wrj
	 rU8gMHexaVA75iY/CyLKi7AvqlwKLgn4N8MmJNTh6wFMY/ri4yHIavvFYbCivFszFcD+OeH9KIIP
	 ZDE0+CbK4x4eFGQ8MFA+uwdVHMqYFuPqTmiiHuskd9zKDzyt6Gzrc94iZriFGEay5oNHbJicaHGG
	 ykOC8po/hRa34ZHMtiHBbyMmxcXQYhbbFAUVACrgcBDVjbc3hmpkL1vr//yNjlHY5xlx3oNv4L27
	 PW9cG1mmHTMGVk+UxLIrbWMLx2Bgiz79TjnWRBIjJNIBEbVyBikg7ewM70MkSiaV5CnkaNBBy0rF
	 Jstg3MUlIAKAa6PfG9qjvjBQMHxWWeKFOU0dgzBulho3u7PEaJlGG9ntpTo1mmIsLvJUmhsY3e1c
	 0Q4kzmeOweKL9ZSWvhCCwv/iJBNAW5qnCamwMLDDR6irMkLw38CVe0UPZjEZJWvK5TTgqMxacqSY
	 ItRBGGE5cP5Umg9n6DiP/LARv0hApObRObM1wS6eRKuNbrKmconifDDorbc3R9rK8pxX0Yw/GRMO
	 96aTsqvvG9J/Zs/EQt3VnL9IBrxt0CFOF4jm10TDHmoI1sP6aq2I9m2RXop1Y+w+rop72NV5eDhc
	 qs1h+vrmbtOKHvLleSBP5DSpM4gnH/p5EnO/D8pkM1fPef2I1h+2XAtwlqoN1uxFHibbYZZelH3C
	 k0MqmyE3kMRs8Rmhpy3oBYZDlSw1amJnQvbgvPhx7gJq5ae+keS0hxRntQPCWlHbmhtYlKmg8kGu
	 RivGWBXy0Xy12lbfE+dv0DLNbwmi4txkPmYF7g1UYqBe8vw5UfUXs3/Ac19iZVjxfTw1zCSrAx8H
	 L87naWAg+WXxdsxbt7sDIQjsl2wH1bTP7R/FfMdOBlQH83sD4KAmRwqyOUDIt1MW0PVDVIv/x436
	 FFg298/faNXJi/tKK6uEyWEAaW8AMWPBdC6WvjIy+Dw6h6wFQFPG6IP5NGawBidjb7TRtswkkhqX
	 1GpKHlrrBNxuk2KvNod3ZbO3uF8X1nHqcwDCWH
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Changjian Liu <driz2t@qq.com>
To: stable@vger.kernel.org
Cc: syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com,
	Changjian Liu <driz2t@qq.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+77026564530dbc29b854@syzkaller.appspotmail.com,
	syzbot+5054473a31f78f735416@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Junxiao Bi <junxiao.bi@oracle.com>,
	Jun Piao <piaojun@huawei.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Heming Zhao <heming.zhao@suse.com>,
	Joel Becker <jlbec@evilplan.org>,
	Mark Fasheh <mark@fasheh.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] PATCH] This is a backport for 6.6.y.
Date: Sun, 29 Mar 2026 15:44:22 +0800
X-OQ-MSGID: <20260329074422.1464710-1-driz2t@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230870-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,qq.com,yandex.ru,linux.alibaba.com,oracle.com,huawei.com,gmail.com,suse.com,evilplan.org,fasheh.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9,77026564530dbc29b854,5054473a31f78f735416];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B039351249
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit e1c70505ee8158c1108340d9cd67182ade93af4a ]

ocfs2: add extra consistency checks for chain allocator dinodes

When validating chain allocator dinode in 'ocfs2_validate_inode_block()',
add an extra checks whether a) the maximum amount of chain records in
'struct ocfs2_chain_list' matches the value calculated based on the
filesystem block size, and b) the next free slot index is within the valid
range.

Link: https://lkml.kernel.org/r/20251030153003.1934585-1-dmantipov@yandex.ru
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Mark Fasheh <mark@fasheh.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Changjian Liu <driz2t@qq.com>
---
 fs/ocfs2/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index c561a8a6493e..7c99f436037b 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1419,6 +1419,23 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	if (le32_to_cpu(di->i_flags) & OCFS2_CHAIN_FL) {
+		struct ocfs2_chain_list *cl = &di->id2.i_chain;
+
+		if (le16_to_cpu(cl->cl_count) != ocfs2_chain_recs_per_inode(sb)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list count %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_count));
+			goto bail;
+		}
+		if (le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+			rc = ocfs2_error(sb, "Invalid dinode %llu: chain list index %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(cl->cl_next_free_rec));
+			goto bail;
+		}
+	}
+
 	rc = 0;
 
 bail:
-- 
2.43.0


