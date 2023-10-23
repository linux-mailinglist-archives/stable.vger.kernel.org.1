Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047097D338C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjJWLbg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJWLbg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:31:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D894E8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:31:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEAEC433C9;
        Mon, 23 Oct 2023 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060691;
        bh=WOahAUSTnltw/Bb/qqFXCdZ9lsAR9AuwGfZWRQfh4tk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3Wy+b2F8L8IKLuZPEdO9+PbnQYJMugRUPVydjv8RrATAYvEA0OpKFeFlOI5qWULw
         PLFdPFjDllU7L5ZfRPSn0yxBHmfjzBy+WhXzGS7mXYhrDSMg/t9ntd2jUzbMREGK7W
         Q13bpLKAj1/AUVLp1H/xSYU3qf1rRQzOeBvcgRW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ma Ke <make_ruc2021@163.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.4 060/123] net: ipv4: fix return value check in esp_remove_trailer
Date:   Mon, 23 Oct 2023 12:56:58 +0200
Message-ID: <20231023104819.701114894@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make_ruc2021@163.com>

commit 513f61e2193350c7a345da98559b80f61aec4fa6 upstream.

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/esp4.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -567,7 +567,9 @@ static inline int esp_remove_trailer(str
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 


