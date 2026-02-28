Return-Path: <stable+bounces-221173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJoJMcVco2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7D1C8F88
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83D82311E67C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B1373BEE;
	Sat, 28 Feb 2026 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c51k+mYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B14373BE1;
	Sat, 28 Feb 2026 17:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301530; cv=none; b=W0eiX6YI3ClHhUHkd5k1yW39yjyQlxM+NPGKIg3fCVStIBod8DY3nMg7zPf/NtiXddTghkyzGFOnts7YDh17AWz6qyYpd4//aRedUdGuKgo7zAwmRRS2FZSGq4g+Mu+sbpnjHrO1XER9EvOoiA7rNoTB7bkaUQlFUqby8O7IBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301530; c=relaxed/simple;
	bh=tnOlQx/gRBuAvLxzGv/ocDXTRdJuzWXZPh3n12vKSOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r12xQC5xfGGgTqk1NPKDMduRGanyPlomcRJpWV6rIY6sBtLj+A87JFK6Vvx2NNrOP2Q1bVnnkkY0hvuVWRssZo7C5r59uy+yVKmMAyt0BNrukoQKXApokbSPlytMXWF/gGyIB3Ru1OgqalwPDZ2fyvH1q7/9XUDnk9pc+Pj892s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c51k+mYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A68C19424;
	Sat, 28 Feb 2026 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301530;
	bh=tnOlQx/gRBuAvLxzGv/ocDXTRdJuzWXZPh3n12vKSOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c51k+mYk33P19MzxV5WnBEgtBV6xbz3X9nhjGNrZhrY7gFkJn6qWxBTAVvWfhHFSG
	 VyTUVjeXgk8isoxKhyb08VTWOe7RpUinXzwI/VLKBnx8a9bxbwCAcHe/ywDCLSX93E
	 LC3V6nepCplEGk0WJODwHno/fGqX10XRc2WaiiP7PdoRxgqZbITqiSIXplJhZBBKxJ
	 8D6zaVwK7ageQefCg6poaJxOlBxPpSrDobQc9qDmeKnrPFvIQ5x/ijt78RcM0uD4zA
	 LcyUGhk2cpoB0kaQbhq6F4M4z3BUcmSkOKuKh+jXKox18xPHBfgBWq8Ng70WxnTf2+
	 JaFCMmwK8Z6mw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Shengming Hu <hu.shengming@zte.com.cn>,
	stable@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 712/752] function_graph: Restore direct mode when callbacks drop to one
Date: Sat, 28 Feb 2026 12:47:03 -0500
Message-ID: <20260228174750.1542406-712-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221173-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC7D1C8F88
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
index 599f2939cd940..13832ff06c96c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1311,7 +1311,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 	static_call_update(fgraph_func, func);
 	static_call_update(fgraph_retfunc, retfunc);
 	if (enable_branch)
-		static_branch_disable(&fgraph_do_direct);
+		static_branch_enable(&fgraph_do_direct);
 }
 
 static void ftrace_graph_disable_direct(bool disable_branch)
-- 
2.51.0


