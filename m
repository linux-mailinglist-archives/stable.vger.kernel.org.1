Return-Path: <stable+bounces-256976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FibCnoRG2qC+wgAu9opvQ
	(envelope-from <stable+bounces-256976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF760E405
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A6F8302C0E5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1DD2F5A06;
	Sat, 30 May 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gBDbLhoV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1A432ED24;
	Sat, 30 May 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158343; cv=none; b=qWHYo2m/V+R2ewLznteHVqDIMEBCOWTskwzH8LpB9W1JgDRogTrcNrtEKSxegLIrktHmkJo4TK6P7N610DPaA+fSzd2GUcbIBm4XXHN/plZPzS5CFyTOCI44vw/GD4ZcBFyUIeIruf+en6+sZ2DlLEdBPWzfL4UiZrnfSaKL9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158343; c=relaxed/simple;
	bh=6uRRNmdHUp9ynxxHUZWz7vvENTqbTt4ZQJyPwHDzB1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alFSOPGMBpYYH+Yby33kP7ZyzZQKJ74jR5uMj2O8aZdg+pwE5oca3VURkaDEUO2WuBNTqdNgKJO+OsXg4kePHN2er2SZgyQA8dbGXHDWEvKNqQWxYMwXvOR2pZRj930CANDk9MVS4HojL4RtJMyfUJIASX/DyGr1luqdnNXuTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gBDbLhoV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B681F00893;
	Sat, 30 May 2026 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158342;
	bh=Bil/9ydlQaIUJxlTVqPH617sOXAaBH0NU4p85zB4oiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBDbLhoVpKvJC0t+YY3zo+5mbvGd4eGI2GY/ikCBURzYFSiz/f+jzk/gvyjZJtG7I
	 bve/ZXZvhiAJvo7LvmxlmOjbK2LapWMz5HEmazHCw5T4jm1WYzrZxEApPNxwR6MCwF
	 EylqGS/+8EWrRei3UXOsVJxUJHWpR+x2d+izJTbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/969] xfrm: Wait for RCU readers during policy netns exit
Date: Sat, 30 May 2026 17:52:46 +0200
Message-ID: <20260530160301.579066204@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256976-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,strlen.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71AF760E405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 069daad4f2ae9c5c108131995529d5f02392c446 ]

xfrm_policy_fini() frees the policy_bydst hash tables after flushing the
policy work items and deleting all policies, but it does not wait for
concurrent RCU readers to leave their read-side critical sections first.

The policy_bydst tables are published via rcu_assign_pointer() and are
looked up through rcu_dereference_check(), so netns teardown must also
wait for an RCU grace period before freeing the table memory.

Fix this by adding synchronize_rcu() before freeing the policy hash tables.

Fixes: e1e551bc5630 ("xfrm: policy: prepare policy_bydst hash for rcu lookups")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index cd534803a0e42..7b9151f4eccfd 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4129,6 +4129,8 @@ static void xfrm_policy_fini(struct net *net)
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
 
+	synchronize_rcu();
+
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
 	for (dir = 0; dir < XFRM_POLICY_MAX; dir++) {
-- 
2.53.0




