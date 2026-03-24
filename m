Return-Path: <stable+bounces-230061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FEyAWQ8wmmCagQAu9opvQ
	(envelope-from <stable+bounces-230061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F2303EDF
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7240D30E4997
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EF33932D4;
	Tue, 24 Mar 2026 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DO7gsYWU"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318131E837;
	Tue, 24 Mar 2026 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335919; cv=none; b=ugNbvkGAdfgMp62LAMkDXoGzIXEw5QghL+arCIxKRG6HAdKX4Q/X1CkUUNnUlxQ2GkxUCdjdnLH64q6auokcWlZb0aaACqsTlUA3VKeXJzJKr6cpCY3UBU+QS+jhgqTDZN3xBfn+SaoM8IA0+rTMErFKy8DaefRfU9s7JFAxEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335919; c=relaxed/simple;
	bh=JI3JltRFrcihdGxp5GS1YcK5LsRsOHDQYKuQqoIHi9s=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=ITlCVwbs/iNSPskMVtbTKGE9pythGBWQtWVM6vc8ks6pVczlmlyQeo3m+fywcgVSd5qVDraGZrmUgGXZD5lk5iosQrrorVj3h+l9blnQETe9pAeHlJ0LbUzpHTgK/sxJTabNsPttofjDRjM/T1adGtW28zv7UWFhvDQkCbel48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DO7gsYWU; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774335902; bh=Gk/Mvx2jlD3ud65KPY3E6fLle2Sp1xLjy3zV1APF9xk=;
	h=From:To:CC:Subject:Date;
	b=DO7gsYWUfJDUjv5wdTwuMSL9qPZDjWgHGPXeBa5McnL6WJ28WNYgGPi+gEeAAw6OH
	 7tWKcmspD9kB7/GbAvmBsuasn2yjw7voMYCG9ih/wtfTkAT404ldF0YauLL0WxyORA
	 gbE/OxCzQ3+uz3/tALdMUy9m9gM7mSk/Enf3EcG8=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: NGZp1yYNf7Y+l+vwv16KzMGan/OedZs8+PJ/T8XoSLCX0Y9jkI8QXPZ0JmIE3g
	 Os3ZksM3NjkjHeQ/G8SzguhxTO+z3byUM6TCna1Uh706TppTXx3ypJYPsLS5eGf9uR9+tnx4SySns
	 gRwYN03RiopxJPZXdfzwmOfzkhtZDzcKXlOU1Rc9HSkU+6pxyxWjZTJs7KvATeA2gyr1XLXrYQUew
	 lNfAlg19ZNuNbhhyY82qW3Ep6053Y0I3r2dyhW52YKcnoEEQGhZhX5pffY1DIrY3cryktsRZkCyRP
	 5gnP680eJRbgfp5jY3bqYLUYEOQ56l1NzJY6hLH7+HOZPGiwU50BNv0eQ8xX67sXjuGXysnjRhKBL
	 JMFAPTAb3VJHiq/dAzBvkn/5GPHqi0u2x8NPKTIsyCvQi0fBtBm9NDamH8qnYZhJ6CpjYtCYxt3kO
	 GMWubcX6UhHro/f2MRjo+cyTyIF5yAtHz7TTbhfmqubqX4/FS5tAV/RusDwLXrguSNGxajwdXopRq
	 Hkb36m+kURSmHCgtWYYcxNUPX2ULME0FeEdpxvFcQkEBcCzuRwOQzwMRW6FygCv7VcZCIIFbDUoYG
	 UEWL7fYtuRn24IaDmSOmoGtvuGNG1lpf5P9iNdkxLzx+3igpcn8zu5aKCRT3JQx5hnQcyTfw3V2lx
	 NBFV5xp7dKVqyA5hepWYxPsxRnNqML3lgJvC2V60nWcNLOPfLv5Q8mauLoQCBAeRZhFPml7j7gyEO
	 0GEcYhisIO1GPIur/hRwjJ36sHS+jXBiz6PVMMQazVAwaYAIySpePhbwA6YrCODpmaRG6awmhGcwc
	 xpChK1UtABy7jodyMXfBmVXGmehhGmfQngYComxmczMo+voao2ki9pbbFlGwryoQIQzQOQC1bIvoN
	 QyHu5CIC7EYaoZo0nWOxOsqvIVtyGpAq+tXhc8xzcFxVbeaqR5jNmEzyd7prWO4c5wjBo6l2DjNIW
	 /zEU2n93rWa69wSZbTKtagpkZn1NK3fCEBAMBjwSAYKIQTaOrbgRP+7Oz+ZnhExm1eTcVTSiRzRWY
	 PTATqcprhsCXTRZJbIHvoqAyrt1n2RD71qlOQSV8GofCDMlebPFgJUA42kHomUh6/zD3VJdjwQl14
	 8n6IHWuhcvvkeBIP9dKzUTPm8T2w7CBQ2PjXHBRX2BsD5A==
Received: from SE3PR03MB9514.apcprd03.prod.outlook.com ([2603:1046:c07:1021::5])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 13B1AC69; Tue, 24 Mar 2026 15:04:59 +0800
X-QQ-mid: xmsmtpt1774335899tumiwbf27
Message-ID: <tencent_BA29A271C331E1BB2072C04E5D55C1B90405@qq.com>
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
Thread-Index: AQHcu1vM1OLBR0gTR0KiT87tk3Xreg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 24 Mar 2026 07:04:58 +0000
X-OQ-MSGID:
	<SE3PR03MB9514009D6136760BB9CF9040A948A@SE3PR03MB9514.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: multipart/mixed;
	boundary="_004_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_"
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230061-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1016331059@qq.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid,alibaba.com:email]
X-Rspamd-Queue-Id: 536F2303EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--_004_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_
Content-Type: multipart/alternative;
	boundary="_000_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_"

