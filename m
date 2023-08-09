Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63538775994
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjHILBq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjHILBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757A11FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B51862496
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DECCC433C7;
        Wed,  9 Aug 2023 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578902;
        bh=5XPJXTNE/wYZRo/ACyYJAp1PDhNx6zXcO8dtZTkicE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQ8a0dh7l9inJLPaEIIjDLMHZJk70xLbdpfHxkUmSz4cFupHZosDelFtSXBaMjau3
         +7gy57NDk/Od5V4IrlQGoxMlWHSwFNTMMgPQbdRSDfoAU3O8mtw2q0r7aTyLYxoxz8
         kGkH8iMVab8Xqq9KHEXnI87esj549mY5taIvNB7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 89/92] soundwire: bus: pm_runtime_request_resume on peripheral attachment
Date:   Wed,  9 Aug 2023 12:42:05 +0200
Message-ID: <20230809103636.604257036@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit e557bca49b812908f380c56b5b4b2f273848b676 ]

In typical use cases, the peripheral becomes pm_runtime active as a
result of the ALSA/ASoC framework starting up a DAI. The parent/child
hierarchy guarantees that the manager device will be fully resumed
beforehand.

There is however a corner case where the manager device may become
pm_runtime active, but without ALSA/ASoC requesting any functionality
from the peripherals. In this case, the hardware peripheral device
will report as ATTACHED and its initialization routine will be
executed. If this initialization routine initiates any sort of
deferred processing, there is a possibility that the manager could
suspend without the peripheral suspend sequence being invoked: from
the pm_runtime framework perspective, the peripheral is *already*
suspended.

To avoid such disconnects between hardware state and pm_runtime state,
this patch adds an asynchronous pm_request_resume() upon successful
attach/initialization which will result in the proper resume/suspend
sequence to be followed on the peripheral side.

BugLink: https://github.com/thesofproject/linux/issues/3459
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20220420023241.14335-4-yung-chuan.liao@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: c40d6b3249b1 ("soundwire: fix enumeration completion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b7cdfa65157c6..cc4cca0325b98 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1841,6 +1841,18 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 				__func__, slave->dev_num);
 
 			complete(&slave->initialization_complete);
+
+			/*
+			 * If the manager became pm_runtime active, the peripherals will be
+			 * restarted and attach, but their pm_runtime status may remain
+			 * suspended. If the 'update_slave_status' callback initiates
+			 * any sort of deferred processing, this processing would not be
+			 * cancelled on pm_runtime suspend.
+			 * To avoid such zombie states, we queue a request to resume.
+			 * This would be a no-op in case the peripheral was being resumed
+			 * by e.g. the ALSA/ASoC framework.
+			 */
+			pm_request_resume(&slave->dev);
 		}
 	}
 
-- 
2.40.1



