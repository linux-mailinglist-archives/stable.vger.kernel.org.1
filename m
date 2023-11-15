Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5829F7ED18D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjKOUCb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbjKOUCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:02:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF8AF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:02:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D2CC433CD;
        Wed, 15 Nov 2023 20:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078539;
        bh=nH2a8o0L9NYb0/ehyMyJJueZb0jtAoMRHedvDJy/MIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZWl3aUvKYIbgUj1SEgabeSlQBcbrldw+Eo+t8QcWSZPgb8ANKA5l7T929zJid6nY
         nCP4luLnldzg50zyYPxt2CaPmCxbAjqnzPW0vCnfC1eME5BmR04bPRkqXqWN6+v+yn
         yC/7x2DX+XyR34JusaPG0Q+2GS1lIXlHonHrDiWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daan De Meyer <daan.j.demeyer@gmail.com>,
        Luigi Leonardi <luigi.leonardi@outlook.com>,
        Filippo Storniolo <f.storniolo95@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 360/379] vsock/virtio: remove socket from connected/bound list on shutdown
Date:   Wed, 15 Nov 2023 14:27:15 -0500
Message-ID: <20231115192706.456212444@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filippo Storniolo <f.storniolo95@gmail.com>

[ Upstream commit 3a5cc90a4d1756072619fe511d07621bdef7f120 ]

If the same remote peer, using the same port, tries to connect
to a server on a listening port more than once, the server will
reject the connection, causing a "connection reset by peer"
error on the remote peer. This is due to the presence of a
dangling socket from a previous connection in both the connected
and bound socket lists.
The inconsistency of the above lists only occurs when the remote
peer disconnects and the server remains active.

This bug does not occur when the server socket is closed:
virtio_transport_release() will eventually schedule a call to
virtio_transport_do_close() and the latter will remove the socket
from the bound and connected socket lists and clear the sk_buff.

However, virtio_transport_do_close() will only perform the above
actions if it has been scheduled, and this will not happen
if the server is processing the shutdown message from a remote peer.

To fix this, introduce a call to vsock_remove_sock()
when the server is handling a client disconnect.
This is to remove the socket from the bound and connected socket
lists without clearing the sk_buff.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Tested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a1581c77cf84a..73e5093928325 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1108,11 +1108,17 @@ virtio_transport_recv_connected(struct sock *sk,
 			vsk->peer_shutdown |= RCV_SHUTDOWN;
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
 			vsk->peer_shutdown |= SEND_SHUTDOWN;
-		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
-		    vsock_stream_has_data(vsk) <= 0 &&
-		    !sock_flag(sk, SOCK_DONE)) {
-			(void)virtio_transport_reset(vsk, NULL);
-			virtio_transport_do_close(vsk, true);
+		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
+			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
+				(void)virtio_transport_reset(vsk, NULL);
+				virtio_transport_do_close(vsk, true);
+			}
+			/* Remove this socket anyway because the remote peer sent
+			 * the shutdown. This way a new connection will succeed
+			 * if the remote peer uses the same source port,
+			 * even if the old socket is still unreleased, but now disconnected.
+			 */
+			vsock_remove_sock(vsk);
 		}
 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
 			sk->sk_state_change(sk);
-- 
2.42.0



