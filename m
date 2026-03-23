Return-Path: <stable+bounces-229654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGMdHDR8wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:45:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB262FA5A0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081B93059FDB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0B83B9DAC;
	Mon, 23 Mar 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCmW2VqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D1340286;
	Mon, 23 Mar 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282506; cv=none; b=J4Be9VWnMN7ER72d4lt58LoRhCUa7R9g5p4coOTn2I/Dp4kgeBS0DTpkCzmeO5YBr6K31Bzs5UpXb3AI6hkg+tpKS7ReUwIBuWea8Lshrang7mxoDxZdL4yFnsc3tdep6ZDQver5Qzz60H7Kbauk6PS5PFUWTh29IMmMOjlVuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282506; c=relaxed/simple;
	bh=xxMPWsnTUa05fu3ARORq04QyqiVrIHWFAEfA77ZXI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os7f6IKjgfl4ph5MiKmNEAiIpiGESQ1rCWQdwBCRT/nitvJBemYhtZcTCYps0+fGip90RkKfljiXmpr3SsQhLMgYTIAm9xdO+LdeRhqg3hD4hBqlR3bNhEVJxKMhufCEwUdZVBuXLCturMgvUrwriP4PTIhH0ct5XH68iWbji4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCmW2VqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A825C4CEF7;
	Mon, 23 Mar 2026 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282506;
	bh=xxMPWsnTUa05fu3ARORq04QyqiVrIHWFAEfA77ZXI88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCmW2VqW6epolxHiMvwIqLl2GQWoSwZQiblmX3gsL305peFJd84EKNaCGO5PVbD7Y
	 b3vT4gyjRLnpUzQ5wAPwl9Ns9V1kmCCBfbpw6wxRDKtYrX13NThJRiM/pNVLEY6FBr
	 7ojBGv8UUrsoqCN8SQC1+svVeTGgZwEIVYtVR6+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 180/481] netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels
Date: Mon, 23 Mar 2026 14:42:42 +0100
Message-ID: <20260323134529.596980949@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,foxmail.com,strlen.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-229654-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,foxmail.com:email]
X-Rspamd-Queue-Id: DFB262FA5A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Tan <tanyuan98@outlook.com>

[ Upstream commit 329f0b9b48ee6ab59d1ab72fef55fe8c6463a6cf ]

IDLETIMER revision 0 rules reuse existing timers by label and always call
mod_timer() on timer->timer.

If the label was created first by revision 1 with XT_IDLETIMER_ALARM,
the object uses alarm timer semantics and timer->timer is never initialized.
Reusing that object from revision 0 causes mod_timer() on an uninitialized
timer_list, triggering debugobjects warnings and possible panic when
panic_on_warn=1.

Fix this by rejecting revision 0 rule insertion when an existing timer with
the same label is of ALARM type.

Fixes: 68983a354a65 ("netfilter: xtables: Add snapshot of hardidletimer target")
Co-developed-by: Yifan Wu <yifanwucs@gmail.com>
Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
Co-developed-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Xin Liu <dstsmallbird@foxmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_IDLETIMER.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index 3f6a9770f74ba..9733f49847a6d 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -320,6 +320,12 @@ static int idletimer_tg_checkentry(const struct xt_tgchk_param *par)
 
 	info->timer = __idletimer_tg_find_by_label(info->label);
 	if (info->timer) {
+		if (info->timer->timer_type & XT_IDLETIMER_ALARM) {
+			pr_debug("Adding/Replacing rule with same label and different timer type is not allowed\n");
+			mutex_unlock(&list_mutex);
+			return -EINVAL;
+		}
+
 		info->timer->refcnt++;
 		mod_timer(&info->timer->timer,
 			  msecs_to_jiffies(info->timeout * 1000) + jiffies);
-- 
2.51.0




