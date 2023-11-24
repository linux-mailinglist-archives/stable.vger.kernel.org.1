Return-Path: <stable+bounces-1907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B087F81F0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839E2283994
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10522364A5;
	Fri, 24 Nov 2023 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZHRBtC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C031748;
	Fri, 24 Nov 2023 19:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FCDC433C7;
	Fri, 24 Nov 2023 19:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852568;
	bh=xTOTfzIgItQdgQBJE+dEEEM/rBtGdVXPy/WG8zokwhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZHRBtC7ZZ+hu8vY9IISKbtVVbygXfKCOsNvCk+jRWq4kUty3xagxF8aagcc2z6ET
	 pd0R0LQ/iS/WK/MnWnPpRxLIEViTJ7SPLaFuyGHHDq85/tWN/8mx8T3lTYFEn21PVT
	 MpI6D16VXUiHygB2AWmaiTVn1CKQ187uR7rMSdtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 011/193] net: annotate data-races around sk->sk_tx_queue_mapping
Date: Fri, 24 Nov 2023 17:52:18 +0000
Message-ID: <20231124171947.625706059@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0bb4d124d34044179b42a769a0c76f389ae973b6 ]

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 234196d904238..9d5e603a10f5a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1853,21 +1853,33 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 	/* sk_tx_queue_mapping accept only upto a 16-bit value */
 	if (WARN_ON_ONCE((unsigned short)tx_queue >= USHRT_MAX))
 		return;
-	sk->sk_tx_queue_mapping = tx_queue;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
 }
 
 #define NO_QUEUE_MAPPING	USHRT_MAX
 
 static inline void sk_tx_queue_clear(struct sock *sk)
 {
-	sk->sk_tx_queue_mapping = NO_QUEUE_MAPPING;
+	/* Paired with READ_ONCE() in sk_tx_queue_get() and
+	 * other WRITE_ONCE() because socket lock might be not held.
+	 */
+	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
 }
 
 static inline int sk_tx_queue_get(const struct sock *sk)
 {
-	if (sk && sk->sk_tx_queue_mapping != NO_QUEUE_MAPPING)
-		return sk->sk_tx_queue_mapping;
+	if (sk) {
+		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
+		 * and sk_tx_queue_set().
+		 */
+		int val = READ_ONCE(sk->sk_tx_queue_mapping);
 
+		if (val != NO_QUEUE_MAPPING)
+			return val;
+	}
 	return -1;
 }
 
-- 
2.42.0




