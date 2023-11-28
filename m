Return-Path: <stable+bounces-2950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F7F7FC6BC
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555921C21CEC
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA542A8E;
	Tue, 28 Nov 2023 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUWKB/Ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01044366;
	Tue, 28 Nov 2023 21:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A163C43391;
	Tue, 28 Nov 2023 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205587;
	bh=9ytLVkmHZqvhfNXT/1h9vXWCr39HinFs1JKWjyuBsgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUWKB/EvZSdranSeWkj3qv0jRl1NsnXnHx4GpG6Y1leyYQx9sDbOWbipKYYUTMiA5
	 tTqRUBVenr2hKJoKS3Hy4Z6ZSfRGQJVTI2OprxAE6JkvhjH1qeyFk2DyUwBmgeoBoY
	 P+ThFK+jrYwqouMP5G6B1ee+XRKhJSjATbnttaLmul/MzzzvJSdTNI/UeaC1lqcB+W
	 hz446MDNT4Bg6AnDz2DCTJ9LO0kg0xqFrkg63Q+WeG6dulPd33atqUZhJdPQQOJqZ6
	 zs4iKUJVS+aHeFPk0rNNPlHAx+Op8m+ceNsBtcMK2UtwUvcgEt+zd1dSc0sbHqJdDO
	 qsAWxnmb8NCmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 04/40] rxrpc: Fix some minor issues with bundle tracing
Date: Tue, 28 Nov 2023 16:05:10 -0500
Message-ID: <20231128210615.875085-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0c3bd086d12d185650d095a906662593ec607bd0 ]

Fix some superficial issues with the tracing of rxrpc_bundle structs,
including:

 (1) Set the debug_id when the bundle is allocated rather than when it is
     set up so that the "NEW" trace line displays the correct bundle ID.

 (2) Show the refcount when emitting the "FREE" traceline.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_client.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 981ca5b98bcb9..1d95f8bc769fa 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -73,6 +73,7 @@ static void rxrpc_destroy_client_conn_ids(struct rxrpc_local *local)
 static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 					       gfp_t gfp)
 {
+	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle;
 
 	bundle = kzalloc(sizeof(*bundle), gfp);
@@ -85,6 +86,7 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		bundle->upgrade		= test_bit(RXRPC_CALL_UPGRADE, &call->flags);
 		bundle->service_id	= call->dest_srx.srx_service;
 		bundle->security_level	= call->security_level;
+		bundle->debug_id	= atomic_inc_return(&rxrpc_bundle_id);
 		refcount_set(&bundle->ref, 1);
 		atomic_set(&bundle->active, 1);
 		INIT_LIST_HEAD(&bundle->waiting_calls);
@@ -105,7 +107,8 @@ struct rxrpc_bundle *rxrpc_get_bundle(struct rxrpc_bundle *bundle,
 
 static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 {
-	trace_rxrpc_bundle(bundle->debug_id, 1, rxrpc_bundle_free);
+	trace_rxrpc_bundle(bundle->debug_id, refcount_read(&bundle->ref),
+			   rxrpc_bundle_free);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
 	kfree(bundle);
@@ -239,7 +242,6 @@ static bool rxrpc_may_reuse_conn(struct rxrpc_connection *conn)
  */
 int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 {
-	static atomic_t rxrpc_bundle_id;
 	struct rxrpc_bundle *bundle, *candidate;
 	struct rxrpc_local *local = call->local;
 	struct rb_node *p, **pp, *parent;
@@ -306,7 +308,6 @@ int rxrpc_look_up_bundle(struct rxrpc_call *call, gfp_t gfp)
 	}
 
 	_debug("new bundle");
-	candidate->debug_id = atomic_inc_return(&rxrpc_bundle_id);
 	rb_link_node(&candidate->local_node, parent, pp);
 	rb_insert_color(&candidate->local_node, &local->client_bundles);
 	call->bundle = rxrpc_get_bundle(candidate, rxrpc_bundle_get_client_call);
-- 
2.42.0


