Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB87A76AF55
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjHAJqy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjHAJow (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2D4228
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 619A5614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB2EC433C8;
        Tue,  1 Aug 2023 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882949;
        bh=F1WrGyYnUd+dIx7oT4jukzFMuyAnQaXgIUgqDL5Vfkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1ORy2XQayL0k1VP5+hGQL3OCVqofuy6su7E4Irmt1fmNEA6bX5i9hItlZrBN8l0F
         /DphqAsBYmWVMrHLakwf2IIjNgqN3S473714mUQdWsR88kQnPguzlWhcuh4Ipr48hZ
         +eIAaoALDL1paW7F8QSofM8CAk1ImAdMf9ClYaEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 059/239] media: staging: atomisp: select V4L2_FWNODE
Date:   Tue,  1 Aug 2023 11:18:43 +0200
Message-ID: <20230801091927.775011593@linuxfoundation.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit bf4c985707d3168ebb7d87d15830de66949d979c ]

Select V4L2_FWNODE as the driver depends on it.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: aa31f6514047 ("media: atomisp: allow building the driver again")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
index c9bff98e5309a..e9b168ba97bf1 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -13,6 +13,7 @@ config VIDEO_ATOMISP
 	tristate "Intel Atom Image Signal Processor Driver"
 	depends on VIDEO_DEV && INTEL_ATOMISP
 	depends on PMIC_OPREGION
+	select V4L2_FWNODE
 	select IOSF_MBI
 	select VIDEOBUF2_VMALLOC
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.39.2



