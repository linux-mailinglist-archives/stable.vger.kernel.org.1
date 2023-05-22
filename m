Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5B670C4BF
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEVR6y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjEVR6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA91FD
        for <stable@vger.kernel.org>; Mon, 22 May 2023 10:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6DE61F3E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 17:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7182EC433D2;
        Mon, 22 May 2023 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684778331;
        bh=CuRzA8SdzCQM5EzEGWrBFLraAp5V6aQM2vB5ohup0YM=;
        h=Subject:To:Cc:From:Date:From;
        b=RaoIGYXTDlYhOnu3T4laScrk5rkAJ2EtyCkdNuFhv7flxS6WwQt34DyBKLZsOlOeD
         VmDoygNZ7mRIIRGpXlC9rqTVHyk+vRGuPviHg1Oyf3ll0+PTfUMptO112Dn3RssETr
         ZMyw6xMQjOTj8SCbf6BLGMv+09ccDdRKqEV7FCGs=
Subject: FAILED: patch "[PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries" failed to apply to 5.15-stable tree
To:     michal.simek@amd.com, dlemoal@kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 22 May 2023 18:58:49 +0100
Message-ID: <2023052249-duplex-pampered-89cb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a7844528722619d2f97740ae5ec747afff18c4be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052249-duplex-pampered-89cb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a78445287226 ("dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries")
f2fb1b50fbac ("dt-bindings: ata: ahci-ceva: convert to yaml")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a7844528722619d2f97740ae5ec747afff18c4be Mon Sep 17 00:00:00 2001
From: Michal Simek <michal.simek@amd.com>
Date: Fri, 12 May 2023 13:52:04 +0200
Subject: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries

Current only one entry is enabled but IP itself is using 4 different IDs
which are already listed in zynqmp.dtsi.

sata: ahci@fd0c0000 {
	compatible = "ceva,ahci-1v84";
	...
	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
		 <&smmu 0x4c2>, <&smmu 0x4c3>;
};

Fixes: 8ac47837f0e0 ("arm64: dts: zynqmp: Add missing iommu IDs")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index 9b31f864e071..71364c6081ff 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
   iommus:
-    maxItems: 1
+    maxItems: 4
 
   power-domains:
     maxItems: 1

