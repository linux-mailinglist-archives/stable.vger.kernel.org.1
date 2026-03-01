Return-Path: <stable+bounces-222125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZZKnOeo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:03:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 243481CCC0F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8874C3085B84
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F12FDC27;
	Sun,  1 Mar 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJtg1itV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5042FE066
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329963; cv=none; b=qorQdnCgtu0ZGUH/rL+/kqOCHDto1bsvWlBI9DSlupbLneQjLj6nEpBYKRCs/AhOQlSVKggLPR7dg5QKFuaWwG/k0uUiGpATANJQsUDbwWoJt7yMMklXmbkVNoyuqXELDJCwQZcU9UFdTM5TZJmvenUWgNiDs0Y5PYP9fELpI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329963; c=relaxed/simple;
	bh=LdkQyWhY8/sOxq6lPbH2M0bRkx10EZVujj0IB3ReurY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIijS1JqvQRq3CZqKjpGBC5iyRlJnlAM9iF3jIF+fA4FfpdqKBVp3vbLu6B5+4PlxgbVrM1AX+Tfc3+JRehAMeDcgwvTyXd8frshGwkK8Tge013E7uFfcodhorOaofRKZ9yclxR7QrH8e5NesxrAdZlcCksYOvwxQwUkbrXMcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJtg1itV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884FCC19421;
	Sun,  1 Mar 2026 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329963;
	bh=LdkQyWhY8/sOxq6lPbH2M0bRkx10EZVujj0IB3ReurY=;
	h=From:To:Cc:Subject:Date:From;
	b=uJtg1itVxg2wNOwyAe7ELdugfJrJO128UWpinichCumeewvMaR983YarGN64n1bR1
	 lQ2NICDs4PHriDLmCez7474TXHdgvWQj6JykpFkRVTg6JbG1N+oWSqaszEdQ8g+tc1
	 4ZQswflGh0L3hE3FCZ2OXHKMic/8XbXOF1GaLcEe2gMdwR9uxmM+3hGqO7y8oV4m/q
	 lg+48Aq0DhzXHFLn3UjO6RyFoPocuG3S+46Ni5Iix6W9QP2wjjQDXMmUrZOJv7AKgq
	 BcuqiQy5UHBY8gC2+xjDKn4Jrg0U6LO0cUrIqE3RdC9rRJuW7jBfQXLnrn/b1MuVFG
	 0MLoARNY+k/5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lgs201920130244@gmail.com
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:41 -0500
Message-ID: <20260301015241.1719268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222125-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,csgroup.eu:email]
X-Rspamd-Queue-Id: 243481CCC0F
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33c1c6d8a28a2761ac74b0380b2563cf546c2a3a Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 23 Sep 2025 21:32:35 +0800
Subject: [PATCH] powerpc/smp: Add check for kcalloc() failure in
 parse_thread_groups()

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250923133235.1862108-1-lgs201920130244@gmail.com
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 292fee8809bc8..cad3358fa4c35 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.51.0





