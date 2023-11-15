Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD187ECD2C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjKOTeu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjKOTet (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8C1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F0C433C9;
        Wed, 15 Nov 2023 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076885;
        bh=6fqWdQB2+GcsyUSk98XJA/S83mjnaedMeyTC/1AxSeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ukGBzTBSdwswyulNVi8mnf3AgsMB1JcPT705c9ga+kKIvSzicX4R2l47h/CBHG4uL
         sLBPyjRZMLLDhm0s2775bXHjy7G3/nqzP12ULBZODp7YbfoNVDkBid5RwLsWAEACHc
         /AQ4ixjsAvpdf5ZMxfK+lx3D5tVvb9lFeFHib+fA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 057/603] udp: add missing WRITE_ONCE() around up->encap_rcv
Date:   Wed, 15 Nov 2023 14:10:02 -0500
Message-ID: <20231115191617.074732924@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6d5a12eb91224d707f8691dccb40a5719fe5466d ]

UDP_ENCAP_ESPINUDP_NON_IKE setsockopt() writes over up->encap_rcv
while other cpus read it.

Fixes: 067b207b281d ("[UDP]: Cleanup UDP encapsulation code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1debc10a0f029..db43907b9a3e8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2675,10 +2675,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
-				up->encap_rcv = ipv6_stub->xfrm6_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   ipv6_stub->xfrm6_udp_encap_rcv);
 			else
 #endif
-				up->encap_rcv = xfrm4_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   xfrm4_udp_encap_rcv);
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
-- 
2.42.0



