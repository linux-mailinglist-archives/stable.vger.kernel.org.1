Return-Path: <stable+bounces-224142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFwAC+r+r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A676024A836
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00645308C461
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293A13859EA;
	Tue, 10 Mar 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5sEY9R0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DF38A720;
	Tue, 10 Mar 2026 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141275; cv=none; b=OCAYQFs1/IiLndTmFwp5+oJ02Y3NY3HQxjtV+sRAhAbt/naeqo/wIYZShpG7axipHKixYN1Pr4ydKq5hmFcOH/UCt8mhSJL/52B3DO3qJstVhN8LhTRiEByepUgpyTdE5uNm5ZjUeALaMDNZmVYpGMLKrvNYjPb95dH1GFSjFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141275; c=relaxed/simple;
	bh=5S23d50eJOj1XYh8oCrO41AdzRn+vzTqr6a6Q4bcAh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJA0qYzoABT6dwHacwi00QipNorCgpd2Px3lW8Srg5j8q/2m83h1+4XTbaN4Fs+vldtDdKePVLLS1XIMpQL7kiIqvYKSZ7WuRHaCHwxY7KtzxbM9wK3oX5DLwKtaVQUI89BvMXsVOxLXzZk4rXdeF87pH2I0PFxe54/sWBz5Oro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5sEY9R0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768CBC19423;
	Tue, 10 Mar 2026 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141275;
	bh=5S23d50eJOj1XYh8oCrO41AdzRn+vzTqr6a6Q4bcAh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5sEY9R0QEqvGeqg5adKy2hUd7aHYJT5/UFY0URgK+jAJz5rjaW21WynK6cAs4UyR
	 t7ISeJPjtlfrnIaepzooYqqdqHsrsoD3323gLct4RDPfXE1y2MXs1nEQojwDoN/7Fc
	 L8/qHUWq5CeaiXqxBlH9v5a7kBCPZidDp71H9mPgEEXE3jIuXxoV/pgoL9epc8idQd
	 n+LXm2fs7ljWPA3Oe1PNKxBYZY9FOsdRPIlHnBnElOLQi+NkcuyXMpl2r/uNF1ils3
	 zTU1tcSudw15JS40aPhT6YRuVf3cPMVkN7wX+yOktrqpm04geBzqglTEFUmXtdu8Oh
	 Y0lajHoJxNSyg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 277/311] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Date: Tue, 10 Mar 2026 07:05:24 -0400
Message-ID: <034acd14605d676d84b20cb807a22cd3efa8171e.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A676024A836
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
	TAGGED_FROM(0.00)[bounces-224142-lists,stable=lfdr.de];
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
index 062415cc3e5a4..d45be2357a5ce 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3983,7 +3983,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (shinfo->nr_frags > 0) {
 		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
 		if (net_is_devmem_iov(niov) &&
-		    net_devmem_iov_binding(niov)->dev != dev)
+		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
 			goto out_free;
 	}
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index ec4217d6c0b4f..e9c5d75091800 100644
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


