Return-Path: <stable+bounces-111946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DEA24CEF
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84F4165761
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599A1D88BE;
	Sun,  2 Feb 2025 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="AdbVu7ww"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A41D7E50
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482633; cv=none; b=kSDo9hcT83lAwboVofXNepuDQfAH8LW1sm04gRaNlxn/fIY8RX6OoHMdg5lqb33XexIlsApKCDjgvVbCVI0jIpTsJuFdudMW+YcfhG37/sPQEUZGb5Hm+oIN43HkfvPEbPHK/5ZAihfOvF6IDDo4dyBx8uTYSHMFte8IxhCs2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482633; c=relaxed/simple;
	bh=tCfziVWVIUoiz7Lt4rzCRzkKuC5bIQB1vwIhu12RM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuJOl3G9fOitFmstt/7JqpffJ15hpFrwzy2xGBx4NFeHllQ6d7oPSmEUOfJtmVLVTDf4BG1tanEVTNG+DhRCCPyILqLid6pOz6gX3SLXI0VJ51c7dlzPf2NMdVs6PtQmav2hSsLhfzIs/uoFOBCWQ5hPkvC2bU6gw5XCNm4+L0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=AdbVu7ww; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 4ADC11C19DD
	for <stable@vger.kernel.org>; Sun,  2 Feb 2025 10:50:30 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482629; x=1739346630; bh=tCfziVWVIUoiz7Lt4rzCRzkKuC5
	bIQB1vwIhu12RM+E=; b=AdbVu7wwTfoQ7AGVZLYeGxf6GvQ+4q4AW7MVVrsyR3+
	EP3y0j5qR2MCC9bw/2hush/AeVQ8bwUYEOuefW73BAOSXjG68U1MBjzH1zgQW/ie
	I5QlNOBJltdeEPKz5Zj6M+OBV7NbRSPAI3rlpEGGquzEk9VRYGq9kS+EtGqCjW0Q
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lXkULYvcz219 for <stable@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:29 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 673A51C2443;
	Sun,  2 Feb 2025 10:50:18 +0300 (MSK)
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
Subject: [PATCH 6.1 07/16] bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator
Date: Sun,  2 Feb 2025 07:46:44 +0000
Message-ID: <20250202074709.932174-8-sdl@nppct.ru>
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

From: Hou Tao <houtao1@huawei.com>

commit 59be91e5e70a1aa91dfee8088b071f6d05c8a1a3 upstream.

The memory free logic in bpf memory allocator chains a RCU Tasks Trace
grace period and a normal RCU grace period one after the other, so it
can ensure that both sleepable and non-sleepable programs have finished.

With the introduction of rcu_trace_implies_rcu_gp(),
__free_rcu_tasks_trace() can check whether or not a normal RCU grace
period has also passed after a RCU Tasks Trace grace period has passed.
If it is true, freeing these elements directly, else freeing through
call_rcu().

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20221014113946.965131-3-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/memalloc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 5c4e54e17f95..9a4fb4ea73ef 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -261,9 +261,13 @@ static void __free_rcu(struct rcu_head *head)
 
 static void __free_rcu_tasks_trace(struct rcu_head *head)
 {
-	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
-
-	call_rcu(&c->rcu, __free_rcu);
+	/* If RCU Tasks Trace grace period implies RCU grace period,
+	 * there is no need to invoke call_rcu().
+	 */
+	if (rcu_trace_implies_rcu_gp())
+		__free_rcu(head);
+	else
+		call_rcu(head, __free_rcu);
 }
 
 static void enque_to_free(struct bpf_mem_cache *c, void *obj)
@@ -292,8 +296,9 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
 		 */
 		__llist_add(llnode, &c->waiting_for_gp_ttrace);
 	/* Use call_rcu_tasks_trace() to wait for sleepable progs to finish.
-	 * Then use call_rcu() to wait for normal progs to finish
-	 * and finally do free_one() on each element.
+	 * If RCU Tasks Trace grace period implies RCU grace period, free
+	 * these elements directly, else use call_rcu() to wait for normal
+	 * progs to finish and finally do free_one() on each element.
 	 */
 	call_rcu_tasks_trace(&c->rcu_ttrace, __free_rcu_tasks_trace);
 }
-- 
2.43.0


