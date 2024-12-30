Return-Path: <stable+bounces-106344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFF99FE7F1
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FA160BFB
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF187156678;
	Mon, 30 Dec 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yFzxzA+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6515E8B;
	Mon, 30 Dec 2024 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573654; cv=none; b=Nm9XML8vQudJtU1HdZLjzuh0s8OqIi4LW5/4hVt37yGrxU/WQq9eJqwAlEFqAiM9IpugtZyTQugA/WduSCWspjQ1Rmz2F4sUy0WNjx9Q442T2r0Wup9399KxhRRbKeflaowdflOKfB9nYRESNlrMueAzqGYj65o3het6YmtX5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573654; c=relaxed/simple;
	bh=eIhvDiwqWhDzVE9a2wEUNtyCKxpGg0xsycqx7rB6eBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZzpjxw22VUWKSGeVK7XKT/iVoJIwm3PuOSM5w/HtZ9pOW0xmbPgdfZWyiVL9XgF0qgatFoKu/P2oGl6emnD3m36DCLlLhsokI6nj2+J+vlBDLVuKh6O5OQyWCm3XDMWNSKAJn/gKtXwTIr0Eva/CzMh4jEp+8C6o5NaNgE2U94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yFzxzA+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD18C4CED0;
	Mon, 30 Dec 2024 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573654;
	bh=eIhvDiwqWhDzVE9a2wEUNtyCKxpGg0xsycqx7rB6eBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yFzxzA+XwEA+68E9Pb82ZTLagikKDKnq6eCltvg7c6Brq9pZsqF1K7TJDP9RvD+b2
	 RjthR1ZcSjM2Z0OgBZZLv4BdF/veUqHKg8ucsh+Vbk7zqcUXuyKT2L13vhBAzxmuBH
	 MiUkPhOg5slccJ+610R6x/m/SLq7bCkMUzDwC35g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 26/60] tracing/kprobe: Make trace_kprobes module callback called after jump_label update
Date: Mon, 30 Dec 2024 16:42:36 +0100
Message-ID: <20241230154208.279907454@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit d685d55dfc86b1a4bdcec77c3c1f8a83f181264e ]

Make sure the trace_kprobe's module notifer callback function is called
after jump_label's callback is called. Since the trace_kprobe's callback
eventually checks jump_label address during registering new kprobe on
the loading module, jump_label must be updated before this registration
happens.

Link: https://lore.kernel.org/all/173387585556.995044.3157941002975446119.stgit@devnote2/

Fixes: 614243181050 ("tracing/kprobes: Support module init function probing")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8657c9b1448e..72655d81b37d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -702,7 +702,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 
 static struct notifier_block trace_kprobe_module_nb = {
 	.notifier_call = trace_kprobe_module_callback,
-	.priority = 1	/* Invoked after kprobe module callback */
+	.priority = 2	/* Invoked after kprobe and jump_label module callback */
 };
 
 static int count_symbols(void *data, unsigned long unused)
-- 
2.39.5




