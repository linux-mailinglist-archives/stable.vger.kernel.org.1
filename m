Return-Path: <stable+bounces-269279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RA7jF0DAPmqwLAkAu9opvQ
	(envelope-from <stable+bounces-269279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:09:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7D6CFA13
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="mYIlP/cv";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269279-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269279-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 417A930151EC
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6903AEB2C;
	Fri, 26 Jun 2026 18:08:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96228279DB6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:08:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497338; cv=none; b=t84ttT1bPTS+AW2jUWUyhVQeOXfWvbJvQoN5zhNRmCL7FyB5vpWV9BSIxBm7WLHK+46H0ftFSrIQOx1XGRAFM/wsKneydSeELf9+My1502CNCHBhhqPTDjw/Yk+H4TrDOwq91CLI582ocpDKZIdPNfVL2URjkv6Uy4Ob2s/uWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497338; c=relaxed/simple;
	bh=O/QYmmGM1Y8xuVRFrimdKn1X2zOedWIbB+b6DMfTK8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szV/DziJudhbfROhH/gMBmzVMxDj8zjg9iZSELv3S9g6q/hnW/QpyVUkhetHt0KdnDfXqj/kvuSr3jR6EHRPnWbL+GfIkUGhXqq5HwR4qJ+WsEXXGwRW7bGLRsdk7OJsqWvnkj1OpLu//kwxqIKf6Oed1kgPV6+gpA1iXKt9I6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mYIlP/cv; arc=none smtp.client-ip=54.254.200.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497313;
	bh=5DxKKwjTeK/x72VejuOqwFnLkIznmy4QERL6IPhU3JM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mYIlP/cvERRCGY+UUO3BMMIorDCD7CijwzSrTsKot0TPN/a/7xiV4eBhE0hBKU3nf
	 60OpvJoEdUSqjQW4D1+F2aUDP1DGMZ31MGeySJMmIIWBv5bJzA4lGAWH4+ZM9QnYFs
	 FlxaEH1apOpqQrczlRYr5fDTcsod8ZgoiKS4+AVY=
X-QQ-mid: zesmtpgz6t1782497294t4247b38d
X-QQ-Originating-IP: FVDvQ8/qOJ1t4IzHuYbz+jTIfJZ2fUtaQxmYYopKL58=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8997781484810931890
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com
Subject: [PATCH 5.10.y v3 06/10] net/sched: act_pedit: rate limit datapath messages
Date: Sat, 27 Jun 2026 02:07:31 +0800
Message-Id: <20260626180735.297017-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ML0YOxEYw9yWVQGqOZmImoy5ENCnzbgqZ17aWEWhS+ceB2K7EAfMHx2u
	WnH8f3l1GuicP7g2jBi8Nlq3wix7fVI/JsXzSoKHB3f4rktUjCTz7eGjEXJ5A+Tn7e3g97T
	vN7oCANnG80xKxtujrccnVC/BJtnkxRTuuhBHcy92nG6DgRyrpZ48GOG1NtjZPJnxDJe3d2
	cCkis5mc+1PAjer0rLDUwKWyfShPXr+TYmW0o3zR9Q1qQ2YkBqcVoKtTElb+VyVfX8pQoX8
	kiAq5dCWse1r9/e7pHiY75w207G5LTRkselgDydGQPCB7QCqpjqLHTxf4/CltEHrt9hMcrY
	T9jVNxgC6zznzcfdCl+4/BW38eB0lXXPrj16/OPmnx6VIi4SrHcFZilxjvJ1VT+k2ehwCDN
	r29UgFF5BNJ7iP8kAcPX255UqJ75DN7iMNq+y6OWoJBMLh4FAg7sojRhzyxhuZEeTrviC7b
	iVOBlbY/uOZUdpU5FCDFd0I3rM9vHoXI9opQ3hCnIl6N1oATSn5DPW5Iwr5q3E4BaSuIzyx
	4MHD9enyTxxcVboBnN7B3uSpHgfG23Duf40GeFq8d2+nTWk8+FbeU/QZuv545wmQ5/MdL5F
	M5UCSGZ/KNbRobvPk4uIyKZXcwQuuGjUazriIDY8Ip7fXpoOubc0HF3lRmMABfrU0EBvdEb
	d2VpHIHNKKWltLJNg4vgi8nyo2HVGStdrfKy9Wbf0yH/Jn+5IVR0NnMiibpgmLiNzCQ1A/F
	x2ci1cUWfXOU47syHd6qUcl4YXV4tEg5WG+89CcLyTopgMRig74OCt0S2jpbyHz20qjiULA
	d8xjOnPbh0G3Kw793DASpo2KpfjxybzW5ZWfhVbRIAcRsBooF5uPTswkfbgGLEJxJ4EhA5G
	ESlRtklGrDXwlpwYv/PQ0MATiZEDxzQsSXmwRv5TLROygyxst/rXI3KtoGpXK6UVmL3Z58G
	9tnAwAEmX/N8/EiIhspAxLy98bImjYZ/0dpOzVkyf2qo5nUjkKbYGxge/rqu2ohneGWfirm
	GQAWjaxVshZoRa07HDlwIxV7fbSe9Dg5rzG6I4NHjI9V31WQPsE/prQwoQeIZ+Q0Uo4Vudh
	rHhWRF2TLNzGhMd8KMddYWejo2M5A1+IZx3FnRenxlu
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,redhat.com,linuxfoundation.org,uniontech.com,mojatatu.com,kernel.org,oss.qualcomm.com,corigine.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269279-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:2045gemini@gmail.com,m:davem@davemloft.net,m:dcaratti@redhat.com,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:jhs@mojatatu.com,m:keenanat2000@gmail.com,m:kuba@kernel.org,m:pctammela@mojatatu.com,m:rajat.gupta@oss.qualcomm.com,m:rollkingzzc@gmail.com,m:simon.horman@corigine.com,m:stable@vger.kernel.org,m:toke@redhat.com,m:victor@mojatatu.com,m:yimingqian591@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,corigine.com:email,davemloft.net:email,mojatatu.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AC7D6CFA13

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


