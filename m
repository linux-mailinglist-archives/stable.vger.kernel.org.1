Return-Path: <stable+bounces-270608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KAPdDLKeRmpAaQsAu9opvQ
	(envelope-from <stable+bounces-270608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:24:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A196FB485
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:24:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="2cWHVxu/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270608-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270608-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C29A30C3E09
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317633D4EC;
	Thu,  2 Jul 2026 16:23:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70F334A3D9;
	Thu,  2 Jul 2026 16:23:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009385; cv=none; b=M5S4HHninyIi1zHN8ah2wvVAivIgWwdBusckgqXJS7H1yrcvVn6/aQDKWJojvsiiPdvz2N4k+l3dbV8QlTOAzgGlkOAFHdHPmPcWH2MeFGFPvB85Wsk+5V+A7Vb2wQX4UlRH/kYmIaxyXREDpaKD6x50PO6YWGjsi0yhjkxh5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009385; c=relaxed/simple;
	bh=/ld/pYuSug3e84qNG2LD0b12K6UV7q+kdvEeV2HWLJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLYR85WxIqaNpHdrQY4z0lgpmRFf+bQzoEubkRDHNrYpWI52g6pgTLLWwX7TNPU608Krj120DtbB7mKENRMg+4gCZaXfjJRL30LPdkAernrngkCKefNkmWDYRROnyYgm46rlGVJvvhoIi7UHo+59KhWhlGWaVOeMnQ4OganGJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2cWHVxu/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB8E1F00A3F;
	Thu,  2 Jul 2026 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009382;
	bh=4WpYjHcf/DRAC+KD+H2uwkG6gzsiHTrflxqW+PXu0/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2cWHVxu/evUgo8Z5K5Pya96sgnMhCVpzNRSiEnU2wgli0Vz7fOy/okH597nwtIsbJ
	 vfoaqaV+Quo1xxvRvo/IOTwi0sd1OrYMwp40uujHT/3ktrt/MZ+d9G1CwcyB/1Mjwe
	 IUZnAOKGxBy9oHvsAEKdl/+OBbtjsTyDCJ+GBds4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 03/96] net/sched: simplify tcf_pedit_act
Date: Thu,  2 Jul 2026 18:18:55 +0200
Message-ID: <20260702155109.031855129@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270608-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jhs@mojatatu.com,m:simon.horman@corigine.com,m:pctammela@mojatatu.com,m:pabeni@redhat.com,m:guanwentao@uniontech.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,uniontech.com:email,corigine.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4A196FB485

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 95b069382351826c0ae37938070aa82dbeaf288d ]

