Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065F472C130
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjFLK5R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbjFLK4x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94DC30DD
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9BC612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9412BC433D2;
        Mon, 12 Jun 2023 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566676;
        bh=Y2ZpP9gyREpAJy8KArjRl6Iyc5bNPzpcdAuBFmdroHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjjpQe0c/b0SUPIAt+8RNX7m5y54osbXGq18Np82/2f7eTBgHdOHsSHzpzG4kIBBo
         MXqGOYJkzgXOB20HjPYAIX6+2Hphdhv2AZVmr4bjfuHTjISCxqrJBMcsMxi5rUIJ2Z
         MxNaRtuM6q9bNLdcXIAnkLS885Xow+8bn6YquA6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imre Kis <imre.kis@arm.com>,
        Balint Dobszay <balint.dobszay@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/132] firmware: arm_ffa: Set handle field to zero in memory descriptor
Date:   Mon, 12 Jun 2023 12:27:29 +0200
Message-ID: <20230612101715.526674577@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Balint Dobszay <balint.dobszay@arm.com>

[ Upstream commit 3aa0519a4780f1b8e11966bd879d4a2934ba455f ]

As described in the commit 111a833dc5cb ("firmware: arm_ffa: Set
reserved/MBZ fields to zero in the memory descriptors") some fields in
the memory descriptor have to be zeroed explicitly. The handle field is
one of these, but it was left out from that change, fix this now.

Fixes: 111a833dc5cb ("firmware: arm_ffa: Set reserved/MBZ fields to zero in the memory descriptors")
Reported-by: Imre Kis <imre.kis@arm.com>
Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
Link: https://lore.kernel.org/r/20230601140749.93812-1-balint.dobszay@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 5904a679d3512..c37e823590055 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -505,6 +505,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
 	}
+	mem_region->handle = 0;
 	mem_region->reserved_0 = 0;
 	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
-- 
2.39.2



