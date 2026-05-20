Return-Path: <stable+bounces-253238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAhHN+QFDmqv5gUAu9opvQ
	(envelope-from <stable+bounces-253238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADC4597B51
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C14C31CB187
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD344421A19;
	Wed, 20 May 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8EYiFK9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6583FF891;
	Wed, 20 May 2026 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302758; cv=none; b=Mh8LzKLSHKwlLEClZhSjjMGTGOefsfuimvsW5aaTWazYu4IsTtr9dYPmlsD4kziqiib2IuMj3u6ag64ek5f+whjl9k/NeFGZSPy+7D5NjOndFsOIApqjs7NX4JW49KFLLuwqu8hAGU46sgfYLmMZYQsE3GCqeQAHSQn4IB+S1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302758; c=relaxed/simple;
	bh=cJd5xLO2wJzzae71NzmZFwQq0JZONLiAb9dyBXeg95Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJfQIs0hiSMMPeE6c1lpIZ+tfDQtKjcpLVeUpINuwlbLiZ4bWyBYBNupgj93FXgVkSlXT17Ef+iuBkwQ9Y0be4Dk2mVZgD4OyLRnlLo7Aupr1JCWSTirEjCbdQRpULtgYgylNlNnH2SZUepcq3hLExthO4/94FnHQ1Qxn/BuDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8EYiFK9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300951F000E9;
	Wed, 20 May 2026 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302756;
	bh=HbgulPpWh70ybfRSWAYWTjlmMWLNlKXSAByE4tbeHWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8EYiFK9BpqlWT102XEZFpdhu642WnI//5UeFxexD5erxKKBuUDarEs30f2/D0zqD
	 DA3cX4RaMy0dMVExYVNf1QNIevyKaz1Jr/XYC2EdooZeiBqrWpQoNZCiIEBwpMs+Dr
	 0i9OXk11ptlhJL6tJBs5SAEcwZEk1cb3r9DUNMh4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 386/508] net/sched: netem: check for negative latency and jitter
Date: Wed, 20 May 2026 18:23:29 +0200
Message-ID: <20260520162106.982298136@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253238-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,networkplumber.org:email]
X-Rspamd-Queue-Id: 7ADC4597B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 90be9fedb218ee95a1cf59050d1306fbfb0e8b87 ]

Reject requests with negative latency or jitter.
A negative value added to current timestamp (u64) wraps
to an enormous time_to_send, disabling dequeue.
The original UAPI used u32 for these values; the conversion to 64-bit
time values via TCA_NETEM_LATENCY64 and TCA_NETEM_JITTER64
allowed signed values to reach the kernel without validation.

Jitter is already silently clamped by an abs() in netem_change();
that abs() can be removed in a follow-up once this rejection is in
place.

Fixes: 99803171ef04 ("netem: add uapi to express delay and jitter in nanoseconds")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260418032027.900913-7-stephen@networkplumber.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index b632e6678881a..f8c5c50618085 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -824,6 +824,16 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_time(const struct nlattr *attr, const char *name,
+			 struct netlink_ext_ack *extack)
+{
+	if (nla_get_s64(attr) < 0) {
+		NL_SET_ERR_MSG_ATTR_FMT(extack, attr, "negative %s", name);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1066,6 +1076,18 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_LATENCY64]) {
+		ret = validate_time(tb[TCA_NETEM_LATENCY64], "latency", extack);
+		if (ret)
+			goto table_free;
+	}
+
+	if (tb[TCA_NETEM_JITTER64]) {
+		ret = validate_time(tb[TCA_NETEM_JITTER64], "jitter", extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0




