Return-Path: <stable+bounces-253330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK8iJFEIDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:15:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C159806F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD9E39C215B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E18407CE3;
	Wed, 20 May 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zCVyBEcQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC14048A3;
	Wed, 20 May 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302999; cv=none; b=egrnB0hUkWHPKRmW/kIVycfkaS/CxMZcPVTNvRfDmzcSZIgGkdKa90/LpkCf/92voWcjAilMwbTOw7qHZJkHVp0i2NWZN8pIvjnSV94EJfstII/sB+cBpBBDtn1lkLXjmaZYrE29RZt1FfNqfeoYzSDdmfmE7AJETvmer4EF2UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302999; c=relaxed/simple;
	bh=JT95u1Q695P8gtCJR8RTli/88JTMACP4Ub+CIrwHINw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZpZV2ZqNW4/7riLRcr16Ul2iVaZed5VG/VvirWttllshualHgE8G4K4wePIeHl9eh5NrlY2McAwZc67QTA4Wf6dOX4LPgzVnVWkFxCph7D1KP4mq6DVA/siFfhWa+zEJqg+ukT/CJb+omHSORpYN3ejJBJm3zuWYP6BFJHPUbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zCVyBEcQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751A01F00899;
	Wed, 20 May 2026 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302996;
	bh=tfO06F/3Z9SEMY3nlapVv2hs+8vVPMqBJj3WEYO6Ax0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zCVyBEcQ2Moafd77WL+NvIBI7Pn11hdPdCuBfX8yui9XuxvrtQmAIQOIK+TcXcg6t
	 ThMzEe1dhAlXXEw4VuYzMJoTVJihrkDl0NyBwvGP/B9OGg4d6PcVl+0OpBTJzpaxce
	 JoXF/dqFCjn15J6M/T2QnFUv8PzJY3jTMEQvy3gU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 437/508] net/sched: cls_flower: revert unintended changes
Date: Wed, 20 May 2026 18:24:20 +0200
Message-ID: <20260520162108.068519685@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253330-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E45C159806F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 1e01abec856593e02cd69fd95b784c10dd46880c ]

While applying the blamed commit 4ca07b9239bd ("net: mctp i2c: check
length before marking flow active"), I unintentionally included
unrelated and unacceptable changes.

Revert them.

Fixes: 4ca07b9239bd ("net: mctp i2c: check length before marking flow active")
Reported-by: Jeremy Kerr <jk@codeconstruct.com.au>
Closes: https://lore.kernel.org/netdev/bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au/
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Link: https://patch.msgid.link/043026a53ff84da88b17648c4b0d17f0331749cb.1777447863.git.pabeni@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 07259b403e108..b00e491e8130d 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -549,7 +549,6 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 		       struct netlink_ext_ack *extack)
 {
 	struct cls_fl_head *head = fl_head_dereference(tp);
-	struct fl_flow_mask *mask;
 
 	*last = false;
 
@@ -566,12 +565,11 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 	list_del_rcu(&f->list);
 	spin_unlock(&tp->lock);
 
-	mask = f->mask;
+	*last = fl_mask_put(head, f->mask);
 	if (!tc_skip_hw(f->flags))
 		fl_hw_destroy_filter(tp, f, rtnl_held, extack);
 	tcf_unbind_filter(tp, &f->res);
 	__fl_put(f);
-	*last = fl_mask_put(head, mask);
 
 	return 0;
 }
-- 
2.53.0




