Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69374761644
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjGYLhk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjGYLhf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:37:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031D10E7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F13061654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5A8C433C7;
        Tue, 25 Jul 2023 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285052;
        bh=7HsFQeCRoK63FAX6HPF64WdWiIYG9Bu4g4EvkJOPKec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ch09IyfBOXEcQgeYIsLm4Lspl/VSVVu1GVJQUnaPhklnxl9zVKB5t68Xbow/yK5Vy
         EUa7tqQZv+1+2GgtkTsQ5jSDDPKuy6JXWgeH/cYLfUjyqRK2ew+bzrHZDxIkAai/6S
         CwNCDEvHr+lC7Ok/mUXxjQy/ErNljOe0nT+o9b+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/313] netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
Date:   Tue, 25 Jul 2023 12:43:40 +0200
Message-ID: <20230725104523.898560586@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit ff0a3a7d52ff7282dbd183e7fc29a1fe386b0c30 ]

Eric Dumazet says:
  nf_conntrack_dccp_packet() has an unique:

  dh = skb_header_pointer(skb, dataoff, sizeof(_dh), &_dh);

  And nothing more is 'pulled' from the packet, depending on the content.
  dh->dccph_doff, and/or dh->dccph_x ...)
  So dccp_ack_seq() is happily reading stuff past the _dh buffer.

BUG: KASAN: stack-out-of-bounds in nf_conntrack_dccp_packet+0x1134/0x11c0
Read of size 4 at addr ffff000128f66e0c by task syz-executor.2/29371
[..]

Fix this by increasing the stack buffer to also include room for
the extra sequence numbers and all the known dccp packet type headers,
then pull again after the initial validation of the basic header.

While at it, mark packets invalid that lack 48bit sequence bit but
where RFC says the type MUST use them.

Compile tested only.

v2: first skb_header_pointer() now needs to adjust the size to
    only pull the generic header. (Eric)

Heads-up: I intend to remove dccp conntrack support later this year.

Fixes: 2bc780499aa3 ("[NETFILTER]: nf_conntrack: add DCCP protocol support")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_dccp.c | 52 +++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_dccp.c b/net/netfilter/nf_conntrack_proto_dccp.c
index b3f4a334f9d78..67b8dedef2935 100644
--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -430,9 +430,19 @@ static bool dccp_error(const struct dccp_hdr *dh,
 		       struct sk_buff *skb, unsigned int dataoff,
 		       const struct nf_hook_state *state)
 {
+	static const unsigned long require_seq48 = 1 << DCCP_PKT_REQUEST |
+						   1 << DCCP_PKT_RESPONSE |
+						   1 << DCCP_PKT_CLOSEREQ |
+						   1 << DCCP_PKT_CLOSE |
+						   1 << DCCP_PKT_RESET |
+						   1 << DCCP_PKT_SYNC |
+						   1 << DCCP_PKT_SYNCACK;
 	unsigned int dccp_len = skb->len - dataoff;
 	unsigned int cscov;
 	const char *msg;
+	u8 type;
+
+	BUILD_BUG_ON(DCCP_PKT_INVALID >= BITS_PER_LONG);
 
 	if (dh->dccph_doff * 4 < sizeof(struct dccp_hdr) ||
 	    dh->dccph_doff * 4 > dccp_len) {
@@ -457,10 +467,17 @@ static bool dccp_error(const struct dccp_hdr *dh,
 		goto out_invalid;
 	}
 
-	if (dh->dccph_type >= DCCP_PKT_INVALID) {
+	type = dh->dccph_type;
+	if (type >= DCCP_PKT_INVALID) {
 		msg = "nf_ct_dccp: reserved packet type ";
 		goto out_invalid;
 	}
+
+	if (test_bit(type, &require_seq48) && !dh->dccph_x) {
+		msg = "nf_ct_dccp: type lacks 48bit sequence numbers";
+		goto out_invalid;
+	}
+
 	return false;
 out_invalid:
 	nf_l4proto_log_invalid(skb, state->net, state->pf,
@@ -468,24 +485,53 @@ static bool dccp_error(const struct dccp_hdr *dh,
 	return true;
 }
 
+struct nf_conntrack_dccp_buf {
+	struct dccp_hdr dh;	 /* generic header part */
+	struct dccp_hdr_ext ext; /* optional depending dh->dccph_x */
+	union {			 /* depends on header type */
+		struct dccp_hdr_ack_bits ack;
+		struct dccp_hdr_request req;
+		struct dccp_hdr_response response;
+		struct dccp_hdr_reset rst;
+	} u;
+};
+
+static struct dccp_hdr *
+dccp_header_pointer(const struct sk_buff *skb, int offset, const struct dccp_hdr *dh,
+		    struct nf_conntrack_dccp_buf *buf)
+{
+	unsigned int hdrlen = __dccp_hdr_len(dh);
+
+	if (hdrlen > sizeof(*buf))
+		return NULL;
+
+	return skb_header_pointer(skb, offset, hdrlen, buf);
+}
+
 int nf_conntrack_dccp_packet(struct nf_conn *ct, struct sk_buff *skb,
 			     unsigned int dataoff,
 			     enum ip_conntrack_info ctinfo,
 			     const struct nf_hook_state *state)
 {
 	enum ip_conntrack_dir dir = CTINFO2DIR(ctinfo);
-	struct dccp_hdr _dh, *dh;
+	struct nf_conntrack_dccp_buf _dh;
 	u_int8_t type, old_state, new_state;
 	enum ct_dccp_roles role;
 	unsigned int *timeouts;
+	struct dccp_hdr *dh;
 
-	dh = skb_header_pointer(skb, dataoff, sizeof(_dh), &_dh);
+	dh = skb_header_pointer(skb, dataoff, sizeof(*dh), &_dh.dh);
 	if (!dh)
 		return NF_DROP;
 
 	if (dccp_error(dh, skb, dataoff, state))
 		return -NF_ACCEPT;
 
+	/* pull again, including possible 48 bit sequences and subtype header */
+	dh = dccp_header_pointer(skb, dataoff, dh, &_dh);
+	if (!dh)
+		return NF_DROP;
+
 	type = dh->dccph_type;
 	if (!nf_ct_is_confirmed(ct) && !dccp_new(ct, skb, dh))
 		return -NF_ACCEPT;
-- 
2.39.2



