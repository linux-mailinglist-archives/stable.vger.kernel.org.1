Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AD4713E2F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjE1Tcv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjE1Tcu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9FDA3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21ED61DBA
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9ABC433D2;
        Sun, 28 May 2023 19:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302368;
        bh=XpT/uLPkQkfBq7ruSn+8ZeTy22ee0bpTz6I5pnEGt4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Blh/6s5VrkWen6WYeOK9lydeWFVf4uSR24DTgkRl0wK8K/y5hRE4QXp67etNjn+u7
         O6sMg4G5qvHOj+HSbSPAQpZ6BCWTTT+mgq3qzoiQ4wkWids7e2El8wsU19Z+fdSpeQ
         52Am1vYrsqvLWIX/ZqO2qWnI702KQc11ORUs+Qao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.3 107/127] platform/mellanox: mlxbf-pmc: fix sscanf() error checking
Date:   Sun, 28 May 2023 20:11:23 +0100
Message-Id: <20230528190839.757623807@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 95e4b25192e9238fd2dbe85d96dd2f8fd1ce9d14 upstream.

The sscanf() function never returns negatives.  It returns the number of
items successfully read.

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/4ccdfd28-099b-40bf-8d77-ad4ea2e76b93@kili.mountain
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1348,9 +1348,8 @@ static int mlxbf_pmc_map_counters(struct
 
 	for (i = 0; i < pmc->total_blocks; ++i) {
 		if (strstr(pmc->block_name[i], "tile")) {
-			ret = sscanf(pmc->block_name[i], "tile%d", &tile_num);
-			if (ret < 0)
-				return ret;
+			if (sscanf(pmc->block_name[i], "tile%d", &tile_num) != 1)
+				return -EINVAL;
 
 			if (tile_num >= pmc->tile_count)
 				continue;