--_000_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch is a backport to stable 5.15.y of upstream commit
7f86b2942791012ac7b4c481d1f84a58fd2fbcfc
("ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()").

This patch addresses a shift-out-of-bounds error in the
ocfs2_verify_volume() function. The bug can be triggered by an invalid
s_clustersize_bits value, which causes the expression

  1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)

to exceed the valid shift range of a 32-bit integer, leading to an
out-of-bounds shift reported by UBSAN.

Instead of performing the invalid shift while printing the error message,
log the raw s_clustersize_bits value directly.

This backport was also tested by syzbot on Linux 5.15.201
(commit 3330a8d33e086f76608bb4e80a3dc569d04a8814 in the stable 5.15.y
tree), and the reproducer did not trigger any issue.

[ Upstream commit 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc ]

Link: https://lkml.kernel.org/r/ZsPvwQAXd5R/jNY+@hostname
Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3Df3fff775402751ebb471
Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Link: https://syzkaller.appspot.com/bug?extid=3Dc6104ecfe56e0fd6b616
Tested-by: syzbot <syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Changjian Liu <driz2t@qq.com>

--_000_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This patch is a backport to stable 5.15.y of upstream commit</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
7f86b2942791012ac7b4c481d1f84a58fd2fbcfc</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
(&quot;ocfs2: fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()&qu=
ot;).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This patch addresses a shift-out-of-bounds error in the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
ocfs2_verify_volume() function. The bug can be triggered by an invalid</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
s_clustersize_bits value, which causes the expression</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; 1 &lt;&lt; le32_to_cpu(di-&gt;id2.i_super.s_clustersize_bits)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
to exceed the valid shift range of a 32-bit integer, leading to an</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
out-of-bounds shift reported by UBSAN.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Instead of performing the invalid shift while printing the error message,</=
div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
log the raw s_clustersize_bits value directly.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This backport was also tested by syzbot on Linux 5.15.201</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
(commit 3330a8d33e086f76608bb4e80a3dc569d04a8814 in the stable 5.15.y</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
tree), and the reproducer did not trigger any issue.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
[ Upstream commit 7f86b2942791012ac7b4c481d1f84a58fd2fbcfc ]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Link: https://lkml.kernel.org/r/ZsPvwQAXd5R/jNY+@hostname</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reported-by: syzbot &lt;syzbot+f3fff775402751ebb471@syzkaller.appspotmail.c=
om&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Closes: https://syzkaller.appspot.com/bug?extid=3Df3fff775402751ebb471</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Tested-by: syzbot &lt;syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com=
&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Joseph Qi &lt;joseph.qi@linux.alibaba.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Link: https://syzkaller.appspot.com/bug?extid=3Dc6104ecfe56e0fd6b616</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Tested-by: syzbot &lt;syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com=
&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Signed-off-by: Qasim Ijaz &lt;qasdev00@gmail.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Changjian Liu &lt;driz2t@qq.com&gt;</div>
</body>
</html>

