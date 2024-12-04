Return-Path: <stable+bounces-98343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAF99E404D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B262A16777D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632852101BC;
	Wed,  4 Dec 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLLVT8hP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0220D4E0;
	Wed,  4 Dec 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331492; cv=none; b=QaANlbW8f8hGXtA8Fr/kk1IWreTEq43vzvAea/dNgjqnsI/6tZ3YKEtmd2ciSKYkEQCp3xm9hxI+4Q5sV4gzzxyzXAfetH9a/hbMXWr4RdHIU/NbOE0Cx1gt1jJEb6ShqnhZ+cGVX4O/5KH+agweMpCnc7MCaMcLw881WEhpyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331492; c=relaxed/simple;
	bh=olZtGMj07hIJB7bATrwj+QKD0jmXNHAEJ3cJcKCYOPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTeaBABu0vHOSZSlM0je88oua0ioU8wUdIrOQKNq+iNbXFT8ogQ8WN7Wd2yx4qZjZt5SpKHfKJdkC/p7fvUn83yL+APXY4wkSi6ume5NwmfRayXnW7FbzalLy/SeVTIJY67eVVF5a5uBdxmXQFv03Vt4PqZVm6wzDAlREWVLPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLLVT8hP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2224C4CECD;
	Wed,  4 Dec 2024 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331491;
	bh=olZtGMj07hIJB7bATrwj+QKD0jmXNHAEJ3cJcKCYOPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLLVT8hPLAIHt67+S6XaXc0UkxWsmEaIWbQQw5qf8L80WZkYakOQ5vjvQj2zokV7U
	 H/9E8TRs7pm6EsxIVuCFk0vLbuAAUDZmJ4WDbauQo6yOa1dF200wywSH+e2IHGyvjp
	 G9ZX3xJHBMW/U9IInw1Jk7GzytumvanNn+KKRFOXfkBKHtNjv7TjOsllOsRfEIsrqe
	 lxy4StGz0eomMXVi2rsfyfQCjeisacSH+uYC6h4PK8DOTU/thWCpBemTdLI8PAqO6B
	 r/5+FCIViGC3B4KcbOnNVvrDe3i5Sn3dQNICqTKjQOjOuWupUurdn6VjDfTLnUK8eG
	 B+sFG4lRsqs1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	jstancek@redhat.com,
	limingming890315@gmail.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/36] rtla/utils: Add idle state disabling via libcpupower
Date: Wed,  4 Dec 2024 10:45:26 -0500
Message-ID: <20241204154626.2211476-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit 083d29d3784319e9e9fab3ac02683a7b26ae3480 ]

Add functions to utils.c to disable idle states through functions of
libcpupower. This will serve as the basis for disabling idle states
per cpu when running timerlat.

Link: https://lore.kernel.org/20241017140914.3200454-4-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/utils.c | 150 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h |  13 +++
 2 files changed, 163 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 0735fcb827ed7..230f9fc7502dd 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -4,6 +4,9 @@
  */
 
 #define _GNU_SOURCE
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+#include <cpuidle.h>
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 #include <dirent.h>
 #include <stdarg.h>
 #include <stdlib.h>
