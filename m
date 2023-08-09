Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D4775770
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHIKqD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjHIKqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A391702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F9663118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4783CC433C8;
        Wed,  9 Aug 2023 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577959;
        bh=zGFqPIRayeR0UzzCbeh5lyXPU4rH8PGANK5r2JhQ4k4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bt6Th8kTBLudqtUThDhI7OK3Q4nqCB8aMg24atSwHLcORNupCTVCu8IWcd8M9ykvt
         glD+UnEJL6nr3F3P5/hdJy9SaZlAx+ZvC8kQceq4Im6Jia4aeRp8aO2RwtrUCAE6Bh
         hJ5FxVZleTZtLmNc6EX1n7K/z3frnYuknNw3tJOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 055/165] net: add missing READ_ONCE(sk->sk_sndbuf) annotation
Date:   Wed,  9 Aug 2023 12:39:46 +0200
Message-ID: <20230809103644.620117085@linuxfoundation.org>
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

[ Upstream commit 74bc084327c643499474ba75df485607da37dd6e ]

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_sndbuf locklessly.

Fixes: e292f05e0df7 ("tcp: annotate sk->sk_sndbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index aed5d09a41c4b..c5dfeb6d4fec6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1626,7 +1626,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_SNDBUF:
-		v.val = sk->sk_sndbuf;
+		v.val = READ_ONCE(sk->sk_sndbuf);
 		break;
 
 	case SO_RCVBUF:
-- 
2.40.1