Remove the check for a negative number of keys as
this cannot ever happen

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_pedit.c | 137 +++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 70 deletions(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 0fbffebfbdc9d8..84152d3a492469 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -341,8 +341,12 @@ static int pedit_skb_hdr_offset(struct sk_buff *skb,
 static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
+	enum pedit_header_type htype = TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+	enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
 	struct tcf_pedit *p = to_pedit(a);
+	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
+	struct tc_pedit_key *tkey;
 	u32 max_offset;
 	int i;
 
@@ -358,88 +362,81 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	tcf_lastuse_update(&p->tcf_tm);
 	tcf_action_update_bstats(&p->common, skb);
 
-	if (parms->tcfp_nkeys > 0) {
-		struct tc_pedit_key *tkey = parms->tcfp_keys;
-		struct tcf_pedit_key_ex *tkey_ex = parms->tcfp_keys_ex;
-		enum pedit_header_type htype =
-			TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
-		enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
-
-		for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
-			u32 *ptr, hdata;
-			int offset = tkey->off;
-			int hoffset;
-			u32 val;
-			int rc;
-
-			if (tkey_ex) {
-				htype = tkey_ex->htype;
-				cmd = tkey_ex->cmd;
-
-				tkey_ex++;
-			}
+	tkey = parms->tcfp_keys;
+	tkey_ex = parms->tcfp_keys_ex;
 
-			rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
-			if (rc) {
-				pr_info("tc action pedit bad header type specified (0x%x)\n",
-					htype);
-				goto bad;
-			}
+	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
+		int offset = tkey->off;
+		u32 *ptr, hdata;
+		int hoffset;
+		u32 val;
+		int rc;
 
-			if (tkey->offmask) {
-				u8 *d, _d;
-
-				if (!offset_valid(skb, hoffset + tkey->at)) {
-					pr_info("tc action pedit 'at' offset %d out of bounds\n",
-						hoffset + tkey->at);
-					goto bad;
-				}
-				d = skb_header_pointer(skb, hoffset + tkey->at,
-						       sizeof(_d), &_d);
-				if (!d)
-					goto bad;
-				offset += (*d & tkey->offmask) >> tkey->shift;
-			}
+		if (tkey_ex) {
+			htype = tkey_ex->htype;
+			cmd = tkey_ex->cmd;
 
-			if (offset % 4) {
-				pr_info("tc action pedit offset must be on 32 bit boundaries\n");
-				goto bad;
-			}
+			tkey_ex++;
+		}
 
-			if (!offset_valid(skb, hoffset + offset)) {
-				pr_info("tc action pedit offset %d out of bounds\n",
-					hoffset + offset);
-				goto bad;
-			}
+		rc = pedit_skb_hdr_offset(skb, htype, &hoffset);
+		if (rc) {
+			pr_info("tc action pedit bad header type specified (0x%x)\n",
+				htype);
+			goto bad;
+		}
 
-			ptr = skb_header_pointer(skb, hoffset + offset,
-						 sizeof(hdata), &hdata);
-			if (!ptr)
-				goto bad;
-			/* just do it, baby */
-			switch (cmd) {
-			case TCA_PEDIT_KEY_EX_CMD_SET:
-				val = tkey->val;
-				break;
-			case TCA_PEDIT_KEY_EX_CMD_ADD:
-				val = (*ptr + tkey->val) & ~tkey->mask;
-				break;
-			default:
-				pr_info("tc action pedit bad command (%d)\n",
-					cmd);
+		if (tkey->offmask) {
+			u8 *d, _d;
+
+			if (!offset_valid(skb, hoffset + tkey->at)) {
+				pr_info("tc action pedit 'at' offset %d out of bounds\n",
+					hoffset + tkey->at);
 				goto bad;
 			}
+			d = skb_header_pointer(skb, hoffset + tkey->at,
+					       sizeof(_d), &_d);
+			if (!d)
+				goto bad;
+			offset += (*d & tkey->offmask) >> tkey->shift;
+		}
 
-			*ptr = ((*ptr & tkey->mask) ^ val);
-			if (ptr == &hdata)
-				skb_store_bits(skb, hoffset + offset, ptr, 4);
+		if (offset % 4) {
+			pr_info("tc action pedit offset must be on 32 bit boundaries\n");
+			goto bad;
 		}
 
-		goto done;
-	} else {
-		WARN(1, "pedit BUG: index %d\n", p->tcf_index);
+		if (!offset_valid(skb, hoffset + offset)) {
+			pr_info("tc action pedit offset %d out of bounds\n",
+				hoffset + offset);
+			goto bad;
+		}
+
+		ptr = skb_header_pointer(skb, hoffset + offset,
+					 sizeof(hdata), &hdata);
+		if (!ptr)
+			goto bad;
+		/* just do it, baby */
+		switch (cmd) {
+		case TCA_PEDIT_KEY_EX_CMD_SET:
+			val = tkey->val;
+			break;
+		case TCA_PEDIT_KEY_EX_CMD_ADD:
+			val = (*ptr + tkey->val) & ~tkey->mask;
+			break;
+		default:
+			pr_info("tc action pedit bad command (%d)\n",
+				cmd);
+			goto bad;
+		}
+
+		*ptr = ((*ptr & tkey->mask) ^ val);
+		if (ptr == &hdata)
+			skb_store_bits(skb, hoffset + offset, ptr, 4);
 	}
 
+	goto done;
+
 bad:
 	spin_lock(&p->tcf_lock);
 	p->tcf_qstats.overlimits++;
-- 
2.53.0




