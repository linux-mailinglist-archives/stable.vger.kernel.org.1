Return-Path: <stable+bounces-200786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC2CB56FB
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DBE30194F3
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF572FB0A9;
	Thu, 11 Dec 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRXx8sO9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2166E32C8B
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447274; cv=none; b=VSm9Nh8oV+zr/L3KJdkzHg9yYzU3Ae+DN3AQhyBcm9Ol86F6v/vsSTQrt1hv/AVbnNDehNTlrJ7Y+HrSz7LLdE88iAFnptjNNOLiiOeGjW8Ti9I2LceE5NyoXBfq9h0iWSaOTk/uPAIek2NXlVr3K8t+jiZW8I9LSot9Ytib4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447274; c=relaxed/simple;
	bh=pVqkKjEXVMsrV1BoKv6j4NeN5cbUKVI6QzaVPeB0uR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spevN5qx1Q91Fa1wXxW90csOiTFqVLkUDd3GhRys/V8F7/LKEL9dekcNW7qk+wm3C4xStiXrtWazjDenPKzStjTnmUy0kCbmJE/GhgT0OhzM9/hrCKeM7KI8OxCMfHt5inr2AfHlM211ZIlPHPF+p4B+9nw+9bjHHynwZ+r3NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRXx8sO9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so655087b3a.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765447272; x=1766052072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxUAwgYNPZb3dBwYcv0C/4y2So0BODQraJ+2jRjaA7w=;
        b=BRXx8sO9DbfIf3MxVh3J1zO/pxQ2xGwAaS7mtZGEWPlSB36gUgFApqqLyer8GQtTyg
         I4hWJyDYQPFeC+KT0mouOjfGnkQqu8kYA6MfjtVY8RPISm4fJPrbaFpo7juSbe/tESwQ
         /p+07p3yOmeW8oPstwsP5NWEPl1nNw9NQa4i4sNHwtQMFd+kvGzEE7d42ZSZOm8jq8LY
         1N7A7IatW1yw5ztQA9QPcRN+HzUcIsyJRQfrxHtS0xOZPy3p1BHJl2c5kWydSsIQ6wkR
         yyOVSRtPEz41dBsjoCe86v+xIrKi3sYWag2iN3J8ITWF+vw/SS3RL9pJepWgd9gp6GeF
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765447272; x=1766052072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxUAwgYNPZb3dBwYcv0C/4y2So0BODQraJ+2jRjaA7w=;
        b=GPtLiBksXQuyrHKY81AXdtgcLOYPkRrMq+3v2+xvfVBT8OZlZPIlDNoKEpQmQjfz1U
         tLJ5Ei3YRJih86fVci274GMT0WtWXBaLf2aKrMiDRoGVC8HU6jhJAZ0/0KpAcSop8OlP
         y+QhIk2BN+DYUMgAiDz3AwdTmgpRP3KCrDIW3OQ1baKdU8f2qWUR7oXEvYuqMvny7e4S
         lCTMdiaRuJTBOoczIvVyo81Cjbook+kJL0iDazB1fVU7bDGq9smFy64Rw1HxBDON5bo1
         IRyFAE+bLzN75gTp0wPwQWZiwwpU4NJY/ZH1NBY02lOPceOB0H5VSNCurlU9GIPFR/8Y
         EdNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQYMUz0QKtQW07MeNS2z0MHNT3phg9lVPmbFkfECSWim3K5YwEqmJ4ZpticVYezivlXTqazHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzKebmEFhNk1xlH3aeKJynVP669lBPJqngZgogg0W6vH6U4RA
	xT0mMhdEwYHUjXn0sDlhXsch2mJdSNqABJ8BvR8GYkgG7GoW+g9VLMIH
X-Gm-Gg: AY/fxX4AmwF2kwY3ijaRQ6RAnPE1DYNOSG2P14H5HtLRTGiPZgZAfs7ARbJJgtHvfMq
	1wB2Xe3yQ6VCTrnuJQNpC/KIA8Oz2Lr52uwl/CNQx5vnQFxI5dVt76lGTHw5hsPsMRP0fF8MCs/
	uKtzX36zmhlFNxQhkH3sb2b/TP34gf0NjBz2woUn8se2BRhjBEqdiMFT3jm8KsOYipE0Iwh0iU9
	o+O8QAebw9Du249HhTayHTrVBNwlJXOp5Pmy+su1YLwQj6Vd3YOa1Vgoz7gxFEDrvmARkuVjrSO
	xHIThQxtCLREC9eyLohIs19y++dE2OQJ1EwZl0iKU18Eot/87ImaL4V3dcYxgf13jDtMzqjEejA
	zI/dbRp6zLcJ1xwz+2Zvbacuc9MvIftQuNU6tsiWGuCH49ezAAwbdVyu59cJ2jjMoVVxhDNI8Uz
	/81AhfTQjqRfhE
X-Google-Smtp-Source: AGHT+IE28P5MxEOst+lrzYcF5oWn2Bj1irMns/TapvB1X3yMs4xi6bm3rBPZTYcsNMKqPvxAsdI4cg==
X-Received: by 2002:a05:6a20:6a1b:b0:350:66b2:9729 with SMTP id adf61e73a8af0-366e2fc161dmr5264654637.60.1765447272165;
        Thu, 11 Dec 2025 02:01:12 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c0c2c48bf7asm1932653a12.32.2025.12.11.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:01:10 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix error handling in event_hist_trigger_parse
Date: Thu, 11 Dec 2025 14:00:58 +0400
Message-Id: <20251211100058.2381268-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocated with trigger_data_alloc() require trigger_data_free()
for proper cleanup.

Replace kfree() with trigger_data_free() to fix this.

Found via static analysis and code review.

Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() implementations use helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e6e70540eef..f9886fff7123 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6902,7 +6902,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	remove_hist_vars(hist_data);
 
-	kfree(trigger_data);
+	trigger_data_free(trigger_data);
 
 	destroy_hist_data(hist_data);
 	goto out;
-- 
2.25.1