@@ -519,6 +522,153 @@ int set_cpu_dma_latency(int32_t latency)
 	return fd;
 }
 
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+static unsigned int **saved_cpu_idle_disable_state;
+static size_t saved_cpu_idle_disable_state_alloc_ctr;
+
+/*
+ * save_cpu_idle_state_disable - save disable for all idle states of a cpu
+ *
+ * Saves the current disable of all idle states of a cpu, to be subsequently
+ * restored via restore_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int save_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int nr_cpus;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	if (saved_cpu_idle_disable_state == NULL) {
+		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
+		if (!saved_cpu_idle_disable_state)
+			return -1;
+	}
+
+	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
+	if (!saved_cpu_idle_disable_state[cpu])
+		return -1;
+	saved_cpu_idle_disable_state_alloc_ctr++;
+
+	for (state = 0; state < nr_states; state++) {
+		disabled = cpuidle_is_state_disabled(cpu, state);
+		if (disabled < 0)
+			return disabled;
+		saved_cpu_idle_disable_state[cpu][state] = disabled;
+	}
+
+	return nr_states;
+}
+
+/*
+ * restore_cpu_idle_disable_state - restore disable for all idle states of a cpu
+ *
+ * Restores the current disable state of all idle states of a cpu that was
+ * previously saved by save_cpu_idle_disable_state.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int restore_cpu_idle_disable_state(unsigned int cpu)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int disabled;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	if (nr_states == 0)
+		return 0;
+
+	if (!saved_cpu_idle_disable_state)
+		return -1;
+
+	for (state = 0; state < nr_states; state++) {
+		if (!saved_cpu_idle_disable_state[cpu])
+			return -1;
+		disabled = saved_cpu_idle_disable_state[cpu][state];
+		result = cpuidle_state_disable(cpu, state, disabled);
+		if (result < 0)
+			return result;
+	}
+
+	free(saved_cpu_idle_disable_state[cpu]);
+	saved_cpu_idle_disable_state[cpu] = NULL;
+	saved_cpu_idle_disable_state_alloc_ctr--;
+	if (saved_cpu_idle_disable_state_alloc_ctr == 0) {
+		free(saved_cpu_idle_disable_state);
+		saved_cpu_idle_disable_state = NULL;
+	}
+
+	return nr_states;
+}
+
+/*
+ * free_cpu_idle_disable_states - free saved idle state disable for all cpus
+ *
+ * Frees the memory used for storing cpu idle state disable for all cpus
+ * and states.
+ *
+ * Normally, the memory is freed automatically in
+ * restore_cpu_idle_disable_state; this is mostly for cleaning up after an
+ * error.
+ */
+void free_cpu_idle_disable_states(void)
+{
+	int cpu;
+	int nr_cpus;
+
+	if (!saved_cpu_idle_disable_state)
+		return;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		free(saved_cpu_idle_disable_state[cpu]);
+		saved_cpu_idle_disable_state[cpu] = NULL;
+	}
+
+	free(saved_cpu_idle_disable_state);
+	saved_cpu_idle_disable_state = NULL;
+}
+
+/*
+ * set_deepest_cpu_idle_state - limit idle state of cpu
+ *
+ * Disables all idle states deeper than the one given in
+ * deepest_state (assuming states with higher number are deeper).
+ *
+ * This is used to reduce the exit from idle latency. Unlike
+ * set_cpu_dma_latency, it can disable idle states per cpu.
+ *
+ * Return: idle state count on success, negative on error
+ */
+int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_state)
+{
+	unsigned int nr_states;
+	unsigned int state;
+	int result;
+
+	nr_states = cpuidle_state_count(cpu);
+
+	for (state = deepest_state + 1; state < nr_states; state++) {
+		result = cpuidle_state_disable(cpu, state, 1);
+		if (result < 0)
+			return result;
+	}
+
+	return nr_states;
+}
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
+
 #define _STR(x) #x
 #define STR(x) _STR(x)
 
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 99c9cf81bcd02..101d4799a0090 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -66,6 +66,19 @@ int set_comm_sched_attr(const char *comm_prefix, struct sched_attr *attr);
 int set_comm_cgroup(const char *comm_prefix, const char *cgroup);
 int set_pid_cgroup(pid_t pid, const char *cgroup);
 int set_cpu_dma_latency(int32_t latency);
+#ifdef HAVE_LIBCPUPOWER_SUPPORT
+int save_cpu_idle_disable_state(unsigned int cpu);
+int restore_cpu_idle_disable_state(unsigned int cpu);
+void free_cpu_idle_disable_states(void);
+int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state);
+static inline int have_libcpupower_support(void) { return 1; }
+#else
+static inline int save_cpu_idle_disable_state(unsigned int cpu) { return -1; }
+static inline int restore_cpu_idle_disable_state(unsigned int cpu) { return -1; }
+static inline void free_cpu_idle_disable_states(void) { }
+static inline int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int state) { return -1; }
+static inline int have_libcpupower_support(void) { return 0; }
+#endif /* HAVE_LIBCPUPOWER_SUPPORT */
 int auto_house_keeping(cpu_set_t *monitored_cpus);
 
 #define ns_to_usf(x) (((double)x/1000))
-- 
2.43.0


