Return-Path: <stable+bounces-220879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAAABMRHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A74991C77E1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34A303180A9C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCD4209BE;
	Sat, 28 Feb 2026 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G71gpomC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E84209B6;
	Sat, 28 Feb 2026 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300769; cv=none; b=YtFXj5HKG71OHgtrSO7DZW3bcnCu+G7EflDeKOFGOhUNkOstUQZ78zAggtcSS6uKJOqCHZ3IqZyj6yxLtZZXFdSfrFA42KehcTgcl87LqzwM/AGlYJi02gyd5+dyfzsDTLs4DIgAJEoBsjJYC7XF9xv8aAV28hlpFF0KXbWl/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300769; c=relaxed/simple;
	bh=kUE4WSTKMv+JLxw/HZxQybOAqh2nTAx9uk2KXDrhArE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=at7yUk23kcjDHNCO/J6xCvjKuB7pAFWKN54j4siwtYXFn9NhcV8epL2ZDuBjsxgR4jTsw8YBu083xi02KkexOnXFUeOUHePTvmhZzSAZDaZZeuEEjTWCE///6ERP+1O83BWjLHGOB/QSsoKhHZ+F8IVzB83u3Cbf/kuMWHRcrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G71gpomC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8995CC19424;
	Sat, 28 Feb 2026 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300769;
	bh=kUE4WSTKMv+JLxw/HZxQybOAqh2nTAx9uk2KXDrhArE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G71gpomCMDAPmEpytgbyG+DV8Hq3YiTZWM6lJOArJmNpOvfyD5BAXiVTF5oKCUbeQ
	 btpiM+glMrIeYBp6nGL4j2FhKa26qApoAiWzelw215ebGZgnCwTv+vfgQBtFibYw9t
	 QP+K9hu+7VxpBRrWzUTJKSF00TGq0ryLAQNqhqLJ563GqYKSL2+RlnkNZq3l+IYyEu
	 VLm1dvB/TdqgbGRrlXdseQrmQvLVkTWIfWFlvzmSOB0VO1Zt3PT3o9XyvaEjgjE2pg
	 JJwPfi8CvxfHbNY3ueurtxi0WTK/DkmAbW06bIFk+pwPmL/7k32VR3rW4E6tN2j89S
	 q2AZhzDEvn88Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 800/844] function_graph: Restore direct mode when callbacks drop to one
Date: Sat, 28 Feb 2026 12:31:53 -0500
Message-ID: <20260228173244.1509663-801-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220879-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,zte.com.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,goodmis.org:email]
X-Rspamd-Queue-Id: A74991C77E1
X-Rspamd-Action: no action

From: Shengming Hu <hu.shengming@zte.com.cn>

[ Upstream commit 53b2fae90ff01fede6520ca744ed5e8e366497ba ]

When registering a second fgraph callback, direct path is disabled and
array loop is used instead.  When ftrace_graph_active falls back to one,
we try to re-enable direct mode via ftrace_graph_enable_direct(true, ...).
But ftrace_graph_enable_direct() incorrectly disables the static key
rather than enabling it.  This leaves fgraph_do_direct permanently off
after first multi-callback transition, so direct fast mode is never
restored.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260213142932519cuWSpEXeS4-UnCvNXnK2P@zte.com.cn
Fixes: cc60ee813b503 ("function_graph: Use static_call and branch to optimize entry function")
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index cc48d16be43e0..4df766c690f92 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1303,7 +1303,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	static_call_update(fgraph_func, func);
 	static_call_update(fgraph_retfunc, retfunc);
 	if (enable_branch)
-		static_branch_disable(&fgraph_do_direct);
+		static_branch_enable(&fgraph_do_direct);
 }
 
 static void ftrace_graph_disable_direct(bool disable_branch)
-- 
2.51.0