--_000_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_--

--_004_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_
Content-Type: application/octet-stream; name="c6104ecfe56e0fd6b616.patch"
Content-Description: c6104ecfe56e0fd6b616.patch
Content-Disposition: attachment; filename="c6104ecfe56e0fd6b616.patch";
	size=2790; creation-date="Tue, 24 Mar 2026 06:59:46 GMT";
	modification-date="Tue, 24 Mar 2026 07:00:10 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhZTMxMDAwNmZjNmUwNmMyMzNiOGQ2NzgwYjJhMmM2YTE2ZDZkNzA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaGFuZ2ppYW4gTGl1IDxkcml6MnRAcXEuY29tPgpEYXRlOiBN
b24sIDIzIE1hciAyMDI2IDExOjM5OjE5ICswODAwClN1YmplY3Q6IFtQQVRDSCA1LjE1LnldIG9j
ZnMyOiBmaXggc2hpZnQtb3V0LW9mLWJvdW5kcyBVQlNBTiBidWcgaW4KIG9jZnMyX3ZlcmlmeV92
b2x1bWUoKQoKVGhpcyBwYXRjaCBpcyBhIGJhY2twb3J0IHRvIHN0YWJsZSA1LjE1Lnkgb2YgdXBz
dHJlYW0gY29tbWl0CjdmODZiMjk0Mjc5MTAxMmFjN2I0YzQ4MWQxZjg0YTU4ZmQyZmJjZmMKKCJv
Y2ZzMjogZml4IHNoaWZ0LW91dC1vZi1ib3VuZHMgVUJTQU4gYnVnIGluIG9jZnMyX3ZlcmlmeV92
b2x1bWUoKSIpLgoKVGhpcyBwYXRjaCBhZGRyZXNzZXMgYSBzaGlmdC1vdXQtb2YtYm91bmRzIGVy
cm9yIGluIHRoZQpvY2ZzMl92ZXJpZnlfdm9sdW1lKCkgZnVuY3Rpb24uIFRoZSBidWcgY2FuIGJl
IHRyaWdnZXJlZCBieSBhbiBpbnZhbGlkCnNfY2x1c3RlcnNpemVfYml0cyB2YWx1ZSwgd2hpY2gg
Y2F1c2VzIHRoZSBleHByZXNzaW9uCgogIDEgPDwgbGUzMl90b19jcHUoZGktPmlkMi5pX3N1cGVy
LnNfY2x1c3RlcnNpemVfYml0cykKCnRvIGV4Y2VlZCB0aGUgdmFsaWQgc2hpZnQgcmFuZ2Ugb2Yg
YSAzMi1iaXQgaW50ZWdlciwgbGVhZGluZyB0byBhbgpvdXQtb2YtYm91bmRzIHNoaWZ0IHJlcG9y
dGVkIGJ5IFVCU0FOLgoKSW5zdGVhZCBvZiBwZXJmb3JtaW5nIHRoZSBpbnZhbGlkIHNoaWZ0IHdo
aWxlIHByaW50aW5nIHRoZSBlcnJvciBtZXNzYWdlLApsb2cgdGhlIHJhdyBzX2NsdXN0ZXJzaXpl
X2JpdHMgdmFsdWUgZGlyZWN0bHkuCgpUaGlzIGJhY2twb3J0IHdhcyBhbHNvIHRlc3RlZCBieSBz
eXpib3Qgb24gTGludXggNS4xNS4yMDEKKGNvbW1pdCAzMzMwYThkMzNlMDg2Zjc2NjA4YmI0ZTgw
YTNkYzU2OWQwNGE4ODE0IGluIHRoZSBzdGFibGUgNS4xNS55CnRyZWUpLCBhbmQgdGhlIHJlcHJv
ZHVjZXIgZGlkIG5vdCB0cmlnZ2VyIGFueSBpc3N1ZS4KClsgVXBzdHJlYW0gY29tbWl0IDdmODZi
Mjk0Mjc5MTAxMmFjN2I0YzQ4MWQxZjg0YTU4ZmQyZmJjZmMgXQoKTGluazogaHR0cHM6Ly9sa21s
Lmtlcm5lbC5vcmcvci9ac1B2d1FBWGQ1Ui9qTlkrQGhvc3RuYW1lClJlcG9ydGVkLWJ5OiBzeXpi
b3QgPHN5emJvdCtmM2ZmZjc3NTQwMjc1MWViYjQ3MUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
PgpDbG9zZXM6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD1mM2ZmZjc3
NTQwMjc1MWViYjQ3MQpUZXN0ZWQtYnk6IHN5emJvdCA8c3l6Ym90K2YzZmZmNzc1NDAyNzUxZWJi
NDcxQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20+ClJldmlld2VkLWJ5OiBKb3NlcGggUWkgPGpv
c2VwaC5xaUBsaW51eC5hbGliYWJhLmNvbT4KTGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3Bv
dC5jb20vYnVnP2V4dGlkPWM2MTA0ZWNmZTU2ZTBmZDZiNjE2ClRlc3RlZC1ieTogc3l6Ym90IDxz
eXpib3QrYzYxMDRlY2ZlNTZlMGZkNmI2MTZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogUWFzaW0gSWpheiA8cWFzZGV2MDBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBDaGFuZ2ppYW4gTGl1IDxkcml6MnRAcXEuY29tPgotLS0KIGZzL29jZnMyL3N1cGVyLmMgfCA0
ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvb2NmczIvc3VwZXIuYyBiL2ZzL29jZnMyL3N1cGVyLmMKaW5kZXggYmIx
NzQwMDkyMDZlLi5hZTJiYTYxNjc1NmQgMTAwNjQ0Ci0tLSBhL2ZzL29jZnMyL3N1cGVyLmMKKysr
IGIvZnMvb2NmczIvc3VwZXIuYwpAQCAtMjM2OSw4ICsyMzY5LDggQEAgc3RhdGljIGludCBvY2Zz
Ml92ZXJpZnlfdm9sdW1lKHN0cnVjdCBvY2ZzMl9kaW5vZGUgKmRpLAogCQkJICAgICAodW5zaWdu
ZWQgbG9uZyBsb25nKWJoLT5iX2Jsb2NrbnIpOwogCQl9IGVsc2UgaWYgKGxlMzJfdG9fY3B1KGRp
LT5pZDIuaV9zdXBlci5zX2NsdXN0ZXJzaXplX2JpdHMpIDwgMTIgfHwKIAkJCSAgICBsZTMyX3Rv
X2NwdShkaS0+aWQyLmlfc3VwZXIuc19jbHVzdGVyc2l6ZV9iaXRzKSA+IDIwKSB7Ci0JCQltbG9n
KE1MX0VSUk9SLCAiYmFkIGNsdXN0ZXIgc2l6ZSBmb3VuZDogJXVcbiIsCi0JCQkgICAgIDEgPDwg
bGUzMl90b19jcHUoZGktPmlkMi5pX3N1cGVyLnNfY2x1c3RlcnNpemVfYml0cykpOworCQkJbWxv
ZyhNTF9FUlJPUiwgImJhZCBjbHVzdGVyIHNpemUgYml0IGZvdW5kOiAldVxuIiwKKwkJCSAgICAg
bGUzMl90b19jcHUoZGktPmlkMi5pX3N1cGVyLnNfY2x1c3RlcnNpemVfYml0cykpOwogCQl9IGVs
c2UgaWYgKCFsZTY0X3RvX2NwdShkaS0+aWQyLmlfc3VwZXIuc19yb290X2Jsa25vKSkgewogCQkJ
bWxvZyhNTF9FUlJPUiwgImJhZCByb290X2Jsa25vOiAwXG4iKTsKIAkJfSBlbHNlIGlmICghbGU2
NF90b19jcHUoZGktPmlkMi5pX3N1cGVyLnNfc3lzdGVtX2Rpcl9ibGtubykpIHsKLS0gCjIuNDMu
MAoK

--_004_SE3PR03MB9514009D6136760BB9CF9040A948ASE3PR03MB9514apcp_--


