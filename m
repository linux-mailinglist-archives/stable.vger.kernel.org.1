Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839767D340B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJWLgW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbjJWLgV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:36:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C36D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:36:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EE8C433C8;
        Mon, 23 Oct 2023 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060978;
        bh=v4+9WgsrsnJtk0MtnIDZT8pX5hePjJInPldsR+P5wzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvTtoWBiglHJ/duGstSBfOSxMuEfiMKPKGdCra+d0D4lvnXPEp7PjAR20RJwqhwu+
         YfiuPetBHptFmoo2+nBN17TbhX6QN9jQ0fZj5BiF5IWHgX6iwGMWOO7UWm0BqsWlSR
         yd9ysdID/fnOXwuee7zOeOqXXOjXgLJ8RwfCxjoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.15 033/137] net: ipv6: fix return value check in esp_remove_trailer
Date:   Mon, 23 Oct 2023 12:56:30 +0200
Message-ID: <20231023104822.144481646@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make_ruc2021@163.com>

commit dad4e491e30b20f4dc615c9da65d2142d703b5c2 upstream.

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/esp6.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -776,7 +776,9 @@ static inline int esp_remove_trailer(str
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 


