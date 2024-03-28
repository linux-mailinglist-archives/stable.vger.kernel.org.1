Return-Path: <stable+bounces-26055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE1870CCB
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BE31C2518E
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39B93B795;
	Mon,  4 Mar 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XFxjSq27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B410A1F;
	Mon,  4 Mar 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587727; cv=none; b=uMj7wxFlt8q6WsLViQhbfrls3YRwG9iSwplGxrTta62+z1HhuXEJ9UguynA5JCko+a+iLbQ3S8lE2N8/lyXDABtWb9A43JOhLBbOwq9v8DkVgDSm90JS4JxjvEkERHFbw5CNm6kZhkS3ZkzmjAVTnotzOJn8HEKc6ZQOhOoSGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587727; c=relaxed/simple;
	bh=Bd114RjLk/AtBYYvjmd1oml3Scf0AlMU2pZpXS465U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNzyNoCNnkNMiGMYA3HXJWyEv+8A3RgRJhdWobvQq8GF1EuShlj6bAPDPJptDogCljQBE+AnGl9Ax59xgooTX1LydpgwUd+vAoF/DUy6hyBs7b2y5glGkF489FZy2aJ4pE9bKwvYU+0olByGYOR8LAdeOFhmLg8T2po/LPpuRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XFxjSq27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E05C433F1;
	Mon,  4 Mar 2024 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587727;
	bh=Bd114RjLk/AtBYYvjmd1oml3Scf0AlMU2pZpXS465U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFxjSq27zVjaX9lj9f2QZ2ipghAEmScWUsWXWsotokPMNmx9HTJsQZ2BiyaCxK8Am
	 GxYlY+bhAUNiVS/T8I/qlroAZd3PdkAu4GwbzrfvfzMzjyG5IKdpwFGQjm9r+FHr1k
	 xwDMI1ODkwwZ4pB7wW5QXwwWvjG0EcryQBXmzoes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 042/162] tls: separate no-async decryption request handling from async
Date: Mon,  4 Mar 2024 21:21:47 +0000
Message-ID: <20240304211553.195504734@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
References: <20240304211551.833500257@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 41532b785e9d79636b3815a64ddf6a096647d011 ]

If we're not doing async, the handling is much simpler. There's no
reference counting, we just need to wait for the completion to wake us
up and return its result.

We should preferably also use a separate crypto_wait. I'm not seeing a
UAF as I did in the past, I think aec7961916f3 ("tls: fix race between
async notify and socket close") took care of it.

This will make the next fix easier.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/47bde5f649707610eaef9f0d679519966fc31061.1709132643.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 13114dc55430 ("tls: fix use-after-free on failed backlog decryption")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1394fc44f3788..1fd37fe13ffd8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -274,9 +274,15 @@ static int tls_do_decryption(struct sock *sk,
 		DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
@@ -285,10 +291,7 @@ static int tls_do_decryption(struct sock *sk,
 		ret = ret ?: -EINPROGRESS;
 	}
 	if (ret == -EINPROGRESS) {
-		if (darg->async)
-			return 0;
-
-		ret = crypto_wait_req(ret, &ctx->async_wait);
+		return 0;
 	} else if (darg->async) {
 		atomic_dec(&ctx->decrypt_pending);
 	}
-- 
2.43.0




