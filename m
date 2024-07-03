Return-Path: <stable+bounces-57080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D506925A91
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1B1C20C99
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4517967E;
	Wed,  3 Jul 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTmxmFO8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68217084B;
	Wed,  3 Jul 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003783; cv=none; b=S711M6CRGo0gZzesROhG+c47+Z60klHSGIotwvuiRHYUQmREcLfUDfmJTlTcd18XuHv88fETnlP/yHiSIAdCAUO494Hss6ur+hCM86buIVowYx9cPPd4F9zDnwtOMWTBAxUH+F9wKbrMQx6xlWdEkYneU/SdHMgqi9flet1O2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003783; c=relaxed/simple;
	bh=+AGyhvmwQEhGaaYpyxKo95vrhRLlfNcUsKH4q1jDsfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWdqaIcrwNoU9+fGRjClZBHlPyCUQamGJfvLC+w4HEiK3kZPWfojRQYnAAIsaX4A41mFbXojMHamp0Tlh27QdTwXk6BOkizcdeqh3dJOJtpKL9RUFZ30m5x8ICmptjUejs17lrYhP7Cm9+80o5OHwD6PlhIjgLFpJMNhKWh1Ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTmxmFO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BB7C2BD10;
	Wed,  3 Jul 2024 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003783;
	bh=+AGyhvmwQEhGaaYpyxKo95vrhRLlfNcUsKH4q1jDsfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTmxmFO8zIeApiApPJ7te0kGOU4I2WaKfuS7VXGteIa5mk6BduY4m30I6vr01Qy/n
	 av1dUctx0IC5/TfE+pdpmRS2uLLgiZ7TvhzX1tBrCRk3IKC/yzu63+pkSFBH6GvKTt
	 WLw+84UHDfMlQDZyVS7AKrbN8SPiwYWLwN/TIc0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 020/189] af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
Date: Wed,  3 Jul 2024 12:38:01 +0200
Message-ID: <20240703102842.267638877@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 5d915e584d8408211d4567c22685aae8820bfc55 ]

We can dump the socket queue length via UNIX_DIAG by specifying
UDIAG_SHOW_RQLEN.

If sk->sk_state is TCP_LISTEN, we return the recv queue length,
but here we do not hold recvq lock.

Let's use skb_queue_len_lockless() in sk_diag_show_rqlen().

Fixes: c9da99e6475f ("unix_diag: Fixup RQLEN extension report")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 4666fabb04933..5bc5cb83cc6e4 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -103,7 +103,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 	struct unix_diag_rqlen rql;
 
 	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
-		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
+		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
 		rql.udiag_rqueue = (u32) unix_inq_len(sk);
-- 
2.43.0




