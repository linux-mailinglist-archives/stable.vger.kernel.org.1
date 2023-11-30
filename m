Return-Path: <stable+bounces-3308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341317FF4FB
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF7B1F20F26
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4D54F98;
	Thu, 30 Nov 2023 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqqE8Mi2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56B482CB;
	Thu, 30 Nov 2023 16:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C04BC433C8;
	Thu, 30 Nov 2023 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361500;
	bh=n80YUGbDRzkDDoYch5h4QL72YFOCe+YPrpd+SFSasWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqqE8Mi2764Z+Pl9dXBvp07aaSSxZsr3/8fIG/M9LNSE1rhSTaaE2/tCk4ecTN09k
	 BGw1p2ysEdKUNBzXnr65n05TD0zR7kLovd74zQB6ZXODuteiQGK/EC38Zq5zjRFMVT
	 KtkGEOJw4aecnAJ/bN/Gn+fb7xk8Y9pd0Lz0XydI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bogdan Marcynkov <bmarcynk@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/112] vsock/test: fix SEQPACKET message bounds test
Date: Thu, 30 Nov 2023 16:21:34 +0000
Message-ID: <20231130162141.807131212@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit f0863888f6cfef33e3117dccfe94fa78edf76be4 ]

Tune message length calculation to make this test work on machines
where 'getpagesize()' returns >32KB. Now maximum message length is not
hardcoded (on machines above it was smaller than 'getpagesize()' return
value, thus we get negative value and test fails), but calculated at
runtime and always bigger than 'getpagesize()' result. Reproduced on
aarch64 with 64KB page size.

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reported-by: Bogdan Marcynkov <bmarcynk@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20231121211642.163474-1-avkrasnov@salutedevices.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/vsock/vsock_test.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 90718c2fd4ea9..5dc7767039f6f 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -392,11 +392,12 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
-#define MAX_MSG_SIZE (32 * 1024)
+#define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
 	unsigned long curr_hash;
+	size_t max_msg_size;
 	int page_size;
 	int msg_count;
 	int fd;
@@ -412,7 +413,8 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 
 	curr_hash = 0;
 	page_size = getpagesize();
-	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
+	max_msg_size = MAX_MSG_PAGES * page_size;
+	msg_count = SOCK_BUF_SIZE / max_msg_size;
 
 	for (int i = 0; i < msg_count; i++) {
 		ssize_t send_size;
@@ -423,7 +425,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		/* Use "small" buffers and "big" buffers. */
 		if (i & 1)
 			buf_size = page_size +
-					(rand() % (MAX_MSG_SIZE - page_size));
+					(rand() % (max_msg_size - page_size));
 		else
 			buf_size = 1 + (rand() % page_size);
 
@@ -479,7 +481,6 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 	unsigned long remote_hash;
 	unsigned long curr_hash;
 	int fd;
-	char buf[MAX_MSG_SIZE];
 	struct msghdr msg = {0};
 	struct iovec iov = {0};
 
@@ -507,8 +508,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 	control_writeln("SRVREADY");
 	/* Wait, until peer sends whole data. */
 	control_expectln("SENDDONE");
-	iov.iov_base = buf;
-	iov.iov_len = sizeof(buf);
+	iov.iov_len = MAX_MSG_PAGES * getpagesize();
+	iov.iov_base = malloc(iov.iov_len);
+	if (!iov.iov_base) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
 
@@ -533,6 +539,7 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 		curr_hash += hash_djb2(msg.msg_iov[0].iov_base, recv_size);
 	}
 
+	free(iov.iov_base);
 	close(fd);
 	remote_hash = control_readulong();
 
-- 
2.42.0




