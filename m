Return-Path: <stable+bounces-649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A57F7BF9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FE66B214ED
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B5381DF;
	Fri, 24 Nov 2023 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wm5Qo7gw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061B39FE1;
	Fri, 24 Nov 2023 18:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089EEC433C7;
	Fri, 24 Nov 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849429;
	bh=QKwYU/PowRdUYKzqlOSMWux1SfZb7t7MLT29EuhG1LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wm5Qo7gwf3aOc+pV5ffnVh05rRL4V+QfB6kFNT9jNF45EJpanRm8bcqFMfGWK0G5Q
	 G4Yc2/hB8iciZNzRRZO9yk5QATz3ZfLNx3rKr1FRZ0ds26EpRKu1BqJVndSqj1jwTz
	 hFK78n+sMG+8VwJUmhmkzKlgiuPJAfpmWAccpR7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinghao Jia <jinghao@linux.ibm.com>,
	Ruowen Qin <ruowenq2@illinois.edu>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 160/530] samples/bpf: syscall_tp_user: Rename num_progs into nr_tests
Date: Fri, 24 Nov 2023 17:45:26 +0000
Message-ID: <20231124172032.955427629@linuxfoundation.org>
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

[ Upstream commit 0ee352fe0d28015cab161b04d202fa3231c0ba3b ]

The variable name num_progs causes confusion because that variable
really controls the number of rounds the test should be executed.

Rename num_progs into nr_tests for the sake of clarity.

Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Link: https://lore.kernel.org/r/20230917214220.637721-3-jinghao7@illinois.edu
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 9220c3ef6fef ("samples/bpf: syscall_tp_user: Fix array out-of-bound access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/syscall_tp_user.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/samples/bpf/syscall_tp_user.c b/samples/bpf/syscall_tp_user.c
index 7a788bb837fc1..18c94c7e8a40e 100644
--- a/samples/bpf/syscall_tp_user.c
+++ b/samples/bpf/syscall_tp_user.c
@@ -17,9 +17,9 @@
 
 static void usage(const char *cmd)
 {
-	printf("USAGE: %s [-i num_progs] [-h]\n", cmd);
-	printf("       -i num_progs      # number of progs of the test\n");
-	printf("       -h                # help\n");
+	printf("USAGE: %s [-i nr_tests] [-h]\n", cmd);
+	printf("       -i nr_tests      # rounds of test to run\n");
+	printf("       -h               # help\n");
 }
 
 static void verify_map(int map_id)
@@ -45,14 +45,14 @@ static void verify_map(int map_id)
 	}
 }
 
-static int test(char *filename, int num_progs)
+static int test(char *filename, int nr_tests)
 {
-	int map0_fds[num_progs], map1_fds[num_progs], fd, i, j = 0;
-	struct bpf_link *links[num_progs * 4];
-	struct bpf_object *objs[num_progs];
+	int map0_fds[nr_tests], map1_fds[nr_tests], fd, i, j = 0;
+	struct bpf_link *links[nr_tests * 4];
+	struct bpf_object *objs[nr_tests];
 	struct bpf_program *prog;
 
-	for (i = 0; i < num_progs; i++) {
+	for (i = 0; i < nr_tests; i++) {
 		objs[i] = bpf_object__open_file(filename, NULL);
 		if (libbpf_get_error(objs[i])) {
 			fprintf(stderr, "opening BPF object file failed\n");
@@ -101,7 +101,7 @@ static int test(char *filename, int num_progs)
 	close(fd);
 
 	/* verify the map */
-	for (i = 0; i < num_progs; i++) {
+	for (i = 0; i < nr_tests; i++) {
 		verify_map(map0_fds[i]);
 		verify_map(map1_fds[i]);
 	}
@@ -117,13 +117,13 @@ static int test(char *filename, int num_progs)
 
 int main(int argc, char **argv)
 {
-	int opt, num_progs = 1;
+	int opt, nr_tests = 1;
 	char filename[256];
 
 	while ((opt = getopt(argc, argv, "i:h")) != -1) {
 		switch (opt) {
 		case 'i':
-			num_progs = atoi(optarg);
+			nr_tests = atoi(optarg);
 			break;
 		case 'h':
 		default:
@@ -134,5 +134,5 @@ int main(int argc, char **argv)
 
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 
-	return test(filename, num_progs);
+	return test(filename, nr_tests);
 }
-- 
2.42.0




