Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA526FA878
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjEHKlO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjEHKkq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD4015695
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C38326283B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4979C4339B;
        Mon,  8 May 2023 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542421;
        bh=9dP2pkoC/WQM0vP0ptL6LnIEekN5wSGvTMthfXdWkt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJCKGQb/6L0Q0OfnaWieEC90Dns3rZFs/ov3AJd+Ga2Z5LRg/vQ6QXl1pk9TsXv/w
         3HfzIIqXSa6kOGE+hynHCsb3JiUX3/n9EKRNLlhwPuvelDoh+mR7mnqNoTLjiNCjM/
         jPgp2vRMMoCiKQRyGtG9ieCa45VNtDGvnN8REc2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 430/663] rxrpc: Fix error when reading rxrpc tokens
Date:   Mon,  8 May 2023 11:44:16 +0200
Message-Id: <20230508094442.012078721@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit fadfc57cc8047080a123b16f288b7138524fb1e2 ]

When converting from ASSERTCMP to WARN_ON, the tested condition must
be inverted, which was missed for this case.

This would cause an EIO error when trying to read an rxrpc token, for
instance when trying to display tokens with AuriStor's "tokens" command.

Fixes: 84924aac08a4 ("rxrpc: Fix checker warning")
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 8d53aded09c42..33e8302a79e33 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -680,7 +680,7 @@ static long rxrpc_read(const struct key *key,
 			return -ENOPKG;
 		}
 
-		if (WARN_ON((unsigned long)xdr - (unsigned long)oldxdr ==
+		if (WARN_ON((unsigned long)xdr - (unsigned long)oldxdr !=
 			    toksize))
 			return -EIO;
 	}
-- 
2.39.2



