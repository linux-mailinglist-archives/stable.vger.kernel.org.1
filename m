Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F279B336
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359566AbjIKWRr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238595AbjIKOAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:00:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C5CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:00:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD657C433C7;
        Mon, 11 Sep 2023 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440808;
        bh=xiuQJDDJFKALjy+gZZxB+IE/WIHAFfNuZRQKbxHxFec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sX+jjPRKAylIk4fpSWdCdpcg9zH/5Bgcma77qGqr+CKgu36KIm6RlddljHXWw9d6y
         k6Og5b5a64P25h6kMlnqEMYkhaFYqH+wdumdP7aiOs/SiEmulSuLX+XBLPQkc+3E97
         R0lwHZ/be5VWRuvn4l5OD5dkHBZRloUa+V4oIySE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Austin <alex.austin@amd.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 192/739] sfc: Check firmware supports Ethernet PTP filter
Date:   Mon, 11 Sep 2023 15:39:51 +0200
Message-ID: <20230911134656.555098017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Austin <alex.austin@amd.com>

[ Upstream commit c4413a20fa6d7c4888009fb7dd391685f196cd36 ]

Not all firmware variants support RSS filters. Do not fail all PTP
functionality when raw ethernet PTP filters fail to insert.

Fixes: e4616f64726b ("sfc: support PTP over Ethernet")
Signed-off-by: Alex Austin <alex.austin@amd.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Link: https://lore.kernel.org/r/20230824164657.42379-1-alex.austin@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 0c40571133cb9..00cf6de3bb2be 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1485,7 +1485,9 @@ static int efx_ptp_insert_multicast_filters(struct efx_nic *efx)
 			goto fail;
 
 		rc = efx_ptp_insert_eth_multicast_filter(efx);
-		if (rc < 0)
+
+		/* Not all firmware variants support this filter */
+		if (rc < 0 && rc != -EPROTONOSUPPORT)
 			goto fail;
 	}
 
-- 
2.40.1



