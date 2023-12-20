Return-Path: <stable+bounces-8169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FD881A5DA
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 18:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC8F2824C8
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10946B9C;
	Wed, 20 Dec 2023 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=in04.sg header.i=@in04.sg header.b="RAAnNpbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FXUUj86v"
X-Original-To: stable@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A9A405F0
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=in04.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in04.sg
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C45855C092A;
	Wed, 20 Dec 2023 12:00:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 12:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in04.sg; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703091633; x=
	1703178033; bh=P0WZZcMcvbs6ChSrRz26hnvze7dRmdkX/niZLy4GqjY=; b=R
	AAnNpbIpBSVxcfWDAYs6n/hj9PG17RoOGIjPq4yMzQ1Ec+KU+7xs9TP2dPBaHx8A
	SmhOQ5akP6p5ensuS8A+CQn8vkSrJe5ekoKTSCsoH6xzZZNO6MBk/D10O1LA+asG
	4VFBM0FhvmY4tcLZu9cTvbJhikVu+kqrY0Dkzl5Tnrc6pZIOVQDyYKFUxwhkrkJf
	yTUoI45YgMQdN9mxz1hB4z6sB6hUqOY4WkzD8QPMGETq+Xx0+rXnxCu2z7Ff7LKS
	+ys8oGq4eQBNcy0LPidMXNqaghedf0c57JEg1V+3Q112BmSJO1VNQSzx5z0N+FPo
	DmbCz4m2fbxY1o2/xosrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703091633; x=
	1703178033; bh=P0WZZcMcvbs6ChSrRz26hnvze7dRmdkX/niZLy4GqjY=; b=F
	XUUj86vwZiU5CuNOHPIorAkIRfUYZmvcyWrnAEQLFJU0/xDI+t7uBUlAH1qPMTmI
	8lIoRXiC9yn/cb/bsggR+5898eVLGvSy7LCETOgji00JbJje6QizxFhcFOhymO6q
	au39CO+DYHYJf7nSs38o4gp+apra5T4OHp53t5qyxMEZa0L9N6ren88kFTgXV3fz
	bPM277/MEXAOwctwN9d0IOrULpCx7f/87pdIG7Q4ZU0xy0dITjm9GsOknGw9Yxi8
	ivf3zVJBsLp4wU/MKhj4wDklDntBrqyIjgVMN4FUdJdDWzW3FFnv0VFjAmWy76zS
	NNQz2q5/y9xxBJt4O4m5g==
X-ME-Sender: <xms:sR2DZdk6bTymVe25KKFoY4r5x9ihVu_Q3upZCD8UXbo88J9SKCfhsQ>
    <xme:sR2DZY0gY5PTnZC9NawOHtSffci7C05E1eansXAphGvADbV306HxWW_PTdG4p6I5e
    3SA-jZGkR9OfJ-yMZw>
X-ME-Received: <xmr:sR2DZTrizw-_u-yoUpfg-Tl5ULZTE75ALpao_C3uOJzAo66MEJnixOIVvTyhfjVyq0bwpoEYhS8u6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgrohcu
    hggvihcuvfgvvgcuoegrnhhgvghlshhlsehinhdtgedrshhgqeenucggtffrrghtthgvrh
    hnpeetudejfefhjedvgeeulefgkeelueduledtudeijeetfeffkefhvdekfedvueelfeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnghgvlhhslhesihhntdegrdhsgh
X-ME-Proxy: <xmx:sR2DZdnaHp_3piDrkK-aFEYxpxHFDD7iA7T1K5g5zGf1pqR4Oydwhw>
    <xmx:sR2DZb3oEaPVWy0Bk3t7WHuM8n9sf4spbilmhgXzZyUoYZdGt4sXGg>
    <xmx:sR2DZcuC3Hqoqmvx2XgRB1Ux0nQ3Z8I3oI6WQXPZg47Co-nDI6OTyA>
    <xmx:sR2DZWTcS_NQNjqI7m4ektWRi7UBEZTiAp-Oha6FZcqNxLl3eQBV0Q>
Feedback-ID: id6914741:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 12:00:31 -0500 (EST)
From: Hao Wei Tee <angelsl@in04.sg>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH 6.1.y] tracing/kprobes: Fix symbol counting logic by looking at modules as well
Date: Thu, 21 Dec 2023 01:00:16 +0800
Message-ID: <20231220170016.23654-1-angelsl@in04.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023102922-handwrite-unpopular-0e1d@gregkh>
References: <2023102922-handwrite-unpopular-0e1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

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
(cherry picked from commit 926fe783c8a64b33997fec405cf1af3e61aed441)
---
 kernel/trace/trace_kprobe.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a34a4fcdab7b..de11845df6d1 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -714,14 +714,30 @@ static int count_symbols(void *data, unsigned long unused)
 	return 0;
 }
 
+struct sym_count_ctx {
+	unsigned int count;
+	const char *name;
+};
+
+static int count_mod_symbols(void *data, const char *name, unsigned long unused)
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
+	module_kallsyms_on_each_symbol(NULL, count_mod_symbols, &ctx);
 
-	return count;
+	return ctx.count;
 }
 
 static int __trace_kprobe_create(int argc, const char *argv[])
-- 
2.43.0


