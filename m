Return-Path: <stable+bounces-187675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6FBEAEEB
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E76F7585627
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22B2E9EBC;
	Fri, 17 Oct 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/hY72eo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772CD2EB5C8;
	Fri, 17 Oct 2025 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720035; cv=none; b=XrJufG0Ngse4vn/s7BCd7asHtFXgYgh5YVCB1ZjUcnGjEali6rpxI2D05i+Sc2qYAp9vFWNh+fxQIvFzA89gmV2rJGqaIOCmDNSVaO+wLp7Xp3A4qoO6fzMnbhjcTyNYelcskDpq6+LHWMg46gCsJhfIUk/K9QwTVDrZBFpqggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720035; c=relaxed/simple;
	bh=xJEp87cP8YctFoabS5BEu8FdvJkbWM5F1W3Z88WRGyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B40iphHgqkGeTC4Yf76m6cc9eY7dGvhDYBhaHQLbJSOdzfRJ3xugeAu0e40MeYsLjB9dVjAiCbTGcmMBPU/RWU2I+70W0HXy/D9r4BnA0JJ8Jh/MWqP7BQmIkAO6UGHPbP5wwWZtxR+acmhmRsg7+0Z9RRYrmrzvnvXdNjQyg5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/hY72eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83616C116C6;
	Fri, 17 Oct 2025 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760720035;
	bh=xJEp87cP8YctFoabS5BEu8FdvJkbWM5F1W3Z88WRGyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/hY72eorFpum9ri2RbgI41VJ2sAWU19LWX7owGh/oLiajZS9437K64n7vDWvuiXv
	 tHaLGA0AN4e8zmV8q/18ODOdjEZcOZ14Nj2cpMQkModgw8SQUwWOe9s6WtkdHBe/+O
	 QRfggsqw5RJ8CVb2kVgSX+IGAsvGcg2tS28AfNCXt++s6EWT/SHjWGcoKCTwawP8FL
	 KQh+MIJJGGx2P0qgK7B66hj5UP+BNTFBlAN3t1scb/6h5pVZTIKVzwoF7J8VFgo4ix
	 3bKLV/P/4+Mxyh5Blx9gEeIUznlxXdfdCwLCjbtgnpOPPFxJI4KK5iE1gFyRqC+3f1
	 jYacP0bZWNWdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 18:53:27 +0200
Subject: [PATCH 5.10.y 3/3] tracing: fix declaration-after-statement
 warning
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-v5-10-gcc-15-v1-3-cdbbfe1a2100@kernel.org>
References: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
In-Reply-To: <20251017-v5-10-gcc-15-v1-0-cdbbfe1a2100@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Douglas Raillard <douglas.raillard@arm.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xJEp87cP8YctFoabS5BEu8FdvJkbWM5F1W3Z88WRGyQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+lcz0Xb0m8Dqf4AnPT9xLHSRTJ920zN3dp6iqlbG0p
 iJL85ZlRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQK7zD8T9g1Md/ZVIl/x9m2
 rbcXZZr6bJSWnrzI2+5N/zPd/dm+ExgZ3idPeRemU+zKo9n9r4NblWXRXpZ9XPKn7upI7P2wLn0
 mPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When building this kernel version this warning is visible:

  kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
  kernel/trace/trace_events_synth.c:847:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    847 |         int ret = trace_event_reg(call, type, data);
        |         ^~~

This can be easily fixed by declaring 'ret' earlier.

This issue is visible in < v5.18, because -std=gnu89 is used by default,
see commit e8c07082a810 ("Kbuild: move to -std=gnu11").

Please note that in v5.15.y, the 'Fixes' commit has been modified during
the backport, not to have this warning. See commit 72848b81b3dd
("tracing: Ensure module defining synth event cannot be unloaded while
tracing") from v5.15.y.

Fixes: 21581dd4e7ff ("tracing: Ensure module defining synth event cannot be unloaded while tracing")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Douglas Raillard <douglas.raillard@arm.com>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/trace/trace_events_synth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 613d45e7b608..b126af59e61c 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -831,6 +831,7 @@ static int synth_event_reg(struct trace_event_call *call,
 		    enum trace_reg type, void *data)
 {
 	struct synth_event *event = container_of(call, struct synth_event, call);
+	int ret;
 
 	switch (type) {
 #ifdef CONFIG_PERF_EVENTS
@@ -844,7 +845,7 @@ static int synth_event_reg(struct trace_event_call *call,
 		break;
 	}
 
-	int ret = trace_event_reg(call, type, data);
+	ret = trace_event_reg(call, type, data);
 
 	switch (type) {
 #ifdef CONFIG_PERF_EVENTS

-- 
2.51.0


