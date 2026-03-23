Return-Path: <stable+bounces-227965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OqOJLs1wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:44:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEB32F222F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078953032049
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CE370D59;
	Mon, 23 Mar 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="N1BB8rXh"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34129AB02;
	Mon, 23 Mar 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269539; cv=none; b=X1lbIoPzVvK8bdXV8DoG+oW732SSBtfXE1i2Ybya7EP8M2nmyXgfRC9e5S/VQMLaoBQ3WS6w9c2vIigiIuxM5eUoyOMiKeZOImNzMxnKsg0E3bmHs9aFqcQUWuj0sdtd9Id7sAc6x84947DuzWZewAEmYDqfLsJQw5JWR4seQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269539; c=relaxed/simple;
	bh=tiVkrNSva0a67YBxJj4Zm2Xu7kQX96Xn0jxtEup2EDc=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=QblvVcEkdw3VUSafZThOa1HZja8VM0cuhsAPiFy4g3npQn1KCjQujbduddMxgYpn14TT2FpnwWJpisbTtlMOJ5izKcgYZtBOv+tOQj6jhpVKzAWpGYXTEY/l4ShF3ogyGO/LYM3PFT7kwYsAfKHq4G981HSAwiCrbRvatHLtYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=N1BB8rXh; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774269534; bh=tiVkrNSva0a67YBxJj4Zm2Xu7kQX96Xn0jxtEup2EDc=;
	h=From:To:CC:Subject:Date;
	b=N1BB8rXhnOiNvKTEW9xTQnD7F1QCpdOmUdS3p/bDUwNuFYPIaoCvukrEG0L+WEKBn
	 XgD9N88OJ3IKIlEyWtVFQwsrPoaURzW4VeiJh+EqgdPajnrAdJ1n5lpg/1j2WzJCQD
	 uQbYWAikaQTcxewUWhOjMZH9p72GK4JJiHSp4pLY=
Received: from SE3PR03MB9514.apcprd03.prod.outlook.com ([2603:1046:c07:1021::5])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 9B3AF08A; Mon, 23 Mar 2026 20:38:51 +0800
X-QQ-mid: xmsmtpt1774269531twf682bg9
Message-ID: <tencent_7C51DF11EF9B2F12D8AE4595C0F91009A405@qq.com>
X-QQ-XMAILINFO: OTAuIxCfey6w6VNzBhxrcwf2gjlEgcSicggWuNxnRJAl0USy4/2K/W9tuzA1qI
	 5WHMqwB4h0Fy0Uclbo+txBJemx1E0xU93jDewyegV56e/JDLLzJSvL2d5W2rMULIm8nglXogYgnf
	 6EeS4MyAemcnfcXuRVz08xaxwSKtBFRvhteX5RxCCnQk6pIWl8JXpIMsEDFTPS2kNCo5PQ2OLqpS
	 96qS50IBJmHPHmUt/ZU9eZDVK7a2/zz2VbMl0dcG/zkehbnLDZs735WGMU/+wNw+f0kPkvi3qtUn
	 lZOi9BBKYVtQvT2leMRDZ05Ic4yGZbAjOat9sRJ+LrqghN+fNLk6rOmP9QUoqiC3W9A4SrEQKjV2
	 33AeiqsdmX1njtJpe9QKer/DMsixL6BVdLBLpc139tTkNx79y1nHfnpUJg/q6LKarhbYtlnm7sAQ
	 f/2GGJZPzcx4kqhZSuXYvDujvlGPkWE80tynz46Vu7Jv7BRoJifcIY0262e8v/2tgewRyzjBtBWw
	 eij5HiZPEh6B0qQWbdeWOCrKnDoWE952GYWp5wVALPIBckejwP3wfRPOTAy74Vp18Un9NtytXiEL
	 +lJSeflfKNFmrpyy4w91IYkXqSquKrDntuF/Nn6gTgPUr7IiyzKtgxCFUZYxSXdm3uGYnJ/pU7pe
	 zKUworCoDGxq3K5ow23G6LEUBX8HV0PdhMACxLFSxfz8yyJKuIpLuFfnwPlbq1YrKXCjsJAaBMD4
	 kHnASW4uAuyVmpIoiZfhkFBGOa+kbhMokuqxCn0iumB3sHWn4oiFGjECV8frrjed2Qy2ICFHuRSb
	 xT6KWY5iYMx1ZXs28FYItTvKE6V15DDLSSHpB4kfvbVrh5y5sBc6kuDmtD4C/CD91DahLvIyrEx8
	 3zuO70sbF6a3EU2zNmPg/9QOteNzA5yXaEGFCEU/2hRhbdYVnCdsiDF5Q2UEr5PhorWJwzN7vDju
	 yYDn6UbLTRkLapAK5vSwbtt/0OZF2Dtxt/6enXwgjAIEDSwtfc8beoHntp7kqenQ+pIzzO0g0KZp
	 Zbbkt2UC7oxixsOqG+qkF/A9zJf4sfWJWHoVtfSLSFts2OszUyw3+mMP05UgJ/OTQiRP9LdOYsCz
	 HNfDewesLGARkd8j8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: "1016331059@qq.com" <1016331059@qq.com>
