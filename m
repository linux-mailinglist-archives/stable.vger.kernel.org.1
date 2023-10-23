Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2D97D35C8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJWLvu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJWLvs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:51:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDED68
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:51:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED98C433C9;
        Mon, 23 Oct 2023 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061900;
        bh=wFAIbEjHOYVoGrRWc7kPHGgB5ZEjOR7V6tS3CyD9F50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zExaxDOfkLe16VXzJpqPGS0bptEAsbD4JJhe7Ne3l8EYJWdYuIOuL2E5h6KK6vIgR
         1EDpR6H7nmDot+CV2SBeEalDfXS1eGYgJh/x9RBn7Cr4QVAysoO+P40NTj3zbiaj5U
         6yr+uEFyCCeTsVqtBtyxJLP/hH3RIqhZIrzuWv1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Xin Long <lucien.xin@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/202] xfrm6: fix inet6_dev refcount underflow problem
Date:   Mon, 23 Oct 2023 12:58:29 +0200
Message-ID: <20231023104832.312700481@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Changzhong <zhangchangzhong@huawei.com>

[ Upstream commit cc9b364bb1d58d3dae270c7a931a8cc717dc2b3b ]

There are race conditions that may lead to inet6_dev refcount underflow
in xfrm6_dst_destroy() and rt6_uncached_list_flush_dev().

One of the refcount underflow bugs is shown below:
	(cpu 1)                	|	(cpu 2)
xfrm6_dst_destroy()             |
  ...                           |
  in6_dev_put()                 |
				|  rt6_uncached_list_flush_dev()
  ...				|    ...
				|    in6_dev_put()
  rt6_uncached_list_del()       |    ...
  ...                           |

xfrm6_dst_destroy() calls rt6_uncached_list_del() after in6_dev_put(),
so rt6_uncached_list_flush_dev() has a chance to call in6_dev_put()
again for the same inet6_dev.

Fix it by moving in6_dev_put() after rt6_uncached_list_del() in
xfrm6_dst_destroy().

Fixes: 510c321b5571 ("xfrm: reuse uncached_list to track xdsts")
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/xfrm6_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -120,11 +120,11 @@ static void xfrm6_dst_destroy(struct dst
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 
-	if (likely(xdst->u.rt6.rt6i_idev))
-		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	dst_destroy_metrics_generic(dst);
 	if (xdst->u.rt6.rt6i_uncached_list)
 		rt6_uncached_list_del(&xdst->u.rt6);
+	if (likely(xdst->u.rt6.rt6i_idev))
+		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	xfrm_dst_destroy(xdst);
 }
 


