Return-Path: <stable+bounces-267029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IVpoDJykM2pnEgYAu9opvQ
	(envelope-from <stable+bounces-267029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:56:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A756669E411
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:56:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=CygRxpTQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267029-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267029-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15EB430CFAB4
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0D3D811B;
	Thu, 18 Jun 2026 07:55:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF433D6CAA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769323; cv=none; b=mZzfMDKqjlopkeku0g4huq6H70vTAVSiTTeRAS95qsUpf91c9Wfdczos8gv50rghfYxG5py168QfcZGfy7vB4pZpylfdAq6Eqn9Wc69P+ncR/PQbWTnUZ6u5pncHxstd09DqYmyNdkmcQZZOApuPOxLNdv7vmohvLeLWBc0uTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769323; c=relaxed/simple;
	bh=lf7gCt4JvwgPZLAIcz+/BuuF8UKNLHkFcmNnzYnIibQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ufL1UUlxXNrnoIZY1TBCNk9ItXsNWltInrrgwC2UP0+wfbP5YoXBUlwkSmwNJv/hQnZVjFeElBBQfRTy2mfh17Zt7ZsMlVHVT+nuZYVvo7gCmFTlE8Fn8txcOqJYBO6CD2DBKuzbAXNhGeQIVBcrFf4zxGwZ3bpzDQBhZghgkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CygRxpTQ; arc=none smtp.client-ip=54.204.34.130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769287;
	bh=XHZDzlXJFPduKF5+7NaJ9ixoUF88W9Qnjgr+DXyETOA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CygRxpTQ+Q7B9NT1IIVVqdItwv0l0M6muAc7+ud46Twg2gysiagE54v9+ZyhxIZVS
	 W2c92KJJF1GJf+TV2xH6/dco4fOLBlmN7B6CrA4+mQTli/+3/QRtf+im5h96lDHf/o
	 e2apqfXSklbK6ERlPv6XKKHwPYBSbGv+dSQP4Iu4=
X-QQ-mid: esmtpgz14t1781769268t331b1065
X-QQ-Originating-IP: f1Io+sT72TldqIm6uQHebnyxWGIARvuNtj2TuMrshRY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:54:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1385508494461404109
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
Subject: [PATCH v5.10.y v2 4/9] net/sched: act_pedit: remove extra check for key type
Date: Thu, 18 Jun 2026 15:53:42 +0800
Message-Id: <20260618075342.1599593-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: ObuqRYdpMhf5HX8hyspV+LvLHk7fL3nLmiidfxV2VYuTZmV/YlqY3NdT
	5troregL+l4rJUIOG6TmAFQrNEOcl3OVS8nZm3JlcGs4CzJ1DSM6r8Kw8LqOTHgywkThCgx
	wmonNCohHkAyXN9SxyZpL2XIwbh/qcDHaU2/GAw8sAKmRp03IwCO2/7p7FRRSIi1HeO9tvh
	qnpSn+DRKYBH158747M2p+i1tJobiAapLSOBFwcqvzSaDwcUUaKfvmjEzz+pg4ZReXqFp6Q
	jgAbuL7yOURMaRWY9PRciZvJ6YtvCYowPIcS5SvD1q1k0jCER+vaWAKdB9yrJKUOVmlr7TT
	JkWTPqxFgvIPACdtlQs/5GVkoRSYXUJgGpICLS2t//AVmhVnn6LTEGzyyRhWA+7lD5OIEUs
	HB62lwQHTg3x8d4l5To4TPOx5O98Tz4DKdm4iLebsXKxU5zKt3nTqIwfMf5Z+UDoRIb2ENf
	Y5se0YerbWKQZ/iQO83S3aD90g25YLxPzzsgRMVnklUvN9D2DdJ27ND65eLbyymdFTTPm8u
	4lhU5vr8EgR8C4In8PJOh14w4WhtLYV0eJUdHGsViuItFe+IAfA8unGGS+WUs9wk4kxsVI4
	wHsQ9bsxyGHZy3u5ckVqARn6UmfydeEDZ424wy2Bnf9tYmAeE4Bu+miT0OL1abYtRua5kdt
	nT0oZuECb7rIB8Pf0PimdfjXfPdvDMyHAKFmCjEpxftqMymm07hDa6MAGnlVdcJHJBI/gtU
	AHb+oH7verMddfwGjtNqxD2zh0tev9Obzl3KcZEqdRtKoKuxgjaAV6xl/5coB1nRwvZLyPx
	9BKtzLqJXkMVVlGuOmG1vMMuoTTA6eAHL9Rnf2jnkf1rd0f3SB8chQBz2dmMI+RTMhtbQtw
	IK93MboBUg+QHMSP3Uki0Khfh+otQUpwHYO7dJIBxGUt8ewTekRpb0gVUioggvAnGA6l4QR
	9tsiUjKwR5R6WPT8DjCv4drti6x/JSDVzf8lHXwK8xAeaoMFEfUNh0U+JTojBFUEMnouqpm
	sqKkXeGT/VpwJUQub5NqfCTf2W3krwryNpkK61bVMRIQT0ZbsYsuXMoA6V51W/rUEBAcEly
	ns4axx7Fv+EUVKy4+rRly381gt1JT0Z6YqxyvHBXZoZXr78Vr892RdB6SEYZzLlx8Znmpcm
	2c6hl84epHLrphLv1TrEp+5zOw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
	TAGGED_FROM(0.00)[bounces-267029-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,corigine.com:email,mojatatu.com:email,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,vger.kernel.org:from_smtp,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A756669E411

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 577140180ba28d0d37bc898c7bd6702c83aa106f ]

The netlink parsing already validates the key 'htype'.
Remove the datapath check as it's redundant.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 84152d3a49246..957ce9017c3f7 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -305,37 +305,28 @@ static bool offset_valid(struct sk_buff *skb, int offset)
 	return true;
 }
 
-static int pedit_skb_hdr_offset(struct sk_buff *skb,
-				enum pedit_header_type htype, int *hoffset)
+static void pedit_skb_hdr_offset(struct sk_buff *skb,
+				 enum pedit_header_type htype, int *hoffset)
 {
-	int ret = -EINVAL;
-
+	/* 'htype' is validated in the netlink parsing */
 	switch (htype) {
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_ETH:
-		if (skb_mac_header_was_set(skb)) {
+		if (skb_mac_header_was_set(skb))
 			*hoffset = skb_mac_offset(skb);
-			ret = 0;
-		}
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP4:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_IP6:
 		*hoffset = skb_network_offset(skb);
-		ret = 0;
 		break;
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_TCP:
 	case TCA_PEDIT_KEY_EX_HDR_TYPE_UDP:
-		if (skb_transport_header_was_set(skb)) {
+		if (skb_transport_header_was_set(skb))
 			*hoffset = skb_transport_offset(skb);
-			ret = 0;
-		}
 		break;
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
-	return ret;
 }
 
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
@@ -367,10 +358,9 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 		int offset = tkey->off;
+		int hoffset = 0;
 		u32 *ptr, hdata;
-		int hoffset;
 		u32 val;
-		int rc;
 
 		if (tkey_ex) {
 			htype = tkey_ex->htype;
@@ -379,12 +369,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			tkey_ex++;
 		}
 
-		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
-		if (rc) {
-			pr_info("tc action pedit bad header type specified (0x%x)\n",
-				htype);
-			goto bad;
-		}
+		pedit_skb_hdr_offset(skb, htype, &hoffset);
 
 		if (tkey->offmask) {
 			u8 *d, _d;
-- 
2.30.2


