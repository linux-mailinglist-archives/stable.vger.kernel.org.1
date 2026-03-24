Return-Path: <stable+bounces-230087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEVqCw5SwmnNbgQAu9opvQ
	(envelope-from <stable+bounces-230087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:57:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AE0305259
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 519B53087C9C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FB3D88FB;
	Tue, 24 Mar 2026 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UdS7BA1x"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD038F65B;
	Tue, 24 Mar 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342322; cv=none; b=Opy3gvQaJJz/Zd+OXj91NdyHtUkKx8wgDOGGLdMIKOIyIwL61FTNHmDQqEBuiSpL5kYDvh0XX40kF2hHOKZdYkXrkYkL6wo7jlHf4glDulbnCWb5O5TzJ7fRPrdfSULtxq7B9CjhbREHfq42nt0fhw0BIDsvWehIAqzs2fPrjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342322; c=relaxed/simple;
	bh=/fJ9v5fUXSVv6fSHN7ZQeOWJ5CUJvDIEBHqUZdlB/3k=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=BGdRp5AvRhfbRBhYHD7t9GxHck/9bR+W8bmy5XXF+YxSmcIbhJQE5eKcyd9h9NsNM222gYFKydLd538EBTYl2Ded4DheqL+yY7PdLCATaq20eco9f5o8BGILJqsRMi8N9MojlHXqCaUJ2cg6ZV0eqmvI1XakeeODG2kF/zuu67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UdS7BA1x; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774342305; bh=RKB/toyE3fIkPlfhuqCKbpNI2kcxXqkPXNxFpTRxA5E=;
	h=From:To:CC:Subject:Date;
	b=UdS7BA1xio8dsP/7YFAFh9O/+7oVrrnfkEiDCWBtZ+UgKWW/ZBP1qRzr+AYj6lwEp
	 FVxWXWAaZijdA6DjchuYKwxJ07jfuaiX4XuSLR3piBailGBPJHb9CBXVZJU9OnGQeY
	 VlaK9syyuSZXbwFYwe8UEZX2128+ek3kvKrMgWUk=
Received: from SE3PR03MB9514.apcprd03.prod.outlook.com ([2603:1046:c07:1021::5])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id CEB08447; Tue, 24 Mar 2026 16:51:43 +0800
X-QQ-mid: xmsmtpt1774342303twljyfwyk
Message-ID: <tencent_13981D81EAB7B312D26CA3A023CCF74F6406@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb53f5C+uuig2aqI7XmSTkE8MdKbL1L7VmY+Xo1esZMzaQt+5fVpc
	 DzScAjP8EiTKODL7Rm/oyMO5bQCqpbD2rx93+37xLPR+DI7L338v11cITDU2O9Sj4ngIK6HUH+Jo
	 bQrRKKITwLwvQfxVn+PUgMEeXhwfjUD9LMqf6zAFZoQzylTiwCA+2NjyifGsr1NlXyYQZfTuBseC
	 jqPjABdSzlrfSih/w5grZfLQGNBlRjhgeN4+5rQwkzDyzd74g7FvRduVVKk+xoAMzp52/o4tcL1c
	 ee7AVWCdh6NVQEFcl59qAvkKqqy5uvDJGpUj/h7wYCD9talPiCAwvi5wCjucjTfoI60+RGsoPLS+
	 w6jgMhz4s/FPnVvaE6OZD/yloO0l+al9NBQgX0cMIFXfiSwjrZLal0xekzOI0oTyEVNggpBsR7b7
	 0VhthsdurthS4HyYaD+HVNEbX6PnvfiOWSlGoKY8BEL3RcNHrwzH5cFNvKYSsu/f58wDGEX8lZ3k
	 q7Xx9csBem9xNOHRwTlw5VT10/qPjL3KejYBP9RmUc4WJfRSob8N0Goljs7XproSkHzoOtOR9iSx
	 3JBo6xuIJinKWXz79waV7KmGIcBoDGFdoqYrGrF9nQLQ63qYDi7jcTTjq1gArjfwb9KrMjzmBVHX
	 DTmdUq0fHTx1zwvvrMFeM5U/JgqZXWJEwJEZakNc8RYekLaZ7oscXxSvfvfkoqtgoOpFLnHfSzUr
	 s5DxSm/1GVnh94J3JGpwUViAjoSM6BptdUVMCkN6lP5aVsEoNkelgvG+hFgLdoBdIiItENAdhRRx
	 e81o2ol0o6+GrdW3jHtHCia+y/r36k+zYQjHc/0TI4vLHcQS+C7E78bfbQOb4QehxHMuRVbhf9u6
	 ZmsBdhJez7kkxEDPlUmKCICNjUj/4QHyShi/zWMK2MVIJzeqx1cBgK381CI0+Wvi35jK+TORETHV
	 LHxZs2WglDtilAIwVk3HXQCjsCAaSFYZ6EICV3IfExdie6RWPBwSAB3wiJaVN8acjeeFJOh6+ezW
	 2jnsJuP+KSkRD7XOvWe9A0s50DDf3lYIG6sGJIqwc9iy7RUtEK5H1jIc1PHTP6P0X1Qa6+ZTjuQK
	 stew5i3V0XISGh3Eg=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: "1016331059@qq.com" <1016331059@qq.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "mark@fasheh.com" <mark@fasheh.com>, "jlbec@evilplan.org"
	<jlbec@evilplan.org>, "joseph.qi@linux.alibaba.com"
	<joseph.qi@linux.alibaba.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "syzkaller-bugs@googlegroups.com"
	<syzkaller-bugs@googlegroups.com>,
	"syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com"
	<syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
Subject: [PATCH 5.15.y] ocfs2: fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Thread-Topic: [PATCH 5.15.y] ocfs2: fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Thread-Index: AQHcu2rhkliTgaZuR0Wz0ayh3cQN7w==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 24 Mar 2026 08:51:42 +0000
X-OQ-MSGID:
	<SE3PR03MB95141C73425CC77214D5B702A948A@SE3PR03MB9514.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230087-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1016331059@qq.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: A4AE0305259
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is a backport to stable 5.15.y of upstream commit=0A=
7f86b2942791012ac7b4c481d1f84a58fd2fbcfc=0A=
("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").=0A=
=0A=
This patch addresses a shift-out-of-bounds error in the=0A=
ocfs2_verify_volume() function. The bug can be triggered by an invalid=0A=
s_clustersize_bits value, which causes the expression=0A=
=0A=
  1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)=0A=
