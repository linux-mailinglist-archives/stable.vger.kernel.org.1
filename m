Return-Path: <stable+bounces-27409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA4878A15
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 22:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3274E2812D6
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87F57306;
	Mon, 11 Mar 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzdvbGSF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4356B7F
	for <stable@vger.kernel.org>; Mon, 11 Mar 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192634; cv=none; b=juh2j6vqtel5DE7ltF/FKkzRtmq+W3SZ73sFgFIMt17Qs6YGJ/1KsJNI0vqHy1rj3ozLlMLfJC3KqIkAQyk2eDLqx2R1RpSOnDZXXJ8yMhrHfxM01N2U71MXveiK1WsiuQidtIL+/9tbLKPMpxtdfOx1oYJl7mlVtV+xk7m4Znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192634; c=relaxed/simple;
	bh=/zZCg2VL8iscJ6/2we7zHLH/zzerOeviN7D4y8YDfes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z5ZSXT1BnFBsW9nv0bK8IzevlP4ub09+cLCLpSpK+8X5wv13bfXMdX8fBffXi/Qzbw35OhsDCKTEb09CP1Y+HZI6DWZH00UPBDsQmmEIp2jigfnFgMTYA9ndm1bpBatwUR9MOixgvbwZ9KMNB3as5pPyuQYCOMFbmqJQY7NgEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzdvbGSF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dd96cc4476so12321775ad.1
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710192632; x=1710797432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGZmnQJ9Zo842qcnXNiY8ufSz2Us7GgEGfjjy9ti7qk=;
        b=zzdvbGSFvd0NDIe9+GuSoBn8nD3UzYIs9x/Wa99p3HipiEsF8d8Nw+eOsV8TEIa2px
         DwUYMWQeUDXEWoX/n6/ed2RkbezCUDy8IikAOGAyXsPu/AnYvC9NSDr8vqfjgfyj5Xv9
         odLYV5e0w3/aA2vtoWqIUy91urYykh+wtuVC3snHclDL8X+uMvbmxTl6KeZY+g7veAuE
         GhCnCnjarYeH83Wz1/3XuH90cbK/dv+NYs3Sjq9AznqhjOMk4saLcJqsh0sheCh+LjSm
         AmN7sIK5HhipXl1XmofLYnasroFX0+WBpM/N/3aojgqudlszOmNL+GvxWsqnoLndimHY
         MkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710192632; x=1710797432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGZmnQJ9Zo842qcnXNiY8ufSz2Us7GgEGfjjy9ti7qk=;
        b=k4B1pQ7/lkamNwLj5VBuuvEZe95fzv/7pp7mACgjBV8vRiit6jz/CR9ctj5tbd1zLs
         QMaZZ5xRSBsSPGzRrur0y30sC5Y4e402Cj0DdR173h/y/3DtmtGaO7HAObfI2jpsdo0y
         c+cE/T/LYnUYiqJVsmVtvU+bOu5qjDnTNVdNz4y7DF1VBHsvJMyh+WzwHUnAAsqgknuO
         jPafxKgPIlCNjmq4Sti8VPn85KV+yVum0F93T9Bowa1Ur+j+byhaQEVuekCp/UFhfCMb
         8k/J/kPZblBdsOfKp2uHgrz+TjXJJXz/Ol4YSrJGUgrLFsYrgcnwL5VEEBMyN5OeQjrg
         bEGw==
X-Gm-Message-State: AOJu0YwU5gyi5DbNsKNk2tqKhTwfcm/f31WwrT01TH0o4AL6/JemTtaq
	WdFY1anjaffd4NqTiGIgJIz80T7SMQSUj2JPjlO48a+uHJG/Wg63GoX4XYCAw1rrg5krcmiCYbK
	8DUXEOwb3BtbqlHuDyborAYrbps0cAu0L0LeFxO+2YjXxseMYlzYH9M6qDQS7X04sFz4iqJmIc7
	/ZbBR9nzgJ5Z4AgqX+PGGsz4WUKiYkBSD1nE8PRjfRE6EXc1X5+cd/NoilFg==
X-Google-Smtp-Source: AGHT+IEpVvnlHZ2pX3MWjMFBjAk02ZfhkXhujb9rPfcdm5HQ1JMd8wK7VvxYzYn/wYL2Y/3jba/h2ehr0+e8LluwBw==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a17:902:f945:b0:1dd:b3fe:b2cb with
 SMTP id kx5-20020a170902f94500b001ddb3feb2cbmr47529plb.8.1710192632379; Mon,
 11 Mar 2024 14:30:32 -0700 (PDT)
Date: Mon, 11 Mar 2024 14:30:21 -0700
In-Reply-To: <cover.1710187165.git.rkolchmeyer@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1710187165.git.rkolchmeyer@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <5ada1efa030b25b2a7e8a4181f74597361803506.1710187165.git.rkolchmeyer@google.com>
Subject: [PATCH v5.15 1/2] rcu-tasks: Provide rcu_trace_implies_rcu_gp()
From: Robert Kolchmeyer <rkolchmeyer@google.com>
To: stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Hou Tao <houtao@huaweicloud.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Sasha Levin <sashal@kernel.org>, 
	Robert Kolchmeyer <rkolchmeyer@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit e6c86c513f440bec5f1046539c7e3c6c653842da ]

As an accident of implementation, an RCU Tasks Trace grace period also
acts as an RCU grace period.  However, this could change at any time.
This commit therefore creates an rcu_trace_implies_rcu_gp() that currently
returns true to codify this accident.  Code relying on this accident
must call this function to verify that this accident is still happening.

Reported-by: Hou Tao <houtao@huaweicloud.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Link: https://lore.kernel.org/r/20221014113946.965131-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 876673364161 ("bpf: Defer the free of inner map when necessary")
Signed-off-by: Sasha Levin <sashal@kernel.org>
(cherry picked from commit 10108826191ab30388e8ae9d54505a628f78a7ec)
Signed-off-by: Robert Kolchmeyer <rkolchmeyer@google.com>
---
 include/linux/rcupdate.h | 12 ++++++++++++
 kernel/rcu/tasks.h       |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 13bddb841ceb..e3b12de36e92 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,6 +205,18 @@ static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
+/**
+ * rcu_trace_implies_rcu_gp - does an RCU Tasks Trace grace period imply an RCU grace period?
+ *
+ * As an accident of implementation, an RCU Tasks Trace grace period also
+ * acts as an RCU grace period.  However, this could change at any time.
+ * Code relying on this accident must call this function to verify that
+ * this accident is still happening.
+ *
+ * You have been warned!
+ */
+static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
+
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 28f628c70245..b24ef77325ee 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1098,6 +1098,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
-- 
2.44.0.278.ge034bb2e1d-goog


