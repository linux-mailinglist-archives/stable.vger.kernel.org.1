Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DDF7757BF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjHIKth (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjHIKth (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF610F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1FA6283F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD4CC433C7;
        Wed,  9 Aug 2023 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578175;
        bh=UrCM4DYeb4BCsSfsME7f+whGNtDCW2I3xQe/1RdA3Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHry2TAjylofrsjdJtgFzBajxYBxTwHejj19w3kjToPiYtnA5jgo3rBxVtwaWEwLN
         zsFCG3O99UXjrIRUUJmco8o4BulvR5cTu+F1FEyADi6o3wVUBOZ6wpOMlJIR0Ae3SB
         GNCEIotwJrI0DkGauwNuypMx4qXg0ukw1G3iLFwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 6.4 103/165] firmware: arm_scmi: Drop OF node reference in the transport channel setup
Date:   Wed,  9 Aug 2023 12:40:34 +0200
Message-ID: <20230809103646.149997548@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit da042eb4f061a0b54aedadcaa15391490c48e1ad upstream.

The OF node reference obtained from of_parse_phandle() should be dropped
if node is not compatible with arm,scmi-shmem.

Fixes: 507cd4d2c5eb ("firmware: arm_scmi: Add compatibility checks for shmem node")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20230719061652.8850-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_scmi/mailbox.c |    4 +++-
 drivers/firmware/arm_scmi/smc.c     |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -166,8 +166,10 @@ static int mailbox_chan_setup(struct scm
 		return -ENOMEM;
 
 	shmem = of_parse_phandle(cdev->of_node, "shmem", idx);
-	if (!of_device_is_compatible(shmem, "arm,scmi-shmem"))
+	if (!of_device_is_compatible(shmem, "arm,scmi-shmem")) {
+		of_node_put(shmem);
 		return -ENXIO;
+	}
 
 	ret = of_address_to_resource(shmem, 0, &res);
 	of_node_put(shmem);
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -118,8 +118,10 @@ static int smc_chan_setup(struct scmi_ch
 		return -ENOMEM;
 
 	np = of_parse_phandle(cdev->of_node, "shmem", 0);
-	if (!of_device_is_compatible(np, "arm,scmi-shmem"))
+	if (!of_device_is_compatible(np, "arm,scmi-shmem")) {
+		of_node_put(np);
 		return -ENXIO;
+	}
 
 	ret = of_address_to_resource(np, 0, &res);
 	of_node_put(np);


