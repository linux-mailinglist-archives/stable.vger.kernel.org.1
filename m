Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31D1783310
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjHUUJu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHUUJu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB75DF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A4564AA3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10982C433C8;
        Mon, 21 Aug 2023 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648587;
        bh=5SUj5yo388A9EBiJZfnpq+U02gFkJdMQTtsntbfhjIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itLvXSYq5MkhVB8Bl0rbuY+fD4LQ71JlVdkcdticQl4k9tcd3oGKBFWaZ1kmOwIY8
         sIgmm1k/gAEcDPaPPteTtuhraEjwXki7XZj054PktCPBL3c1jVVQywC90zZt+0o6Ia
         9shM3y2d8TpYRjuzsm1S8hjC0/kHws5rJFkqcszU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tim Huang <Tim.Huang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 229/234] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU v13.0.4/11
Date:   Mon, 21 Aug 2023 21:43:12 +0200
Message-ID: <20230821194139.044287422@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tim Huang <Tim.Huang@amd.com>

commit 730d44e1fa306a20746ad4a85da550662aed9daa upstream.

For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
the firmwares will handle that properly.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1573,9 +1573,9 @@ static int smu_disable_dpms(struct smu_c
 
 	/*
 	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
-	 * for gpu reset case. Driver involvement is unnecessary.
+	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
 	 */
-	if (amdgpu_in_reset(adev)) {
+	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(13, 0, 4):
 		case IP_VERSION(13, 0, 11):


