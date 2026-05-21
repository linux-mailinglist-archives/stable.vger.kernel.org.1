Return-Path: <stable+bounces-253533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDe/EKsND2qSEgYAu9opvQ
	(envelope-from <stable+bounces-253533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981885A64AF
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A43AE314C91B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4073D75AB;
	Thu, 21 May 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0+wvIl6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94EF3D7D86
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368288; cv=none; b=G3OD/bJqNq+n6YF4lxRlMr7Dm8Ik/JNaRq9s78ZDwT/VDY1qIihrOcUrQHZP7g1kYJPEnObe5EG3tS6KFiLgHJuWojQkhCe5CrRoJav/4DEV5YYlqiiS7srP7lNBZVD/tkVGjy9xw66+lwQ2j7oAJeFvTVSiLIyXLLLV0xToqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368288; c=relaxed/simple;
	bh=9VOjmrYiswFNHpRJZnT48g9/ha2YLWYHCeLXe6cG5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQuP/aidm6sVmih7yQk8YPD8Ih4NHRRDKRpDnpeY1EqGokjZhGxV4IA8pMP/VRy+NUK/3Rne7i94F0o9Hiu3A9aLgezyl99uYiTJrHbZ8PkJ36rpgsxYvxl3WZp0fkG1olEQMBRudfQnCw46Li1kWr4ARlEZPOQQkkmfvYp0BhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0+wvIl6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2581F000E9;
	Thu, 21 May 2026 12:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368287;
	bh=j6/R8H0ZBLf1kzrGxiUurrGdm/MfoyKgNL4dAsOezII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0+wvIl68nltbZSQ6UGaG8hHyv3M3mOjs9d8isli/+92U15Cj6VEsAJaSkN43eXNg
	 ZpiZ8rRkoqn8edMazPysV/9Y1Bhf/mCzJGJfmRmFwHjwrUOJSKdNqqjR/owpI91lBK
	 wWM6KQRWcxPFfOFsvoGLCs2WLks3NWOhhpWFogLDvMT9Ndk6QP0/s/s7rUZ9pgSQAc
	 nz5J2bYiMcPth/yQrq9miUKah9qje9Y0InTJizCUXV425V4yPkhYlhMUNT+GnXY+I5
	 WwCJTYXsTsoVTBK8CJl7qcM+M5DMzu6m4cgLDECKZfigL+8EX6OpbdURHqjbi+8Dqs
	 7RNmKO1sGSp7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] tracing: fprobe: Remove unused local variable
Date: Thu, 21 May 2026 08:58:03 -0400
Message-ID: <20260521125805.1165028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051559-bucket-granny-664d@gregkh>
References: <2026051559-bucket-granny-664d@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253533-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 981885A64AF
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
Stable-dep-of: aa72812b4910 ("tracing/fprobe: Avoid kcalloc() in rcu_read_lock section")
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


