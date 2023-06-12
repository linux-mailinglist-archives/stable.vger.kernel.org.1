Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2932372C0AD
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjFLKyF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjFLKxk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E157FFE6
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A263612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B27DC433D2;
        Mon, 12 Jun 2023 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566322;
        bh=uq0SVz5UqtJkl8ieMNLcZhzMswHJEEXgcxp9PenjSck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzzmLdDT7rsUgRGvIsJHjM4F/ZXC2Hgig0/Ok7dqGCvKhXYw+CzRthQ8MUA2svS/2
         7yLCtANNPKkc30m+SHAV7VjLcmUhBSJkYqHTCSAFOQE4Weqa27Utz3ol2frKtFr80J
         BXgURqm8NaFaJeFB6RuWnGs+xE3qwMGXplfy4Hww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imre Kis <imre.kis@arm.com>,
        Balint Dobszay <balint.dobszay@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 80/91] firmware: arm_ffa: Set handle field to zero in memory descriptor
Date:   Mon, 12 Jun 2023 12:27:09 +0200
Message-ID: <20230612101705.428434163@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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
index f53d11eff65e0..e4fb0c1ae4869 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -454,6 +454,7 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
 	}
+	mem_region->handle = 0;
 	mem_region->reserved_0 = 0;
 	mem_region->reserved_1 = 0;
 	mem_region->ep_count = args->nattrs;
-- 
2.39.2



