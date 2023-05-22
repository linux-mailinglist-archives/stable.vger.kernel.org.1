Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8970C949
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjEVTq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjEVTqW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF9A3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8665362A05
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9546EC433D2;
        Mon, 22 May 2023 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784779;
        bh=ZJGyKJX+SJn7/ogkf8kjQ039MZHB/DIAntQZJF7LQlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpsfs7Bm7VWG0SBpXBGfhIK72yJkTtY9hcGKAOpWOSYGbroxm6ZpqqsaIFcP1THP7
         HOobmErBAIx2ifn/ffXhGqxQcY3HOgmQP0AK7coNbdAkMLe3pZmvpZq50PcRqa7Cko
         XVwTZiWUI+tuGoHiWtOt6J+BzvDGZ4n0TKDddlOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 200/364] xfrm: Fix leak of dev tracker
Date:   Mon, 22 May 2023 20:08:25 +0100
Message-Id: <20230522190417.730362672@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit ec8f32ad9a65a8cbb465b69e154aaec9d2fe45c4 ]

At the stage of direction checks, the netdev reference tracker is
already initialized, but released with wrong *_put() call.

Fixes: 919e43fad516 ("xfrm: add an interface to offload policy")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 95f1436bf6a2e..e2ca50bfca24f 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -378,7 +378,7 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 		break;
 	default:
 		xdo->dev = NULL;
-		dev_put(dev);
+		netdev_put(dev, &xdo->dev_tracker);
 		NL_SET_ERR_MSG(extack, "Unrecognized offload direction");
 		return -EINVAL;
 	}
-- 
2.39.2



