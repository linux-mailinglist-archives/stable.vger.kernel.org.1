Return-Path: <stable+bounces-119014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCEA423BB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DFD19C21B4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1CE18C03D;
	Mon, 24 Feb 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VfiG08i7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD72629F;
	Mon, 24 Feb 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408026; cv=none; b=uZV7HAtuTtbqKfUu384TSVDPmnt9Q7fcat186QJE6VbTcTlXRXdgJQSb/or5iZt+LNgtuv8hw+2aK/+oucy/icYZ02jgkPyyVFbIe5uo5OzIpZTMAmFfDJApUNrrXgySHeJbwJ0LiGpizM0HP1hYB0vSnz6v1FouKHauKibq6kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408026; c=relaxed/simple;
	bh=2DHtY+vWK0X4lyigSotbh0qX7bFCHP9QBXkCKohzafY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WArMgHonOI9Ldsjx0Xlw4LJqQDi3oc/dwyQRF9At9ut+BVpssh4T5qjMzDDIv1pKgp4vQ4opbLFGcZMtLzUPB7E8elpE4fOjkLjah3dTu0LO8j6zVgJbdpyfXmYMWZDpV+k7M9UmYmvnK5tHFIQ07x6hThjWuaS8dR9MjWmpOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VfiG08i7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4669EC4CEE6;
	Mon, 24 Feb 2025 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408026;
	bh=2DHtY+vWK0X4lyigSotbh0qX7bFCHP9QBXkCKohzafY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VfiG08i7R3GzF4k34r/1TsYEb8s6I4WUMMltQsNQ+G5a89d3aN/JxRNxJnUBFSjAk
	 JkWeFSaxvLynVwSJKcWqzMCx5sbySSA87HAueF+w9YRWhMG3FZJF8WFZe1UP1RZI7y
	 BcS22j0EHgFrqssAXObee069xRUrnavY19JiCplM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Luczaj <mhal@rbox.co>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/140] sockmap, vsock: For connectible sockets allow only connected
Date: Mon, 24 Feb 2025 15:34:38 +0100
Message-ID: <20250224142606.115574681@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142602.998423469@linuxfoundation.org>
References: <20250224142602.998423469@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Luczaj <mhal@rbox.co>

[ Upstream commit 8fb5bb169d17cdd12c2dcc2e96830ed487d77a0f ]

sockmap expects all vsocks to have a transport assigned, which is expressed
in vsock_proto::psock_update_sk_prot(). However, there is an edge case
where an unconnected (connectible) socket may lose its previously assigned
transport. This is handled with a NULL check in the vsock/BPF recv path.

Another design detail is that listening vsocks are not supposed to have any
transport assigned at all. Which implies they are not supported by the
sockmap. But this is complicated by the fact that a socket, before
switching to TCP_LISTEN, may have had some transport assigned during a
failed connect() attempt. Hence, we may end up with a listening vsock in a
sockmap, which blows up quickly:

KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_read_skb+0x4b/0x90
Call Trace:
 sk_psock_verdict_data_ready+0xa4/0x2e0
 virtio_transport_recv_pkt+0x1ca8/0x2acc
 vsock_loopback_work+0x27d/0x3f0
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x35a/0x700
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

For connectible sockets, instead of relying solely on the state of
vsk->transport, tell sockmap to only allow those representing established
connections. This aligns with the behaviour for AF_INET and AF_UNIX.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f37a26efdd8ab..dcc0f31a17a8d 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -538,6 +538,9 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
 		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+	if (sk_is_vsock(sk) &&
+	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
+		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
 	return true;
 }
 
-- 
2.39.5




