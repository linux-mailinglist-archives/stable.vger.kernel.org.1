Return-Path: <stable+bounces-258528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMmfD6AqG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:21:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AB6118ED
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58558309E975
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF383B7B72;
	Sat, 30 May 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U56JP0un"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FD31F98D;
	Sat, 30 May 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164652; cv=none; b=CG72X8yHiJJWP4dSgGtmRllgHPAjk3baT/jRcMPCMHQWklAWFHWFEpVbAGsl/8fUZhpBAGrnBHjdUD4d24iPSwt875Ldz9yMDhZ6kEzHu4QubDuZRafLxJOmBa+UvwJASuhtqlN9m0Xme6Js/oEQjcclw1J4MjITYJByN1uM9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164652; c=relaxed/simple;
	bh=743gMninsXlotvIiaAzqOui+3YtkuMWZehWn47xe0Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ol71VknNM+vecFLP0Q4f6hvmuKirXvgJSuJ5jaUTyyEpnL1usSb3oAHA1iaE+DX8A00FvCJe2v1Rwx8uB6XRKkM/tbuhuPTxqC/A62abJGNk8DxlLHu6yrqg9TiUQ7WyrQPK/vmskCnHD0Am2HyV7ZblFAFJm37rRL3yxbprYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U56JP0un; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648041F00893;
	Sat, 30 May 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164651;
	bh=kXAlwhQBl5ZULclUHfzVsp2X+TfUlmRMCwa9XwA/VIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U56JP0unUN2yHbfSEkC7IEp2I7GKM/SY05VGtA6iZt9BecsLsCmuQwSG0HtwwkTK7
	 JjGB7drwXw9g8w8iJgXkiD3FAOipurGzHGFLOf1WiJz27bJY0gSEo6Q6brDuBpau0V
	 qUWbyi757fDZ/2tGSiaRlFGPo6pHMxzQ6R3d23k0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 617/776] net/sched: netem: validate slot configuration
Date: Sat, 30 May 2026 18:05:31 +0200
Message-ID: <20260530160255.938474099@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258528-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,networkplumber.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 999AB6118ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 01801c359a74737b9b1aa28568b60374d857241a ]

Reject slot configurations that have no defensible meaning:

  - negative min_delay or max_delay
  - min_delay greater than max_delay
  - negative dist_delay or dist_jitter
  - negative max_packets or max_bytes

Negative or out-of-order delays underflow in get_slot_next(),
producing garbage intervals. Negative limits trip the per-slot
accounting (packets_left/bytes_left <= 0) on the first packet of
every slot, defeating the rate-limiting half of the slot feature.

Note that dist_jitter has been silently coerced to its absolute
value by get_slot() since the feature was introduced; rejecting
negatives here converts that silent coercion into -EINVAL. The
abs() can be removed in a follow-up.

Fixes: 836af83b54e3 ("netem: support delivering packets in delayed time slots")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260418032027.900913-5-stephen@networkplumber.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_netem.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 64542c9c15340..3e3bced82c564 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -815,6 +815,29 @@ static int get_dist_table(struct disttable **tbl, const struct nlattr *attr)
 	return 0;
 }
 
+static int validate_slot(const struct nlattr *attr, struct netlink_ext_ack *extack)
+{
+	const struct tc_netem_slot *c = nla_data(attr);
+
+	if (c->min_delay < 0 || c->max_delay < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative slot delay");
+		return -EINVAL;
+	}
+	if (c->min_delay > c->max_delay) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "slot min delay greater than max delay");
+		return -EINVAL;
+	}
+	if (c->dist_delay < 0 || c->dist_jitter < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative dist delay");
+		return -EINVAL;
+	}
+	if (c->max_packets < 0 || c->max_bytes < 0) {
+		NL_SET_ERR_MSG_ATTR(extack, attr, "negative slot limit");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void get_slot(struct netem_sched_data *q, const struct nlattr *attr)
 {
 	const struct tc_netem_slot *c = nla_data(attr);
@@ -1030,6 +1053,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			goto table_free;
 	}
 
+	if (tb[TCA_NETEM_SLOT]) {
+		ret = validate_slot(tb[TCA_NETEM_SLOT], extack);
+		if (ret)
+			goto table_free;
+	}
+
 	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
-- 
2.53.0




