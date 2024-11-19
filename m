Return-Path: <stable+bounces-93948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF59D2457
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BF51F239A9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532001C2301;
	Tue, 19 Nov 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utIUs9p+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEAA1C07F9;
	Tue, 19 Nov 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013955; cv=none; b=o/6aB1RXudkcd5sdiN8Gc8p/siwDxQAs5tXB+uoDn2JjmytaUgqp8d6ZbVlVHAABefkd9jNMWqX3QA7q7HbBaOIeMDGt1wAUXUCXfic1hBOUSwVJGa7obrHHpa3vtqjMVRAb7W79Bc6DUXSen848XVIerkIqsn5ZWPWUpjPVevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013955; c=relaxed/simple;
	bh=JVbnu0sAQ/YKJbs+i4PxYwD1ttKgXN1HQFfLAjGEJTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJuHEv2nhDsnk907uNgOisuSkYmkDhe5Q35FjUr6IPGhPwhHiVqiCXeIB3oP2y0DM0hH2TP1DQnPIkXaINdQsEBmHujBOdrdWYrRUBP18crjXviCKu4owv4QDgyKo3VlxUl1gtvUCNKU42PwiFNRBbQBM/f4d/qrSq5TH69bVIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utIUs9p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF0DC4CECF;
	Tue, 19 Nov 2024 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732013954;
	bh=JVbnu0sAQ/YKJbs+i4PxYwD1ttKgXN1HQFfLAjGEJTw=;
	h=From:To:Cc:Subject:Date:From;
	b=utIUs9p+rXGG/rUh78inRfp+aX0okAXhuhTfr+UwdOX/dJdWCcdv0dCc/iyhbpgjO
	 z8kTkvunGAEhH3nW6aiNSIzmNSfkcrnx8bhcGu20/8LzQtKiEekKcx5R6JdQYEtHL9
	 n8Hx27ETAV5jrPe3REQcgaFgpxLEeAIHNEIbtSXxvhtyycl7NsLCuz24n3XFkl6Ljq
	 qu2+/QJsNqCSebXIZtzGwCCpWMjV8/dFgMngdFAE0d+MkT4Bi14CLBBHf6S7oHTZaU
	 gq1/J7DwsrlnJl77EMDwLQvQA4KqrTEqGfwpjPJ/Zr31IfBYC9XmNUGknDzztgrpk1
	 ej20xfsoSlw+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Tue, 19 Nov 2024 11:58:59 +0100
Message-ID: <20241119105858.3494900-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=matttbe@kernel.org; h=from:subject; bh=K/yzLVBVKv8VyVxf+d0AlQvJI8/Ma/Ji3Y7ZjJX2y6Q=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPG9yRcu4JBlHcEyzPkuKKJtWdaZFEoTfZX+P2 1WXLwkVceSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxvcgAKCRD2t4JPQmmg c0k0EADpQwFeGh7AF8tm6wE7KgOxOqTgWw9bHKcG40r9l/hz0JkHlFc508PQfqWkpkSr24dTa8q ItlT+W7V7m15Va9OCz8V6Ko5GAacO2yUOtl5E91WYvtn6Xi6ZIYFdYv0nSTUO/00X0tbOi5Oaly SkwgFXCx41FN4XBtk5x84tORqwuJhPu0TLSwIT6+GDegrPA8xDDbRmwEw8rwY+USwn0zDZKFaL6 8VND8gbVMl2HUXywG6Dgr7NDhdlhTwJ6luidaKpHoQz1gHXA/KlsfcM86lFYH+t6OlVhWbvv4w3 9bT9dY6ADsfazrtp5DkFUVYEU2KKCtHIpQHxRcguxn8kgVFXMsi82EPyEiaYXyEKxXrWI135pY5 1fgj0o378zAOsJdyXyblrc20bLTDyhrCOtsxmy4MoBAOKgfI0p6lj4r+TXspzhIzGnWnpaAG5EH Aw5Lm1SnAH/OAhwbI3awByJrS3CkM9kXgPpoVN+XgZv0VE8khtk1mEkt+Y2gmB+DZUEDDqQtNdB 028dfyif6Cx5PEDIVabqgSpPTXhihc1tQoeFzc1TG63J0JeagHC/C3XEcPEl4VXkwAA7UPiuKBw jeNo4wkzTTQCUYtYsnQm67fjJfpp7MAlGbLGvhlHlf5wRKfE8oqQEkxvsLOj01KEUa0DexsFRaZ Z9ap7S58MAAAKBg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit ce7356ae35943cc6494cc692e62d51a734062b7d upstream.

Additional active subflows - i.e. created by the in kernel path
manager - are included into the subflow list before starting the
3whs.

A racing recvmsg() spooling data received on an already established
subflow would unconditionally call tcp_cleanup_rbuf() on all the
current subflows, potentially hitting a divide by zero error on
the newly created ones.

Explicitly check that the subflow is in a suitable state before
invoking tcp_cleanup_rbuf().

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit f410cbea9f3d ("tcp: annotate
  data-races around tp->window_clamp") has not been backported to this
  version. The conflict is easy to resolve, because only the context is
  different, but not the line to modify. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 34c98596350e..bcbb1f92ce24 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1986,7 +1986,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				tcp_sk(ssk)->window_clamp = window_clamp;
-				tcp_cleanup_rbuf(ssk, 1);
+				if (tcp_can_send_ack(ssk))
+					tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
 		}
-- 
2.45.2