To: "syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com"
	<syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "mark@fasheh.com"
	<mark@fasheh.com>, "jlbec@evilplan.org" <jlbec@evilplan.org>,
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] ocfs2: shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Thread-Topic: [syzbot] ocfs2: shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume
Thread-Index: AQHcusHWnIYyQM4p20W6ol6hvS7KLA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Mon, 23 Mar 2026 12:38:51 +0000
X-OQ-MSGID:
	<SE3PR03MB9514B5CF5D43F735BC965585A94BA@SE3PR03MB9514.apcprd03.prod.outlook.com>
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
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[1016331059@qq.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-227965-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BEB32F222F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Syzbot,=0A=
=0A=
This patch is a fix for the bug reported by you.=0A=
Bug ID: c6104ecfe56e0fd6b616=0A=
Link: https://syzkaller.appspot.com/bug?extid=3Dc6104ecfe56e0fd6b616=0A=
=0A=
This patch is a backport to stable 5.15.y of upstream commit=0A=
7f86b2942791012ac7b4c481d1f84a58fd2fbcfc=0A=
("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").=0A=
=0A=
Please test it on the public 5.15.y tree below.=0A=
=0A=
#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git 3=
330a8d33e086f76608bb4e80a3dc569d04a8814=0A=
=0A=
From ae310006fc6e06c233b8d6780b2a2c6a16d6d708 Mon Sep 17 00:00:00 2001=0A=
From: Changjian Liu <driz2t@qq.com>=0A=
Date: Mon, 23 Mar 2026 11:39:19 +0800=0A=
Subject: [PATCH] ocfs2: fix shift-out-of-bounds UBSAN bug in=0A=
 ocfs2_verify_volume()=0A=
=0A=
This patch is a backport to stable 5.15.y of upstream commit=0A=
7f86b2942791012ac7b4c481d1f84a58fd2fbcfc=0A=
("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").=0A=
=0A=
This patch addresses a shift-out-of-bounds error in the=0A=
ocfs2_verify_volume() function, identified by UBSAN. The bug was=0A=
triggered by an invalid s_clustersize_bits value (e.g., 1548), which=0A=
caused the expression=0A=
=0A=
 =A01 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)=0A=
=0A=
to exceed the limits of a 32-bit integer, leading to an out-of-bounds=0A=
shift.=0A=
=0A=
Instead of shifting by an invalid bit count while reporting the error,=0A=
log the raw s_clustersize_bits value directly.=0A=
=0A=
[ Upstream commit 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc ]=0A=
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
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long long)bh->b_blocknr);=0A=
 =A0 =A0 =A0 =A0 } else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits)=
 < 12 ||=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(di->id2.i_super.s_clustersize_=
bits) > 20) {=0A=
- =A0 =A0 =A0 =A0 =A0 =A0mlog(ML_ERROR, "bad cluster size found: %u\n",=0A=
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 << le32_to_cpu(di->id2.i_super.s_cluste=
rsize_bits));=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0mlog(ML_ERROR, "bad cluster size bit found: %u\n",=
=0A=
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 le32_to_cpu(di->id2.i_super.s_clustersize=
_bits));=0A=
 =A0 =A0 =A0 =A0 } else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {=
=0A=
 =A0 =A0 =A0 =A0 =A0 =A0 mlog(ML_ERROR, "bad root_blkno: 0\n");=0A=
 =A0 =A0 =A0 =A0 } else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno=
)) {=0A=
-- =0A=
2.43.0=0A=
=0A=
Thanks,=0A=
Changjian Liu=0A=


