Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43373703561
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbjEOQ60 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243283AbjEOQ60 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807591BC0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1278461F7D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E83C433D2;
        Mon, 15 May 2023 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169902;
        bh=9p47YU1vsNyNrtHbqc+cLvTDKpJgkVNfO0hrM2F8Pi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P5OinKq+ba2o3vi+WauQ3aJ3ACKQJ6a5mcBD8D7rt94dU+g9gshnSgyqPoJCaImrT
         QnIyoSS/vhz6HX8Lbi9oDULeULjyicJXztvrJObj3qw58R2diVyCB94WRXptS8HQFB
         wf7KqkfTzI5SXUf7DjZQR1DfypgNrCbuFTqt2E+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Guchun Chen <guchun.chen@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 207/246] drm/amdgpu: disable sdma ecc irq only when sdma RAS is enabled in suspend
Date:   Mon, 15 May 2023 18:26:59 +0200
Message-Id: <20230515161728.814651153@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Guchun Chen <guchun.chen@amd.com>

commit 8b229ada2669b74fdae06c83fbfda5a5a99fc253 upstream.

sdma_v4_0_ip is shared on a few asics, but in sdma_v4_0_hw_fini,
driver unconditionally disables ecc_irq which is only enabled on
those asics enabling sdma ecc. This will introduce a warning in
suspend cycle on those chips with sdma ip v4.0, while without
sdma ecc. So this patch correct this.

[ 7283.166354] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.167001] RSP: 0018:ffff9a5fc3967d08 EFLAGS: 00010246
[ 7283.167019] RAX: ffff98d88afd3770 RBX: 0000000000000001 RCX: 0000000000000000
[ 7283.167023] RDX: 0000000000000000 RSI: ffff98d89da30390 RDI: ffff98d89da20000
[ 7283.167025] RBP: ffff98d89da20000 R08: 0000000000036838 R09: 0000000000000006
[ 7283.167028] R10: ffffd5764243c008 R11: 0000000000000000 R12: ffff98d89da30390
[ 7283.167030] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.167032] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.167036] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.167039] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.167041] Call Trace:
[ 7283.167046]  <TASK>
[ 7283.167048]  sdma_v4_0_hw_fini+0x38/0xa0 [amdgpu]
[ 7283.167704]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.168296]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.168875]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.169464]  pci_pm_freeze+0x54/0xc0

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1903,9 +1903,11 @@ static int sdma_v4_0_hw_fini(void *handl
 		return 0;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
-			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
+			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
+				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
+		}
 	}
 
 	sdma_v4_0_ctx_switch_enable(adev, false);


