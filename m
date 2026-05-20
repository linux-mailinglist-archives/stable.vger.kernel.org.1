Return-Path: <stable+bounces-250147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOoZA0DkDWpk4gUAu9opvQ
	(envelope-from <stable+bounces-250147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:41:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D2A59241C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C29AA30E101A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2C3A4526;
	Wed, 20 May 2026 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqUlVWZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6336B059;
	Wed, 20 May 2026 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294667; cv=none; b=M7P9us3MnA4wLRGFWwLnr6uQsT9582ziEqK5jFtF6vUU7oRzssPZJMvZrDbOjhvM2xu/HCaUXG5qc9zDL9boSKKP6/hMSPuluslkye/t4oNzAElJmNfEunJj/3mYEuaA39jdDX109NX3UvSOp6JNcc51UvLsNUfpe3jWcxS2xqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294667; c=relaxed/simple;
	bh=7ArY9DvI2NqGMSp7YI5Y9XR+pDlMG42KciiJVdUMxGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l851uk4UaPlEgTXodB1l0WLNbxRdwhoch0ijSokSDZOU1vWCXvK0UYZbu2m8eVQuzbr8vUpam7v+6WBdSgIloNg83mEg9K6o3Yn04ndjtWDS14E4QjfAOK0bWcopIJJz3TBKfCElOpzs1yzmhQJs8qt9YL3X4yhVYbo+R7z9Ddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqUlVWZd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE70B1F00894;
	Wed, 20 May 2026 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294666;
	bh=08RQYYK0LVsBNxObKCQA9uLecFdUI5ul0cZe7LP4iU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqUlVWZdknUZCS9NGQDz1FQKx/B5WsW9Dey2MosYQl5dtQtJvYNrC0dBSNSAJJcZ5
	 qpbxGklDzuCM5ZhJs015WLcvhPC71oMvrfFojvq+fN3YqR1k//GfnWNQLoeopmOqKj
	 fAtjpZNkgJ0hsTr8zk8NQUaPw+Tarl1yVxK1IwTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0086/1146] bpf: Do not allow deleting local storage in NMI
Date: Wed, 20 May 2026 18:05:36 +0200
Message-ID: <20260520162150.297889922@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-250147-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A5D2A59241C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit 350de5b8a9befaa2a68861c51f671d4f5f751ca5 ]

Currently, local storage may deadlock when deferring freeing selem or
local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
in NMI or reentrant. Since deleting selem in NMI is an unlikely use
case, partially mitigate it by returning error when calling from
bpf_xxx_storage_delete() helpers in NMI. Note that, it is still possible
to deadlock through reentrant. A full mitigation requires returning
error when irqs_disabled() is true, which, however is too heavy-handed
for bpf_xxx_storage_delete().

The long-term solution requires _nolock versions of call_rcu. Another
possible solution is to defer the free through irq_work [0], but it
would grow the size of selem, which is non-ideal.

The check is only needed in bpf_selem_unlink(), which is used by helpers
and syscalls. bpf_selem_unlink_nofail() is fine as it is called during
map and owner tear down that never run in NMI or reentrant.

[0] https://lore.kernel.org/bpf/20260205190233.912-1-alexei.starovoitov@gmail.com/

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://patch.msgid.link/20260319025716.2361065-1-ameryhung@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81a..4c6079d2cf28d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -393,6 +393,9 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	unsigned long flags;
 	int err;
 
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return 0;
-- 
2.53.0




