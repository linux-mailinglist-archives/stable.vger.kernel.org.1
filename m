Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E9724B66
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 20:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbjFFS3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 14:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbjFFS3P (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 14:29:15 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F402E1717
        for <stable@vger.kernel.org>; Tue,  6 Jun 2023 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686076151; x=1717612151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4dR+NvpUQW1qLO92IlfMXeunBKtGHfm6bCXDqAxQkk=;
  b=oVzEoBS0zDzl55zpz6U5gsztdc+isa7UTBaveiWhcIhFj+ar3mbASlAm
   t2EH+i5CXJuOdPID08ir6O0xfXeWdw5eV1vGKekLn8oRNQWpm3vkZ+iyW
   6FZnfhGSclp5eaZI6BCxsL90KDmJ+ITRk29cdB1ru/Tf7zpfgqscTNuIB
   M=;
X-IronPort-AV: E=Sophos;i="6.00,221,1681171200"; 
   d="scan'208";a="8555200"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:29:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 3842080652;
        Tue,  6 Jun 2023 18:29:07 +0000 (UTC)
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 18:29:06 +0000
Received: from u46989501580c5c.ant.amazon.com (10.111.86.65) by
 EX19D001UWA002.ant.amazon.com (10.13.138.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 6 Jun 2023 18:29:06 +0000
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <benh@amazon.com>, Al Viro <viro@zeniv.linux.org.uk>,
        <stable@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>
Subject: [PATCH 4.14] Fix double fget() in vhost_net_set_backend()
Date:   Tue, 6 Jun 2023 11:28:31 -0700
Message-ID: <20230606182831.639358-1-samjonas@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.111.86.65]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA002.ant.amazon.com (10.13.138.236)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[4.14: Account for get_tap_skb_array() instead of get_tap_ptr_ring()]
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
---
 drivers/vhost/net.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 66212ba07cbc..c41197402d81 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1047,13 +1047,9 @@ static struct socket *get_raw_socket(int fd)
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
@@ -1062,7 +1058,6 @@ static struct skb_array *get_tap_skb_array(int fd)
 		goto out;
 	array = NULL;
 out:
-	fput(file);
 	return array;
 }
 
@@ -1143,8 +1138,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
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
-- 
2.25.1

