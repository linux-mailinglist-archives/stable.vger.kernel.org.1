Return-Path: <stable+bounces-9275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819D823156
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B371C21361
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF34429;
	Wed,  3 Jan 2024 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b="ygI4SmHm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+thl+O8"
X-Original-To: stable@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CB1D525
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=in04.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in04.sg
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8DACF3200B1B;
	Wed,  3 Jan 2024 11:34:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Jan 2024 11:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in04.sg; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1704299657; x=
	1704386057; bh=j4dNnqD7pnbuB3wSt8KFsF+jfKyusVvnspDdII7byZY=; b=y
	gI4SmHmsUk1jilqxK8RfHWw98yG8WaefnkKYN1s14zV9r2ikaS4uFgLnobYaoZpx
	cg/xI5DgOaEzaQHNSEKC70tQYaFZQfCiiKH+cuXV/sZ0ZrfVOomz2r2vlrtI4s2r
	tF1+Oi5Yvbr7EcUAiFh1r1w7de4EfennH0s1Bm1Y1JApkPYgPXVu4r9L8JQCb3gy
	p+LF/SwgS8HQunVcq2FEF6gwbPNV7WjhhuolYQde5exJ2gb+3+42mNjmc7gyT3MA
	EQq39UNlzoVf7s9xHl+orB2urDPYEyXtgFOM6jP9qqO9+Ez8XTiWS3c7pu5deDXu
	F5LYlP+gwgak8inlFOgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704299657; x=
	1704386057; bh=j4dNnqD7pnbuB3wSt8KFsF+jfKyusVvnspDdII7byZY=; b=C
	+thl+O8L4QdzZzhBLlWoowv0GvEbTKIMzf2EeLdn5c+WWEmfATLp+UDnbJGLtIzW
	iWM0Rdms5KA8PyZU9hLT1TYD8ydzLqHe+JV68e+wYADwfld4wRBC08uKGd7JWyZJ
	VXf1b9xQk4HyiSm4R9bVkStm7xwLU7BPQYChgCTZ4Gh9Qni64IKaNyX2WxEr/12e
	zptSwzBSL5vPhhOKMzL+8RhpNdjLQXkbBjVx8xINF6NTlYXNVX+snA0BFtvkNWJh
	J8Vgo3hv20HG4cFvgKLCLCqJvezrH92VXBdQ+rVOIGaibrTsMvLi6Tzb8ADsyWWD
	FpmF9EXxGn02kh9qitM7g==
X-ME-Sender: <xms:iIyVZcRVPAUK8MQ0_VePvgBY2GjceDSD1anPjFe-e3jPFELSdcxJXQ>
    <xme:iIyVZZy4ZMCemv4ZJCcigtWuInaIsr6iGzlicNlJH8c8bSkz1KBMvQ6uxo-K2f7dh
    5TZYoJIX9inkXW5obA>
X-ME-Received: <xmr:iIyVZZ0a79cMBqsvq-v9Kw5j-Am5RLKCMOP1TRDLy8kzjRHLJJuQ0NWu25uRp21X0Af-ytiK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgrohcu
    hggvihcuvfgvvgcuoegrnhhgvghlshhlsehinhdtgedrshhgqeenucggtffrrghtthgvrh
    hnpeetudejfefhjedvgeeulefgkeelueduledtudeijeetfeffkefhvdekfedvueelfeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnghgvlhhslhesihhntdegrdhsgh
X-ME-Proxy: <xmx:iIyVZQDPVrbL-GZ6QuEPsDYtnE2Pi17PxGJ_86ek90Tm0iJyVT108w>
    <xmx:iIyVZVjnM7GXdWsF1zquLZQoZQ79BjRF-z3lV6WJfI6POuxnOKRTRQ>
    <xmx:iIyVZcos-Sp4Qan9cYtlYAZWKxhYiCbnuvF-HQw9MyzrOJIsXow43g>
    <xmx:iYyVZTYQZbC6MFMoM1Z3HbUPuD7f0ZYp7aaQW9QJiUlv8_JmWf5qBQ>
Feedback-ID: id6914741:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 11:34:14 -0500 (EST)
From: Hao Wei Tee <angelsl@in04.sg>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Song Liu <song@kernel.org>,
	Hao Wei Tee <angelsl@in04.sg>
Subject: [PATCH v2 6.1.y] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Thu,  4 Jan 2024 00:33:19 +0800
Message-ID: <20240103163350.18573-2-angelsl@in04.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024010101-stabilize-geography-7d63@gregkh>
References: <2024010101-stabilize-geography-7d63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

commit 926fe783c8a64b33997fec405cf1af3e61aed441 upstream.

Recent changes to count number of matching symbols when creating
a kprobe event failed to take into account kernel modules. As such, it
breaks kprobes on kernel module symbols, by assuming there is no match.

Fix this my calling module_kallsyms_on_each_symbol() in addition to
kallsyms_on_each_match_symbol() to perform a proper counting.

Link: https://lore.kernel.org/all/20231027233126.2073148-1-andrii@kernel.org/

Cc: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Hao Wei Tee <angelsl@in04.sg>
---
Fixed for 6.1. Please cherry-pick 73feb8d5fa3b755bb51077c0aabfb6aa556fd498 too.

Sorry for the bad patch originally. I had a mixup..

 kernel/trace/trace_kprobe.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a34a4fcdab7b..e3993d19687d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,31 @@ static int count_symbols(void *data, unsigned long unused)
 	return 0;
 }
 
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name,
+			     struct module *module, unsigned long unused)
+{
+	struct sym_count_ctx *ctx = data;
+
+	if (strcmp(name, ctx->name) == 0)
+		ctx->count++;
+
+	return 0;
+}
+
 static unsigned int number_of_same_symbols(char *func_name)
 {
-	unsigned int count;
+	struct sym_count_ctx ctx = { .count = 0, .name = func_name };
+
+	kallsyms_on_each_match_symbol(count_symbols, func_name, &ctx.count);
 
-	count = 0;
-	kallsyms_on_each_match_symbol(count_symbols, func_name, &count);
+	module_kallsyms_on_each_symbol(count_mod_symbols, &ctx);
 
-	return count;
+	return ctx.count;
 }
 
 static int __trace_kprobe_create(int argc, const char *argv[])
-- 
2.43.0


