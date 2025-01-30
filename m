Return-Path: <stable+bounces-111402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B38A22EFB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7251816418C
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24C1E7C08;
	Thu, 30 Jan 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EA2QKibj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4721DDE9;
	Thu, 30 Jan 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246633; cv=none; b=NkQDPLSiaoSKOFKNqdI9QSAM5cBPsug9z3eg9Vm5jTDVfJTzucHe6NkwDtuWpLclxdOf1YLCVvp62ucekpnxiOxlBIPi7d5yJPDv7DbVqaEjZwfX61AXzYNCRT7AQ9U4yP7x5MNbv6rLUxQ2N6yRZTnA8Zz81kUs247IIE0kxD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246633; c=relaxed/simple;
	bh=5vCsNbS/cDwM7t8qflC3tn/BjIaWi5C7ZcXcKwy0iMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0bbMazRR7j6i6UFyBKMGjBrWfbTdfZE0LP1+RssF6co3Ph24wxmXkVA/T2Hg3xDe3DyKXqiAqtCd2ug3f4njyZdyMWgd/nFvCuXCb7N2tgx+7GR4ZO0a2J8nmTFLBZGvhDG+/mRYjSiHGwyQr6Tz7WhfeZ1dC59Nwvy5yrPnJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EA2QKibj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85FAC4CED2;
	Thu, 30 Jan 2025 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246633;
	bh=5vCsNbS/cDwM7t8qflC3tn/BjIaWi5C7ZcXcKwy0iMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EA2QKibjrqtxK7xTHoynwXyWyRbACUNhPPZWKV4FbUX13UH0hxGd2nijBw0cNb/S7
	 SKnXDKMkE/9KsmHnsoau1+AJuvWepuk5aYkiiXWL6Tyy8DkcMXRihaUf1gLGTEOnd+
	 k1mLropI36ZKDXxZGNT4HGRGhgLNHl2yrI/qFwco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Xing <kernelxing@tencent.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 07/91] tcp/dccp: complete lockless accesses to sk->sk_max_ack_backlog
Date: Thu, 30 Jan 2025 15:00:26 +0100
Message-ID: <20250130140133.965144277@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
References: <20250130140133.662535583@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 9a79c65f00e2b036e17af3a3a607d7d732b7affb ]

Since commit 099ecf59f05b ("net: annotate lockless accesses to
sk->sk_max_ack_backlog") decided to handle the sk_max_ack_backlog
locklessly, there is one more function mostly called in TCP/DCCP
cases. So this patch completes it:)

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240331090521.71965-1-kerneljasonxing@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3479c7549fb1 ("tcp/dccp: allow a connection when sk_max_ack_backlog is zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 180ff3ca823a..c81bbfc5f4df 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -285,7 +285,7 @@ static inline int inet_csk_reqsk_queue_len(const struct sock *sk)
 
 static inline int inet_csk_reqsk_queue_is_full(const struct sock *sk)
 {
-	return inet_csk_reqsk_queue_len(sk) >= sk->sk_max_ack_backlog;
+	return inet_csk_reqsk_queue_len(sk) >= READ_ONCE(sk->sk_max_ack_backlog);
 }
 
 bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req);
-- 
2.39.5




