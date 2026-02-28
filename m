Return-Path: <stable+bounces-220780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI9nKulDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C61C7301
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54E60308F550
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC8F40A8E4;
	Sat, 28 Feb 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCKXmY32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDAD492537;
	Sat, 28 Feb 2026 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300664; cv=none; b=JsUBNLBpZ68wBdtHzO1EglwiBRLs/NvyAZCUsTMULuPbDFaBIbgZL5XaJj4n0Q/ZCMizTcHdIDzON1E4iOQ+2WIz39i5vl44OgNiboSLRNaAxt1f0696Fj4RruhrFx/14ABOS25eaQiAbhqadjvIWOy+8+1o+6lY/++GA8ypBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300664; c=relaxed/simple;
	bh=l6graGhs00TKyzQLpbf68cfiC+x52l/KmoX1tNaXKPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+Gg+oATAqeFwEAI5p2MI8ljrLZzQT0X/+00ogLziC52sQ9zbKK8yEAS12NPo4V62QLYtcMHPlVJBzSqNvsHqEOEGbBEo2UntMPNXNYUcP9Cn2Ex+KbEFmLYMW+3tUBYxr53Z4XptEeFQT6E1nDod0JVY/an+UnMHNSinILXhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCKXmY32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE9C116D0;
	Sat, 28 Feb 2026 17:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300664;
	bh=l6graGhs00TKyzQLpbf68cfiC+x52l/KmoX1tNaXKPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCKXmY32G/PoOXBn4L62OS3iVA+azj7WYaiVal6b3xvmV8NMa190WNTyQfjZ9xjaw
	 YZ/mjfkpFLwZUnseSK874Kl6H4SbkRktYJ+vS1jz+Q9YBSbu1kr/xnBqHCq8eR6RG+
	 KYIXHqzryhZGyYKwCAye0JWdTcB4SthN0PQpfzETVt7sfu3NrhLMk3Xqw+Zn7gJtRs
	 Yvyf62rdt9qpkTFfqN57uWAK5Z+lXBwJGVEzOSQpvFlXT/h/M5aXg7QlR5lr1mUOMc
	 JmdiPa4o4YcRQNccv/ohgvngHseLyxMuCN1GedDO97ta6eSf8AAKK4d2x9nY8lDJW1
	 PrBRCPNLTzzsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d8d4c31d40f868eaea30@syzkaller.appspotmail.com,
	Uladzislau Rezki <urezki@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 701/844] mm/vmalloc: prevent RCU stalls in kasan_release_vmalloc_node
Date: Sat, 28 Feb 2026 12:30:14 -0500
Message-ID: <20260228173244.1509663-702-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,sina.com,linux-foundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220780-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,d8d4c31d40f868eaea30];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,linux-foundation.org:email,sina.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 5A1C61C7301
X-Rspamd-Action: no action

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit 5747435e0fd474c24530ef1a6822f47e7d264b27 ]

When CONFIG_PAGE_OWNER is enabled, freeing KASAN shadow pages during
vmalloc cleanup triggers expensive stack unwinding that acquires RCU read
locks.  Processing a large purge_list without rescheduling can cause the
task to hold CPU for extended periods (10+ seconds), leading to RCU stalls
and potential OOM conditions.

The issue manifests in purge_vmap_node() -> kasan_release_vmalloc_node()
where iterating through hundreds or thousands of vmap_area entries and
freeing their associated shadow pages causes:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu: Tasks blocked on level-0 rcu_node (CPUs 0-1): P6229/1:b..l
  ...
  task:kworker/0:17 state:R running task stack:28840 pid:6229
  ...
  kasan_release_vmalloc_node+0x1ba/0xad0 mm/vmalloc.c:2299
  purge_vmap_node+0x1ba/0xad0 mm/vmalloc.c:2299

Each call to kasan_release_vmalloc() can free many pages, and with
page_owner tracking, each free triggers save_stack() which performs stack
unwinding under RCU read lock.  Without yielding, this creates an
unbounded RCU critical section.

Add periodic cond_resched() calls within the loop to allow:
- RCU grace periods to complete
- Other tasks to run
- Scheduler to preempt when needed

The fix uses need_resched() for immediate response under load, with a
batch count of 32 as a guaranteed upper bound to prevent worst-case stalls
even under light load.

Link: https://lkml.kernel.org/r/20260112103612.627247-1-kartikey406@gmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: syzbot+d8d4c31d40f868eaea30@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8d4c31d40f868eaea30
Link: https://lore.kernel.org/all/20260112084723.622910-1-kartikey406@gmail.com/T/ [v1]
Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vmalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e286c2d2068cb..ea24ee957605e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2268,11 +2268,14 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 	reclaim_list_global(&decay_list);
 }
 
+#define KASAN_RELEASE_BATCH_SIZE 32
+
 static void
 kasan_release_vmalloc_node(struct vmap_node *vn)
 {
 	struct vmap_area *va;
 	unsigned long start, end;
+	unsigned int batch_count = 0;
 
 	start = list_first_entry(&vn->purge_list, struct vmap_area, list)->va_start;
 	end = list_last_entry(&vn->purge_list, struct vmap_area, list)->va_end;
@@ -2282,6 +2285,11 @@ kasan_release_vmalloc_node(struct vmap_node *vn)
 			kasan_release_vmalloc(va->va_start, va->va_end,
 				va->va_start, va->va_end,
 				KASAN_VMALLOC_PAGE_RANGE);
+
+		if (need_resched() || (++batch_count >= KASAN_RELEASE_BATCH_SIZE)) {
+			cond_resched();
+			batch_count = 0;
+		}
 	}
 
 	kasan_release_vmalloc(start, end, start, end, KASAN_VMALLOC_TLB_FLUSH);
-- 
2.51.0


