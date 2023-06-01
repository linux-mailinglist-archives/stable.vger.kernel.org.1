Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4C719DBE
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjFAN0L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjFANZv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB9110E4
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21AA564499
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D9C433EF;
        Thu,  1 Jun 2023 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625933;
        bh=oQcAf/BHiD4yF/pH+M4JAdla42eC4Wu+AAw0NRQj6r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdYy3Mg5HMr1QakLeEsBP0KYyb+M70BBoL8l+X8bonnUqHEahynidKxiVFDyxxp+k
         4ZbezQL5L6ipUbTVDtBWGv823HXWWkyZnWEp/hUGkw5+FV6Yrv2FR+bGv0z5XXP4K7
         czPHLw7MbtPhdcPA2gOldB3hZewljZ4KdG7OW6wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tejun Heo <tj@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 01/45] firmware: arm_scmi: Fix incorrect alloc_workqueue() invocation
Date:   Thu,  1 Jun 2023 14:20:57 +0100
Message-Id: <20230601131938.770208127@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 44e8d5ad2dc01529eb1316b1521f24ac4aac8eaf ]

scmi_xfer_raw_worker_init() is specifying a flag, WQ_SYSFS, as @max_active.
Fix it by or'ing WQ_SYSFS into @flags so that it actually enables sysfs
interface and using 0 for @max_active for the default setting.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")
Link: https://lore.kernel.org/r/ZEGTnajiQm7mkkZS@slm.duckdns.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/raw_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index d40df099fd515..6971dcf72fb99 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -1066,7 +1066,7 @@ static int scmi_xfer_raw_worker_init(struct scmi_raw_mode_info *raw)
 
 	raw->wait_wq = alloc_workqueue("scmi-raw-wait-wq-%d",
 				       WQ_UNBOUND | WQ_FREEZABLE |
-				       WQ_HIGHPRI, WQ_SYSFS, raw->id);
+				       WQ_HIGHPRI | WQ_SYSFS, 0, raw->id);
 	if (!raw->wait_wq)
 		return -ENOMEM;
 
-- 
2.39.2



