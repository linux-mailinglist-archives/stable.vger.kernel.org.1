Return-Path: <stable+bounces-253534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHeXJ5IED2pDEQYAu9opvQ
	(envelope-from <stable+bounces-253534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:11:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D0A5A5702
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A14303C420
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1433D810C;
	Thu, 21 May 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqGwp5+c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7BA35674C
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368289; cv=none; b=bJil5Jsp2oyUhIdT2lpmx4gjkOZONo+4aaT7Fx9Jm/YJ9v/K4UYrgvCRugOd0SJswTOUPgQmE5a28vkxbBmKXtyJLShbyqHRXoaca4wlhGvkJnmdSoyP/kYUTaTh5I5oU57j4dXX7dCePPJFNGglSY6t4YsZDh+5JQPYgBXnqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368289; c=relaxed/simple;
	bh=+94LsoVVbMNrotX89OeACw1RuuBWn1uO9kjRgxJPb0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHXZxjMGQVeZUTWLJw2rI2+FnBDe53Yq71VhaRZuWn5fpkv1sGHvCfxsyW5d+PUPp2/rhXxI2euaDCwmCLZahpbY/rkihp336S4MVvYTHejDmZrI/W4ZDkrFM/SfD3Uz6T+qjil3IPQYj5oYXfbe2bQ5Xc2yqZ6MN7iAds8Zl/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqGwp5+c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9014B1F00A3C;
	Thu, 21 May 2026 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368288;
	bh=G65e3Vmrlx7zRIU6ZKjaDmcOtetxlFkrwFZibJH/tWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqGwp5+cz6rRA26AwLRDC/dlTTfzAEvrtWZiZ1ib3ztWZHcR/1n7YYwPEre8qjkw8
	 0cxH/svZOiJVOgX0qNhoV7zJZXQyQ0vYtHkyDRY2VX8sBrF/vmGpQUjR+W/EvKYRT7
	 UEqY7A1ADpGDaamjZp7Tyc4kDHfRsToCPTJ3whspcM6s0XaK9TDbI/RXBdkVOER7Sp
	 dKvqNUAfJsqYzCkfCKEO7IAYJnks7GvTechS8W4C2OCFYzeF5syZ+HjH5K5KZf7h46
	 wPfKgCMyA1z5k69zIuZ5WrWork4QBasvhd6BjpZUBj57oJGhPmfKExtZ2r2ZUckHyc
	 6nhpn9zdaTC6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Date: Thu, 21 May 2026 08:58:04 -0400
Message-ID: <20260521125805.1165028-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521125805.1165028-1-sashal@kernel.org>
References: <2026051559-bucket-granny-664d@gregkh>
 <20260521125805.1165028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chinatelecom.cn,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253534-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 01D0A5A5702
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit cd06078a38aaedfebbf8fa0c009da0f99f4473fb ]

For now, we will use ftrace for the fprobe if fp->exit_handler not exists
and CONFIG_DYNAMIC_FTRACE_WITH_REGS is enabled.

However, CONFIG_DYNAMIC_FTRACE_WITH_REGS is not supported by some arch,
such as arm. What we need in the fprobe is the function arguments, so we
can use ftrace for fprobe if CONFIG_DYNAMIC_FTRACE_WITH_ARGS is enabled.

Therefore, use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_REGS or
CONFIG_DYNAMIC_FTRACE_WITH_ARGS enabled.

Link: https://lore.kernel.org/all/20251103063434.47388-1-dongml2@chinatelecom.cn/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: aa72812b4910 ("tracing/fprobe: Avoid kcalloc() in rcu_read_lock section")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 51003d85933d9..574f2886cc9e3 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -45,6 +45,7 @@
 static struct hlist_head fprobe_table[FPROBE_TABLE_SIZE];
 static struct rhltable fprobe_ip_table;
 static DEFINE_MUTEX(fprobe_mutex);
+static struct fgraph_ops fprobe_graph_ops;
 
 static u32 fprobe_node_hashfn(const void *data, u32 len, u32 seed)
 {
@@ -259,7 +260,7 @@ static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent
 	return ret;
 }
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
 /* ftrace_ops callback, this processes fprobes which have only entry_handler. */
 static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
 	struct ftrace_ops *ops, struct ftrace_regs *fregs)
@@ -300,7 +301,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
 
 static struct ftrace_ops fprobe_ftrace_ops = {
 	.func	= fprobe_ftrace_entry,
-	.flags	= FTRACE_OPS_FL_SAVE_REGS,
+	.flags	= FTRACE_OPS_FL_SAVE_ARGS,
 };
 static int fprobe_ftrace_active;
 
@@ -341,6 +342,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return !fp->exit_handler;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+	ftrace_set_filter_ips(&fprobe_ftrace_ops, ips, cnt, remove, reset);
+}
+#endif
 #else
 static int fprobe_ftrace_add_ips(unsigned long *addrs, int num)
 {
@@ -355,7 +365,15 @@ static bool fprobe_is_ftrace(struct fprobe *fp)
 {
 	return false;
 }
+
+#ifdef CONFIG_MODULES
+static void fprobe_set_ips(unsigned long *ips, unsigned int cnt, int remove,
+			   int reset)
+{
+	ftrace_set_filter_ips(&fprobe_graph_ops.ops, ips, cnt, remove, reset);
+}
 #endif
+#endif /* !CONFIG_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /* fgraph_ops callback, this processes fprobes which have exit_handler. */
 static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
@@ -601,14 +619,8 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	} while (node == ERR_PTR(-EAGAIN));
 	rhashtable_walk_exit(&iter);
 
-	if (alist.index > 0) {
-		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
-				      alist.addrs, alist.index, 1, 0);
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
-		ftrace_set_filter_ips(&fprobe_ftrace_ops,
-				      alist.addrs, alist.index, 1, 0);
-#endif
-	}
+	if (alist.index > 0)
+		fprobe_set_ips(alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
 
 	kfree(alist.addrs);
-- 
2.53.0


