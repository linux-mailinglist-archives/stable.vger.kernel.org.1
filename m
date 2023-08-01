Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD576A893
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 08:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjHAGAg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 02:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHAGAb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 02:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC6E7D
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 23:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 848686136C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9262AC433C8;
        Tue,  1 Aug 2023 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869629;
        bh=n8Rrb8e6qqcfsF6Bz5oRJJJAmvvBvSJwGgW3UC39smg=;
        h=Subject:To:Cc:From:Date:From;
        b=GEgar7yvJzXXZY+K4aUKu5R3Lx792n8RGrxZdMaXdtIZgxs1vo8uaktnRFgxeQ0Tg
         RO8f0YlwJ2hupP/K8uHoNIWWsc52z4zEQDnb52ID3HHZzoQdDB4LnZ9zfe6rtTlPPs
         5o+yhDISfhpYMWVCjmx11MCXSqek7RpwW/PX0JFQ=
Subject: FAILED: patch "[PATCH] soundwire: fix enumeration completion" failed to apply to 5.15-stable tree
To:     johan+linaro@kernel.org, pierre-louis.bossart@linux.intel.com,
        rander.wang@linux.intel.com, vkoul@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 08:00:27 +0200
Message-ID: <2023080127-unquote-heaviness-e2c5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c40d6b3249b11d60e09d81530588f56233d9aa44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080127-unquote-heaviness-e2c5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c40d6b3249b1 ("soundwire: fix enumeration completion")
e557bca49b81 ("soundwire: bus: pm_runtime_request_resume on peripheral attachment")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c40d6b3249b11d60e09d81530588f56233d9aa44 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 5 Jul 2023 14:30:11 +0200
Subject: [PATCH] soundwire: fix enumeration completion

The soundwire subsystem uses two completion structures that allow
drivers to wait for soundwire device to become enumerated on the bus and
initialised by their drivers, respectively.

The code implementing the signalling is currently broken as it does not
signal all current and future waiters and also uses the wrong
reinitialisation function, which can potentially lead to memory
corruption if there are still waiters on the queue.

Not signalling future waiters specifically breaks sound card probe
deferrals as codec drivers can not tell that the soundwire device is
already attached when being reprobed. Some codec runtime PM
implementations suffer from similar problems as waiting for enumeration
during resume can also timeout despite the device already having been
enumerated.

Fixes: fb9469e54fa7 ("soundwire: bus: fix race condition with enumeration_complete signaling")
Fixes: a90def068127 ("soundwire: bus: fix race condition with initialization_complete signaling")
Cc: stable@vger.kernel.org      # 5.7
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230705123018.30903-2-johan+linaro@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index dba920ec88f6..cf78839b3f74 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -922,8 +922,8 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"initializing enumeration and init completion for Slave %d\n",
 			slave->dev_num);
 
-		init_completion(&slave->enumeration_complete);
-		init_completion(&slave->initialization_complete);
+		reinit_completion(&slave->enumeration_complete);
+		reinit_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
@@ -931,7 +931,7 @@ static void sdw_modify_slave_status(struct sdw_slave *slave,
 			"signaling enumeration completion for Slave %d\n",
 			slave->dev_num);
 
-		complete(&slave->enumeration_complete);
+		complete_all(&slave->enumeration_complete);
 	}
 	slave->status = status;
 	mutex_unlock(&bus->bus_lock);
@@ -1951,7 +1951,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				"signaling initialization completion for Slave %d\n",
 				slave->dev_num);
 
-			complete(&slave->initialization_complete);
+			complete_all(&slave->initialization_complete);
 
 			/*
 			 * If the manager became pm_runtime active, the peripherals will be

