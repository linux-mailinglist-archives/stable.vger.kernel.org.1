Return-Path: <stable+bounces-230842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME0XIC3CyGk7qQUAu9opvQ
	(envelope-from <stable+bounces-230842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:09:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6165350E11
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 08:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713D0301F1B9
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80627B347;
	Sun, 29 Mar 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PGiUGnN6"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3142494F0;
	Sun, 29 Mar 2026 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774764552; cv=none; b=AARnxjAVu/lToW0O79GoSqE2v2xO1WgIZtOxwZuFz6DFXcEPr9UIYdVxfvJ0Q/hc+Zf+vFMnODKkYxUidt7rHYznivnbUMa7Ba0XBYvZA04QliD9sI4LLUZfeG60aSl01vIJEAhY9v13vrtc43nXEnMmVRk16PAJZRBVz3HhiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774764552; c=relaxed/simple;
	bh=akt1j5RLgcI6S5n71SnrJlqgPQMbm3JiASV7nH6wEB0=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=eOS3vmvIvEglZWewmwDFTa1IBAAvpwi3edIRhg++2Cw6swTQeWwV6HSFaJ+UkyLyZ95EPLhYoF2+EVl6N7/FjkZ41mOyE2k/Nq7AQm6w9ONI/Zq4YdCh9L4Dsfm3FdnxCWpvS+iGGnb1YWAZg+CWkazDkdNMqqVen3SV7o32JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PGiUGnN6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774764545; bh=akt1j5RLgcI6S5n71SnrJlqgPQMbm3JiASV7nH6wEB0=;
	h=From:To:CC:Subject:Date;
	b=PGiUGnN6u3WWcDVzSvV8us0xoC3RPEMeuh7KUgy7nS4lrC1e7Z8ImAczWf+fHp5Zt
	 e4+KWVtwlaqLQjcrS+Rv/qN9IZkWcPO6/eEdhjbfIQHF1MiZpN2VTsLLf2uorC3dzC
	 Z4yNx858yQRjBS22G1ciU7Bp06ijYvW/lh1QEmEc=
Received: from SG2PR02MB5841.apcprd02.prod.outlook.com ([2603:1046:c01:910::5])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 2431A2BC; Sun, 29 Mar 2026 14:09:03 +0800
X-QQ-mid: xmsmtpt1774764543tx780ugc4
Message-ID: <tencent_20BE792225EC3654239D0B90001A911DE909@qq.com>
X-QQ-XMAILINFO: MfXlhb1xJpsO4OzEkdm/SKx2GC0hKL9YVhRh8Ud32LhMeGXvxwZYmLWboXwuFU
	 RFug0CAy7/kjG4nJjdbi2/GfkPS2ptmX+EYNOXU4krooZuv5wn9BIG7ErAj4P5kpYb355dLNnefr
	 023TP1dz4LiCMdqlfjLLMIQS0rqgtgsChqCMvrSoO3nNAWvRwfH5QJZ4pvPmWxxsdqkN050M0/V/
	 cwNQQTqVJI4opUN55eYClHprgw3ESqxHa8T+KNrjSNgqid+LCv/MXojs4KdxMa0yvly5H+ktymIL
	 CO7O6qVHBmSvp2f7X0YG1qw984iO44dqKqe2ErmlHy8RomwPjx8S/ypP0f18k2pMIpFcqs3Dt7yR
	 A4Jps3Luw76TshC7dUvqAx+NI5mxh9VOuRWazt5hojgdAZzgGnndMfBupZvzKRySMdsivbs9D1Cq
	 FnZiUxWw3l7Y7K/6/CNkCXNEvCnZ0A61/vJgA7qWzuc7Gb3APpzykD9vra56vYFOXt4e+cxW7++P
	 0fbLz6UMpIIqXteD3zmQmS/Z1imL+iLD1ZJmEFMoh4Xh7wAWxADfm/97CT04b4dl36kmbvlb7JBk
	 UHBrJQJybSAc4UcmKW1w4XKuXSg74QVIDFkzGe0mnPjAeC094eyEe4bN3HpeUSWn7UuoeF9jIhz3
	 tllWPqjwai2/YthqSENucvB5YkbNtUDOj+ZqC8Xd1mi/cF93xu+hmSoUjnq6iMWTbWU4ng76ksNS
	 bqUGYN+0Z3F60abAewvxvodYr8yNq2/o6gYyCUTvKUyDxk4m5DtAffBk42tRJjnZUN62k1Yqi0gD
	 O6m5IpDtVjLyXsle19WwPVdfpNZjYmWTArdKh9t1vuyAg4OzCFKng+dkmVIVZUiTb9eJhsl6rV3S
	 orw6l8SW3OeT5Bzg4hwYifvMxrehPxciWxKz8K4KtGv+GB33hNJtai0f59fU+eEUFb4+0Ej09UJG
	 e1iFw0JzXiDNxzMnIM4HfUDROnQHBtgSNmsAigUNMuhSWIFnvr1cO6ANem0P7UAQ80R8kzLEElsR
	 H+473D5n+x82ixq09IL04Zj9sIE5LEvo6i7eQo6yY/XXDubSKV+rNxoh6AxD8yC37VT9ylz/p8iq
	 CVW+i1
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: "driz2t@qq.com" <driz2t@qq.com>
To: stable <stable@vger.kernel.org>
CC: "syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com"
	<syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com>, joseph.qi
	<joseph.qi@linux.alibaba.com>, mark <mark@fasheh.com>, jlbec
	<jlbec@evilplan.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject:  [PATCH 6.6.y] kernel BUG in ocfs2_remove_extent
Thread-Topic:  [PATCH 6.6.y] kernel BUG in ocfs2_remove_extent
Thread-Index: AQHcv0E22BYwVZUP7U+He/0ovMIvoA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 29 Mar 2026 06:09:02 +0000
X-OQ-MSGID:
	<SG2PR02MB5841E2BB56938506FFBF0D33F255A@SG2PR02MB5841.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230842-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,1dd53396e7124586dca9];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6165350E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhpcyBpcyBhIGJhY2twb3J0IGZvciA2LjYueS4KClsgVXBzdHJlYW0gY29tbWl0IGUxYzcwNTA1
