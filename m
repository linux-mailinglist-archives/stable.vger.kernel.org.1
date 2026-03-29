Return-Path: <stable+bounces-230873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDSVNnntyGlfsQUAu9opvQ
	(envelope-from <stable+bounces-230873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:14:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD103514F1
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FB423006D7F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B277259CA9;
	Sun, 29 Mar 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vNA75dUY"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D12F28FC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774775667; cv=none; b=YbgHEWGg9ovtOt6F4bA4x3MtaClBjRL5BR9Pvv856X6TGH/vO1bPEm3poXhnWbBFU8sLPaTabLhXCtKLvOw3TsmwQUqGPhEJGjprozfpdgA7Q5QVjWLMwvDOtOjFLELFbr2vrPpkFJnX8tinRqecqxCOfWEy9O61XuOt+NQfRFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774775667; c=relaxed/simple;
	bh=adlydW56b1snN02x62dy+pparjcOAWGySRNbWMdh4J8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WelPTWIQC1DjoxXCWmajGZttQ3rZLZuIAZXKJK7iLTUCXRieVnWbcrYMotJBHVcTT+6PNRAMo9KWfRjj/zVdO8R+7A7JYJwT67Q0/ADaCzprwh25eV05Nc9lY5mM543R1tjU6s7kpxKQ7McVzK9pYIq2py0fLHMqohqZLtTks8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vNA75dUY; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774775659; bh=26/AEwqSvpOKnnOhA59M4j0AcvT/CoB1DEqcq6uuMdc=;
	h=From:To:Cc:Subject:Date;
	b=vNA75dUYQqfHvRvrW3Z3la64k13p8X1/jsyMgQ4Dq+N9747zvCxQh4Y4srKeFfpDx
	 dDtceqCDPumeiefXkYjAjz/8kqEAz8HjmeYlhqwtsRUbdSiAQ89GdyrL+7mvh2acEN
	 A8TpxA3XlSwVx/o9kobqqX5SOkyahB7Ebbnkn+fA=
Received: from shy-Super-Server.. ([240c:ce04:3500:3500:0:9e:31f:aa00])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 38F86028; Sun, 29 Mar 2026 17:14:15 +0800
X-QQ-mid: xmsmtpt1774775655tdwdi8yel
Message-ID: <tencent_3C8D7C8EE9DF1B910A7643AA5ACE97481808@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLdZrKqeMp/6GXw7pTbu7e1apHAue6IkI6lnEANzzuY5ToS4u/Ei
	 FdiZPTSJVTVbFCVzxwIlCWiEXL8Z8SetQcDzai1FHn74lsZ0pJJLRlv9nDWA7uBcDRpxrqJONlGz
	 pXU9XHDp9by7Fo2tS0XYzWgxLaVxspt7lVWIXh3XEIPxnAzKaiLqRsEwZFBt399M9cHb8dZ9AZ9p
	 bDKRcbUgCZSQBvug+KG0n6hlXPB29J1kW+yAPiSz2w9ksJ5Dy8tBeaO2O6oGppdn5AGCM5t/XZ1w
	 3xCLO0zokz059Prvy4dSy+ykSk9VKMBpRAO3ReDjPuIrdxpUgU7QmnbA6B/V9WrHmkgf1yog7SuM
	 sEBIM0tkgok7PtT1+Kk3PBIU5QCEnkjd6axB39SloZ9d4tqh8olI1ZrVjq0qIfJYKgC+zrSqTz3J
	 cMIpZPFKMaMxNrJdtkMm7QJk0zeBQQ0MmT+RycDXg/FqrscMJhUghPfeae1gcYIjtTnIy9F7O6XP
	 5SpIXdgXMWSvINidCKPxYk6krSr2Hl7sNVMYcki9npNgzr6TP3l05feS2h421hX4uR7F+9TbWZFN
	 j4z3PF3W0wiT/F7qyR+jXWmnILdth7QYlmuQtj1dD/gKlvtY4XfaR/h47gCynMYQVpjSkW5dXsnN
	 qJfoUAYo7NDiTWuZ+HI/3+v5UGPuOU2tAC4Q8XuxkNbm4g98dJcMQ3hZdF+o39hNB3tAN1ac5hgQ
	 9ROEIFlOT2bK3IwEmoyxf8QB40zxxNTp5V9E0Q7x3cYyny01kV7aety30trQ4zKiiqhH/ksbopau
	 4YqwI5uQ7Xlv55a50+rRv+CqG/bdVZ9h4dWl+wPNRInZi4qDLo8I2vAFD98uerLKseQvdciYdIVT
	 DhrujRhVn4fD+86Bv8CuuPZAuCoCZbCr/tWpzj51rcrpt6lbej1GGWrZKAfPUARgXp0Gu/QD4WUQ
	 RaCyVgUU9NJhtXZKUTqoayKYyLgtPRilY44es6UdAyWWFlXC1SckguGb6D+a881K0CK6oaSLEtlJ
	 hdBIy5NpWfeTIOK7p7uy1HdL5hOUcJW5ykEV+k8pARMUZyQc8+yGtCvEkYdIH5an98jeokAZmO52
	 OHIyG+9/ndtX+CePYZv598rXmsiHV18rDK1rTfdnP0jlCZ4ZE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH 6.6.y] ocfs2: add extra consistency checks for chain allocator dinodes
Date: Sun, 29 Mar 2026 17:13:52 +0800
X-OQ-MSGID: <20260329091352.2960293-1-driz2t@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230873-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AD103514F1
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


