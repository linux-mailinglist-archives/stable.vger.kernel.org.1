Return-Path: <stable+bounces-273494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FAS/JQmRU2q+bwMAu9opvQ
	(envelope-from <stable+bounces-273494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C3744C17
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 15:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=tkfF8o5e;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273494-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273494-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3525F3008E29
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFDD3A7186;
	Sun, 12 Jul 2026 13:05:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF52BE033
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 13:05:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783861509; cv=none; b=EHbgX/cArPji3qqYJf6gNIC3X/bAg+NQ29c7uqyk01lfsBZJFWycJY9ALnJGFePsMv+sJhzbz9IJq+nGkEeyMQ7uMKDV5zwB9h6GoTUGH5lyYJZaRhGAvRtryQVqH0Br2gCFd71dnrHwCHTlStTW3YCIAcOc7q/P1daSg5SVM7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783861509; c=relaxed/simple;
	bh=GUp3PmnFmXHoEhrHLOH8q4YGU/QcMp1uvL4xYuiuYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCrW7CMOqp9K/IGu4GS69SOQnFlZ5Yt29GphIxWpNAAkysFwSE9QP4TqhNCXZpjQA85UKbd9thv29c36fjLfaevGhl1QHet3p5NCgK1affJyIt1MDMqDGgmNGXuRpT2NUumK8hcoIMG6jthJd8IbPBs6EtN6rrsR9P4JkIgwAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tkfF8o5e; arc=none smtp.client-ip=95.215.58.177
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783861505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9T+JTQqyK8bJsfsDIZygaYxhXti8DrgIowVgz9xghEw=;
	b=tkfF8o5eMabajNpylI8gbbgnE5DL0YGvdMF/rAtKCIWIS7Uf2/FWsv4tkb3EqbzcqH87yG
	PHI02nnFXKnvCYIYqZOU1SDsYlwtG1dKZgyHqpEq0rLew3wluoKUEhTUWphPVZLT9TxlE+
	rfEzr1ljBwNgkxpQYhUQtO2CDlsCK4w=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	opurdila@ixiacom.com,
	tim.bird@sony.com,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] llc: fix SAP refcount leak when creating incoming sockets
Date: Sun, 12 Jul 2026 21:03:43 +0800
Message-ID: <20260712130343.518797-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273494-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:opurdila@ixiacom.com,m:tim.bird@sony.com,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 742C3744C17

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

llc_sap_add_socket() takes a SAP reference for each socket added to a SAP,
and llc_sap_remove_socket() releases it. llc_create_incoming_sock() takes
an additional SAP reference after adding the child socket.

This extra reference was balanced by an explicit llc_sap_put() in
llc_ui_release() until commit 3100aa9d74db ("llc: fix SAP reference
counting w.r.t. socket handling") removed that put. The corresponding hold
in the accept path was left behind.

When such a child socket is removed, only the reference taken by
llc_sap_add_socket() is released. The extra reference keeps the SAP alive
after its last socket is removed. Remove the obsolete hold.

Fixes: 3100aa9d74db ("llc: fix SAP reference counting w.r.t. socket handling")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/llc/llc_conn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index e8f427375c68..260460d50f54 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -767,7 +767,6 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
 	newllc->dev = dev;
 	dev_hold(dev);
 	llc_sap_add_socket(llc->sap, newsk);
-	llc_sap_hold(llc->sap);
 out:
 	return newsk;
 }
-- 
2.51.0


