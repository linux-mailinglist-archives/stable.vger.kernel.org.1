Return-Path: <stable+bounces-129787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAADA8011F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A409B188B600
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE53269B12;
	Tue,  8 Apr 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhJFgxST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBA269B0B;
	Tue,  8 Apr 2025 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111978; cv=none; b=E4YEuJgJLRydN+doHR86aUTnRGG4zMKwUo5dGqvJJOus+aU0AodB4/4mBltauRAcsBm9IhO1N1W6601r8j76F/o6sEooiLaThfMHNmW/ekjtfB4b8Sy7+Hru0XNdpwSZ2BCJILvXdhHSWZDadKqLlPT9FpThMzBkd0ux+Wa8xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111978; c=relaxed/simple;
	bh=zUY1w6U9c7yD6MvaZe+SpuYXdTnNuXKd7AZFSSCJxdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXjKqVCJ8ryqQo/zIvWJpleiIfar1cZV3cszl+KI0ZXBJ/seW401l83z0jJ0tpHO1jzQgPlEXL7XqvywKAd8fnYCHDpL6hSqXPDCvZw5x5BVqp/256d7KVdsqWB+lkgHVkaYlP7K7AkaqkwSqmxgopUb/nNDVt3CUKxasCPzNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhJFgxST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC2C4CEE5;
	Tue,  8 Apr 2025 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111978;
	bh=zUY1w6U9c7yD6MvaZe+SpuYXdTnNuXKd7AZFSSCJxdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhJFgxST9m9IvuFrIZ/rrOQetdU9rs2byztWU1jVKW8kDdAbE6s5kn14DFkQxlaip
	 fGNEPLOViv41WdpNhBvACEc13iJeBg/+ctf54cTRaJf+LhnEEseQV8pjgUC97MRmP1
	 SoGiXBi2AEDPwq5rYRcHlkQsEVesy5hXgJwqhnc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luigi Leonardi <leonardi@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 629/731] vsock: avoid timeout during connect() if the socket is closing
Date: Tue,  8 Apr 2025 12:48:46 +0200
Message-ID: <20250408104928.902153113@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit fccd2b711d9628c7ce0111d5e4938652101ee30a ]

When a peer attempts to establish a connection, vsock_connect() contains
a loop that waits for the state to be TCP_ESTABLISHED. However, the
other peer can be fast enough to accept the connection and close it
immediately, thus moving the state to TCP_CLOSING.

When this happens, the peer in the vsock_connect() is properly woken up,
but since the state is not TCP_ESTABLISHED, it goes back to sleep
until the timeout expires, returning -ETIMEDOUT.

If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
vsock_connect() can return immediately without errors or delay since the
connection actually happened. The socket will be in a closing state,
but this is not an issue, and subsequent calls will fail as expected.

We discovered this issue while developing a test that accepts and
immediately closes connections to stress the transport switch between
two connect() calls, where the first one was interrupted by a signal
(see Closes link).

Reported-by: Luigi Leonardi <leonardi@redhat.com>
Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Link: https://patch.msgid.link/20250328141528.420719-1-sgarzare@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/af_vsock.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7e3db87ae4333..fc6afbc8d6806 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1551,7 +1551,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 	timeout = vsk->connect_timeout;
 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
+	/* If the socket is already closing or it is in an error state, there
+	 * is no point in waiting.
+	 */
+	while (sk->sk_state != TCP_ESTABLISHED &&
+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
 		if (flags & O_NONBLOCK) {
 			/* If we're not going to block, we schedule a timeout
 			 * function to generate a timeout on the connection
-- 
2.39.5




