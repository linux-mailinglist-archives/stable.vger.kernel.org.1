Return-Path: <stable+bounces-180360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBBB7F226
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E34E4A4791
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC573328978;
	Wed, 17 Sep 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/e3GyA6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45518FDBD;
	Wed, 17 Sep 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114215; cv=none; b=jhRyR0JzpZCPyjGp8MDQWZfD9iCe2KtwmOBmKBw/t+CL9wGbrYutrV9VlmcnllhoqTnLzJGq70ZI8P4R2LD7i7Vyauz1S2OGQKj64IsuoeJRTHEO4l/YArmIxYIrkoeQfW5J3F/yE3A6ReUkjABRBawTcUikxkXek/FsXg+Tuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114215; c=relaxed/simple;
	bh=JlntoDesyhZq9cnCAEmgSlprw7eg4psbv6LP4I/3zl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6odvLtPhy+X/EYTeVnIjgGUxIsPTj2EtuAac/wrOrGyGm3NxMxMur38NK4YyU6otH3NT3zVuYft5FYVQcrm5/cuKni0a6iKwLe0xQrWJCadO6P3WCFhQkwbv8zwc+RIW0BSWa2SjcFGSkYwaE/DgtUH9eSj6AXfItn4/KV1lJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/e3GyA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D3BC4CEF5;
	Wed, 17 Sep 2025 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758114215;
	bh=JlntoDesyhZq9cnCAEmgSlprw7eg4psbv6LP4I/3zl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/e3GyA6sIxk8TyKmGJ68aTyl7k6QjuCOweWIoG5/1ohfhHdlzWXF733kwYhrBBL0
	 u0SvtD9/ZRp4zdG0WrGlzFUU3OQy56yvSC2v9Ni1qNmnEghv6A4RmNQzBOA5sKoC7P
	 FT4hHF8OGWAThidIb7MkTa8mz4xQ8AVRHeTASXCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krister Johansen <kjlx@templeofstupid.com>,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 26/78] mptcp: sockopt: make sync_socket_options propagate SOCK_KEEPOPEN
Date: Wed, 17 Sep 2025 14:34:47 +0200
Message-ID: <20250917123330.202164820@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krister Johansen <kjlx@templeofstupid.com>

commit 648de37416b301f046f62f1b65715c7fa8ebaa67 upstream.

Users reported a scenario where MPTCP connections that were configured
with SO_KEEPALIVE prior to connect would fail to enable their keepalives
if MTPCP fell back to TCP mode.

After investigating, this affects keepalives for any connection where
sync_socket_options is called on a socket that is in the closed or
listening state.  Joins are handled properly. For connects,
sync_socket_options is called when the socket is still in the closed
state.  The tcp_set_keepalive() function does not act on sockets that
are closed or listening, hence keepalive is not immediately enabled.
Since the SO_KEEPOPEN flag is absent, it is not enabled later in the
connect sequence via tcp_finish_connect.  Setting the keepalive via
sockopt after connect does work, but would not address any subsequently
created flows.

Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on the
subflow when calling sync_socket_options.

The fix was valdidated both by using tcpdump to observe keepalive
packets not being sent before the fix, and being sent after the fix.  It
was also possible to observe via ss that the keepalive timer was not
enabled on these sockets before the fix, but was enabled afterwards.

Fixes: 1b3e7ede1365 ("mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY")
Cc: stable@vger.kernel.org
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/aL8dYfPZrwedCIh9@templeofstupid.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1347,13 +1347,12 @@ static void sync_socket_options(struct m
 {
 	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
 	struct sock *sk = (struct sock *)msk;
+	bool keep_open;
 
-	if (ssk->sk_prot->keepalive) {
-		if (sock_flag(sk, SOCK_KEEPOPEN))
-			ssk->sk_prot->keepalive(ssk, 1);
-		else
-			ssk->sk_prot->keepalive(ssk, 0);
-	}
+	keep_open = sock_flag(sk, SOCK_KEEPOPEN);
+	if (ssk->sk_prot->keepalive)
+		ssk->sk_prot->keepalive(ssk, keep_open);
+	sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
 
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;



