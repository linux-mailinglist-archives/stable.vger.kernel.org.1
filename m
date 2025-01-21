Return-Path: <stable+bounces-109792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87DA183E8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A13A3143
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0A1F55F7;
	Tue, 21 Jan 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gRlrIwsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065291F55F0;
	Tue, 21 Jan 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482452; cv=none; b=slEwGnmRs33BL9meuVo3Qrrp2xqkB3fD4fon2YxcYnH7oVU/Kkje3ycRrwyotF3yK0h/+DNtPqAuFxSk52YEhL3mRauDwv+danyc8M/wyvI+Cf+yXAQWFsfjL5te/om0TdrFn4PNgwbwgh16HOfcfw4otlBQLRj0UmuHKLsHieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482452; c=relaxed/simple;
	bh=Vy7Ln0sOSx7MugrkP4AXkTYd8HOft1/9iY14k27SwZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4R7poHO9AdAX/bzwOpFVEyjH2QFK6AbECLRvhDgq1PK2TqjOwMvL++DYJDdatZ8VffNJ2yGZ+spyrGyOlH+tmjkyXEMNPW61FzsPVzYj6WH+dif7kJ0vuPDvEqlFiSQZNFLkE02ymbes2olrNpIG1AZt2rvuQUxvxfNYEg22rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gRlrIwsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB3C4CEDF;
	Tue, 21 Jan 2025 18:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482451;
	bh=Vy7Ln0sOSx7MugrkP4AXkTYd8HOft1/9iY14k27SwZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRlrIwsXcQ5wVDNmoA8Ct3kaWv570G9a2UYk4DCFO8pQkq3aLsVuXi25NgmMek/Ol
	 DWqyA9HCZPR2h5o21uc1ImaNJ5XzGE+kOIkGs6t8iVx7UW9RjOPSOSLNYEWJm3yphn
	 WefMO7pauLwsfHNGQ3gGa/a+sh6lOfLNDFoWc298=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 082/122] selftests: mptcp: avoid spurious errors on disconnect
Date: Tue, 21 Jan 2025 18:52:10 +0100
Message-ID: <20250121174536.171443909@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 218cc166321fb3cc8786677ffe0d09a78778a910 upstream.

The disconnect test-case generates spurious errors:

  INFO: disconnect
  INFO: extra options: -I 3 -i /tmp/tmp.r43niviyoI
  01 ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP (duration 140ms) [FAIL]
  file received by server does not match (in, out):
  Unexpected revents: POLLERR/POLLNVAL(19)
  -rw-r--r-- 1 root root 10028676 Jan 10 10:47 /tmp/tmp.r43niviyoI.disconnect
  Trailing bytes are:
  ��\����R���!8��u2��5N%
  -rw------- 1 root root 9992290 Jan 10 10:47 /tmp/tmp.Os4UbnWbI1
  Trailing bytes are:
  ��\����R���!8��u2��5N%
  02 ns1 MPTCP -> ns1 (dead:beef:1::1:10001) MPTCP (duration 206ms) [ OK ]
  03 ns1 MPTCP -> ns1 (dead:beef:1::1:10002) TCP   (duration  31ms) [ OK ]
  04 ns1 TCP   -> ns1 (dead:beef:1::1:10003) MPTCP (duration  26ms) [ OK ]
  [FAIL] Tests of the full disconnection have failed
  Time: 2 seconds

The root cause is actually in the user-space bits: the test program
currently disconnects as soon as all the pending data has been spooled,
generating an FASTCLOSE. If such option reaches the peer before the
latter has reached the closed status, the msk socket will report an
error to the user-space, as per protocol specification, causing the
above failure.

Address the issue explicitly waiting for all the relevant sockets to
reach a closed status before performing the disconnect.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250113-net-mptcp-connect-st-flakes-v1-3-0d986ee7b1b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c |   43 ++++++++++++++++------
 1 file changed, 32 insertions(+), 11 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -25,6 +25,8 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 
+#include <arpa/inet.h>
+
 #include <netdb.h>
 #include <netinet/in.h>
 
@@ -1211,23 +1213,42 @@ static void parse_setsock_options(const
 	exit(1);
 }
 
-void xdisconnect(int fd, int addrlen)
+void xdisconnect(int fd)
 {
-	struct sockaddr_storage empty;
+	socklen_t addrlen = sizeof(struct sockaddr_storage);
+	struct sockaddr_storage addr, empty;
 	int msec_sleep = 10;
-	int queued = 1;
-	int i;
+	void *raw_addr;
+	int i, cmdlen;
+	char cmd[128];
+
+	/* get the local address and convert it to string */
+	if (getsockname(fd, (struct sockaddr *)&addr, &addrlen) < 0)
+		xerror("getsockname");
+
+	if (addr.ss_family == AF_INET)
+		raw_addr = &(((struct sockaddr_in *)&addr)->sin_addr);
+	else if (addr.ss_family == AF_INET6)
+		raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
+	else
+		xerror("bad family");
+
+	strcpy(cmd, "ss -M | grep -q ");
+	cmdlen = strlen(cmd);
+	if (!inet_ntop(addr.ss_family, raw_addr, &cmd[cmdlen],
+		       sizeof(cmd) - cmdlen))
+		xerror("inet_ntop");
 
 	shutdown(fd, SHUT_WR);
 
-	/* while until the pending data is completely flushed, the later
+	/*
+	 * wait until the pending data is completely flushed and all
+	 * the MPTCP sockets reached the closed status.
 	 * disconnect will bypass/ignore/drop any pending data.
 	 */
 	for (i = 0; ; i += msec_sleep) {
-		if (ioctl(fd, SIOCOUTQ, &queued) < 0)
-			xerror("can't query out socket queue: %d", errno);
-
-		if (!queued)
+		/* closed socket are not listed by 'ss' */
+		if (system(cmd) != 0)
 			break;
 
 		if (i > poll_timeout)
@@ -1281,9 +1302,9 @@ again:
 		return ret;
 
 	if (cfg_truncate > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 	} else if (--cfg_repeat > 0) {
-		xdisconnect(fd, peer->ai_addrlen);
+		xdisconnect(fd);
 
 		/* the socket could be unblocking at this point, we need the
 		 * connect to be blocking



