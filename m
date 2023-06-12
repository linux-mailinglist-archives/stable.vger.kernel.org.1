Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44872C200
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbjFLLCC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbjFLLBg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DBF49DB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADBCB624CF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE94C433EF;
        Mon, 12 Jun 2023 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566938;
        bh=EYuEkeCPEWWbbCX01P83N+1oqQy7cklZH5Ysb8vs/64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jydb82TkSlYJ8KawmgeyfIHI8b+Ry9ZQlOCz+WDygAZM9XmCROfZOP8I1eYgIX46Q
         Yd83FX4cbbl7kE9AyO51tIEoBx3urQTKbmA/nG6NbNs/n2UJsC5GkMaAYmC/jFr33i
         nu+GbmUaGg8gT7sNAkpvknDLmBH5z869YOOsS7y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 089/160] drm/amd/pm: Fix power context allocation in SMU13
Date:   Mon, 12 Jun 2023 12:27:01 +0200
Message-ID: <20230612101719.093189010@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

From: Lijo Lazar <lijo.lazar@amd.com>

commit 1d13c49cf4e246b218d71873f1bb1bbd376aa10e upstream.

Use the right data structure for allocation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -566,11 +566,11 @@ int smu_v13_0_init_power(struct smu_cont
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
+	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_power_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_13_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_13_0_power_context);
 
 	return 0;
 }


