Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B4775DB9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjHILko (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjHILkm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0983173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E1363648
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C69C433C7;
        Wed,  9 Aug 2023 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581241;
        bh=CIMRSvkXtM78MKU2tiik/PQwCgTy/UK9oHNc2N2kuJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6lj6M060uSgMGgotiUdrLhpqMiMHdF39TnNPmTQRRIO08+hPLky+O/R8p+rJIUqX
         UU3Umnv0OjQhAD612NKEvOFbzy8jexv0+53ScnCyqEiJHt8gWwhzUWRxgaePHTF/0C
         nx9ZlP0V4k94EjcLos8JXfOI/tUZVvQb1WQgCR94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 156/201] tcp_metrics: fix addr_same() helper
Date:   Wed,  9 Aug 2023 12:42:38 +0200
Message-ID: <20230809103648.942139655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
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

[ Upstream commit e6638094d7af6c7b9dcca05ad009e79e31b4f670 ]

Because v4 and v6 families use separate inetpeer trees (respectively
net->ipv4.peers and net->ipv6.peers), inetpeer_addr_cmp(a, b) assumes
a & b share the same family.

tcp_metrics use a common hash table, where entries can have different
families.

We must therefore make sure to not call inetpeer_addr_cmp()
if the families do not match.

Fixes: d39d14ffa24c ("net: Add helper function to compare inetpeer addresses")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230802131500.1478140-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index f3ca6eea2ca39..3fe7eb3bc84c9 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -78,7 +78,7 @@ static void tcp_metric_set(struct tcp_metrics_block *tm,
 static bool addr_same(const struct inetpeer_addr *a,
 		      const struct inetpeer_addr *b)
 {
-	return inetpeer_addr_cmp(a, b) == 0;
+	return (a->family == b->family) && !inetpeer_addr_cmp(a, b);
 }
 
 struct tcpm_hash_bucket {
-- 
2.40.1



