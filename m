Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AD1783369
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHUTzT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHUTzQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA5FA
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27DF0645A2
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353C4C433C8;
        Mon, 21 Aug 2023 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647714;
        bh=QoUHOy1hMl35+v/+/K6UM3YcObeNLkRM5pnSKCc2ztw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pml7klS09zJAuolvhTX+k/QzvRS9VIJrfplr3MwcPgVlK2CvdtxF+0TZEMiKi1fPs
         Ngdb7141UnSNsdkXioEoWbKwjkaxkAFqcdPHIKwxTvc5smlcng4j0QUZJPiVwCV4v6
         ByQm+YvJppAk/Xdj0vyjcoi/lZDKyC8OVzd0b2cg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        stable@vger.kernelorg, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.1 095/194] vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
Date:   Mon, 21 Aug 2023 21:41:14 +0200
Message-ID: <20230821194126.885919775@linuxfoundation.org>
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
@@ -1174,6 +1174,7 @@ static const struct nla_policy vdpa_nl_p
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
 	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
 };
 


