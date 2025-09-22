Return-Path: <stable+bounces-181353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66912B93119
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F5F1881211
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB792517AC;
	Mon, 22 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INRqN+MJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9511253B5C;
	Mon, 22 Sep 2025 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570329; cv=none; b=ezq1TOEO4dvgRQY/CHM2TzA6g4y3V3pcbOohD8zhFyyMj1O0zDa1+HR2HNg6XErfFAdXymTZDL7CaBr3Dnh8W4/Dk9PwpQWlrdqrMUskM575ZJfIrcI+XBNlfk+LztU5KsJY2zKTFx7Slw8nAmobeZ87Q6V7BZhDDrQEE1L3DBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570329; c=relaxed/simple;
	bh=SqqKkPGF79c5dGQnY9D5uNWTkldB8wYR8PoByOdjSSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhRRndPGWC0lrVa4tvlzIDHZB+gg6JOPHnO2O1N4s0ERDpqO6PbROUkyo9Zj8jlDzseOh5xUcfRFoH5/C+E833yj2z4KRJ5MiB42ieF/K0F2AE2sJ9jT82rwnE2Lw08xHtWcLI6V8QlXWKwRHwj7jZ4epRlZ7YNiE0Yf/uLj79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INRqN+MJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44291C4CEF0;
	Mon, 22 Sep 2025 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570329;
	bh=SqqKkPGF79c5dGQnY9D5uNWTkldB8wYR8PoByOdjSSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INRqN+MJzD1m5a2HIMK/AFCVBuXNlw/Wj3pp/4DPjrBCKKGEqZW7zoo2KhiU+keOb
	 ipqTTUAOklO9kJIStJMsKQgLS4tOHa+RGPZBcK+Px94QXArIWTbv8ubxRRe9yNwRfa
	 EgZJYhJ7fiCiZadCsmW1IGiAPlmdOLiJOQJbct2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.16 106/149] selftests: mptcp: avoid spurious errors on TCP disconnect
Date: Mon, 22 Sep 2025 21:30:06 +0200
Message-ID: <20250922192415.554142042@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 8708c5d8b3fb3f6d5d3b9e6bfe01a505819f519a upstream.

The disconnect test-case, with 'plain' TCP sockets generates spurious
errors, e.g.

  07 ns1 TCP   -> ns1 (dead:beef:1::1:10006) MPTCP
  read: Connection reset by peer
  read: Connection reset by peer
  (duration   155ms) [FAIL] client exit code 3, server 3

  netns ns1-FloSdv (listener) socket stat for 10006:
  TcpActiveOpens                  2                  0.0
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       274                0.0
  TcpOutSegs                      276                0.0
  TcpOutRsts                      3                  0.0
  TcpExtPruneCalled               2                  0.0
  TcpExtRcvPruned                 1                  0.0
  TcpExtTCPPureAcks               104                0.0
  TcpExtTCPRcvCollapsed           2                  0.0
  TcpExtTCPBacklogCoalesce        42                 0.0
  TcpExtTCPRcvCoalesce            43                 0.0
  TcpExtTCPChallengeACK           1                  0.0
  TcpExtTCPFromZeroWindowAdv      42                 0.0
  TcpExtTCPToZeroWindowAdv        41                 0.0
  TcpExtTCPWantZeroWindowAdv      13                 0.0
  TcpExtTCPOrigDataSent           164                0.0
  TcpExtTCPDelivered              165                0.0
  TcpExtTCPRcvQDrop               1                  0.0

In the failing scenarios (TCP -> MPTCP), the involved sockets are
actually plain TCP ones, as fallbacks for passive sockets at 2WHS time
cause the MPTCP listeners to actually create 'plain' TCP sockets.

Similar to commit 218cc166321f ("selftests: mptcp: avoid spurious errors
on disconnect"), the root cause is in the user-space bits: the test
program tries to disconnect as soon as all the pending data has been
spooled, generating an RST. If such option reaches the peer before the
connection has reached the closed status, the TCP socket will report an
error to the user-space, as per protocol specification, causing the
above failure. Note that it looks like this issue got more visible since
the "tcp: receiver changes" series from commit 06baf9bfa6ca ("Merge
branch 'tcp-receiver-changes'").

Address the issue by explicitly waiting for the TCP sockets (-t) to
reach a closed status before performing the disconnect. More precisely,
the test program now waits for plain TCP sockets or TCP subflows in
addition to the MPTCP sockets that were already monitored.

While at it, use 'ss' with '-n' to avoid resolving service names, which
is not needed here.

Fixes: 218cc166321f ("selftests: mptcp: avoid spurious errors on disconnect")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250912-net-mptcp-fix-sft-connect-v1-3-d40e77cbbf02@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1248,7 +1248,7 @@ void xdisconnect(int fd)
 	else
 		xerror("bad family");
 
-	strcpy(cmd, "ss -M | grep -q ");
+	strcpy(cmd, "ss -Mnt | grep -q ");
 	cmdlen = strlen(cmd);
 	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
 		       sizeof(cmd) - cmdlen))
@@ -1258,7 +1258,7 @@ void xdisconnect(int fd)
 
 	/*
 	 * wait until the pending data is completely flushed and all
-	 * the MPTCP sockets reached the closed status.
+	 * the sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {



