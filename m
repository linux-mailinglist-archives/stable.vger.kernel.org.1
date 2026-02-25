Return-Path: <stable+bounces-219424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GM5N0SgnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:09:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CCF1930BB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34DF231D176B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3481313264;
	Wed, 25 Feb 2026 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwkv8BWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729530E855;
	Wed, 25 Feb 2026 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002706; cv=none; b=jXDfU7pTYjOQbA/wTpDeZV8XWiwQcOXgdRRPRvdmBQCwp+dJIXZqyJ6T/eN7oBe0rx6lp0ArIj3kWuc3YlEXQ+3QnEPyJTIFVGIOSx40EckAdt/B4PjxC8F/0/wOPCBmR4QpFN/0+7izK7D3qERSeQUpwA4CJdKaJyvHQKOSetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002706; c=relaxed/simple;
	bh=m4vU6dP/sNeV8TYbAPk/RcP3+EHNKLSZJKW9sftm0io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9HDw3GX0aRNrWzeNKstuvGG+1VqzvPoleg4jwSLX1NHTazcd+WcZXgK9NSd+cncdl7xg3iluIwbZV/H6BSwI6ZDcCC0t6xlqKYaKJyMqW0sAh34N+HvjKDzuI2UIs6f8HDREdghoZVSq1MrE5pH9zH4I9QrkO2C5g8VpWe1WuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwkv8BWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAA0C116D0;
	Wed, 25 Feb 2026 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002706;
	bh=m4vU6dP/sNeV8TYbAPk/RcP3+EHNKLSZJKW9sftm0io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwkv8BWXtfpBcHl3J0MV7X4K34TzcPCDn/YOf1yF4XXZP9NythMRqJpkdXMiYa6Oh
	 7+KOP6ad/iOWj5PwspcjrEGzcX/2kNk+PLs0jAk0HlPC7Tch+YrfUDHAja1OrP8tKa
	 T6xURRGzxeM5qY4OIXqICk0mjFOzW3LAtOLntAMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aristeu Rozanski <aris@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Shuah Khan <shuah@kernel.org>,
	liuye <liuye@kylinos.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 506/641] selftests/memfd: use IPC semaphore instead of SIGSTOP/SIGCONT
Date: Tue, 24 Feb 2026 17:23:52 -0800
Message-ID: <20260225012400.785580010@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219424-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,cyphar.com:email]
X-Rspamd-Queue-Id: 48CCF1930BB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aristeu Rozanski <aris@redhat.com>

[ Upstream commit b24335521de92fd2ee22460072b75367ca8860b0 ]

selftests/memfd: use IPC semaphore instead of SIGSTOP/SIGCONT

In order to synchronize new processes to test inheritance of memfd_noexec
sysctl, memfd_test sets up the sysctl with a value before creating the new
process.  The new process then sends itself a SIGSTOP in order to wait for
the parent to flip the sysctl value and send a SIGCONT signal.

This would work as intended if it wasn't the fact that the new process is
being created with CLONE_NEWPID, which creates a new PID namespace and the
new process has PID 1 in this namespace.  There're restrictions on sending
signals to PID 1 and, although it's relaxed for other than root PID
namespace, it's biting us here.  In this specific case the SIGSTOP sent by
the new process is ignored (no error to kill() is returned) and it never
stops its execution.  This is usually not noticiable as the parent usually
manages to set the new sysctl value before the child has a chance to run
and the test succeeds.  But if you run the test in a loop, it eventually
reproduces:

	while [ 1 ]; do ./memfd_test >log 2>&1 || break; done; cat log

So this patch replaces the SIGSTOP/SIGCONT synchronization with IPC
semaphore.

Link: https://lkml.kernel.org/r/a7776389-b3d6-4b18-b438-0b0e3ed1fd3b@work
Fixes: 6469b66e3f5a ("selftests: improve vm.memfd_noexec sysctl tests")
Signed-off-by: Aristeu Rozanski <aris@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: liuye <liuye@kylinos.cn>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 113 +++++++++++++++++++--
 1 file changed, 105 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 5b993924cc3f5..2ca07ea7202a5 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -18,6 +18,9 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/sem.h>
 #include <unistd.h>
 #include <ctype.h>
 
@@ -39,6 +42,20 @@
 		    F_SEAL_EXEC)
 
 #define MFD_NOEXEC_SEAL	0x0008U
