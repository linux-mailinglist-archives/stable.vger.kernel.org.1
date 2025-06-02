Return-Path: <stable+bounces-148508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE17ACA3ED
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 01:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6557F1886324
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094A628D8CA;
	Sun,  1 Jun 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXY1YJBm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4228D8C4;
	Sun,  1 Jun 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820661; cv=none; b=feMdwuPNQXP8VKjKzXx8R2ANAsKCzvHcXGWg82GSqywQsABGa+7AyHPKEt0guUjj4F8QwxA70FhYc3XJ3qdeY1WKVYm7+Broga4mSZ84IFagFgV0HkVyWUd+h4d5MtwLt9zxRCQHZdtasWElubopTXhciri+96xptCpxlQdywHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820661; c=relaxed/simple;
	bh=TLto0RxbMnRRa5lPrNxh/em4QAn4kW8P1T4XGKcs3gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbOK5/Z0m96oZGuE2orJwkzxAmzxss57KucG00I15Vbu9jfarhOYaJrcLf3Pz4tZCbxyiR47MEgE1lpd/7YvsiLQuehrTbvt5Dj2WYirteOIbltNzfEMdSgMdoMebhvDQLJ4yP3N4oV0ytnsT8kXN2fH2N5jkM3KZqB/+Q6bSn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXY1YJBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9248C4CEF2;
	Sun,  1 Jun 2025 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820661;
	bh=TLto0RxbMnRRa5lPrNxh/em4QAn4kW8P1T4XGKcs3gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXY1YJBmtm08nYxmAxRLCXiQ8BWCUfw7+/YCCipWiV67nDMjO14Xgm/zydOhALX8j
	 zLKEl6TJsuhwVxVGtiTTuAafalmPWOCkdi1bcwU7QfcJVAuTyRsU460ZHt9DKXRp8l
	 LCudZLymfuQexIXIqk3UstuThTS79TbZTc1/C5bEBIhb6V3t0k4MZhOesurcdDTtuK
	 Cd0xPbpY5xj+UcGbbViAepGueq5GGgZ9OTgmIb6/Py4ehZjeYtspkFWcIKAAMj44IS
	 tVaba0MFiqSiD9opxfBTdxVNmvDnvysOOYBnPbMx+AkQsaFly9unh44T13faVZdBnO
	 T5xUBk+I4F20g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>,
	Heming zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 032/102] dlm: use SHUT_RDWR for SCTP shutdown
Date: Sun,  1 Jun 2025 19:28:24 -0400
Message-Id: <20250601232937.3510379-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Transfer-Encoding: 8bit

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 55612ddb62fc12437a7ff2f27b51a8981bc187a4 ]

Currently SCTP shutdown() call gets stuck because there is no incoming
EOF indicator on its socket. On the peer side the EOF indicator as
recvmsg() returns 0 will be triggered as mechanism to flush the socket
queue on the receive side. In SCTP recvmsg() function sctp_recvmsg() we
can see that only if sk_shutdown has the bit RCV_SHUTDOWN set SCTP will
recvmsg() will return EOF. The RCV_SHUTDOWN bit will only be set when
shutdown with SHUT_RD is called. We use now SHUT_RDWR to also get a EOF
indicator from recvmsg() call on the shutdown() initiator.

SCTP does not support half closed sockets and the semantic of SHUT_WR is
different here, it seems that calling SHUT_WR on sctp sockets keeps the
socket open to have the possibility to do some specific SCTP operations on
it that we don't do here.

