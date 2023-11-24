Return-Path: <stable+bounces-657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C697F7C01
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD63B2102B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53839FD4;
	Fri, 24 Nov 2023 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00Tqnk01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40A381D6;
	Fri, 24 Nov 2023 18:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36F0C433C7;
	Fri, 24 Nov 2023 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849449;
	bh=fg7TPX6hECAfYtRJsgQU8/2C1+sXU5c/CKNfci6Xoe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=00Tqnk01uhG8NeYt2GO4d4UMLKYmhQklFrAR5nGenNdyWvVTiyP8nLo1z3VWYRx05
	 jcVYbL8fb1RiiTQBDmJCQiv8/6ZNizQP+R0Eazt6+HtWk3+hNrcxvGHORYC5kjrPaf
	 D6vifQ1NRlGmmgEIh2UVfiCTKCrVq4XHaO9thfio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinghao Jia <jinghao@linux.ibm.com>,
	Ruowen Qin <ruowenq2@illinois.edu>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 161/530] samples/bpf: syscall_tp_user: Fix array out-of-bound access
Date: Fri, 24 Nov 2023 17:45:27 +0000
Message-ID: <20231124172032.986872869@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Jinghao Jia <jinghao@linux.ibm.com>

[ Upstream commit 9220c3ef6fefbf18f24aeedb1142a642b3de0596 ]

Commit 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint
to syscall_tp sample") added two more eBPF programs to support the
openat2() syscall. However, it did not increase the size of the array
that holds the corresponding bpf_links. This leads to an out-of-bound
access on that array in the bpf_object__for_each_program loop and could
corrupt other variables on the stack. On our testing QEMU, it corrupts
the map1_fds array and causes the sample to fail:

  # ./syscall_tp
  prog #0: map ids 4 5
  verify map:4 val: 5
  map_lookup failed: Bad file descriptor

Dynamically allocate the array based on the number of programs reported
by libbpf to prevent similar inconsistencies in the future

Fixes: 06744f24696e ("samples/bpf: Add openat2() enter/exit tracepoint to syscall_tp sample")
Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Link: https://lore.kernel.org/r/20230917214220.637721-4-jinghao7@illinois.edu
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/syscall_tp_user.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
index 18c94c7e8a40e..7a09ac74fac07 100644
--- a/samples/bpf/syscall_tp_user.c
+++ b/samples/bpf/syscall_tp_user.c
@@ -48,7 +48,7 @@ static void verify_map(int map_id)
 static int test(char *filename, int nr_tests)
 {
 	int map0_fds[nr_tests], map1_fds[nr_tests], fd, i, j = 0;
-	struct bpf_link *links[nr_tests * 4];
+	struct bpf_link **links = NULL;
 	struct bpf_object *objs[nr_tests];
 	struct bpf_program *prog;
 
@@ -60,6 +60,19 @@ static int test(char *filename, int nr_tests)
 			goto cleanup;
 		}
 
+		/* One-time initialization */
+		if (!links) {
+			int nr_progs = 0;
+
+			bpf_object__for_each_program(prog, objs[i])
+				nr_progs += 1;
+
+			links = calloc(nr_progs * nr_tests, sizeof(struct bpf_link *));
+
+			if (!links)
+				goto cleanup;
+		}
+
 		/* load BPF program */
 		if (bpf_object__load(objs[i])) {
 			fprintf(stderr, "loading BPF object file failed\n");
@@ -107,8 +120,12 @@ static int test(char *filename, int nr_tests)
 	}
 
 cleanup:
-	for (j--; j >= 0; j--)
-		bpf_link__destroy(links[j]);
+	if (links) {
+		for (j--; j >= 0; j--)
+			bpf_link__destroy(links[j]);
+
+		free(links);
+	}
 
 	for (i--; i >= 0; i--)
 		bpf_object__close(objs[i]);
-- 
2.42.0