=0A=
to exceed the valid shift range of a 32-bit integer, leading to an=0A=
out-of-bounds shift reported by UBSAN.=0A=
=0A=
Instead of performing the invalid shift while printing the error message,=
=0A=
log the raw s_clustersize_bits value directly.=0A=
=0A=
This backport was also tested by syzbot on Linux 5.15.201=0A=
(commit 3330a8d33e086f76608bb4e80a3dc569d04a8814 in the stable 5.15.y=0A=
tree), and the reproducer did not trigger any issue.=0A=
=0A=
[ Upstream commit 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc ]=0A=
=0A=
Link: https://lkml.kernel.org/r/ZsPvwQAXd5R/jNY+@hostname=0A=
Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>=
=0A=
Closes: https://syzkaller.appspot.com/bug?extid=3Df3fff775402751ebb471=0A=
Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>=
=0A=
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>=0A=
Link: https://syzkaller.appspot.com/bug?extid=3Dc6104ecfe56e0fd6b616=0A=
Tested-by: syzbot <syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>=
=0A=
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>=0A=
Signed-off-by: Changjian Liu <driz2t@qq.com>=0A=
---=0A=
 fs/ocfs2/super.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c=0A=
index bb174009206e..ae2ba616756d 100644=0A=
--- a/fs/ocfs2/super.c=0A=
+++ b/fs/ocfs2/super.c=0A=
@@ -2369,8 +2369,8 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *d=
i,=0A=
 			     (unsigned long long)bh->b_blocknr);=0A=
 		} else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||=0A=
 			    le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {=0A=
-			mlog(ML_ERROR, "bad cluster size found: %u\n",=0A=
-			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));=0A=
+			mlog(ML_ERROR, "bad cluster size bit found: %u\n",=0A=
+			     le32_to_cpu(di->id2.i_super.s_clustersize_bits));=0A=
 		} else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {=0A=
 			mlog(ML_ERROR, "bad root_blkno: 0\n");=0A=
 		} else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {=0A=
-- =0A=
2.43.0=


