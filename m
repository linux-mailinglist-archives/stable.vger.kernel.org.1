Return-Path: <stable+bounces-10067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E30827242
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA049284496
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EC34C617;
	Mon,  8 Jan 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jOM1urPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248C4C3D3;
	Mon,  8 Jan 2024 15:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54185C433CD;
	Mon,  8 Jan 2024 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726656;
	bh=oOjhZJDvPL9vbNrfuljvWfLLLg7gUUpkCgfw+CR/gsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOM1urPoZUeTUdD65H5Vhz9miuENCabgq4f9hG95BQNrfjlyWysWt9kx2zD7k8b03
	 3g/MKE6VpB256i8h4z8CJhI5jDR2DRbd3gKKXzRvjpr8fkN6cf1bFpsu1ToZq3c36E
	 /0m0gBB840bmPen+3AMYDpclqajllJLAAkfIo76c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?J=C3=B6rn-Thorben=20Hinz?= <jthinz@mailbox.tu-berlin.de>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/124] net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)
Date: Mon,  8 Jan 2024 16:07:43 +0100
Message-ID: <20240108150604.685264562@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>

[ Upstream commit 7f6ca95d16b96567ce4cf458a2790ff17fa620c3 ]

Commit 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW") added the new
socket option SO_TIMESTAMPING_NEW. Setting the option is handled in
sk_setsockopt(), querying it was not handled in sk_getsockopt(), though.

Following remarks on an earlier submission of this patch, keep the old
behavior of getsockopt(SO_TIMESTAMPING_OLD) which returns the active
flags even if they actually have been set through SO_TIMESTAMPING_NEW.

The new getsockopt(SO_TIMESTAMPING_NEW) is stricter, returning flags
only if they have been set through the same option.

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")
Link: https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-berlin.de/
Link: https://lore.kernel.org/netdev/0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com/
Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bfaf47b3f3c7c..fe687e6170c9a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1718,9 +1718,16 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TIMESTAMPING_OLD:
+	case SO_TIMESTAMPING_NEW:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
-		v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		/* For the later-added case SO_TIMESTAMPING_NEW: Be strict about only
+		 * returning the flags when they were set through the same option.
+		 * Don't change the beviour for the old case SO_TIMESTAMPING_OLD.
+		 */
+		if (optname == SO_TIMESTAMPING_OLD || sock_flag(sk, SOCK_TSTAMP_NEW)) {
+			v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
+			v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
+		}
 		break;
 
 	case SO_RCVTIMEO_OLD:
-- 
2.43.0




