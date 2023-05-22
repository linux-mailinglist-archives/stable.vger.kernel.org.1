Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB370C851
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjEVTiE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjEVThu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DDE63
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B782E620EB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EB1C433D2;
        Mon, 22 May 2023 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784211;
        bh=C0p4SOYWxBZj7g7+KsOgjeAIHM6D9O9UL5KINSlusoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5xZeKsqHq+A4vpch91kcSY3fx2tf03Fp7Dycd/w4dMy1WNjGF3t29TuJwXqBJ1AK
         PdKnDg8LnEstsP7qfoK5toG4bW5uRynWMelBiNI6Z7kHBBpcITDlsBfOsx3R7yfuIX
         ayXSNE/9xPwcBi74r455t+G7yu5s61G/YvjerlXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 273/292] drm/amdgpu/gfx11: Adjust gfxoff before powergating on gfx11 as well
Date:   Mon, 22 May 2023 20:10:30 +0100
Message-Id: <20230522190412.764065750@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

commit 11fbdda2ab6bf049e2869139c07016022b4e045b upstream.

(Bas: speculative change to mirror gfx10/gfx9)

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5085,8 +5085,14 @@ static int gfx_v11_0_set_powergating_sta
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
+		if (!enable)
+			amdgpu_gfx_off_ctrl(adev, false);
+
 		gfx_v11_cntl_pg(adev, enable);
-		amdgpu_gfx_off_ctrl(adev, enable);
+
+		if (enable)
+			amdgpu_gfx_off_ctrl(adev, true);
+
 		break;
 	default:
 		break;


