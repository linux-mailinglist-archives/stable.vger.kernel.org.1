Return-Path: <stable+bounces-35113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F544894278
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5542836B7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522CD481C4;
	Mon,  1 Apr 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+E8BNP6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB01DFF4;
	Mon,  1 Apr 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990375; cv=none; b=q81FtXExMmQIxRygvDpETx1YhrLFBMLWBOFOZ4rGrLiPzPO0JSQlhnBm34l2kIrdnVv5V+6Enjg2LrhyDZYAnizNvCdlNwu8feah9sfh7Bs/UqOzZthKPXbRtLO2MXBi2aeDQMEiAsVEOewBOWX1UoWEwrcfrGuDZQTgEZNf8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990375; c=relaxed/simple;
	bh=/rg1WRlV+le6jrfLfO3mf75VkIfz4uIAoOBS468XSIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyMkVDzmp6dWfnjBkib9JDj6/7YdX1q8oSRcGjkXDEaVhXOq7Oc4tIabhzCiLlgSAY7AeIQzSVESzkV5XX9UBqLLUATdooZz6bzq69zCdLEvPnFHbXbA23IdC1lKAFC54gfzpOH3tckca+nhdXg0sLeYHIIdtygI0WSkXYt9Iu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+E8BNP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC48C433C7;
	Mon,  1 Apr 2024 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990374;
	bh=/rg1WRlV+le6jrfLfO3mf75VkIfz4uIAoOBS468XSIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+E8BNP6fyUxPChTY2vEoXBHKi2DABFvZvIK7vPrOZK7XXNozaSZYxeWttqVbnXZ0
	 DNDxSvdQWdiOYY97rljI7rCRWenzs9mqCZFJsUN67HMoPgWtS05idVRTIMehxcyWGv
	 K2vJxuZz/Zu+N5PJwSl0gVs0lhmhN7g4nr4YhMoY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 305/396] selftests/mm: gup_test: conform test to TAP format output
Date: Mon,  1 Apr 2024 17:45:54 +0200
Message-ID: <20240401152557.009037161@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit cb6e7cae18868422a23d62670110c61fd1b15029 ]

Conform the layout, informational and status messages to TAP.  No
functional change is intended other than the layout of output messages.

Link: https://lkml.kernel.org/r/20240102053807.2114200-1-usama.anjum@collabora.com
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 8b65ef5ad486 ("selftests/mm: Fix build with _FORTIFY_SOURCE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mm/gup_test.c | 65 ++++++++++++++-------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index ec22291363844..cbe99594d319b 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -50,39 +50,41 @@ static char *cmd_to_str(unsigned long cmd)
 void *gup_thread(void *data)
 {
 	struct gup_test gup = *(struct gup_test *)data;
-	int i;
+	int i, status;
 
 	/* Only report timing information on the *_BENCHMARK commands: */
 	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
 	     (cmd == PIN_LONGTERM_BENCHMARK)) {
 		for (i = 0; i < repeats; i++) {
 			gup.size = size;
-			if (ioctl(gup_fd, cmd, &gup))
-				perror("ioctl"), exit(1);
+			status = ioctl(gup_fd, cmd, &gup);
+			if (status)
+				break;
 
 			pthread_mutex_lock(&print_mutex);
-			printf("%s: Time: get:%lld put:%lld us",
-			       cmd_to_str(cmd), gup.get_delta_usec,
-			       gup.put_delta_usec);
+			ksft_print_msg("%s: Time: get:%lld put:%lld us",
+				       cmd_to_str(cmd), gup.get_delta_usec,
+				       gup.put_delta_usec);
 			if (gup.size != size)
-				printf(", truncated (size: %lld)", gup.size);
-			printf("\n");
+				ksft_print_msg(", truncated (size: %lld)", gup.size);
+			ksft_print_msg("\n");
 			pthread_mutex_unlock(&print_mutex);
 		}
 	} else {
 		gup.size = size;
-		if (ioctl(gup_fd, cmd, &gup)) {
-			perror("ioctl");
-			exit(1);
-		}
+		status = ioctl(gup_fd, cmd, &gup);
+		if (status)
+			goto return_;
 
 		pthread_mutex_lock(&print_mutex);
-		printf("%s: done\n", cmd_to_str(cmd));
+		ksft_print_msg("%s: done\n", cmd_to_str(cmd));
 		if (gup.size != size)
-			printf("Truncated (size: %lld)\n", gup.size);
+			ksft_print_msg("Truncated (size: %lld)\n", gup.size);
 		pthread_mutex_unlock(&print_mutex);
 	}
 
+return_:
+	ksft_test_result(!status, "ioctl status %d\n", status);
 	return NULL;
 }
 
@@ -170,7 +172,7 @@ int main(int argc, char **argv)
 			touch = 1;
 			break;
 		default:
-			return -1;
+			ksft_exit_fail_msg("Wrong argument\n");
 		}
 	}
 
@@ -198,11 +200,12 @@ int main(int argc, char **argv)
 		}
 	}
 
+	ksft_print_header();
+	ksft_set_plan(nthreads);
+
 	filed = open(file, O_RDWR|O_CREAT);
-	if (filed < 0) {
-		perror("open");
-		exit(filed);
-	}
+	if (filed < 0)
+		ksft_exit_fail_msg("Unable to open %s: %s\n", file, strerror(errno));
 
 	gup.nr_pages_per_call = nr_pages;
 	if (write)
@@ -213,27 +216,24 @@ int main(int argc, char **argv)
 		switch (errno) {
 		case EACCES:
 			if (getuid())
-				printf("Please run this test as root\n");
+				ksft_print_msg("Please run this test as root\n");
 			break;
 		case ENOENT:
-			if (opendir("/sys/kernel/debug") == NULL) {
-				printf("mount debugfs at /sys/kernel/debug\n");
-				break;
-			}
-			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
+			if (opendir("/sys/kernel/debug") == NULL)
+				ksft_print_msg("mount debugfs at /sys/kernel/debug\n");
+			ksft_print_msg("check if CONFIG_GUP_TEST is enabled in kernel config\n");
 			break;
 		default:
-			perror("failed to open " GUP_TEST_FILE);
+			ksft_print_msg("failed to open %s: %s\n", GUP_TEST_FILE, strerror(errno));
 			break;
 		}
-		exit(KSFT_SKIP);
+		ksft_test_result_skip("Please run this test as root\n");
+		return ksft_exit_pass();
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
-	if (p == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (p == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
 	gup.addr = (unsigned long)p;
 
 	if (thp == 1)
@@ -264,7 +264,8 @@ int main(int argc, char **argv)
 		ret = pthread_join(tid[i], NULL);
 		assert(ret == 0);
 	}
+
 	free(tid);
 
-	return 0;
+	return ksft_exit_pass();
 }
-- 
2.43.0




