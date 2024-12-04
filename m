Return-Path: <stable+bounces-98338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38E9E4043
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1889828372B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305C20E333;
	Wed,  4 Dec 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gczAojY8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A120C474;
	Wed,  4 Dec 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331478; cv=none; b=ukmNTXGiSTDirQwmL1rHSs3qBH6GCocAJqGEEX3JhIdz1UVyeTqX69L/1a3QY7DL2h7+fClc52dYU/gWq0+tMG7Cvj5yJLoPI6T5twtmaNEuz/5ndCpxXFSzX8Hq8dzH+XJEXlrYDva8ePkFt5JtVHuyT9AenJJ2OYunxgU0JmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331478; c=relaxed/simple;
	bh=EDGtG5EBGtH2cHj7KVKZS1fbq4ioEggx+uprl8swCfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wayuw5wIdBRPtawv7py8/SV2B8Q9J8Lvxx/CXetZtJx21Mn1Dr5rtlI0Ql1EUqKLC3qlBVPUewpt8mDci5caBSXQZeM3DKkk2Z55axUrwIi1f6yPc+EmGEP6+PzCrdf4OQ2a98Iw4wQnEbbKKJlkX71uYvjCqvGI0gaBy+ogNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gczAojY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB7C4CECD;
	Wed,  4 Dec 2024 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331478;
	bh=EDGtG5EBGtH2cHj7KVKZS1fbq4ioEggx+uprl8swCfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gczAojY8jLP0TV6PtTz0Yo4Ur9RmIF7XqhNUNqhxlYGFxbuYdPP6c+k+SB4VJ6/1T
	 za1czKhaPSxKlx4br5gtGLJcv+wilgdb+QH3+ah/NzxHBzzUD6jRNWtYNV4wj5f+4k
	 bwrCptB0haXb5HDPX8u5OVq0HebZ5UW2N9QUEk9xKllWp1K36VfeAvMPV5m20bWXMZ
	 uswL5S2az0zXMHJbAMsT5bi6xPYovtcKtpaRsqzWcUT+oJe9B/g7f5J7S1XfHvwrT9
	 VbMyqcbdYEnPlX+Nhho+giFCMzW2FIYKhafhCaGVLIL0V8ILHH3AR+p8wwZ7VgjHby
	 PyNlFqiX/v89Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Stancek <jstancek@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	tglozar@redhat.com,
	limingming890315@gmail.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/36] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
Date: Wed,  4 Dec 2024 10:45:21 -0500
Message-ID: <20241204154626.2211476-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Jan Stancek <jstancek@redhat.com>

[ Upstream commit 0eecee340672c4b512f6f4a8c6add26df05d130c ]

glibc commit 21571ca0d703 ("Linux: Add the sched_setattr
and sched_getattr functions") now also provides 'struct sched_attr'
and sched_setattr() which collide with the ones from rtla.

  In file included from src/trace.c:11:
  src/utils.h:49:8: error: redefinition of ‘struct sched_attr’
     49 | struct sched_attr {
        |        ^~~~~~~~~~
  In file included from /usr/include/bits/sched.h:60,
                   from /usr/include/sched.h:43,
                   from /usr/include/tracefs/tracefs.h:10,
                   from src/trace.c:4:
  /usr/include/linux/sched/types.h:98:8: note: originally defined here
     98 | struct sched_attr {
        |        ^~~~~~~~~~

Define 'struct sched_attr' conditionally, similar to what strace did:
  https://lore.kernel.org/all/20240930222913.3981407-1-raj.khem@gmail.com/
and rename rtla's version of sched_setattr() to avoid collision.

Link: https://lore.kernel.org/8088f66a7a57c1b209cd8ae0ae7c336a7f8c930d.1728572865.git.jstancek@redhat.com
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 4 ++--
 tools/tracing/rtla/src/utils.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 9ac71a66840c1..0735fcb827ed7 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -233,7 +233,7 @@ long parse_ns_duration(char *val)
 
 #define SCHED_DEADLINE		6
 
-static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+static inline int syscall_sched_setattr(pid_t pid, const struct sched_attr *attr,
 				unsigned int flags) {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
@@ -243,7 +243,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 	int flags = 0;
 	int retval;
 
-	retval = sched_setattr(pid, attr, flags);
+	retval = syscall_sched_setattr(pid, attr, flags);
 	if (retval < 0) {
 		err_msg("Failed to set sched attributes to the pid %d: %s\n",
 			pid, strerror(errno));
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index d44513e6c66a0..99c9cf81bcd02 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -46,6 +46,7 @@ update_sum(unsigned long long *a, unsigned long long *b)
 	*a += *b;
 }
 
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -56,6 +57,7 @@ struct sched_attr {
 	uint64_t sched_deadline;
 	uint64_t sched_period;
 };
+#endif /* SCHED_ATTR_SIZE_VER0 */
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int parse_cpu_set(char *cpu_list, cpu_set_t *set);
-- 
2.43.0


