Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07D8775D37
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjHILe5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjHILez (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A51BFF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C3FE634CB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9FBC433C8;
        Wed,  9 Aug 2023 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580892;
        bh=zT8j9RqAIb3TvxuGxMCmKOVM6gPMxktlpTTqenENVqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urbjH3hivHsnOomatSTBoYHymPvQ+7UqlcI62r9fRSdwSnZFnR7e1UpmVWT+sF5Z8
         SDecpswga+RvFk+6s+2rpMyr+ZMWt5EpqKmXPBOqbfY/PPbYn2q3mh91IL0om+5Tjd
         JmL45HGUiWcPJZnj80Gav9aGrgYI9bbaPrjmGu8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 032/201] vxlan: move to its own directory
Date:   Wed,  9 Aug 2023 12:40:34 +0200
Message-ID: <20230809103644.905048250@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Roopa Prabhu <roopa@nvidia.com>

[ Upstream commit 6765393614ea8e2c0a7b953063513823f87c9115 ]

vxlan.c has grown too long. This patch moves
it to its own directory. subsequent patches add new
functionality in new files.

Signed-off-by: Roopa Prabhu <roopa@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 94d166c5318c ("vxlan: calculate correct header length for GPE")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/Makefile                        | 2 +-
 drivers/net/vxlan/Makefile                  | 7 +++++++
 drivers/net/{vxlan.c => vxlan/vxlan_core.c} | 0
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/vxlan/Makefile
 rename drivers/net/{vxlan.c => vxlan/vxlan_core.c} (100%)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 72e18d505d1ac..64430440c580c 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_TAP) += tap.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
-obj-$(CONFIG_VXLAN) += vxlan.o
+obj-$(CONFIG_VXLAN) += vxlan/
 obj-$(CONFIG_GENEVE) += geneve.o
 obj-$(CONFIG_BAREUDP) += bareudp.o
 obj-$(CONFIG_GTP) += gtp.o
diff --git a/drivers/net/vxlan/Makefile b/drivers/net/vxlan/Makefile
new file mode 100644
index 0000000000000..5672661335933
--- /dev/null
+++ b/drivers/net/vxlan/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the vxlan driver
+#
+
+obj-$(CONFIG_VXLAN) += vxlan.o
+
+vxlan-objs := vxlan_core.o
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan/vxlan_core.c
similarity index 100%
rename from drivers/net/vxlan.c
rename to drivers/net/vxlan/vxlan_core.c
-- 
2.39.2



