Return-Path: <stable+bounces-96787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A4E9E21BC
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979FA168668
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102A1F8AFA;
	Tue,  3 Dec 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WreKjYsd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C81F8914;
	Tue,  3 Dec 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238592; cv=none; b=Gm+eQYGPdgdy4q2ut+C3d9cKJeEYBnua/Qcqbztn0ngZXivlOjz7IvDFmCxG5KxUKVFcyXY7fXSD31CeredNwVgjNiVhkexj0msX2Evu/SkjNXRjde2Di0vcA7Fjx4PAJBARC39e541orNmMXux/1qcUnM45b1ywutKoMpQq/Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238592; c=relaxed/simple;
	bh=rkC7wjoHY/dhAY5BGQtYvgTl5I6PnzvXvcNkMAHmLVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPKParP4t7w6E2im5jW8HSkeKOfK3R0BSN6ZRQLWIRFJzReu3ngM6Vo1ohf7hOiX8pzWP0cQB4fl3H1KQFAOv+dOpTunMSFGp7Besx+G8tgldJ0AgL7qiALDkWlTuowG51dxBa/umCVCNBhOV+KEosC0J95LHSVmZGqQyfksG8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WreKjYsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6747AC4CECF;
	Tue,  3 Dec 2024 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238591;
	bh=rkC7wjoHY/dhAY5BGQtYvgTl5I6PnzvXvcNkMAHmLVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WreKjYsdXZ+5W2A1+WqP/0nw3WkwsKbcq7gC2DPsiuSYhvWh8JHcmaLlYNV3EFDGD
	 fThPv+4mKq2FbbtKjSuX7ZMliOQy2nseatj9VIcZKtyHF82xrWRSePcBT2FaUiBQfN
	 X+U53WGTdthg4x1lXIxo/8nVUeiOc4GvbCkbdvQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijian Zhang <zijianzhang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 330/817] selftests/bpf: Add push/pop checking for msg_verify_data in test_sockmap
Date: Tue,  3 Dec 2024 15:38:22 +0100
Message-ID: <20241203144008.700443007@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijian Zhang <zijianzhang@bytedance.com>

[ Upstream commit 862087c3d36219ed44569666eb263efc97f00c9a ]

Add push/pop checking for msg_verify_data in test_sockmap, except for
pop/push with cork tests, in these tests the logic will be different.
1. With corking, pop/push might not be invoked in each sendmsg, it makes
the layout of the received data difficult
2. It makes it hard to calculate the total_bytes in the recvmsg
Temporarily skip the data integrity test for these cases now, added a TODO

Fixes: ee9b352ce465 ("selftests/bpf: Fix msg_verify_data in test_sockmap")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20241106222520.527076-5-zijianzhang@bytedance.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_sockmap.c | 106 ++++++++++++++++++++-
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 5f4558f1f0049..61a747afcd05f 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -88,6 +88,10 @@ int ktls;
 int peek_flag;
 int skb_use_parser;
 int txmsg_omit_skb_parser;
