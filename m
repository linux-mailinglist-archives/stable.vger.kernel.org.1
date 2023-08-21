Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6D783263
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHUUDv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHUUDu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08139DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC536487C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93320C433C7;
        Mon, 21 Aug 2023 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648228;
        bh=HyjCIrWwlRMrvk9h78kLY8b27RD8dbrbvSWE4JRBcaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vmzHvf6KAyNXd+ZetT4ahrs+JJ7fglBRNZkuJyJRe1VzXjnOh2gw0FKeeec+9+ZAJ
         gzEXXw15ntBR/xgzqeDQr09hZNhH7iCNhujO7YBwMglnjr3qzttR+3MevYc/5jU7wO
         k0tBITsa2pLQyQsw9biqZr60qXH2AaUk1WxnGjh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        stable@vger.kernelorg, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.4 101/234] vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
Date:   Mon, 21 Aug 2023 21:41:04 +0200
Message-ID: <20230821194133.272284647@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

commit b3003e1b54e057f5f3124e437b80c3bef26ed3fe upstream.

The vdpa_nl_policy structure is used to validate the nlattr when parsing
the incoming nlmsg. It will ensure the attribute being described produces
a valid nlattr pointer in info->attrs before entering into each handler
in vdpa_nl_ops.

That is to say, the missing part in vdpa_nl_policy may lead to illegal
nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

This patch adds the missing nla_policy for vdpa queue index attr to avoid
such bugs.

Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernelorg
Message-Id: <20230727175757.73988-5-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1249,6 +1249,7 @@ static const struct nla_policy vdpa_nl_p
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
 	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
 };
 


