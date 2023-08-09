Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550C5775771
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjHIKqG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjHIKqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FC1FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0047763118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF49C433C8;
        Wed,  9 Aug 2023 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577962;
        bh=WxVAyr/b4Gr6p7QN1M4qGkQb40nfA+WCxuQltzZRve4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdXIKGjPDVrN/G2F3rlwDO/rv3x+/39dajX2EXnEtCx5eVbmwmClP0k2b0dejNfs5
         oQC3SlYb/Ty+bWZ5QELYsX2CM6aNl1NhTJr9pIgSrQzcKmsn/jwnCtALbJvT4RbQhh
         mG/lh5rtApKwgiitXDmRoH+NynQyuNIOjalBQzYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 056/165] net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
Date:   Wed,  9 Aug 2023 12:39:47 +0200
Message-ID: <20230809103644.650329245@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b4b553253091cafe9ec38994acf42795e073bef5 ]

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_rcvbuf locklessly.

Fixes: ebb3b78db7bf ("tcp: annotate sk->sk_rcvbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index c5dfeb6d4fec6..8c69610753ec2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1630,7 +1630,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RCVBUF:
-		v.val = sk->sk_rcvbuf;
+		v.val = READ_ONCE(sk->sk_rcvbuf);
 		break;
 
 	case SO_REUSEADDR:
-- 
2.40.1



