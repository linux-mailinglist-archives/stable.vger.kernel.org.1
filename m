Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEDF6FA568
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjEHKJN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjEHKJK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC43293D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A430862397
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D00C433EF;
        Mon,  8 May 2023 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540545;
        bh=K73JapF0uO1cI6Bv1v5F72BtGVNp+dXws7n2SJpgN/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y24IaPav7YKxq73Q94GDpdUYiM/py6dT0eTf+I6By/P1YPlg7GBmZXIe9RF2YezYa
         yX0N7tN9tdwRoO/3T98dn3ZYmY4ZM1Kx/TO5FClU/n/yWIDcA+aeodgUB96HZqIrHz
         yeP6WumQK8+GHkrJ6xkPrtpGVJuNlrpQfm2Oc6c8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Pagani <marpagan@redhat.com>,
        Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 405/611] fpga: bridge: fix kernel-doc parameter description
Date:   Mon,  8 May 2023 11:44:07 +0200
Message-Id: <20230508094435.429536383@linuxfoundation.org>
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

From: Marco Pagani <marpagan@redhat.com>

[ Upstream commit 7ef1a2c1c9dffa177ecc3ea50b7f5ee63a621137 ]

Fix the kernel-doc description for the "struct fpga_image_info *info"
parameter of the fpga_bridge_get() function.

Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20230301140309.512578-1-marpagan@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 13918c8c839ea..833ce13ff6f86 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to an fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to an fpga bridge.
  *
-- 
2.39.2



