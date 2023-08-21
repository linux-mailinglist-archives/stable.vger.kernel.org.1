Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544847831FA
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjHUTzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjHUTzO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECABFFA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B2B2645AA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BAFC433C7;
        Mon, 21 Aug 2023 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647709;
        bh=8xxxQfbgoXBKVx1RjgHDkM8YYRxXFEyIYiNGiIdYxvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfYZB5bLeVUmUipOvn9F7AANC+YsOeW2zu4Fg3Ua5L6nppDl2qSsaZ8tVHucG3InJ
         +Bd5N5eBDNrq3yOJTCSjUZFAQpYL2Sy7DNNoqC25ruG+QPjlP74pDDRvjS5/LXkkdl
         KGsV0gnqXL1/cbjrIZzv7XonLWGGCYt+lX4irtMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 111/194] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Date:   Mon, 21 Aug 2023 21:41:30 +0200
Message-ID: <20230821194127.582025506@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 5e2424708da7207087934c5c75211e8584d553a0 ]

The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
message to user space") added one additional attribute named
XFRMA_MTIMER_THRESH and described its type at compat_policy
(net/xfrm/xfrm_compat.c).

However, the author forgot to also describe the nla_policy at
xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
bytes) value can be faked as empty (0 bytes) by a malicious user, which
leads to 4 bytes overflow read and heap information leak when parsing
nlattrs.

To exploit this, one malicious user can spray the SLUB objects and then
leverage this 4 bytes OOB read to leak the heap data into
x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
userspace via copy_to_user_state_extra(...).

The above bug is assigned CVE-2023-3773. To fix it, this commit just
completes the nla_policy description for XFRMA_MTIMER_THRESH, which
enforces the length check and avoids such OOB read.

Fixes: 4e484b3e969b ("xfrm: rate limit SA mapping change message to user space")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 9fc1da47d02e0..d042ca01211fa 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2989,6 +2989,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_SET_MARK]	= { .type = NLA_U32 },
 	[XFRMA_SET_MARK_MASK]	= { .type = NLA_U32 },
 	[XFRMA_IF_ID]		= { .type = NLA_U32 },
+	[XFRMA_MTIMER_THRESH]   = { .type = NLA_U32 },
 };
 EXPORT_SYMBOL_GPL(xfrma_policy);
 
-- 
2.40.1



