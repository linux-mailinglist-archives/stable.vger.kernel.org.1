Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847476AFCD
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjHAJuP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjHAJt7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B971707
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8843614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E63C433C8;
        Tue,  1 Aug 2023 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883369;
        bh=RkhRuSQN/uAhcVHDSZbHe7v2KY+OX5SxLY/OJX9pVTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yod+tH8fiH//c4jdvlDwZ7+VM+J5u2ERGsFDfbj6fq8TVrQZ3G4uNDxY/u9V8qbuB
         KCZNMbcTLDqYgzioreyy6vKZ4JRMnUYp1DS1wIdz3yfMj20iRPypcNmfhXnE7YXRgK
         +HRL2wbHU4fdqbpwDR1DnrxsEtu0wOYTpnfa2bjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.4 211/239] soundwire: fix enumeration completion
Date:   Tue,  1 Aug 2023 11:21:15 +0200
Message-ID: <20230801091933.453058053@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit c40d6b3249b11d60e09d81530588f56233d9aa44 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -908,8 +908,8 @@ static void sdw_modify_slave_status(stru
 			"initializing enumeration and init completion for Slave %d\n",
 			slave->dev_num);
 
-		init_completion(&slave->enumeration_complete);
-		init_completion(&slave->initialization_complete);
+		reinit_completion(&slave->enumeration_complete);
+		reinit_completion(&slave->initialization_complete);
 
 	} else if ((status == SDW_SLAVE_ATTACHED) &&
 		   (slave->status == SDW_SLAVE_UNATTACHED)) {
@@ -917,7 +917,7 @@ static void sdw_modify_slave_status(stru
 			"signaling enumeration completion for Slave %d\n",
 			slave->dev_num);
 
-		complete(&slave->enumeration_complete);
+		complete_all(&slave->enumeration_complete);
 	}
 	slave->status = status;
 	mutex_unlock(&bus->bus_lock);
@@ -1941,7 +1941,7 @@ int sdw_handle_slave_status(struct sdw_b
 				"signaling initialization completion for Slave %d\n",
 				slave->dev_num);
 
-			complete(&slave->initialization_complete);
+			complete_all(&slave->initialization_complete);
 
 			/*
 			 * If the manager became pm_runtime active, the peripherals will be


