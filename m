Return-Path: <stable+bounces-95167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5AB9D76C8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8BFBE6C8D
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F2233565;
	Sun, 24 Nov 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoNdwaJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7B923355B;
	Sun, 24 Nov 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456223; cv=none; b=tGCpMV5AzlBN0YKz+zNRCwncDh6u7n387DEI/T+rprcsHlY9LI5d/J1EKrAn/W9U700XnvJYXfmuHQMJlIPscYDX5RMObzkgAP7eh9jgJMQ/NqWIN2ny9SkoiFK/yPz7B+KAKQ1/CR/8Sx+S3ISmkPdBmTT0lzEQ1MUAFlUhjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456223; c=relaxed/simple;
	bh=w9JPbwdPRzEeAVQYLEJ1St/BssbsSv/B8KXtxIjLXTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjHSbdt3Z5ZYECIvR5hn4iwJ0o32BKumAyeSvxWzCd0En7xD8xiPGkp4Lj4ryhKGgUORrCu5wG3TnYNdMKX50KIIYg//vimC4Edft/Zur3cop96DhImxOmp8pF6BuUfwO8JrNNUk5SOG1bLWHigdJsDPCg/Xh11lx6soZcjBXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoNdwaJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E931DC4CED1;
	Sun, 24 Nov 2024 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456223;
	bh=w9JPbwdPRzEeAVQYLEJ1St/BssbsSv/B8KXtxIjLXTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IoNdwaJGtjeONjmXvjSzakUwXAhJAs/KuBhPwNwNZ3aLr+q6IzQUL01DPbr1UP40W
	 VixcnqC1Ng1YBqaTLZl+joXGUMYkWtKVUUytv6dF7jvFaELHc+0f94qGaBJibM8Dk9
	 JOspb9pV/b5Sg2b0ldKDBqmYSO1L6mdVFP+G+l2NjXLGOfwnexqusKeXGe5LCIbwS9
	 kWOHuEZ3pSSiP2vzJkAFkl/WzAICTkQKhIfisf+swyb6kckNs9DMGc56CVFb6YNh+m
	 OBxYQVNPqVLJjXdZ5SHqlPMAu8KG3zWowm6wm+ac2DfKEqy98I5yzYHe3LeMFi8669
	 gGwn3vsw+Lvvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/48] Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
Date: Sun, 24 Nov 2024 08:48:39 -0500
Message-ID: <20241124134950.3348099-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 7c4f78cdb8e7501e9f92d291a7d956591bf73be9 ]

bt_sock_alloc() allocates the sk object and attaches it to the provided
sock object. On error l2cap_sock_alloc() frees the sk object, but the
dangling pointer is still attached to the sock object, which may create
use-after-free in other code.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241014153808.51894-3-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b17782dc513b5..4e965916c17c1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1920,6 +1920,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	chan = l2cap_chan_create();
 	if (!chan) {
 		sk_free(sk);
+		sock->sk = NULL;
 		return NULL;
 	}
 
-- 
2.43.0