There exists still a difference in the limitations of TCP vs SCTP in
case if we are required to have a half closed socket functionality. This
was tried to archieve with DLM protocol changes in the past and
hopefully we really don't require half closed socket functionality.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Tested-by: Heming zhao <heming.zhao@suse.com>
Reviewed-by: Heming zhao <heming.zhao@suse.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis, here is my assessment: **YES** This commit should
be backported to stable kernel trees. ## Analysis ### The Problem The
commit addresses a critical functional issue in DLM (Distributed Lock
Manager) when using SCTP protocol. The issue is that SCTP shutdown
operations get stuck because there's no incoming EOF indicator on the
socket, preventing proper connection cleanup. ### Root Cause Analysis
from Code Changes 1. **Current behavior (before patch)**: DLM always
uses `SHUT_WR` for both TCP and SCTP protocols in
`kernel_sock_shutdown(con->sock, SHUT_WR)` at line 813 in the
`shutdown_connection()` function. 2. **SCTP-specific problem**: Unlike
TCP, SCTP requires both read and write shutdown (`SHUT_RDWR`) to
properly trigger the EOF condition. The commit message explains that
SCTP's `recvmsg()` function (`sctp_recvmsg()`) only returns EOF when
`sk_shutdown` has the `RCV_SHUTDOWN` bit set, which only happens with
`SHUT_RD` or `SHUT_RDWR`. 3. **The fix**: The patch introduces a new
`how` field in the `dlm_proto_ops` structure and sets: - TCP: `SHUT_WR`
(maintains existing behavior) - SCTP: `SHUT_RDWR` (fixes the EOF
detection issue) ### Why This Should Be Backported 1. **Critical Bug
Fix**: This fixes a fundamental functional issue where DLM connections
using SCTP cannot properly shutdown, leading to stuck operations. 2.
**Minimal and Contained Change**: - Adds only one new field to a
protocol operations structure - Changes only the shutdown method
parameter based on protocol - No architectural changes or new features
3. **Clear Side Effects Assessment**: The change is protocol-specific
and maintains backward compatibility. TCP behavior is unchanged, and
SCTP behavior is fixed to work as intended. 4. **Follows Stable Tree
Rules**: - Fixes an important bug affecting users of DLM with SCTP -
Small, well-contained change with minimal regression risk - No
introduction of new features 5. **Historical Context**: Looking at the
git history, there have been multiple fixes for DLM shutdown handling,
indicating this is an actively maintained and critical subsystem. This
specific fix addresses a protocol-level compatibility issue that has
likely affected users. 6. **Similar Backport Patterns**: This is similar
to "Similar Commit #1" which was marked as YES - it's a contained fix
for connection handling in DLM with clear problem scope and minimal code
changes. The fix is essential for environments using DLM with SCTP
protocol, as without it, proper connection shutdown is impossible,
leading to resource leaks and potentially affecting cluster operations.

 fs/dlm/lowcomms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 70abd4da17a63..90abcd07f8898 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -160,6 +160,7 @@ struct dlm_proto_ops {
 	bool try_new_addr;
 	const char *name;
 	int proto;
+	int how;
 
 	void (*sockopts)(struct socket *sock);
 	int (*bind)(struct socket *sock);
@@ -810,7 +811,7 @@ static void shutdown_connection(struct connection *con, bool and_other)
 		return;
 	}
 
-	ret = kernel_sock_shutdown(con->sock, SHUT_WR);
+	ret = kernel_sock_shutdown(con->sock, dlm_proto_ops->how);
 	up_read(&con->sock_lock);
 	if (ret) {
 		log_print("Connection %p failed to shutdown: %d will force close",
@@ -1858,6 +1859,7 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 static const struct dlm_proto_ops dlm_tcp_ops = {
 	.name = "TCP",
 	.proto = IPPROTO_TCP,
+	.how = SHUT_WR,
 	.sockopts = dlm_tcp_sockopts,
 	.bind = dlm_tcp_bind,
 	.listen_validate = dlm_tcp_listen_validate,
@@ -1896,6 +1898,7 @@ static void dlm_sctp_sockopts(struct socket *sock)
 static const struct dlm_proto_ops dlm_sctp_ops = {
 	.name = "SCTP",
 	.proto = IPPROTO_SCTP,
+	.how = SHUT_RDWR,
 	.try_new_addr = true,
 	.sockopts = dlm_sctp_sockopts,
 	.bind = dlm_sctp_bind,
-- 
2.39.5


