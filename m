Return-Path: <stable+bounces-165496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6DB15E25
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 12:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7604B3B7AEC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDFD28313F;
	Wed, 30 Jul 2025 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stdlhzhL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A42528003A;
	Wed, 30 Jul 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871306; cv=none; b=sz3NQA7ZHiMx1JieRYpGbolR5gkMDs6M+p0/4xqQGSpnwfpe1G9xX1Enxn6DBjo7CZqUVzQCRVv6MT1fYeP/9EXDoii/wPZXEhxf908G6mSpqOj0s6KTXOZZ4JuIcqNJPWYcNcgM0z9sguuSRTuGeTwse+/Ih+jBUIZKTxcVzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871306; c=relaxed/simple;
	bh=YjnqLD86ZZjRbkGBKYjdaA/qg5xANqw0XgAY0xjN1Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtOyHf5UZmVUC5DgNuYGwDRvsEQ2YMlz43VoKRcSZjd6R/NHM6temjBvznMM8PwuciZ9Oz5Db+1tm7ZRcD6IRGjOv2EF5qtWFyhyOtzoKFPmA9UPLb8XbDdwmuLHtvd6aUEz6Y+dcze+/xWZmHFlBfaYJFM1K11ahb9GhBwE14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stdlhzhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12264C4CEF5;
	Wed, 30 Jul 2025 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753871305;
	bh=YjnqLD86ZZjRbkGBKYjdaA/qg5xANqw0XgAY0xjN1Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stdlhzhLFWKfzvMe2I41380aa5A5w1GaEChBOO+APBb2ux5CaBWxbKqBI+MfVdIUL
	 vJYgquVtlA4Z2QpOJek4Fzka/XszYwhRzR3Q4VsbkGlTTw0eBBed2wFJ8/0gqVDh6g
	 ssTixCOFScNpI1x13r1XLW/ZFjVmgFhd2jAoyzXZk6V2VpAlApBs84zLURUJQqcxGX
	 Gws0A31vRVYo4+CZxM+wSMNbjm4B8AQk3tdeDABJDLSYrFD3aDjAIpVIad7J4UFGVy
	 cLDrWqR+NDIZVjGkvtZSV8sLf84lBKI4DIb9lQgKPeSS6CZ8GE0OEAC5CGO0SMlrcZ
	 WIPGSjoIv2ZPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>,
	sashal@kernel.org,
	Xiumei Mu <xmu@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/3] selftests: mptcp: make sendfile selftest work
Date: Wed, 30 Jul 2025 12:28:08 +0200
Message-ID: <20250730102806.1405622-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025072839-wildly-gala-e85f@gregkh>
References: <2025072839-wildly-gala-e85f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=matttbe@kernel.org; h=from:subject; bh=h30l6jtyIIdP7OjBd69ZifQdIAHUDqB7LGViE6bbDcQ=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI6P+9gym9g4purFM97L4Fp37abPfGNS3bGqlz/n9+1w cw3Kkyno5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCK9TIwMa2MrtfhXBl2/mqUU nBzMVCmg5tIpdsfx1P/3zVemcW9/w/Dfe9NN4xuLH2f3TxKdsYL9kkRhWwCnq8Wr4xwuj+uelJZ xAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

commit df9e03aec3b14970df05b72d54f8ac9da3ab29e1 upstream.

When the selftest got added, sendfile() on mptcp sockets returned
-EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
immediately.

This is no longer the case, but the script fails anyway due to timeout.
Let the receiver know once the sender has sent all data, just like
with '-m mmap' mode.

v2: need to respect cfg_wait too, as pm_userspace.sh relied
on -m sendfile to keep the connection open (Mat Martineau)

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Reported-by: Xiumei Mu <xmu@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 .../selftests/net/mptcp/mptcp_connect.c       | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 95e81d557b08..d505c6cba668 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -451,6 +451,18 @@ static void set_nonblock(int fd)
 	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
 }
 
+static void shut_wr(int fd)
+{
+	/* Close our write side, ev. give some time
+	 * for address notification and/or checking
+	 * the current status
+	 */
+	if (cfg_wait)
+		usleep(cfg_wait);
+
+	shutdown(fd, SHUT_WR);
+}
+
 static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after_out)
 {
 	struct pollfd fds = {
@@ -528,14 +540,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
 					/* ... and peer also closed already */
 					break;
 
-				/* ... but we still receive.
-				 * Close our write side, ev. give some time
-				 * for address notification and/or checking
-				 * the current status
-				 */
-				if (cfg_wait)
-					usleep(cfg_wait);
-				shutdown(peerfd, SHUT_WR);
+				shut_wr(peerfd);
 			} else {
 				if (errno == EINTR)
 					continue;
@@ -666,7 +671,7 @@ static int copyfd_io_mmap(int infd, int peerfd, int outfd,
 		if (err)
 			return err;
 
-		shutdown(peerfd, SHUT_WR);
+		shut_wr(peerfd);
 
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
@@ -690,6 +695,9 @@ static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
 		err = do_sendfile(infd, peerfd, size);
 		if (err)
 			return err;
+
+		shut_wr(peerfd);
+
 		err = do_recvfile(peerfd, outfd);
 		*in_closed_after_out = true;
 	}
-- 
2.50.0


