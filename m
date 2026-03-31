Return-Path: <stable+bounces-232033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFj+HSP9y2naNAYAu9opvQ
	(envelope-from <stable+bounces-232033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACF36D8BA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5E3231305F1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D5A423A9F;
	Tue, 31 Mar 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcnJkaon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BA413225;
	Tue, 31 Mar 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975702; cv=none; b=bLBd0kc4GqBkX0AMBxiv6eoRFJiClEi0ot5aQ+HH+E5Jfn0E/ebS4PPeVk3+UcTnCxHcL/pWgfDAAwQlDFUdUkSgcsHHsWJasvCBwEUf09dA0CoKsXNVrG0Z6GDo9lmkKkzdg52Z1WkT4Gi39v7n+SuxXrwtvobYZanhRi561Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975702; c=relaxed/simple;
	bh=u8B5+8sMDWriSmI7WECcgkCisyLqmu9UMTQ63C2cU1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzlv1Udtf/JokMX5u5UtS9t26WAqgSOLq3umCh4ws0Z+/Vt1DuEadklNOVVw+ZxNQTdl7KeyRXSUC9RWSzn1788gEu1rzmyAY6Kna4LIJTarPFG0hXPxJ/NwS1L2Z/ufUWvyxEOVw2V50PF/mvelE6OBEz8NKErqR7KmjUc3z14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcnJkaon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938B4C19423;
	Tue, 31 Mar 2026 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975701;
	bh=u8B5+8sMDWriSmI7WECcgkCisyLqmu9UMTQ63C2cU1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcnJkaon49c5Fn99s0o39WJXiVn+QdlOLw6AOQfQBy/a04ZXPczgGZ1GcNG6HtEwC
	 AOrxx0J+6JZk/zgO6y+uILRjNvIXK3VnYgtbeinQ0jFjVayj5HNx5YXqbDGzDW4Twe
	 5fc06KFVD7cpnU1VZs12jvUswywlAbIkOMtLiPWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Minwoo Ra <raminwo0202@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 053/244] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Tue, 31 Mar 2026 18:20:03 +0200
Message-ID: <20260331161743.651416992@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232033-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,secunet.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E7ACF36D8BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Minwoo Ra <raminwo0202@gmail.com>

[ Upstream commit 29fe3a61bcdce398ee3955101c39f89c01a8a77e ]

A XFRM_MSG_NEWSPDINFO request can queue the per-net work item
policy_hthresh.work onto the system workqueue.

The queued callback, xfrm_hash_rebuild(), retrieves the enclosing
struct net via container_of(). If the net namespace is torn down
before that work runs, the associated struct net may already have
been freed, and xfrm_hash_rebuild() may then dereference stale memory.

xfrm_policy_fini() already flushes policy_hash_work during teardown,
but it does not synchronize policy_hthresh.work.

Synchronize policy_hthresh.work in xfrm_policy_fini() as well, so the
queued work cannot outlive the net namespace teardown and access a
freed struct net.

Fixes: 880a6fab8f6b ("xfrm: configure policy hash table thresholds by netlink")
Signed-off-by: Minwoo Ra <raminwo0202@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index e1ce873b83234..f4713ab7996f2 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4270,6 +4270,8 @@ static void xfrm_policy_fini(struct net *net)
 	unsigned int sz;
 	int dir;
 
+	disable_work_sync(&net->xfrm.policy_hthresh.work);
+
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
-- 
2.51.0




