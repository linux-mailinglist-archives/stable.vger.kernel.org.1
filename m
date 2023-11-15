Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FA67ECDCE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjKOTif (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjKOTic (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1ACC433C7;
        Wed, 15 Nov 2023 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077108;
        bh=OlfyErGyX0odEDUQQka69xXSiHkSfo8f/D8wS6pmKmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmhPmBWH6LY13HTUr/UaPTGVdsCj9zPPXp3mEKsoX+y4W6Mz3EEGNAnBFwb6aZS8Z
         YFUiyDrmAScJYFR+o5aFIWiHZk+jQYTuCJ0GqLUSymAdhbGKVXy9CtEzWaDixjkBui
         +PDYUn81lZ9SretVwt+WGjE/oAqyN8ijD2wWOJDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 501/550] rxrpc: Fix two connection reaping bugs
Date:   Wed, 15 Nov 2023 14:18:05 -0500
Message-ID: <20231115191635.652692742@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 61e4a86600029e6e8d468d1fad6b6c749bebed19 ]

Fix two connection reaping bugs:

 (1) rxrpc_connection_expiry is in units of seconds, so
     rxrpc_disconnect_call() needs to multiply it by HZ when adding it to
     jiffies.

 (2) rxrpc_client_conn_reap_timeout() should set RXRPC_CLIENT_REAP_TIMER if
     local->kill_all_client_conns is clear, not if it is set (in which case
     we don't need the timer).  Without this, old client connections don't
     get cleaned up until the local endpoint is cleaned up.

Fixes: 5040011d073d ("rxrpc: Make the local endpoint hold a ref on a connected call")
Fixes: 0d6bf319bc5a ("rxrpc: Move the client conn cache management to the I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/783911.1698364174@warthog.procyon.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_object.c  | 2 +-
 net/rxrpc/local_object.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ac85d4644a3c3..df8a271948a1c 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -212,7 +212,7 @@ void rxrpc_disconnect_call(struct rxrpc_call *call)
 		conn->idle_timestamp = jiffies;
 		if (atomic_dec_and_test(&conn->active))
 			rxrpc_set_service_reap_timer(conn->rxnet,
-						     jiffies + rxrpc_connection_expiry);
+						     jiffies + rxrpc_connection_expiry * HZ);
 	}
 
 	rxrpc_put_call(call, rxrpc_call_put_io_thread);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 7d910aee4f8cb..c553a30e9c838 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -87,7 +87,7 @@ static void rxrpc_client_conn_reap_timeout(struct timer_list *timer)
 	struct rxrpc_local *local =
 		container_of(timer, struct rxrpc_local, client_conn_reap_timer);
 
-	if (local->kill_all_client_conns &&
+	if (!local->kill_all_client_conns &&
 	    test_and_set_bit(RXRPC_CLIENT_CONN_REAP_TIMER, &local->client_conn_flags))
 		rxrpc_wake_up_io_thread(local);
 }
-- 
2.42.0



