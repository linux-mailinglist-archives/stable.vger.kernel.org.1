Return-Path: <stable+bounces-180863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F3B8EA03
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D319189895A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF82AD3C;
	Mon, 22 Sep 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GdFFa3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939E3C33
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501788; cv=none; b=Nb3CHU7uXwxy7hjbHf1wAMYPe6Yr6YbwXbj2OmHU5vShv2WFzXSc5H2eDpTnjil/W2UZ+8+Zh4mC1hqZnQw7HPlS5rpI8CcbIuToWXCzQ8lQrsJzljpJQqN5a3N48eCQxUOBlA0sLsM6ww03MnZm3n/98WGXbyDj7pvwNo5vBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501788; c=relaxed/simple;
	bh=bjyxEPIHqLDi+M+KtIUSI97CYGIZYhi52oJgsCyxHk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQZvNostvMsgqwPY9tc2WEdbX3Bwl0SkdRAJHT5bmKYO2O/3P9KNnTyJD5hL+kvd28bGjlUKmv6Tcb0o2WF4RopJkIFn5rjMSL6+kgYJofcdbvB/h+yPQeM3RdWsCa54gd8dfhaN70ivK+ixdtBrJotxyOV5Ukktg+wo+CEnGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GdFFa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948F8C4CEE7;
	Mon, 22 Sep 2025 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758501788;
	bh=bjyxEPIHqLDi+M+KtIUSI97CYGIZYhi52oJgsCyxHk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9GdFFa3LOhCAP4eTgwv/m30g/a/hDtHGxigKnwMgY7MSv0MlyyHQ42zh2VJiwraH
	 M3hEA7PF1z7yCT3JFPUViJl3AWvm8wAemlMptTZK4PF6YZIqRQ2KMdQZLlKW9mLgbO
	 jYQuOWejI+TMfBtuwbWt5XPnHx8CPLO1zp+/o25mNQ0vUl9Jb2Qbqelc+gIVimWNuL
	 Q7I/hT4I9tLKIcaiilt/tN1WxuVAFldQuzWa8fuVoALcV2bMaDUC0mEXkE164i5Cm0
	 /7tMkI3N2ntge/It4gRkCwHCPeGtAwCKQKXBrRyxaaX18hR8iN98UDn4g2qW8l/ADS
	 wpFjsDft0xfxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: connect: catch IO errors on listen side
Date: Sun, 21 Sep 2025 20:43:04 -0400
Message-ID: <20250922004304.3106590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092157-mullets-tweed-dee4@gregkh>
References: <2025092157-mullets-tweed-dee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 14e22b43df25dbd4301351b882486ea38892ae4f ]

IO errors were correctly printed to stderr, and propagated up to the
main loop for the server side, but the returned value was ignored. As a
consequence, the program for the listener side was no longer exiting
with an error code in case of IO issues.

Because of that, some issues might not have been seen. But very likely,
most issues either had an effect on the client side, or the file
transfer was not the expected one, e.g. the connection got reset before
the end. Still, it is better to fix this.

The main consequence of this issue is the error that was reported by the
selftests: the received and sent files were different, and the MIB
counters were not printed. Also, when such errors happened during the
'disconnect' tests, the program tried to continue until the timeout.

Now when an IO error is detected, the program exits directly with an
error.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-fix-sft-connect-v1-2-d40e77cbbf02@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index a842f5ade6e37..efa9a73d32eb9 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1005,6 +1005,7 @@ int main_loop_s(int listensock)
 	struct pollfd polls;
 	socklen_t salen;
 	int remotesock;
+	int err = 0;
 	int fd = 0;
 
 again:
@@ -1036,7 +1037,7 @@ int main_loop_s(int listensock)
 
 		SOCK_TEST_TCPULP(remotesock, 0);
 
-		copyfd_io(fd, remotesock, 1, true);
+		err = copyfd_io(fd, remotesock, 1, true, &winfo);
 	} else {
 		perror("accept");
 		return 1;
@@ -1045,10 +1046,10 @@ int main_loop_s(int listensock)
 	if (cfg_input)
 		close(fd);
 
-	if (--cfg_repeat > 0)
+	if (!err && --cfg_repeat > 0)
 		goto again;
 
-	return 0;
+	return err;
 }
 
 static void init_rng(void)
-- 
2.51.0