ZWU4MTU4YzExMDgzNDBkOWNkNjcxODJhZGU5M2FmNGEgXQoKb2NmczI6IGFkZCBleHRyYSBjb25z
aXN0ZW5jeSBjaGVja3MgZm9yIGNoYWluIGFsbG9jYXRvciBkaW5vZGVzCgpXaGVuIHZhbGlkYXRp
bmcgY2hhaW4gYWxsb2NhdG9yIGRpbm9kZSBpbiAnb2NmczJfdmFsaWRhdGVfaW5vZGVfYmxvY2so
KScsCmFkZCBhbiBleHRyYSBjaGVja3Mgd2hldGhlciBhKSB0aGUgbWF4aW11bSBhbW91bnQgb2Yg
Y2hhaW4gcmVjb3JkcyBpbgonc3RydWN0IG9jZnMyX2NoYWluX2xpc3QnIG1hdGNoZXMgdGhlIHZh
bHVlIGNhbGN1bGF0ZWQgYmFzZWQgb24gdGhlCmZpbGVzeXN0ZW0gYmxvY2sgc2l6ZSwgYW5kIGIp
IHRoZSBuZXh0IGZyZWUgc2xvdCBpbmRleCBpcyB3aXRoaW4gdGhlIHZhbGlkCnJhbmdlLgoKTGlu
azogaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI1MTAzMDE1MzAwMy4xOTM0NTg1LTEtZG1h
bnRpcG92QHlhbmRleC5ydQpTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgQW50aXBvdiA8ZG1hbnRpcG92
QHlhbmRleC5ydT4KUmVwb3J0ZWQtYnk6IHN5emJvdCs3NzAyNjU2NDUzMGRiYzI5Yjg1NEBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPTc3MDI2NTY0NTMwZGJjMjliODU0ClJlcG9ydGVkLWJ5OiBzeXpib3QrNTA1
NDQ3M2EzMWY3OGY3MzU0MTZAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBz
Oi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD01MDU0NDczYTMxZjc4ZjczNTQxNgpT
dWdnZXN0ZWQtYnk6IEpvc2VwaCBRaSA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPgpSZXZp
ZXdlZC1ieTogSm9zZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+ClRlc3RlZC1i
eTogc3l6Ym90KzFkZDUzMzk2ZTcxMjQ1ODZkY2E5QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20K
U2lnbmVkLW9mZi1ieTogQ2hhbmdqaWFuIExpdSA8ZHJpejJ0QHFxLmNvbT4KLS0tCsKgZnMvb2Nm
czIvaW5vZGUuYyB8IDE3ICsrKysrKysrKysrKysrKysrCsKgMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9vY2ZzMi9pbm9kZS5jIGIvZnMvb2NmczIvaW5v
ZGUuYwppbmRleCBjNTYxYThhNjQ5M2UuLjdjOTlmNDM2MDM3YiAxMDA2NDQKLS0tIGEvZnMvb2Nm
czIvaW5vZGUuYworKysgYi9mcy9vY2ZzMi9pbm9kZS5jCkBAIC0xNDE5LDYgKzE0MTksMjMgQEAg
aW50IG9jZnMyX3ZhbGlkYXRlX2lub2RlX2Jsb2NrKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCsKg
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZ290byBiYWlsOwrCoOKAguKAguKAguKA
guKAgn0KwqAKK+KAguKAguKAguKAguKAgmlmIChsZTMyX3RvX2NwdShkaS0+aV9mbGFncykgJiBP
Q0ZTMl9DSEFJTl9GTCkgewor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCc3RydWN0
IG9jZnMyX2NoYWluX2xpc3QgKmNsID0gJmRpLT5pZDIuaV9jaGFpbjsKKwor4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCaWYgKGxlMTZfdG9fY3B1KGNsLT5jbF9jb3VudCkgIT0gb2Nm
czJfY2hhaW5fcmVjc19wZXJfaW5vZGUoc2IpKSB7CivigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigIJyYyA9IG9jZnMyX2Vycm9yKHNiLCAiSW52YWxpZCBk
aW5vZGUgJWxsdTogY2hhaW4gbGlzdCBjb3VudCAldVxuIiwKK+KAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAgiAodW5zaWduZWQgbG9uZyBsb25nKWJoLT5iX2Jsb2NrbnIsCivigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigIIgbGUxNl90b19jcHUoY2wtPmNsX2NvdW50KSk7CivigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigIJnb3RvIGJhaWw7Civi
gILigILigILigILigILigILigILigILigILigILigIJ9CivigILigILigILigILigILigILigILi
gILigILigILigIJpZiAobGUxNl90b19jcHUoY2wtPmNsX25leHRfZnJlZV9yZWMpID4gbGUxNl90
b19jcHUoY2wtPmNsX2NvdW50KSkgewor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCCcmMgPSBvY2ZzMl9lcnJvcihzYiwgIkludmFsaWQgZGlub2RlICVs
bHU6IGNoYWluIGxpc3QgaW5kZXggJXVcbiIsCivigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gIIgKHVuc2lnbmVkIGxvbmcgbG9uZyliaC0+Yl9ibG9ja25yLAor4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCIGxlMTZfdG9fY3B1KGNsLT5jbF9uZXh0X2ZyZWVfcmVjKSk7CivigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigILigIJnb3RvIGJhaWw7Civi
gILigILigILigILigILigILigILigILigILigILigIJ9CivigILigILigILigILigIJ9CisKwqDi
gILigILigILigILigIJyYyA9IDA7CsKgCsKgYmFpbDoKLS0KMi40My4wCg==


