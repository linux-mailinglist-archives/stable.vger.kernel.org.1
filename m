Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698B7553A4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGPUVS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjGPUVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077B1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF1460EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575B1C433C7;
        Sun, 16 Jul 2023 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538875;
        bh=qpaxR4VC4lJxEIuDUdVGtOHl8qxXvZdNl/a4jFajblc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RVs4qkY5nvzUhbo0QvPswLDfZHQcTBPeUatHkWqLKKnesrAUxGLXJ3wQW4/L7Oa3R
         5W+Pgx2Ro7SAApXolT9j1IcanUoWt1WHEnE8Cx+LJ+lILPVUtJHw8Dd/3rDyeSTHQX
         nC0NJfWzsKEKTI/sqZTyUHw6BFy77fG00P/+t1Aw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 608/800] media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
Date:   Sun, 16 Jul 2023 21:47:41 +0200
Message-ID: <20230716195003.229220624@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 1657f2934daf89e8d9fa4b2697008909eb22c73e ]

Ideally, strlen(cur->string.pointer) and strlen(out) would be the same.
But this code is using strscpy() to avoid a potential buffer overflow.
So in the same way we should take the strlen() of the smaller string to
avoid a buffer overflow in the caller, gmin_get_var_int().

Link: https://lore.kernel.org/r/26124bcd-8132-4483-9d67-225c87d424e8@kili.mountain

Fixes: 387041cda44e ("media: atomisp: improve sensor detection code to use _DSM table")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index c718a74ea70a3..88d4499233b98 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -1357,7 +1357,7 @@ static int gmin_get_config_dsm_var(struct device *dev,
 	dev_info(dev, "found _DSM entry for '%s': %s\n", var,
 		 cur->string.pointer);
 	strscpy(out, cur->string.pointer, *out_len);
-	*out_len = strlen(cur->string.pointer);
+	*out_len = strlen(out);
 
 	ACPI_FREE(obj);
 	return 0;
-- 
2.39.2



