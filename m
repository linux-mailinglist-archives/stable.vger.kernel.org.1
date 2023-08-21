Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2507831F8
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHUTz4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjHUTz4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0686199
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F34E645C3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF54C433C7;
        Mon, 21 Aug 2023 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647745;
        bh=M4DTS+drw2p5W2ABw0ZRSB4V7H4iuWimUeaOxzVSFII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EinHY8Y8oXJsE2+Mboi/6Go0DHF2N72eBCsdsmsOSQ0ApsBPRLjll1x1ZOyuvZbEk
         33BCOKkpP/PIH4gEpFUPD7Jh5xJOt8UxiO9R2Pi7/IilFIEy116CeeVE5tgMCVREkh
         7kvvTsOvNSYMl+jsS2aPaItmBn5eHaJqRNrxjO7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.1 096/194] vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check
Date:   Mon, 21 Aug 2023 21:41:15 +0200
Message-ID: <20230821194126.926030783@linuxfoundation.org>
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

commit 5d6ba607d6cb5c58a4ddf33381e18c83dbb4098f upstream.

The vdpa_nl_policy structure is used to validate the nlattr when parsing
the incoming nlmsg. It will ensure the attribute being described produces
a valid nlattr pointer in info->attrs before entering into each handler
in vdpa_nl_ops.

That is to say, the missing part in vdpa_nl_policy may lead to illegal
nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

This patch adds the missing nla_policy for vdpa max vqp attr to avoid
such bugs.

Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernel.org
Message-Id: <20230727175757.73988-7-dtatulea@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1172,6 +1172,7 @@ static const struct nla_policy vdpa_nl_p
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
+	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
 	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },


