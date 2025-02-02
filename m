Return-Path: <stable+bounces-111945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DA7A24CEB
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F261653DE
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BA1D7E2F;
	Sun,  2 Feb 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="KmHsaxVC"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E211D6DCC
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482631; cv=none; b=dzVWknLV9vGHdx4yCc/RzJGeiBAUE6Stp/r05ZUpxqBAraIvBxzpq47YrTfVgzkmFpPJchHN5lKodJXAvGOEy20Qoh4V4FBe2xZYfXKAGv7mUBOzOKgeO27qMSWSMySx99UbzrJMgrsgUAn3tvZ1H6gxbT7hB7chA7HYU6xDRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482631; c=relaxed/simple;
	bh=ct4FVMAhR3QrzY31JTgnzGPReYFrJVc3mEqKmQgn9CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC+pWV4C/+JAUAicLEFsNnPG/Llq4mlhkF/FvYa/0N/r+Sr6unVhW/zgHVuZX6yBB9xpj9pGNht8fAZFnE2thp0GoDOoLaBdn6RnN9pudPhPvZLLeGc1jh6bQxZObvnGWqAnqJceb4lEOf9FAYCKXpyQgq0xAZ6LyliueNkwyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=KmHsaxVC; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 996371C2423
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 10:50:27 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482627; x=1739346628; bh=ct4FVMAhR3QrzY31JTgnzGPReYF
	rJVc3mEqKmQgn9CA=; b=KmHsaxVC3YGDMpeEDL9OWW93n2QMs7HEQxmoB1cw4LO
	WiU/qWLXRUM/R28u4kHQI34DDKoxOvIhzBh83ixZpMRvefWotTJBrFkMM28vColf
	99clrEx1gP63uL+N/+cepieK3h5WVkzNOo/VDSUPtYxssTCbora7jPWCZNDc8r9A
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RmPVDhQV-DQ3 for <stable@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:27 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 6FD1E1C2429;
	Sun,  2 Feb 2025 10:50:17 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 06/16] bpf: Factor out inc/dec of active flag into helpers.
Date: Sun,  2 Feb 2025 07:46:43 +0000
Message-ID: <20250202074709.932174-7-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

commit 18e027b1c7c6dd858b36305468251a5e4a6bcdf7 upstream.

Factor out local_inc/dec_return(&c->active) into helpers.
No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230706033447.54696-6-alexei.starovoitov@gmail.com
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 0f45ea4259cb..5c4e54e17f95 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -154,17 +154,15 @@ static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
 #endif
 }
 
-static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+static void inc_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
-	unsigned long flags;
-
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		/* In RT irq_work runs in per-cpu kthread, so disable
 		 * interrupts to avoid preemption and interrupts and
 		 * reduce the chance of bpf prog executing on this cpu
 		 * when active counter is busy.
 		 */
-		local_irq_save(flags);
+		local_irq_save(*flags);
 	/* alloc_bulk runs from irq_work which will not preempt a bpf
 	 * program that does unit_alloc/unit_free since IRQs are
 	 * disabled there. There is no race to increment 'active'
@@ -172,13 +170,25 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
 	 * bpf prog preempted this loop.
 	 */
 	WARN_ON_ONCE(local_inc_return(&c->active) != 1);
-	__llist_add(obj, &c->free_llist);
-	c->free_cnt++;
+}
+
+static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+{
 	local_dec(&c->active);
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(flags);
 }
 
+static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
+{
+	unsigned long flags;
+
+	inc_active(c, &flags);
+	__llist_add(obj, &c->free_llist);
+	c->free_cnt++;
+	dec_active(c, flags);
+}
+
 /* Mostly runs from irq_work except __init phase. */
 static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
@@ -295,17 +305,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 	int cnt;
 
 	do {
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_save(flags);
-		WARN_ON_ONCE(local_inc_return(&c->active) != 1);
+		inc_active(c, &flags);
 		llnode = __llist_del_first(&c->free_llist);
 		if (llnode)
 			cnt = --c->free_cnt;
 		else
 			cnt = 0;
-		local_dec(&c->active);
-		if (IS_ENABLED(CONFIG_PREEMPT_RT))
-			local_irq_restore(flags);
+		dec_active(c, flags);
 		if (llnode)
 			enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
-- 
2.43.0


