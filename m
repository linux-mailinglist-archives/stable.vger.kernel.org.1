Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4139974C34C
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjGILai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjGILag (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C4C0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF79C60BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEFBC433C7;
        Sun,  9 Jul 2023 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902235;
        bh=t/TYWDCOeYX6MMhr1xnokdmnP2tjOveGRxeU3fbIfVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=boo/ONi851+v3lnejXsqabczAnNEmwmzDnBF5LDv7jSlbJGUte948BvL5sbMgUo8T
         Hfa7BDNAz/d5gVBortCJc60M5umv2jYQJzBGGbN84l4E7KgnWYGKleFWJkAuutDFg5
         zlZons63j+IvXoi4lJbe7fFzRaM/C+o7WvpMA8lc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 276/431] drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
Date:   Sun,  9 Jul 2023 13:13:44 +0200
Message-ID: <20230709111457.615244952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit bafc31166aa7df5fa26ae0ad8196d1717e6cdea9 ]

It is likely p1_min_meta_chunk_bytes was expected here, instead of
min_meta_chunk_bytes.

Test the correct variable.

Fixes: dda4fb85e433 ("drm/amd/display: DML changes for DCN32/321")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
index 395ae8761980f..9ba6cb67655f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
@@ -116,7 +116,7 @@ void dml32_rq_dlg_get_rq_reg(display_rq_regs_st *rq_regs,
 	else
 		rq_regs->rq_regs_l.min_meta_chunk_size = dml_log2(min_meta_chunk_bytes) - 6 + 1;
 
-	if (min_meta_chunk_bytes == 0)
+	if (p1_min_meta_chunk_bytes == 0)
 		rq_regs->rq_regs_c.min_meta_chunk_size = 0;
 	else
 		rq_regs->rq_regs_c.min_meta_chunk_size = dml_log2(p1_min_meta_chunk_bytes) - 6 + 1;
-- 
2.39.2



