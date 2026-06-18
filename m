Return-Path: <stable+bounces-266983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yrDPFnBpM2pqAgYAu9opvQ
	(envelope-from <stable+bounces-266983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:43:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C408769D5B7
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 05:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Xar4hgfl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266983-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266983-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D91B0302E7C0
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 03:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC930F80C;
	Thu, 18 Jun 2026 03:43:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BAD14884C
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754219; cv=none; b=aJWpyAthbcitFE3oZsAHgIO8DnwKFKWAGn2aL9yeKlF2diIPLIppsqpHOsS+iVvpRwEqNSVwLdXY6jm5ep9Mz+akZ9Tobpxq8J/LTRCgdp0XZ2cZgaB2GabP+4jAYkXmTdI/LpGKATfsfE3QnKqX7CdRAsyfgzlrETmOtctnQng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754219; c=relaxed/simple;
	bh=M/SY2oHM6heqUzd5oIg6bRcDLp15Xu/sq8tRBYhnyuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o33H+WCAkk6IF4W9bx6Y2TwTfvkPLIbgCghaFJ5/pMc1hf67oaQgqekIk7PGlrxxEcwCz524Z2/ruD2LQNygYLFBprqwSKmqtueprgcockgaQzMDTQupODm7cUxnYrbZUawQ/2jiBGkYOmvl503RVcn9WNfqAoVIBEseEhJI7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Xar4hgfl; arc=none smtp.client-ip=54.243.244.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754195;
	bh=aKRH9vsLdSP6xszzoF1c3cSPDafELHO/23Y48eGZWAk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Xar4hgflGnDLP7Yi5sLh1G0XxU9AJDPSoxMlTwJMQsFKBbgRNBQSxBWRRp1N4mw3A
	 E6QPqK2lAyOl6BvbXk40Dwwf2EW/Qd6fYAdPq+b43pz0BfDUFeyi/m5aELMlM2MwSt
	 QlALQj6OYuJVwTa1xWJCCX3gdw0us6GiWhl3PBl0=
X-QQ-mid: esmtpsz16t1781754176t2cb8eb53
X-QQ-Originating-IP: ryqksIF/MZ9pwBPnAEH3OlDBJglMXN+2/sunf8kgwJU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:42:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5472547804747186854
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
Subject: [PATCH 6.1.y 1/3] net/sched: act_pedit: check static offsets a priori
Date: Thu, 18 Jun 2026 11:42:48 +0800
Message-Id: <20260618034250.1525454-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618034034.1525175-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NcdhUYIpzyYIAib7Z5TtV6S1PTChVUe0V5KCIykPFoZYHYdzqM/DgMR8
	x3jmn8/peMYFPPg2uUshn5c3JEYLZUrhjUssUDxLkp5X+D43OABOFGrYgpY4F1TgNdMon6g
	b1flRxNMelqTKpMNqlitdfqM3Wsv9464PAx8q4k9lvV+XcsBFj5AwwhXkkY/2ZKJDH+TAGt
	XBo6A1ZyE26s8Jv27SX5zwI/dPewnQjOZbLmQC07pr27PLzxD8/tYN3TGiY1pa6KN4yE6lA
	b18lKp6/uhyHK7T6u4lpJaNMjBsgXxkp2958V8Dr3BAuGSZjOHA9Vm0wB5SduXHNVRxuuPD
	Sm7p1bM71UfI6IAxq19IYB71GNssE8yaZH9LP87GBZ9VmPC5mI+RwqLfmP38tmsXrnlPdC/
	X4qf7Sgfr9lGS87o4CIWzWGWlM1g5kteppBJhhOYE58pipwdk5tTzr5cdf5y8TQyJsqqT4k
	JtSQIgJdW/TVbR+RY8uWwCa72hxHvqehodYUVAoiwrInQE+okhc7JrYk6Z40tTi++k8ZIVf
	SvYS35d8tAgykZWe2fgoyKEc+4NJ5XDyzTtJPO2TjWpbZzpOSdqLoHOx0NwYxFFLz9ACzSd
	s4ryHlDdcjSCKWFxNijCJi+svkuO9Mw1LdOvOCc8RX8Il5Dl2W2L7lNEUxAojTqgMQ4uuM3
	R6di/EThAmbq6lwYhrR459+ttrshAwk8CgGuybYbDtHuPc0M682ZiI4q4Jkzk3eETK0WVGi
	QKEEKJ3NHRdS1sqHCU9Xw+5rcZwYq0NoXR4UdR9wiPDWef8+/PaUHxJvQis0MJx65S7fmjS
	m3XQvk6mihIgu5RMdtOSFKI70YMM8CK32nL6Zxi1d0sU6pjmfYfX8Z2BQOys9fDT7oB94nI
	R8vwFTsILUatEFZRsuhObQswEdxFv1hxgwHw1d1KP+5fL9jMV6OZia/nz3EfBWZYLZFDbIY
	3CjsHwdWMsYm3fpvwMaVMLu+j7DsOS2tpyeh9wt+MTxEKswOYisyKxBJG98poYNqutDTlHk
	Bdw2NUynHDPhSl3bVtlFcEHKvf/x4esMAvcQIEF1zPMxCJWXjYuDfqTTne6MBIqYKl5ji5/
	cV4uLEP9mnP
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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
	TAGGED_FROM(0.00)[bounces-266983-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,corigine.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C408769D5B7

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit e1201bc781c28766720e78a5e099ffa568be4d74 ]

Static key offsets should always be on 32 bit boundaries. Validate them on
create/update time for static offsets and move the datapath validation
for runtime offsets only.

iproute2 already errors out if a given offset and data size cannot be
packed to a 32 bit boundary. This change will make sure users which
create/update pedit instances directly via netlink also error out,
instead of finding out when packets are traversing.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e1201bc781c28766720e78a5e099ffa568be4d74)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index aee2e13f1db62..2bdc44efee779 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -250,8 +250,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	memcpy(nparms->tcfp_keys, parm->keys, ksize);
 
 	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
+		u32 offmask = nparms->tcfp_keys[i].offmask;
 		u32 cur = nparms->tcfp_keys[i].off;
 
+		/* The AT option can be added to static offsets in the datapath */
+		if (!offmask && cur % 4) {
+			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
+			ret = -EINVAL;
+			goto put_chain;
+		}
+
 		/* sanitize the shift value for any later use */
 		nparms->tcfp_keys[i].shift = min_t(size_t,
 						   BITS_PER_TYPE(int) - 1,
@@ -260,7 +268,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		/* The AT option can read a single byte, we can bound the actual
 		 * value with uchar max.
 		 */
-		cur += (0xff & nparms->tcfp_keys[i].offmask) >> nparms->tcfp_keys[i].shift;
+		cur += (0xff & offmask) >> nparms->tcfp_keys[i].shift;
 
 		/* Each key touches 4 bytes starting from the computed offset */
 		nparms->tcfp_off_max_hint =
@@ -429,12 +437,12 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 					       sizeof(_d), &_d);
 			if (!d)
 				goto bad;
-			offset += (*d & tkey->offmask) >> tkey->shift;
-		}
 
-		if (offset % 4) {
-			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-			goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+			if (offset % 4) {
+				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+				goto bad;
+			}
 		}
 
 		if (!offset_valid(skb, hoffset + offset)) {
-- 
2.30.2


