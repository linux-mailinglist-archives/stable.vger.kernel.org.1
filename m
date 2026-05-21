Return-Path: <stable+bounces-253536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QELMH60ND2p7EgYAu9opvQ
	(envelope-from <stable+bounces-253536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208DC5A64BD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB803303CE26
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388B3D88E9;
	Thu, 21 May 2026 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdT+jegI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF313B5F48
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368297; cv=none; b=j3Hm9DJagTfWbVNkgHk9afQp180YRPPDSpCR7OafyIkLeWs4cZs4gDwdKD14A/rh0/xzWZLVEQWiQYoBDEof1nlMBTB8Zk9cXQH+G4JOtUEFu4Rh4iwdrucfX1AViOYBOs8qMZYWiy/NMQCRyddTl37FQImrcKScQ4T/tV1eKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368297; c=relaxed/simple;
	bh=ytZJdiEh6HR3SVXfTWJzSUhQB0aMDwdDWS//Iv6NP9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJKFMhenau61OuVwFc6VevtZKNWZcJyTyxvaNxEXRuqn9fuobzSasqiJhWHtDGiY2QTVb8WsZd9/Wrovm2F6gjhnRLEbvu+yzX78g58+89KmDlz+wTYDVmHXedW/mj2HdjUMs0Iez1xtK9JYPluOgFgyd2Gv3+f7rpmK0a5MyGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdT+jegI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690F01F00A3C;
	Thu, 21 May 2026 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368295;
	bh=MEucJDmHGi82EiJqmneA2/C0HIJLSUcqz4N9MPIR0LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdT+jegIjndWNA3pcle/dph4c3padl63Tdk4g+OtYVfLdN2cXp9lbATvwRUMFe1dA
	 bFQs6gdUGmP6Gmcv5lQTf8SYjownT0wTMWT6MzZpXIQljpyA8yujxjRrrV9MDAFEUO
	 ZcQbupjPS871cda3XAZUiEvK7w0qRRXjY4AkQdOtHMLEanGC1o4xUDTHfLydM4GAQ0
	 VwG9U6XoeRHMTPI39J83zMU5gGomHMlQ6NHPsAZlkcFx2LcPUNIJPYnl2W7xbEOsvI
	 IIZhoS111eTAF3DiZUP3d0GyxBDDoglWCKz/lLWoOLYdGxXfRF9fpNBC4PBVH464b2
	 dqNUCOPz4DFqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] tracing: fprobe: Remove unused local variable
Date: Thu, 21 May 2026 08:58:10 -0400
Message-ID: <20260521125813.1165339-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051547-headless-mutilated-277a@gregkh>
References: <2026051547-headless-mutilated-277a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253536-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 208DC5A64BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 90e69d291d195d35215b578d210fd3ce0e5a3f42 ]

The 'ret' local variable in fprobe_remove_node_in_module() was used
for checking the error state in the loop, but commit dfe0d675df82
("tracing: fprobe: use rhltable for fprobe_ip_table") removed the loop.
So we don't need it anymore.

Link: https://lore.kernel.org/all/175867358989.600222.6175459620045800878.stgit@devnote2/

Fixes: e5a4cc28a052 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Menglong Dong <menglong8.dong@gmail.com>
Stable-dep-of: 0ac0058a74ac ("tracing/fprobe: Check the same type fprobe on table as the unregistered one")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 8fa5bff2c26fa..51003d85933d9 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -561,8 +561,6 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist_node *node,
 					 struct fprobe_addr_list *alist)
 {
-	int ret = 0;
-
 	if (!within_module(node->addr, mod))
 		return;
 	if (delete_fprobe_node(node))
@@ -571,8 +569,7 @@ static void fprobe_remove_node_in_module(struct module *mod, struct fprobe_hlist
 	 * If failed to update alist, just continue to update hlist.
 	 * Therefore, at list user handler will not hit anymore.
 	 */
-	if (!ret)
-		ret = fprobe_addr_list_add(alist, node->addr);
+	fprobe_addr_list_add(alist, node->addr);
 }
 
 /* Handle module unloading to manage fprobe_ip_table. */
-- 
2.53.0