+union semun {
+	int val;
+	struct semid_ds *buf;
+	unsigned short int *array;
+	struct seminfo *__buf;
+};
+
+/*
+ * we use semaphores on nested wait tasks due the use of CLONE_NEWPID: the
+ * child will be PID 1 and can't send SIGSTOP to themselves due special
+ * treatment of the init task, so the SIGSTOP/SIGCONT synchronization
+ * approach can't be used here.
+ */
+#define SEM_KEY 0xdeadbeef
 
 /*
  * Default is not to test hugetlbfs
@@ -1333,8 +1350,22 @@ static int sysctl_nested(void *arg)
 
 static int sysctl_nested_wait(void *arg)
 {
-	/* Wait for a SIGCONT. */
-	kill(getpid(), SIGSTOP);
+	int sem = semget(SEM_KEY, 1, 0600);
+	struct sembuf sembuf;
+
+	if (sem < 0) {
+		perror("semget:");
+		abort();
+	}
+	sembuf.sem_num = 0;
+	sembuf.sem_flg = 0;
+	sembuf.sem_op = 0;
+
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		abort();
+	}
+
 	return sysctl_nested(arg);
 }
 
@@ -1355,7 +1386,9 @@ static void test_sysctl_sysctl2_failset(void)
 
 static int sysctl_nested_child(void *arg)
 {
-	int pid;
+	int pid, sem;
+	union semun semun;
+	struct sembuf sembuf;
 
 	printf("%s nested sysctl 0\n", memfd_str);
 	sysctl_assert_write("0");
@@ -1389,23 +1422,53 @@ static int sysctl_nested_child(void *arg)
 			   test_sysctl_sysctl2_failset);
 	join_thread(pid);
 
+	sem = semget(SEM_KEY, 1, IPC_CREAT | 0600);
+	if (sem < 0) {
+		perror("semget:");
+		return 1;
+	}
+	semun.val = 1;
+	sembuf.sem_op = -1;
+	sembuf.sem_flg = 0;
+	sembuf.sem_num = 0;
+
 	/* Verify that the rules are actually inherited after fork. */
 	printf("%s nested sysctl 0 -> 1 after fork\n", memfd_str);
 	sysctl_assert_write("0");
 
+	if (semctl(sem, 0, SETVAL, semun) < 0) {
+		perror("semctl:");
+		return 1;
+	}
+
 	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
 			   test_sysctl_sysctl1_failset);
 	sysctl_assert_write("1");
-	kill(pid, SIGCONT);
+
+	/* Allow child to continue */
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		return 1;
+	}
 	join_thread(pid);
 
 	printf("%s nested sysctl 0 -> 2 after fork\n", memfd_str);
 	sysctl_assert_write("0");
 
+	if (semctl(sem, 0, SETVAL, semun) < 0) {
+		perror("semctl:");
+		return 1;
+	}
+
 	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
 			   test_sysctl_sysctl2_failset);
 	sysctl_assert_write("2");
-	kill(pid, SIGCONT);
+
+	/* Allow child to continue */
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		return 1;
+	}
 	join_thread(pid);
 
 	/*
@@ -1415,28 +1478,62 @@ static int sysctl_nested_child(void *arg)
 	 */
 	printf("%s nested sysctl 2 -> 1 after fork\n", memfd_str);
 	sysctl_assert_write("2");
+
+	if (semctl(sem, 0, SETVAL, semun) < 0) {
+		perror("semctl:");
+		return 1;
+	}
+
 	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
 			   test_sysctl_sysctl2);
 	sysctl_assert_write("1");
-	kill(pid, SIGCONT);
+
+	/* Allow child to continue */
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		return 1;
+	}
 	join_thread(pid);
 
 	printf("%s nested sysctl 2 -> 0 after fork\n", memfd_str);
 	sysctl_assert_write("2");
+
+	if (semctl(sem, 0, SETVAL, semun) < 0) {
+		perror("semctl:");
+		return 1;
+	}
+
 	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
 			   test_sysctl_sysctl2);
 	sysctl_assert_write("0");
-	kill(pid, SIGCONT);
+
+	/* Allow child to continue */
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		return 1;
+	}
 	join_thread(pid);
 
 	printf("%s nested sysctl 1 -> 0 after fork\n", memfd_str);
 	sysctl_assert_write("1");
+
+	if (semctl(sem, 0, SETVAL, semun) < 0) {
+		perror("semctl:");
+		return 1;
+	}
+
 	pid = spawn_thread(CLONE_NEWPID, sysctl_nested_wait,
 			   test_sysctl_sysctl1);
 	sysctl_assert_write("0");
-	kill(pid, SIGCONT);
+	/* Allow child to continue */
+	if (semop(sem, &sembuf, 1) < 0) {
+		perror("semop:");
+		return 1;
+	}
 	join_thread(pid);
 
+	semctl(sem, 0, IPC_RMID);
+
 	return 0;
 }
 
-- 
2.51.0




