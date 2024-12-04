Return-Path: <stable+bounces-98430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D49E4156
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9A2822CB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052B223042;
	Wed,  4 Dec 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt3KhjW7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D7217678;
	Wed,  4 Dec 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331754; cv=none; b=qCW35NzZWVTv2ucUX1Qgt/ZYKI5Q1ubLcg1l1eoNokNlzbv8SBsQZ05v7cmCyPLN8xm8LaNLt5/1BXa0IOyo8KuZU7AMooAmdunu4pVHdi80xoC2i7YyXF/hG5iC3VDo93iVv6pTySrRjoifTv+ayGMqME9+SEoBpdh3a+H7R4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331754; c=relaxed/simple;
	bh=Lj7Qtnd7u4uC1BrsHmDuqRPGLzeBmH4Gfg7x0/Qk/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BShafnLgyziTv5Wq00Tw3lTZBU487OFSAOQwOTElJOSxJA6u+zvD3BAZE4p3TIv12GNT7I+S+wSp5kA8QOGyjtJLIreT4DniXxQa2bu/De0jq5PD7qSj/wzYlrPP+xD+14yxfiUpjLDlT5mA7c9G7KCA1h8TaQSGTthY6jk99D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt3KhjW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB9C4CED6;
	Wed,  4 Dec 2024 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331754;
	bh=Lj7Qtnd7u4uC1BrsHmDuqRPGLzeBmH4Gfg7x0/Qk/eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gt3KhjW7qdo+isPVFgEx04/KuzbKcv5/1PTxE+2m0DJdPx4dZ+MBN5pxz4+6eJiOx
	 SvHrdvMoqHaVXnJfhHDINa+QGmrFNcEf5lPjsnRhW8RYzTEyGRtT8NNS8egtBJYIES
	 +JMKHfKz9kkFCio7FwQQWAMQdfe7+5T6eYVJ4b619uV+LMB4lBIG2gLtKH45jjjHzZ
	 eX3gcVG5T+YVRIf7atia/5EYtaJKZOKvMnIZmInPWlze4cTVhhnEHXkumErrRxPX1N
	 MNic9whjk1nMgpvBu3NWukYu/45TDb1Now95tsR+Cf9e2MsAepceRxeRlbQtx8jQR+
	 VRayzvyOHB7Dg==
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
Subject: [PATCH AUTOSEL 6.1 04/15] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
Date: Wed,  4 Dec 2024 10:50:43 -0500
Message-ID: <20241204155105.2214350-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155105.2214350-1-sashal@kernel.org>
References: <20241204155105.2214350-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 8c8d63c7196cf..02194773ef12d 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -238,7 +238,7 @@ long parse_ns_duration(char *val)
 
 #define SCHED_DEADLINE		6
 
-static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+static inline int syscall_sched_setattr(pid_t pid, const struct sched_attr *attr,
 				unsigned int flags) {
 	return syscall(__NR_sched_setattr, pid, attr, flags);
 }
@@ -248,7 +248,7 @@ int __set_sched_attr(int pid, struct sched_attr *attr)
 	int flags = 0;
 	int retval;
 
-	retval = sched_setattr(pid, attr, flags);
+	retval = syscall_sched_setattr(pid, attr, flags);
 	if (retval < 0) {
 		err_msg("Failed to set sched attributes to the pid %d: %s\n",
 			pid, strerror(errno));
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 92da41aaf4c4c..e445ccf15e701 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -44,6 +44,7 @@ update_sum(unsigned long long *a, unsigned long long *b)
 	*a += *b;
 }
 
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
 	uint32_t size;
 	uint32_t sched_policy;
@@ -54,6 +55,7 @@ struct sched_attr {
 	uint64_t sched_deadline;
 	uint64_t sched_period;
 };
+#endif /* SCHED_ATTR_SIZE_VER0 */
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
-- 
2.43.0


