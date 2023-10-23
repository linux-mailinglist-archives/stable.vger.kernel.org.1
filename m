Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7647D3297
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJWLV4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJWLVz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:21:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F972D6
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:21:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4FC433C9;
        Mon, 23 Oct 2023 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060112;
        bh=1BvJQSqUZ9kZGp3NJ+0EAvaP1bh7Oo+m+wYF1HNpzMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VasXooIN/UuS/u3RO2A+XoRptfHrMdfJTCsbniPJtR1v9qyNt4bYjnYOaUmj8UKeM
         /QE/6INErEUQWtY+kFFPgyDUm1nd3i16R5bRRa5M2j9k2otTPba9zGvjmQ6oos0I7b
         2favPaEYj6o2+Orc4RAO8kTEm7UM5o+eRbdTCFKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Wiesner <jwiesner@suse.de>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 063/196] bonding: Return pointer to data after pull on skb
Date:   Mon, 23 Oct 2023 12:55:28 +0200
Message-ID: <20231023104830.321689283@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Wiesner <jwiesner@suse.de>

commit d93f3f992780af4a21e6c1ab86946b7c5602f1b9 upstream.

Since 429e3d123d9a ("bonding: Fix extraction of ports from the packet
headers"), header offsets used to compute a hash in bond_xmit_hash() are
relative to skb->data and not skb->head. If the tail of the header buffer
of an skb really needs to be advanced and the operation is successful, the
pointer to the data must be returned (and not a pointer to the head of the
buffer).

Fixes: 429e3d123d9a ("bonding: Fix extraction of ports from the packet headers")
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3990,7 +3990,7 @@ static inline const void *bond_pull_data
 	if (likely(n <= hlen))
 		return data;
 	else if (skb && likely(pskb_may_pull(skb, n)))
-		return skb->head;
+		return skb->data;
 
 	return NULL;
 }


