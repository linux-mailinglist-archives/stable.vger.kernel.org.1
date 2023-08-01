Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DE76AF2E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjHAJp3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHAJpM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11D2107
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:43:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47FAB61511
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586E1C433C7;
        Tue,  1 Aug 2023 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883021;
        bh=nqXUpcsp+/BUIRwwPKLlWWYzLBlqVzpOUkNRtjvXT6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PblTfjfHlQpVTBr1962c4UoC6cMPBw+EGudr+oAo7dtN+/FwLMq/e0ms6VtXER1Jo
         WC/t3K0PXTxAovIVajypUZRRWr+EuZa2Quw6vdAJeNFYtwoxGgCGrSaEOhgPF5nlj5
         sLjk6N/2hE3FmcWrD49Fu0jKiDt9VG0TibhbW/G8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 086/239] macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
Date:   Tue,  1 Aug 2023 11:19:10 +0200
Message-ID: <20230801091928.844736046@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 55cef78c244d0d076f5a75a35530ca63c92f4426 ]

The previous commit 954d1fa1ac93 ("macvlan: Add netlink attribute for
broadcast cutoff") added one additional attribute named
IFLA_MACVLAN_BC_CUTOFF to allow broadcast cutfoff.

However, it forgot to describe the nla_policy at macvlan_policy
(drivers/net/macvlan.c). Hence, this suppose NLA_S32 (4 bytes) integer
can be faked as empty (0 bytes) by a malicious user, which could leads
to OOB in heap just like CVE-2023-3773.

To fix it, this commit just completes the nla_policy description for
IFLA_MACVLAN_BC_CUTOFF. This enforces the length check and avoids the
potential OOB read.

Fixes: 954d1fa1ac93 ("macvlan: Add netlink attribute for broadcast cutoff")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230723080205.3715164-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macvlan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4a53debf9d7c4..ed908165a8b4e 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1746,6 +1746,7 @@ static const struct nla_policy macvlan_policy[IFLA_MACVLAN_MAX + 1] = {
 	[IFLA_MACVLAN_MACADDR_COUNT] = { .type = NLA_U32 },
 	[IFLA_MACVLAN_BC_QUEUE_LEN] = { .type = NLA_U32 },
 	[IFLA_MACVLAN_BC_QUEUE_LEN_USED] = { .type = NLA_REJECT },
+	[IFLA_MACVLAN_BC_CUTOFF] = { .type = NLA_S32 },
 };
 
 int macvlan_link_register(struct rtnl_link_ops *ops)
-- 
2.39.2



