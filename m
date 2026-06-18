Return-Path: <stable+bounces-266997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4xO2H+91M2q1CAYAu9opvQ
	(envelope-from <stable+bounces-266997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 06:37:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B569D826
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 06:37:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="cq/2uyEh";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266997-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266997-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 245B530073EC
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 04:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994DE3101BC;
	Thu, 18 Jun 2026 04:37:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E42F7F06
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757421; cv=none; b=FKxUSNGu/TZzUYXjIVsYJzjvcAxWgL0w9Y5mFf2ieIy/QcY8IlI8x5aD6LvALadVKBYh3oqCKOBEU7xp20ejTFcNEMoz7s2IDplwp7Exg5Nj6SQ5H44ON88WqITDv9o8YJpYpN6gLWZdPs87ab2pqUA76BHTL3QcV/GC5FCzGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757421; c=relaxed/simple;
	bh=j5g8dVqaqSuKvgOqTrairofKT4IZZIehRk9DU36v1tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRuW+E43XpphFMSGpzLP1+rsoDeFOxXxK+ECPD5SwnfR5HoR90gAx86xZ2lvK8GUNv7H1TDzd5J78aVeIcJlqQ76xIg9l731XqB9A7I4ICh6B6cgqHqtZT29ja6QoEOLeeFWKmR8y1+IJSVvb7R7ITs+G3Q4SwsK+Zr8N/SELeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cq/2uyEh; arc=none smtp.client-ip=54.243.244.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757404;
	bh=1iM04kA9xD/Tp1X10hfbsdrdGEUX/5GE15+rSZ2vGlQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cq/2uyEhuMyjnSXf6Rznio5NoLTseCkjnsQbm/vx4wFJmrn9WDzap/ybJiYmgX1lr
	 12euIdCzZSt0HZn+4B6eWmNtJYEtlpF7GtkOhwRBUGqiQv8olWljt+FMiFqalV16KN
	 3TsMaNHUamVUWQJeTXiewxPPPK/1IVTx1kPPGIag=
X-QQ-mid: zesmtpsz6t1781757385t78b70c22
X-QQ-Originating-IP: C4vrKU27GualLdts/rJ3qUpAZUlYqpfAI/S4QjiS+WQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10969982639606645568
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
Subject: [PATCH 5.10.y 6/8] net/sched: act_pedit: rate limit datapath messages
Date: Thu, 18 Jun 2026 12:35:38 +0800
Message-Id: <20260618043539.1557035-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618043539.1557035-1-guanwentao@uniontech.com>
References: <20260618043539.1557035-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: Nyju35pICpZdKliuhzEfRHKmELJAbfM3JH6C+I6vYnb1ZDLXKCTy+0Xv
	D4yPq5E/1qejQ8DU5sSuWYk5u4z9jbIFmndy+vz5xUM/0M5hlHhsbgOBT4QPW4MYQifCJ2v
	8NpjiNfIAMDie3lP0xu8kKMv2PpYLbxo/xY+jmGceyDyi7pGImltXF36ZgPeOefFJB2vshv
	DLhWZSOrAiNk9/z/Z3cbfYpYDeqPY7DbEY4Nmlyko6r9bh89CkV5GWYwBIBKlLiX8MS4ab4
	sW1dQsP9IL1alh1tdDZ4VQQ5uwxpIER3DQoFBbiE3b1Qse0K4sO4FAquvm6bbsQcQ+GwetH
	aLzT99oZkKuuKBZIgPq5SuXItIs7X/90arid250FTgdLVfZvODywwWxKJPGRQSLCK/rN0Tb
	O/enHAejGusNaDXM4iIhG8/DYEvN6FEAEJAEah/ZLPKtnBJ+elx+hZq9QK3pR/lMldjAFn3
	MoTHzvzCblcOSRpVzO3nELyTbXNIqSZ/0xpayx0ZKVzLdPDHztFM0E9gyhn7XU6++Kxikxh
	vQA3EOWHRmmOy1yq67EcOERcNfEQEWcoNJ5yRpL/WSoxQv3fabnYTjuZSNfSgYCyWSur87U
	H6WmN1H8CKgVpNs2cu1vWgsaCdULfDuQLK/imTwBnIHmBz2C+NFCDsvgM7pQ5Z3glhBB4O1
	dtqTGjjoTRtvnbYbOEQw9EzRt7rQoOgdsvikP97SyaPQ8iB3a4qMjn3Hgh/+kjGJC76Cg5I
	0lzy/E8H0glm0Wg6ctMiWDTlp4Ay8sHMJDG2PnNYt+FlEWB0TLjfc+hleqPxdyicdFP1UPu
	IExXsLk1tjWTkeYLEisR1qQ4dkZpyNqa/7rKALYbn9Y8lQ/I97On7ydWas7RmxbFSLf+hY4
	5WoJ5z7SvZ2f3xdRjgYYTyKig4Zgumv5RKQfVm9rhVowtxf0kzc1/fzhKjuR4g2ljMKeYXf
	mo+noYAhh2hvj1kE+0tLqU+O/jf8H5CX1U4XSRxweGcCPcpF0z8swisjw2Ohp3nkjeAm82r
	aYU7Yr58ylpCuXM+nQiUz++CevfCBGTr76y/lNaexs9ZgGq+ZxuUbitJjsbMt2lDUEY55RY
	0iwPzLSVC+P0CeRA8dLW1AzwGOZ3HsaJL+InCKT5oECkKOLshxPfg5b4/wdCIDIHRoUj7Qd
	Sr/MgJyt1fhMwVAmDGfHAxdO9AKSpPdT4fRDiH+N2WAZKb61jI3UzZAW5l5tzK/31w/1
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266997-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,davemloft.net:email,corigine.com:email,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 179B569D826

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
index 95ae885ecba16..ecad6fc39dc3d 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -383,8 +383,8 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			u8 *d, _d;
 
 			if (!offset_valid(skb, hoffset + tkey->at)) {
-				pr_info("tc action pedit 'at' offset %d out of bounds\n",
-					hoffset + tkey->at);
+				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
+						    hoffset + tkey->at);
 				goto bad;
 			}
 			d = skb_header_pointer(skb, hoffset + tkey->at,
@@ -394,14 +394,13 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
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
 
@@ -418,8 +417,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
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


