Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC2726AF4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjFGUVU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjFGUVM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2159D26B8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA8964392
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245ABC4339B;
        Wed,  7 Jun 2023 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169224;
        bh=rOGwzp4wdvUK32NTUppxLuccKbf/zm39VBLfEOvqHA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTduEo803bW1HgiW+jJHkCqTyyoCvru9nlyr56v6KGk9g50Wqh3fT1PpeHuhCpFgX
         Bv5U79XR5nwzdqkAWwyVSy4979RD+g8o64m96xiyBJrtTNVEf4IljHjiLY2n4FXisT
         8o+T50u9UaxkQTCA/I30a52JW7n3pKMI5gigRG20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>
Subject: [PATCH 4.14 60/61] Fix double fget() in vhost_net_set_backend()
Date:   Wed,  7 Jun 2023 22:16:14 +0200
Message-ID: <20230607200855.836993540@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200835.310274198@linuxfoundation.org>
References: <20230607200835.310274198@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit fb4554c2232e44d595920f4d5c66cf8f7d13f9bc upstream.

Descriptor table is a shared resource; two fget() on the same descriptor
may return different struct file references.  get_tap_ptr_ring() is
called after we'd found (and pinned) the socket we'll be using and it
tries to find the private tun/tap data structures associated with it.
Redoing the lookup by the same file descriptor we'd used to get the
socket is racy - we need to same struct file.

Thanks to Jason for spotting a braino in the original variant of patch -
I'd missed the use of fd == -1 for disabling backend, and in that case
we can end up with sock == NULL and sock != oldsock.

Cc: stable@kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[4.14: Account for get_tap_skb_array() instead of get_tap_ptr_ring()]
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1047,13 +1047,9 @@ err:
 	return ERR_PTR(r);
 }
 
-static struct skb_array *get_tap_skb_array(int fd)
+static struct skb_array *get_tap_skb_array(struct file *file)
 {
 	struct skb_array *array;
-	struct file *file = fget(fd);
-
-	if (!file)
-		return NULL;
 	array = tun_get_skb_array(file);
 	if (!IS_ERR(array))
 		goto out;
@@ -1062,7 +1058,6 @@ static struct skb_array *get_tap_skb_arr
 		goto out;
 	array = NULL;
 out:
-	fput(file);
 	return array;
 }
 
@@ -1143,8 +1138,12 @@ static long vhost_net_set_backend(struct
 		vhost_net_disable_vq(n, vq);
 		vq->private_data = sock;
 		vhost_net_buf_unproduce(nvq);
-		if (index == VHOST_NET_VQ_RX)
-			nvq->rx_array = get_tap_skb_array(fd);
+		if (index == VHOST_NET_VQ_RX) {
+			if (sock)
+				nvq->rx_array = get_tap_skb_array(sock->file);
+			else
+				nvq->rx_array = NULL;
+		}
 		r = vhost_vq_init_access(vq);
 		if (r)
 			goto err_used;


