Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB07D16DC
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjJTUWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTUWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1226A1A4
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F3AC433C7;
        Fri, 20 Oct 2023 20:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833324;
        bh=eQm3PsxdyKFw4WBlEFhWzaXMsyFyxDFoW7+YomJqflM=;
        h=Subject:To:Cc:From:Date:From;
        b=1STvRNZn+FZGn1q0ekgO1BoMu/fUzXwNc45pLPfgUEQOz0rLXXd3dpyUllOOrWKnx
         F5iCZ/RoNchvVtjNwGpXmRhtyPWrO5BU805NKCkwsYDnpo4tdJMwdus30GO40ASAir
         Df3Ot+NzDUHQWni4RhN3BdzY5LU7s7oBogwt4cGw=
Subject: FAILED: patch "[PATCH] xfrm6: fix inet6_dev refcount underflow problem" failed to apply to 6.1-stable tree
To:     zhangchangzhong@huawei.com, lucien.xin@gmail.com,
        steffen.klassert@secunet.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:22:01 +0200
Message-ID: <2023102001-barometer-press-265e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cc9b364bb1d58d3dae270c7a931a8cc717dc2b3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102001-barometer-press-265e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc9b364bb1d58d3dae270c7a931a8cc717dc2b3b Mon Sep 17 00:00:00 2001
From: Zhang Changzhong <zhangchangzhong@huawei.com>
Date: Fri, 15 Sep 2023 19:20:41 +0800
Subject: [PATCH] xfrm6: fix inet6_dev refcount underflow problem

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

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 188224a76685..45d0f9a8b28c 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -117,10 +117,10 @@ static void xfrm6_dst_destroy(struct dst_entry *dst)
 {
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 
-	if (likely(xdst->u.rt6.rt6i_idev))
-		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	dst_destroy_metrics_generic(dst);
 	rt6_uncached_list_del(&xdst->u.rt6);
+	if (likely(xdst->u.rt6.rt6i_idev))
+		in6_dev_put(xdst->u.rt6.rt6i_idev);
 	xfrm_dst_destroy(xdst);
 }
 

