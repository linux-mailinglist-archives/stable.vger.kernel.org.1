Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C699F76AD2C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjHAJ1A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjHAJ0o (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:26:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2631FC8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CA661506
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D37C433CA;
        Tue,  1 Aug 2023 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881939;
        bh=IlKoMXAx8zR8fIYAxyXlgt688RTBBU3wcISHUv+L2cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=moMi97eidHVpjWc5cBNlsCvZ/R1y6TDgzLtie2zmhGxiqnJz1RVwcAlpGywWmfIDE
         ag7lyK+Jm3+qmAa6ZJp2URgPc+kRJKACCnpwAunU7xFP0cGfdS3rw5JsAh8eFTsH7I
         LRhUmcg+KnPKnUu2p9vtNzViYm/nyKORyCCslzbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 054/155] media: staging: atomisp: select V4L2_FWNODE
Date:   Tue,  1 Aug 2023 11:19:26 +0200
Message-ID: <20230801091912.124320070@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
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
index aeed5803dfb1e..0031d76356c1c 100644
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -13,6 +13,7 @@ config VIDEO_ATOMISP
 	tristate "Intel Atom Image Signal Processor Driver"
 	depends on VIDEO_V4L2 && INTEL_ATOMISP
 	depends on PMIC_OPREGION
+	select V4L2_FWNODE
 	select IOSF_MBI
 	select VIDEOBUF_VMALLOC
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.39.2



