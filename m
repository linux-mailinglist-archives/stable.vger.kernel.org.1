Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D372A70CA0B
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjEVTyW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjEVTyW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D775E0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B292F62B6A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2ADC433D2;
        Mon, 22 May 2023 19:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785259;
        bh=K13WyvsTQCDWMfOVfJ2WIZu1auSPFasF4FzVq/oUDaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LSaCJwvB1boR7fl1TYMqrvTuLeCOzCzqt/3K3ZzNKncm1/RpaguinlgRzMfzhhy3
         QaCDGFx3ggPxMNZSMAVNf181TzjNtd1cxByK9dfsTrJ6JmfQ8udUZAA3rdLiYMHa5N
         2cUJeiEvCZfy9DAN8vbazOrcn/KQYSlh+K/+a6og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Ma <li.ma@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 363/364] drm/amdgpu: reserve the old gc_11_0_*_mes.bin
Date:   Mon, 22 May 2023 20:11:08 +0100
Message-Id: <20230522190421.844467065@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Li Ma <li.ma@amd.com>

commit 8855818ce7554fb7420200187fac9c3b69500da0 upstream.

Reserve the MOUDLE_FIRMWARE declaration of gc_11_0_*_mes.bin
to fix falling back to old mes bin on failure via autoload.

Fixes: 97998b893c30 ("drm/amd/amdgpu: introduce gc_*_mes_2.bin v2")
Signed-off-by: Li Ma <li.ma@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -32,14 +32,19 @@
 #include "v11_structs.h"
 #include "mes_v11_api_def.h"
 
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 


