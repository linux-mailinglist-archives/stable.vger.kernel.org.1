Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0254726B57
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjFGUYg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjFGUYT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF80B2126
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043896440B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F7DC433D2;
        Wed,  7 Jun 2023 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169426;
        bh=xrrrxnSc1CzCpNxQ8lD9U1mfhyromHV+oKK88IbaZNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLIT6Fws1BwjI+ay5pMQk6PTCvaWTnIsSaacDnvWIPoj8itQnJ0Sp+6lpx9lfP99n
         qxCoAyO/IMOhcCGYHciecfQAVIuTtoOQgHcevJ0eJVZ9eemtQjGw9zBB9PDPxw8xpQ
         hmmfN+NAu5DdniB510qZNYMt0vVKfPIkQ5nZ6eeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiumei Mu <xmu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 077/286] rtnetlink: add the missing IFLA_GRO_ tb check in validate_linkmsg
Date:   Wed,  7 Jun 2023 22:12:56 +0200
Message-ID: <20230607200925.596220486@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 65d6914e253f3d83b724a9bbfc889ae95711e512 ]

This fixes the issue that dev gro_max_size and gso_ipv4_max_size
can be set to a huge value:

  # ip link add dummy1 type dummy
  # ip link set dummy1 gro_max_size 4294967295
  # ip -d link show dummy1
    dummy addrgenmode eui64 ... gro_max_size 4294967295

Fixes: 0fe79f28bfaf ("net: allow gro_max_size to exceed 65536")
Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size per device")
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7094569009b14..f235cc6832767 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2396,11 +2396,23 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 			return -EINVAL;
 		}
 
+		if (tb[IFLA_GRO_MAX_SIZE] &&
+		    nla_get_u32(tb[IFLA_GRO_MAX_SIZE]) > GRO_MAX_SIZE) {
+			NL_SET_ERR_MSG(extack, "too big gro_max_size");
+			return -EINVAL;
+		}
+
 		if (tb[IFLA_GSO_IPV4_MAX_SIZE] &&
 		    nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]) > dev->tso_max_size) {
 			NL_SET_ERR_MSG(extack, "too big gso_ipv4_max_size");
 			return -EINVAL;
 		}
+
+		if (tb[IFLA_GRO_IPV4_MAX_SIZE] &&
+		    nla_get_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]) > GRO_MAX_SIZE) {
+			NL_SET_ERR_MSG(extack, "too big gro_ipv4_max_size");
+			return -EINVAL;
+		}
 	}
 
 	if (tb[IFLA_AF_SPEC]) {
-- 
2.39.2



