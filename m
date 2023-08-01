Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B976AE09
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjHAJft (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjHAJf0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3D139
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77BAB614DF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D34C433C7;
        Tue,  1 Aug 2023 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882393;
        bh=75BZq0c91+Yt3neqveQ/7DYVu5WES6CMi2WU0hq0NGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcRTOvbSjwpE1WpKVZG5P+ZyPHEj3UtAET+WuIVedUJ6rcaNp+ESOqjDTK46fqn8n
         OL51U9AYz/Gc2OvF75bn5j0gNY3Zfg+yRSA/9vFYkvFPtrgr4SXjTzXln4GOTPCj+E
         G5dvFwGcZi0ezlBPUsYiin5YJxsirrQuTDC3cB40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 090/228] vxlan: fix GRO with VXLAN-GPE
Date:   Tue,  1 Aug 2023 11:19:08 +0200
Message-ID: <20230801091926.096897319@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit b0b672c4d0957e5897685667fc848132b8bd2d71 ]

In VXLAN-GPE, there may not be an Ethernet header following the VXLAN
header. But in GRO, the vxlan driver calls eth_gro_receive
unconditionally, which means the following header is incorrectly parsed
as Ethernet.

Introduce GPE specific GRO handling.

For better performance, do not check for GPE during GRO but rather
install a different set of functions at setup time.

Fixes: e1e5314de08ba ("vxlan: implement GPE")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 84 ++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 0dc7326fd6ed4..0c3eb850fcb79 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -722,26 +722,24 @@ static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 	return vh;
 }
 
-static struct sk_buff *vxlan_gro_receive(struct sock *sk,
-					 struct list_head *head,
-					 struct sk_buff *skb)
+static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
+						  struct list_head *head,
+						  struct sk_buff *skb,
+						  struct gro_remcsum *grc)
 {
-	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
-	int flush = 1;
 	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
 	__be32 flags;
-	struct gro_remcsum grc;
 
-	skb_gro_remcsum_init(&grc);
+	skb_gro_remcsum_init(grc);
 
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh = skb_gro_header(skb, hlen, off_vx);
 	if (unlikely(!vh))
-		goto out;
+		return NULL;
 
 	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
 
@@ -749,12 +747,12 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 
 	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
 		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
-				       vh->vx_vni, &grc,
+				       vh->vx_vni, grc,
 				       !!(vs->flags &
 					  VXLAN_F_REMCSUM_NOPARTIAL));
 
 		if (!vh)
-			goto out;
+			return NULL;
 	}
 
 	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
@@ -771,12 +769,48 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 		}
 	}
 
-	pp = call_gro_receive(eth_gro_receive, head, skb);
-	flush = 0;
+	return vh;
+}
+
+static struct sk_buff *vxlan_gro_receive(struct sock *sk,
+					 struct list_head *head,
+					 struct sk_buff *skb)
+{
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	int flush = 1;
 
-out:
+	if (vxlan_gro_prepare_receive(sk, head, skb, &grc)) {
+		pp = call_gro_receive(eth_gro_receive, head, skb);
+		flush = 0;
+	}
 	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
+	return pp;
+}
 
+static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
+					     struct list_head *head,
+					     struct sk_buff *skb)
+{
+	const struct packet_offload *ptype;
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	struct vxlanhdr *vh;
+	__be16 protocol;
+	int flush = 1;
+
+	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
+	if (vh) {
+		if (!vxlan_parse_gpe_proto(vh, &protocol))
+			goto out;
+		ptype = gro_find_receive_by_type(protocol);
+		if (!ptype)
+			goto out;
+		pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
+		flush = 0;
+	}
+out:
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 	return pp;
 }
 
@@ -788,6 +822,21 @@ static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
 }
 
+static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+{
+	struct vxlanhdr *vh = (struct vxlanhdr *)(skb->data + nhoff);
+	const struct packet_offload *ptype;
+	int err = -ENOSYS;
+	__be16 protocol;
+
+	if (!vxlan_parse_gpe_proto(vh, &protocol))
+		return err;
+	ptype = gro_find_complete_by_type(protocol);
+	if (ptype)
+		err = ptype->callbacks.gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+	return err;
+}
+
 static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
 					 __u16 state, __be32 src_vni,
 					 __u16 ndm_flags)
@@ -3416,8 +3465,13 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	tunnel_cfg.encap_rcv = vxlan_rcv;
 	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	tunnel_cfg.gro_receive = vxlan_gro_receive;
-	tunnel_cfg.gro_complete = vxlan_gro_complete;
+	if (vs->flags & VXLAN_F_GPE) {
+		tunnel_cfg.gro_receive = vxlan_gpe_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gpe_gro_complete;
+	} else {
+		tunnel_cfg.gro_receive = vxlan_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gro_complete;
+	}
 
 	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
 
-- 
2.39.2



