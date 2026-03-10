Return-Path: <stable+bounces-224462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D8EHk8EsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:45:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66524B7EE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC26332CDC56
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3580425CF7;
	Tue, 10 Mar 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJgubWtj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EBF3EFD36;
	Tue, 10 Mar 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142194; cv=none; b=aKMnZVEFIcI/kXYGKOYy4TYx84yl8Z6/bqRqwPfV4ywhxSXGuQ4Yj0g1O+17ZdiWhw98FvCt6TEKrC2PN7x5NYjBjfAcjjM7iKcMo04Jv7k2onLGwT1U2t2vAEME9+RWF/kLs9i0Tq7d5vItugKfB0DYRT9zUoUmlhIY7OyzvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142194; c=relaxed/simple;
	bh=K7GvCREAcw9Q/DJXPKrxnddq3lTC2FqKlKZB66fI5NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENj8ICeU/M4z1Ygmg66REqBoAKhhd82OEjMY9WSnl3K2jblrZEdNeMsGCZrf1QfbFXkLUn3Qarugvl7A9bmCn76r+J5OpYG182W1/KXW0TV3KAGtBglWHLPYpRJwlEjCFlsKF1/3H76/lALNe1+0UWKWcqZV5om5e3Tzaj/Hc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJgubWtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4FEC19423;
	Tue, 10 Mar 2026 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142194;
	bh=K7GvCREAcw9Q/DJXPKrxnddq3lTC2FqKlKZB66fI5NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJgubWtjvPI4LkTZNLqID3VsKee9OrMijxr2gjLFRQ21TiiSkCmb0axsnp0YjDH+Y
	 IsZtvBQK1e5IseNt97jWZpUH0FfwtMUQ4lMeg8bhgGqs+mMi8h8mlyCvR0f336WYWN
	 A2mvzu45Lm68yvMa4T+QjPAOaG/nLjB+0hB1ptP71573EUxopuGK1+N+Q2koes5xml
	 TG7SRp2aca92nIyewE1GBYUMPbMDsAcP92N8ZnCKF96m279RYgr5oJt7wjch1Kcy0q
	 dQIJm/CIpKBHxqjgywtHq8LcN5rKf71pUhYeeZ+UKydC5R6pNE+f3m7onjXXfSLY4u
	 13HaMDHedPKWA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 283/314] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Date: Tue, 10 Mar 2026 07:19:02 -0400
Message-ID: <80f49bf45de15791a2407d3594304ff07e100ba7.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E66524B7EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224462-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,meta.com:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

[ Upstream commit 40bf00ec2ee271df5ba67593991760adf8b5d0ed ]

binding->dev is protected on the write-side in
mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
concurrent bare reads in net_devmem_get_binding() and
validate_xmit_unreadable_skb() it should be wrapped in a
READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
with the underlying register in unforeseen ways.

Doesn't present a critical bug because the known compiler optimizations
don't result in bad behavior. There is no tearing on u64, and load
omissions/invented loads would only break if additional binding->dev
references were inlined together (they aren't right now).

This just more strictly follows the linux memory model (i.e.,
"Lock-Protected Writes With Lockless Reads" in
tools/memory-model/Documentation/access-marking.txt).

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Link: https://patch.msgid.link/20260302-devmem-membar-fix-v2-1-5b33c9cbc28b@meta.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c    | 2 +-
 net/core/devmem.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9b57a5b63919c..f937b8ba08222 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3975,7 +3975,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (shinfo->nr_frags > 0) {
 		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
 		if (net_is_devmem_iov(niov) &&
-		    net_devmem_iov_binding(niov)->dev != dev)
+		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
 			goto out_free;
 	}
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 1d04754bc756d..448f6582ac1ae 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -387,7 +387,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 * net_device.
 	 */
 	dst_dev = dst_dev_rcu(dst);
-	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
+	if (unlikely(!dst_dev) ||
+	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
@@ -504,7 +505,8 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 			xa_erase(&binding->bound_rxqs, xa_idx);
 			if (xa_empty(&binding->bound_rxqs)) {
 				mutex_lock(&binding->lock);
-				binding->dev = NULL;
+				ASSERT_EXCLUSIVE_WRITER(binding->dev);
+				WRITE_ONCE(binding->dev, NULL);
 				mutex_unlock(&binding->lock);
 			}
 			break;
-- 
2.51.0