+int verify_push_start;
+int verify_push_len;
+int verify_pop_start;
+int verify_pop_len;
 
 static const struct option long_options[] = {
 	{"help",	no_argument,		NULL, 'h' },
@@ -514,12 +518,41 @@ static int msg_alloc_iov(struct msghdr *msg,
 	return -ENOMEM;
 }
 
-/* TODO: Add verification logic for push, pull and pop data */
+/* In push or pop test, we need to do some calculations for msg_verify_data */
+static void msg_verify_date_prep(void)
+{
+	int push_range_end = txmsg_start_push + txmsg_end_push - 1;
+	int pop_range_end = txmsg_start_pop + txmsg_pop - 1;
+
+	if (txmsg_end_push && txmsg_pop &&
+	    txmsg_start_push <= pop_range_end && txmsg_start_pop <= push_range_end) {
+		/* The push range and the pop range overlap */
+		int overlap_len;
+
+		verify_push_start = txmsg_start_push;
+		verify_pop_start = txmsg_start_pop;
+		if (txmsg_start_push < txmsg_start_pop)
+			overlap_len = min(push_range_end - txmsg_start_pop + 1, txmsg_pop);
+		else
+			overlap_len = min(pop_range_end - txmsg_start_push + 1, txmsg_end_push);
+		verify_push_len = max(txmsg_end_push - overlap_len, 0);
+		verify_pop_len = max(txmsg_pop - overlap_len, 0);
+	} else {
+		/* Otherwise */
+		verify_push_start = txmsg_start_push;
+		verify_pop_start = txmsg_start_pop;
+		verify_push_len = txmsg_end_push;
+		verify_pop_len = txmsg_pop;
+	}
+}
+
 static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
-				 unsigned char *k_p, int *bytes_cnt_p)
+			   unsigned char *k_p, int *bytes_cnt_p,
+			   int *check_cnt_p, int *push_p)
 {
-	int i, j, bytes_cnt = *bytes_cnt_p;
+	int bytes_cnt = *bytes_cnt_p, check_cnt = *check_cnt_p, push = *push_p;
 	unsigned char k = *k_p;
+	int i, j;
 
 	for (i = 0, j = 0; i < msg->msg_iovlen && size; i++, j = 0) {
 		unsigned char *d = msg->msg_iov[i].iov_base;
@@ -538,6 +571,37 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
 		}
 
 		for (; j < msg->msg_iov[i].iov_len && size; j++) {
+			if (push > 0 &&
+			    check_cnt == verify_push_start + verify_push_len - push) {
+				int skipped;
+revisit_push:
+				skipped = push;
+				if (j + push >= msg->msg_iov[i].iov_len)
+					skipped = msg->msg_iov[i].iov_len - j;
+				push -= skipped;
+				size -= skipped;
+				j += skipped - 1;
+				check_cnt += skipped;
+				continue;
+			}
+
+			if (verify_pop_len > 0 && check_cnt == verify_pop_start) {
+				bytes_cnt += verify_pop_len;
+				check_cnt += verify_pop_len;
+				k += verify_pop_len;
+
+				if (bytes_cnt == chunk_sz) {
+					k = 0;
+					bytes_cnt = 0;
+					check_cnt = 0;
+					push = verify_push_len;
+				}
+
+				if (push > 0 &&
+				    check_cnt == verify_push_start + verify_push_len - push)
+					goto revisit_push;
+			}
+
 			if (d[j] != k++) {
 				fprintf(stderr,
 					"detected data corruption @iov[%i]:%i %02x != %02x, %02x ?= %02x\n",
@@ -545,15 +609,20 @@ static int msg_verify_data(struct msghdr *msg, int size, int chunk_sz,
 				return -EDATAINTEGRITY;
 			}
 			bytes_cnt++;
+			check_cnt++;
 			if (bytes_cnt == chunk_sz) {
 				k = 0;
 				bytes_cnt = 0;
+				check_cnt = 0;
+				push = verify_push_len;
 			}
 			size--;
 		}
 	}
 	*k_p = k;
 	*bytes_cnt_p = bytes_cnt;
+	*check_cnt_p = check_cnt;
+	*push_p = push;
 	return 0;
 }
 
@@ -612,6 +681,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		unsigned char k = 0;
 		int bytes_cnt = 0;
+		int check_cnt = 0;
+		int push = 0;
 		fd_set w;
 
 		fcntl(fd, fd_flags);
@@ -637,6 +708,10 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
+		if (data) {
+			msg_verify_date_prep();
+			push = verify_push_len;
+		}
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
 			perror("recv start time");
@@ -712,7 +787,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 						iov_length :
 						iov_length * iov_count;
 
-				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt);
+				errno = msg_verify_data(&msg, recv, chunk_sz, &k, &bytes_cnt,
+							&check_cnt, &push);
 				if (errno) {
 					perror("data verify msg failed");
 					goto out_errno;
@@ -722,7 +798,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 								recvp,
 								chunk_sz,
 								&k,
-								&bytes_cnt);
+								&bytes_cnt,
+								&check_cnt,
+								&push);
 					if (errno) {
 						perror("data verify msg_peek failed");
 						goto out_errno;
@@ -1636,6 +1714,8 @@ static void test_txmsg_pull(int cgrp, struct sockmap_options *opt)
 
 static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 {
+	bool data = opt->data_test;
+
 	/* Test basic pop */
 	txmsg_pass = 1;
 	txmsg_start_pop = 1;
@@ -1654,6 +1734,12 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
 
+	/* TODO: Test for pop + cork should be different,
+	 * - It makes the layout of the received data difficult
+	 * - It makes it hard to calculate the total_bytes in the recvmsg
+	 * Temporarily skip the data integrity test for this case now.
+	 */
+	opt->data_test = false;
 	/* Test pop + cork */
 	txmsg_redir = 0;
 	txmsg_cork = 512;
@@ -1667,10 +1753,13 @@ static void test_txmsg_pop(int cgrp, struct sockmap_options *opt)
 	txmsg_start_pop = 1;
 	txmsg_pop = 2;
 	test_send_many(opt, cgrp);
+	opt->data_test = data;
 }
 
 static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 {
+	bool data = opt->data_test;
+
 	/* Test basic push */
 	txmsg_pass = 1;
 	txmsg_start_push = 1;
@@ -1689,12 +1778,19 @@ static void test_txmsg_push(int cgrp, struct sockmap_options *opt)
 	txmsg_end_push = 2;
 	test_send_many(opt, cgrp);
 
+	/* TODO: Test for push + cork should be different,
+	 * - It makes the layout of the received data difficult
+	 * - It makes it hard to calculate the total_bytes in the recvmsg
+	 * Temporarily skip the data integrity test for this case now.
+	 */
+	opt->data_test = false;
 	/* Test push + cork */
 	txmsg_redir = 0;
 	txmsg_cork = 512;
 	txmsg_start_push = 1;
 	txmsg_end_push = 2;
 	test_send_many(opt, cgrp);
+	opt->data_test = data;
 }
 
 static void test_txmsg_push_pop(int cgrp, struct sockmap_options *opt)
-- 
2.43.0




