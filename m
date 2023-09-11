Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A179BCB7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348596AbjIKV24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbjIKPD5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:03:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702F125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:03:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB70EC433C8;
        Mon, 11 Sep 2023 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444632;
        bh=5EdB07EmViEi7Zkhg5JNpU2c0Uu+CTYzo7r2q9rmk98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oK7vzljiEJhUNTok7S+Qu9ko2c527a/7ZExTu1zXauqJd+PppR2rKI6bopQbV508z
         0/3qDyHEQZ4UtUtIhb6KqikpgKqel0lkh1RcYzFoVyIo3UPknRh/x6ajuCqXwIZXk8
         O5HxsiiCvS+CX2fVYaEv/If5hRsbemSnsjI7uG/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/600] drm/amdgpu: Match against exact bootloader status
Date:   Mon, 11 Sep 2023 15:41:34 +0200
Message-ID: <20230911134635.426713971@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit d3de41ee5febe5c2d9989fe9810bce2bb54a3a8e ]

On PSP v13.x ASICs, boot loader will set only the MSB to 1 and clear the
least significant bits for any command submission. Hence match against
the exact register value, otherwise a register value of all 0xFFs also
could falsely indicate that boot loader is ready. Also, from PSP v13.0.6
and newer, bits[7:0] will be used to indicate command error status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 8c5fa4b7b68a2..c7cb30efe43de 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -147,14 +147,15 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	int ret;
 	int retry_loop;
 
+	/* Wait for bootloader to signify that it is ready having bit 31 of
+	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
+	 * If there is an error in processing command, bits[7:0] will be set.
+	 * This is applicable for PSP v13.0.6 and newer.
+	 */
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
-		/* Wait for bootloader to signify that is
-		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			0x80000000, 0xffffffff, false);
 
 		if (ret == 0)
 			return 0;
-- 
2.40.1



