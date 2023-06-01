Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7563719E02
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjFAN2Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFAN2D (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D2E50
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96631644E4
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63DAC433D2;
        Thu,  1 Jun 2023 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626061;
        bh=Q66oGo6YHunqdLXo+Uqi03t/BOE+7faoNHZDZl5VWLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p69Fv0y77m4xwgVbzgQ1RiQFaEeR8HeNme//4BLLdW61wmToOX0ciAeRqh86EoQCQ
         1TcE3mzDCUoyozsPtUFOTVnV25juMtDJLp1bkFmy4dU3L2Gbg/6a0Bvw/sgrEWEKs5
         RDHQBk/bYX+HKsVHVIgSxYoL7JiiD9eCfWUfnSgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tariq Toukan <tariqt@nvidia.com>,
        Shai Amiram <samiram@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 06/42] tls: rx: device: fix checking decryption status
Date:   Thu,  1 Jun 2023 14:21:15 +0100
Message-Id: <20230601131939.338500118@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit b3a03b540e3cf62a255213d084d76d71c02793d5 ]

skb->len covers the entire skb, including the frag_list.
In fact we're guaranteed that rxm->full_len <= skb->len,
so since the change under Fixes we were not checking decrypt
status of any skb but the first.

Note that the skb_pagelen() added here may feel a bit costly,
but it's removed by subsequent fixes, anyway.

Reported-by: Tariq Toukan <tariqt@nvidia.com>
Fixes: 86b259f6f888 ("tls: rx: device: bound the frag walk")
Tested-by: Shai Amiram <samiram@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a7cc4f9faac28..3b87c7b04ac87 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1012,7 +1012,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 	struct sk_buff *skb_iter;
 	int left;
 
-	left = rxm->full_len - skb->len;
+	left = rxm->full_len + rxm->offset - skb_pagelen(skb);
 	/* Check if all the data is decrypted already */
 	skb_iter = skb_shinfo(skb)->frag_list;
 	while (skb_iter && left > 0) {
-- 
2.39.2



