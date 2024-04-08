Return-Path: <stable+bounces-36617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C589C0E4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E66284CC4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160F84FCE;
	Mon,  8 Apr 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyfn9nKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05B84D03;
	Mon,  8 Apr 2024 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581850; cv=none; b=IwuvUPJKirwej5CEkHZyts9dgNoob3TZjCa+aXBlpnf/Uv10gRNkOnz5u+l/pcc29JS0vA6RygFKhDN+3+j0dszL3fUqQ/4PbDBjDtYkHuZjmNHWMwnOTaNpXe6DPjDx6v8BTdaxVoHSlOMzRTiUqNKIPyy6MiTSa+cMO03HCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581850; c=relaxed/simple;
	bh=p1uNTQT6UPwmAHYzicBYzeC6DJIx9bSfW3BgnCeOxCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey70TbiD/+oHlCh8a+UQYcjat1ifQ8Rw/AayZ3o8DoNzQYj0vNRMImQV0tTA6VDJe5jJTrRNdj48wpkdqPNs1Nia5xgwanDe0CRCMQHhmpqiS7MKGYO98Jw6A6ikQ0gOGdaRz9/xGo9RVZ96g2K4jZ2D/DqPjjdqkxSIk5+tFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iyfn9nKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CB7C43330;
	Mon,  8 Apr 2024 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581849;
	bh=p1uNTQT6UPwmAHYzicBYzeC6DJIx9bSfW3BgnCeOxCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyfn9nKJjZXS6yj9/oPM8BK86V++JO8yYRfo8AGNzGO8EZK9vQt7ak3Ay24V5vUYh
	 72+8V/dCvBVppbgQl6ninsKkavzFUmdh9/wqgxjabUyiS+93tUJffX/scP2JYu8JdM
	 FrDwpgACF/GDWYeDlYfpj7EUrveoNueIqUUJVAuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/252] tls: get psock ref after taking rxlock to avoid leak
Date: Mon,  8 Apr 2024 14:55:30 +0200
Message-ID: <20240408125307.612069168@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 417e91e856099e9b8a42a2520e2255e6afe024be ]

At the start of tls_sw_recvmsg, we take a reference on the psock, and
then call tls_rx_reader_lock. If that fails, we return directly
without releasing the reference.

Instead of adding a new label, just take the reference after locking
has succeeded, since we don't need it before.

Fixes: 4cbc325ed6b4 ("tls: rx: allow only one reader at a time")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/fe2ade22d030051ce4c3638704ed58b67d0df643.1711120964.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 925de4caa894a..df166f6afad82 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1976,10 +1976,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return sock_recv_errqueue(sk, msg, len, SOL_IP, IP_RECVERR);
 
-	psock = sk_psock_get(sk);
 	err = tls_rx_reader_lock(sk, ctx, flags & MSG_DONTWAIT);
 	if (err < 0)
 		return err;
+	psock = sk_psock_get(sk);
 	bpf_strp_enabled = sk_psock_strp_enabled(psock);
 
 	/* If crypto failed the connection is broken */
-- 
2.43.0




