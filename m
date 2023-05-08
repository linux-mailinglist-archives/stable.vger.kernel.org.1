Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAF6FA611
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjEHKPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjEHKPw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB83ACDB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48F926248D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E559C433EF;
        Mon,  8 May 2023 10:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540950;
        bh=FC884IW4HmSfoKS5dBzpF8BXVzOw0LBrRmhS3DCvSEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nn4t97FXVPB2uaSPKomveIpTuSLVcgUPAq/+VhiQXnQsUYV2BzwiLKluwFcbzIG74
         90HzsS58nUILF3uOE62oIqD6wNhhzQVMp30FDDv4KP+tGSWPMgIjIwSSjXi54qFC9d
         IvdVahJzYG3w+C6v2ngLXmXkW/PpHPIle0YFt1w8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 552/611] hte: tegra-194: Fix off by one in tegra_hte_map_to_line_id()
Date:   Mon,  8 May 2023 11:46:34 +0200
Message-Id: <20230508094439.944090868@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e078180d66848a6a890daf0a3ce28dc43cc66790 ]

The "map_sz" is the number of elements in the "m" array so the >
comparison needs to be changed to >= to prevent an out of bounds
read.

Fixes: 09574cca6ad6 ("hte: Add Tegra194 HTE kernel provider")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hte/hte-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 49a27af22742b..d1b579c822797 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -251,7 +251,7 @@ static int tegra_hte_map_to_line_id(u32 eid,
 {
 
 	if (m) {
-		if (eid > map_sz)
+		if (eid >= map_sz)
 			return -EINVAL;
 		if (m[eid].slice == NV_AON_SLICE_INVALID)
 			return -EINVAL;
-- 
2.39.2



