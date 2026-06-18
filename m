Return-Path: <stable+bounces-266989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wlYvHYFsM2r4AwYAu9opvQ
	(envelope-from <stable+bounces-266989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:56:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E83F469D690
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="g/Q/x5WH";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266989-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266989-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E9F3030E84
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 03:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978CB360EFF;
	Thu, 18 Jun 2026 03:56:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3730C16E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:56:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755005; cv=none; b=njWcXCQ4tLWUZmFSO3QZ4M4jhgKQHgltvc+MEEUrJ/dvHkBcbbLP6+2r2BKd1XYgb0OhT2D77rTkpjvBxGhy6maUMxgYCqWVv2oRxBHgMm9wMbd9J1QhawCB5dh8eGiigIxxCb6aAqlZJc8Yn1FLETwCpimJr5QKR9n0aYAupB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755005; c=relaxed/simple;
	bh=e8+E8L7A3ye5GnI1GQ3o1uHJKBfkeYBJSxt2qCQjeho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esyZ6lVNGNkclLpbsPJQNC6ui6fpOh8FGz2AUMpojtGVVaMk/dMhPW7iSYkpV/WetBMlvDuuE+wm2xMcFDeHe+4wi4CKznJ9OlitP3wDltDfuZvoVZwOd8WSxbT3jDjbndQO8+mSSeqcmdShVNGd42AU1Rma+BWzb3ToG3m2/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=g/Q/x5WH; arc=none smtp.client-ip=54.204.34.130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754974;
	bh=ywSDlu4cIxWLMxy+sZeBOargpt6iEXDwjueNhO7EyiU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=g/Q/x5WH6rHM1nnnZvynJfCbv37+IDSZLY/y0Lm4/huia4Hv70JSsdtabKGEF+qXZ
	 KYzYAJTJSPA4Rq2nLtp6scOLTfihHIr7Hc+b2xSlNmMZESjTvEDzH7gzp4ymUkqoIp
	 v9Vox2WDv91kL7ofrzGHUm0HIB5Tc2/qgjzNhzsc=
X-QQ-mid: esmtpsz20t1781754955t5e10e1e3
X-QQ-Originating-IP: SyZd5S3XV5z/GF1cCDZrEwKP8HSYWIVBitgnDfQPUt4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:55:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4286009773290780161
EX-QQ-RecipientCnt: 17
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
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y 2/4] net/sched: act_pedit: rate limit datapath messages
Date: Thu, 18 Jun 2026 11:55:06 +0800
Message-Id: <20260618035504.1536870-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NjyC0gRqZaLJ9b1X2sg0lLLabPYxVS34MLEJALxLbWDvPr9Fr2EF+E9o
	mEq3CM7bT+mrU6XcPScnaZ8Stm0BM4G5rVjVXTNw/zUqTtRL9AHPY8h94o+0vt9LdP3Qlm4
	RtwN7ffNohlIHPf7vb2wngeBFcgU9kgj1oxtC5Bxcvr1gRrEKgdcc2eF5u8NM4RJp4tAEiB
	K+fmGJswmnItk8bph/wh3510vzoZNqU65yaHtV6v8Y7cjoZ4E7mk8DAGW+/Hn28ybWaAniZ
	CBxC7eO4/Mv6hhJZAaQUj2FB04E3/O+5Ple+MQmqBfxfsVpy1l89CO5kbGhmE8VyL1RtLrI
	XzKlKEsJLiZF7/YWN2iN/ZutKwKY+GBsFpl0nnGUcxN/+fVPpsvGrWt7SQVlf/KNXp1pBYG
	sAO6T4/tpj3HmU4xp8mYXql0xcaG5OtZXTh6ESIqv3M0Mln0QJE+In2wQaloN9mMhLTsoNB
	mJnxbRNdlqwbar1uu8HGBiAbBKLZrwh375sFWehDRMR0i37D8FFtdElSiqe7hqpVOmS3glA
	N53KGAry51yuwIG+xvodjiJm5uBVUypknLf8JD+mrd2TkkXu7Ml9KyZRGlvVpiDEkWgHXJr
	3GkR7I/b/j9VfLVpk3m9IqkXRzgpdAJsfpCkSJYXgfIJJvucYvSFkLFHJT0j5Ys7Dl92TDc
	OzH/1PlBrMdBvstUuBFy2QeYGpVPs1hdSBLLGdNje1P6SJDhTS7sZqSUcyHcKmpQwj2K9GJ
	z5kMB3z9zZAaXgKymWPDs6reROuJ/cHubIhchzSLOTwFG75WJ5DW1iOKZDG6qGLrA1S9FZC
	FBy7TmjyirGeiiweyemiLPuVmv45qDfOss5lQk4X7ObC5AUvHJs+IkhFuBPRJ8HVNKv3rFt
	KXqS3XYLw2p2IohUkEE9WDDMFSmVmVdQfksyGk/MXOMuC8iAkJWkR16MMSxCZK50307PQL5
	uwjzk4SGcXc4FHj0NTpV74T6VOUmAPFXOFl/nD+rKH73b4FJo55/kWKsYDe32gUdY+Htz+A
	2DP/Pkc1+8fXpxtfmNoab/eSLpZ/SMTKWRdUDK4yophG+mhOU8ofdDy3hv8OklRMaQq0FNL
	WXayOMm8i4HAcucgmhe2Y7ZuD7YUIfK9cMjIVSu13evbIKYLmbV5xLbAr40L8hm9ipy2Jfn
	5Az+iNBQSD+cmL0gZunjTNbQOtq8bPEa6p20
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:stable@vger.kernel.org,m:2045gemini@gmail.com,m:dcaratti@redhat.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,m:pctammela@mojatatu.com,m:simon.horman@corigine.com,m:davem@davemloft.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,mojatatu.com,kernel.org,oss.qualcomm.com,corigine.com,davemloft.net];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[corigine.com:email,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,mojatatu.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E83F469D690

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a ]

Unbounded info messages in the pedit datapath can flood the printk
ring buffer quite easily depending on the action created.
As these messages are informational, usually printing some, not all,
is enough to bring attention to the real issue.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e3c9673e2f6e1b3aa4bb87c570336e10f364c28a)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 8679e87d774d3..46436b7641c14 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -429,8 +429,8 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			u8 *d, _d;
 
 			if (!offset_valid(skb, hoffset + tkey->at)) {
-				pr_info("tc action pedit 'at' offset %d out of bounds\n",
-					hoffset + tkey->at);
+				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
+						    hoffset + tkey->at);
 				goto bad;
 			}
 			d = skb_header_pointer(skb, hoffset + tkey->at,
@@ -440,14 +440,13 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 			offset += (*d & tkey->offmask) >> tkey->shift;
 			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				pr_info_ratelimited("tc action pedit offset must be on 32 bit boundaries\n");
 				goto bad;
 			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-			pr_info("tc action pedit offset %d out of bounds\n",
-				hoffset + offset);
+			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoffset + offset);
 			goto bad;
 		}
 
@@ -464,8 +463,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			val = (*ptr + tkey->val) & ~tkey->mask;
 			break;
 		default:
-			pr_info("tc action pedit bad command (%d)\n",
-				cmd);
+			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
 			goto bad;
 		}
 
-- 
2.30.2


