Return-Path: <stable+bounces-266987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uCJ2L2NsM2rlAwYAu9opvQ
	(envelope-from <stable+bounces-266987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:56:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36769D688
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:56:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="Fd4/AI18";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266987-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266987-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B4E7303FFFD
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 03:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611735202E;
	Thu, 18 Jun 2026 03:55:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC88361DA9
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:55:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754946; cv=none; b=AaTvDDSGmp0ppANePHGdy6gxvodUlD8p/aSpNKQ1ka5bclMxMQwa2NG6A2ht2MvZmthlBKxr+vCw3bf3TJTqIHBrV+Y6DtoQ70oEI3hbpRHFDMoBGWheQ1l2+/AU9guqCCbVt00lIuIuRkTPVwJtZKhpi1ySil6S7ejal9TeSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754946; c=relaxed/simple;
	bh=9XvQgKKW14e6ISnVyxmPqygAIaTJ25qIsNsBi/IhJlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uugCabsTCR/t4vRkE/FJQ7APeJTAshqDvHJkKnKlkiWd8tOuUrhLZmVKT9sIb1V4C9z5633cmfXEkRPfc8AnhhGwo84Tp3khi2q6SFik08crQnSJrfPnNZXPa8/NEhteohZs98czkHWq9xZ369o0BIzHSClZft+Jyyrj6eD882o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Fd4/AI18; arc=none smtp.client-ip=54.254.200.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754925;
	bh=3ix6uBCBvW31K5bhik12w2N7rNXat6Ewvad3mCbBjIo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Fd4/AI18KU1POA3DZQU7s74msjp+oZJTkyqz315FKDF39uHymVTR+7afjajGWjgZp
	 vG1kG+VoKEUho/UkZwVzUBiXVpnTIi88ttBcYGLPaqxtD4zKaANP0GEAC3DBAVwPG2
	 K3iZCTcsWilUoccjiP9WEaS5zXzZRPQXrrIe98Qs=
X-QQ-mid: esmtpsz20t1781754919t5bc77483
X-QQ-Originating-IP: kyCaQjQiI87qKrtp0NkBJSyLBBubrdg8nF2olaLT2pg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:55:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9903793249695214928
EX-QQ-RecipientCnt: 14
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.15.y 0/4] net/sched: fix pedit partial COW leading to page cache corruption
Date: Thu, 18 Jun 2026 11:55:01 +0800
Message-Id: <20260618035504.1536870-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MD4sJBF2yUQ8bW9S19DHonlVDcWvh/a44Yqj2Wfap1Ik8nkiNR1pMVWr
	Z/SJIu+sDVdgx8Qz89ZKmd8wbA+/sMQE9qmheUY3VMk3CR5TTuTd7Ani1aLXBaqHw77nqq2
	tgPjJCtmeFPClLMyomTp90Lz71dXdgSpFzukFf8MpdiVniobifGgQnknn0v0WQyO2fiYzbl
	Q4M2f7SFOSJy5L4wJOXTlOhKOoWsU28/8dOjRRyYCF+zjBaF0h/G1Xmc9JCjRjSoDJR8ueJ
	XrzxiEqj68p6JAFmpfYDoJDmBcsK4FoFitawvj+kUW/YrLa7kMqTwkkJqGhD4O9gxByZTgm
	CumtTBL0vP+j/3t+g/tb5j5u0zqepBrk6wiL8iqiI7SJ/po3lLxOB420YUVkhBnqRbOJHu+
	bGPJAJaSoLqpRZBu9hcghois9Mc2aAPmNvXluVbiB3dCreqqKnNzhMmbHoF5qGOngxx6j5G
	1VXcbrDZJG3Y1zkB7NoeRS1YHjLTbl8koA7QNGW8WsWtixuSvzx9/9qNTUOhxrQmm8dB5he
	y7rMv27snONDvnDuxFKLBLbxgVLmneEddSBY13x+Xh9TXQzIGxbM8seyI3eukhNiLu+SS+N
	ie+ToGDBQyKeKgKUGw0dEqRkTcL0gT2LslOHPHj/TKXR38ae0+h+3iRdW26r4DnscjiWm7q
	p8Cn8dhRtP+XGeaiwlUIV7o0LjDPZ3uex3mpZ09XIHaC64ALQp3pbODTWL98MrH2os8gt7J
	4kcHdHTnFaXI4C4qAdS0MKzfHTOvO/H/ZdUWZGKm4X61HJY4/6N8qLwarIpkXDE0FWiVRop
	yCoVLWlZrfU6L7BBApPb0ZyJZ/ZrPFrvjkXvKetcJfiN6Eg30jaey3m0ebW+yHdWPV4rqBx
	YBSWTeHmZTrLneCurvjK20F0g5HzIqQbFo2jDyWJxi8KGQwyshodGfbAAAd2/GX+f6htqiW
	+aP9jy+5LSQBYNyOAhCBtTNBU33mrVjhGED5aCEApX/oPkuTNt84OjriMxdP+aqx1k+Ul1A
	OAcBbVt9TMpaBlGbKQttTMv82Ai07VIjF7qT7HMTZfWzVR+bR5x3pU4tdr8/ecFPTNhtMlR
	yZTlqlxMSI8SuezNWLfoj5CWHtsVJgCWTCEWUs4eb+yG7zpUEorLQHUxMAup+VlRzeO+dw7
	jKzKro+kG5wCq8CY6uWQ1rPDYA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266987-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F36769D688

Fixes CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache corruption

Link: https://lore.kernel.org/all/2026061625-CVE-2026-46331-47be@gregkh/

Pedro Tammela (3):
  net/sched: act_pedit: check static offsets a priori
  net/sched: act_pedit: rate limit datapath messages
  net/sched: act_pedit: free pedit keys on bail from offset check

Rajat Gupta (1):
  net/sched: fix pedit partial COW leading to page cache corruption

 include/net/tc_act/tc_pedit.h |   1 -
 net/sched/act_pedit.c         | 101 +++++++++++++++++++---------------
 2 files changed, 57 insertions(+), 45 deletions(-)

-- 
2.30.2


