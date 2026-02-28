Return-Path: <stable+bounces-221115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LTEGsBNo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD41C8332
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EEBA306ABE3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FA371451;
	Sat, 28 Feb 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+RmjBO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274E37146B;
	Sat, 28 Feb 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301465; cv=none; b=UGefwqcDeVCDtpySKzTUYkapw0d8eGfWid3QThDVsQo/ePy5phMPhy3ETDJ1l9ourjVB2mbFYrpCzOkrm3tLHyhuLXW5ICsWIxj5moLEJpUT6FXDiI0KD6sHkUcmTekJmPPXccJG6pw4G398+iebZD4iqIl4cXn3wzNLqc7tYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301465; c=relaxed/simple;
	bh=GmsVpxpNT/LPNenninbLyr63BYxl7iMmqbgXl29Fmfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HABIyWm+ev7d87yznT1p6k9sXTjEBB4UYm59ksZSLaOUqEQSha/XuZDOg8GGZ9q8Trp4ta/G0Ta6OYx1crTbTPBzdNbikPpcx6d4mofQk0nHFaZ4zubaTIuUDk/gMvEz1I5eTZznitvy2enZWGL3hm0B/+Fac5AWPJTOuOmxFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+RmjBO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0924C19425;
	Sat, 28 Feb 2026 17:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301465;
	bh=GmsVpxpNT/LPNenninbLyr63BYxl7iMmqbgXl29Fmfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+RmjBO5fV8TXhYHNHsE/mY/twx9SuCmCw7yHCCARkfZE3XFiPWv4xBbCzDYjdWBJ
	 rCE0w3EWMBME82hTjctQqA9sWhO7aZsXIHJRkyG7PhaNb94MH81CyhLYkr7mzSJTBc
	 oZ1TBYj+HWTXwp/Iy6p8ewx+N91MgExo4fUJxZnFwFnzOSOr+WunBcVCYTnLIQEh8M
	 6sxYqi7Wzg+zGj7orUUgVsp/jMgAOcvDDIyJAZCS81+UrvS3WCsCGkIyfemgtB8Btz
	 uQt8kEtzzoSpWWaVy+4KJIlte5sFyoL4ABhtWWcCIj3Gg31kDwJcT/mWUX5+cYe//0
	 XmhnjvzRD/9/g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Breno Leitao <leitao@debian.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 650/752] uprobes: Fix incorrect lockdep condition in filter_chain()
Date: Sat, 28 Feb 2026 12:46:01 -0500
Message-ID: <20260228174750.1542406-650-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221115-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 02AD41C8332
X-Rspamd-Action: no action

From: Breno Leitao <leitao@debian.org>

[ Upstream commit a56a38fd9196fc89401e498d70b7aa9c9679fa6e ]

The list_for_each_entry_rcu() in filter_chain() uses
rcu_read_lock_trace_held() as the lockdep condition, but the function
holds consumer_rwsem, not the RCU trace lock.

This gives me the following output when running with some locking debug
option enabled:

  kernel/events/uprobes.c:1141 RCU-list traversed in non-reader section!!
    filter_chain
    register_for_each_vma
    uprobe_unregister_nosync
    __probe_event_disable

Remove the incorrect lockdep condition since the rwsem provides
sufficient protection for the list traversal.

Fixes: cc01bd044e6a ("uprobes: travers uprobe's consumer list locklessly under SRCU protection")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260128-uprobe_rcu-v2-1-994ea6d32730@debian.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index f11ceb8be8c41..4f42e7af575f5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1138,7 +1138,7 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	bool ret = false;
 
 	down_read(&uprobe->consumer_rwsem);
-	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
+	list_for_each_entry(uc, &uprobe->consumers, cons_node) {
 		ret = consumer_filter(uc, mm);
 		if (ret)
 			break;
-- 
2.51.0


