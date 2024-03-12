Return-Path: <stable+bounces-27416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2E878BFB
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBCDB21126
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36EE64F;
	Tue, 12 Mar 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7/zZIhL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431F63A
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710204300; cv=none; b=ZVNfW7W0IGD2W3Wn3ezkAJqzWcinc8oqSD5iJ9yuUAQJDOqNvZwuavu8I/wO1XLRQvrzBQtXHL/AShTr2qUPGbmlJGcD+bNLYC/WxGAWl9UREb/myhtPnF0f7wCo59Ee5WEI/v7xxzgUyc4twAzYz9NXUQIbyMniSWwcVmJNtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710204300; c=relaxed/simple;
	bh=AHlmMJkdvovEIexEy4unVPVQA523WujVlyGbBTZ2u1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t3ARr1z2gMHr9+lhWv7oK47DY+sXqDDdwplclK7c7PVmGlyVbsJ4jidNUfbsDF36XnTm5AuVfy3nEefIIy09Cfw6EetnqQMLIXtWAEj599O5KVhWy1OLF2IM+NNCeWPqrnKPLArLrWnnSqZo2Gzqv4LwOed9q5SMbBWzKDtXZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7/zZIhL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rkolchmeyer.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc657e9bdc4so1058837276.0
        for <stable@vger.kernel.org>; Mon, 11 Mar 2024 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710204298; x=1710809098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8eMIRZD/k0gFovShUK2UbDhWvueGs6TGvoJhXxJjP2A=;
        b=w7/zZIhLWE/U/s6yfQvPf9dCbwNJWwY35xubjXt9mbbaEo2ky2zOw+R9OKBGCL2J+C
         lD1LsQx8qqK1s3ys2tSZNpNtaPezrqv0xpW/p70fywlLI9lN+qTPC1z4Y/IAJSH0AOdo
         /lgdc30fyo6a/SSaC25+BEL/mEaenMJ7VSOFAVt/IME447dKTgso8cuzBFEzbaaCoIW2
         BNK2DqGPBZEJeDzaUBmEKbogYMT3J3bmF23YFqNQ0GtLny6jrJ/QhpxdC64o6IWl0sjS
         n5bhe/bVA0I9PUIfzC/2yC/vOepDcSabRf3eRo2lquUZNCbnUXPIIE+hz8ye+Ripbe2i
         797A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710204298; x=1710809098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eMIRZD/k0gFovShUK2UbDhWvueGs6TGvoJhXxJjP2A=;
        b=cqXZNia0PcfAJM6tWOdAz18K7+KFxeHnP6lqguhsWv9CwZWsuQXc95a4eCcSqMcnAT
         GWN4a63ZB/U568oTuV9WUdK5QXO0vmLid41x5p8cMY7ncHko50AWcv1bQDm1SHVcV80U
         Vd1pbSbZPMGywMiMae6N8+h3o1wZuqYBz7ZjhHGbhZI8E5jz4D8iVseFdIIueVwzHdlX
         CLieXA1edxiTldKYisXOSTMSmoTgtKWShyxtAwnTjDzJseo21RzxV5fvNCQr6vhQuulG
         /T/diAUJXFRuUmjhI4Io5MQUJVUR/L6k8hG9EYub8vXk83nmrkXe4wXEjfxygFOx8zks
         n2iQ==
X-Gm-Message-State: AOJu0YwNHxVaiM25E1cbjqDlsQ7K92LUVmDDRmjMtMLQnBJOgxzlMG8w
	P7kXvI+m9nCFCMKjXGv9/PNHUnxedJaoe2LlZODULZ14YD507TOBX67IIzxKOuAf22W17jNsPxa
	042XXWhmq4Z1AyNHlGymdssMd7J3d0F53GuGBtrnDppI+SbScGOJWdzliY95R00sznjBl2pDBsC
	HOwQODI9hP++KdHTvCrVFFYdqePg/lYjfKVFj2o1OIu6X+19eX9b1Z79N9Gw==
X-Google-Smtp-Source: AGHT+IGmxB3JCRbHK+uvpjYok57XydaBcn5VGOR/56vLei8SuSdnGbGU8gbmRERYVFo8e9EB5AtT2RunJgNdw0jekg==
X-Received: from rkolchmeyer.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:7f04])
 (user=rkolchmeyer job=sendgmr) by 2002:a25:be49:0:b0:dc6:44d4:bee0 with SMTP
 id d9-20020a25be49000000b00dc644d4bee0mr464397ybm.7.1710204297832; Mon, 11
 Mar 2024 17:44:57 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:44:34 -0700
In-Reply-To: <cover.1710203361.git.rkolchmeyer@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1710203361.git.rkolchmeyer@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <8401d4c4b5816d034a9a95900914033cb62aa9d6.1710203361.git.rkolchmeyer@google.com>
Subject: [PATCH v5.10 1/2] rcu-tasks: Provide rcu_trace_implies_rcu_gp()
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
index 8716a1706351..0122c03da24a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -201,6 +201,18 @@ static inline void exit_tasks_rcu_stop(void) { }
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
index c5624ab0580c..105fdc2bb004 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1015,6 +1015,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
+
+	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
 	synchronize_rcu();
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
-- 
2.44.0.278.ge034bb2e1d-goog


