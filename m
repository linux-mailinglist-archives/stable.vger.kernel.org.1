Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D727ECDA1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjKOThb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjKOThb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DAC9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D755C433C7;
        Wed, 15 Nov 2023 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077047;
        bh=6QEuWTnLf0AU00h6ga5KD97fyBfei6FRN2rYUSlgiXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iURUQsF6BtkPBIi7PAM6a19uorIkwkjFkim/hb53OZeon2b6kW+Im8G7Ct6dtY5yl
         WkUdbiFUyn3cRU76peed/9bbeD6w61syT5iRIbVDkpU7GzuHYuskxJ2INsbCBEVhUy
         U+4p6t2nvvqQ73qEPLaAEquUcqp4/6Wn5be5dv+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 486/550] media: verisilicon: Fixes clock list for rk3588 av1 decoder
Date:   Wed, 15 Nov 2023 14:17:50 -0500
Message-ID: <20231115191634.553168099@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

[ Upstream commit 39377f84fb98561b86b645f0b7c33512eba7afaf ]

Mainlined RK3588 clock driver manage by itself the dependency between
aclk/hclk and their root clocks (aclk_vdpu_root/hclk_vdpu_root).
RK3588 av1 video decoder do not have to take care of it anymore so
remove them from the list and be compliant with yaml bindings description.

Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 816ffa905a4bb..f975276707835 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -648,7 +648,7 @@ static const char * const rockchip_vpu_clk_names[] = {
 };
 
 static const char * const rk3588_vpu981_vpu_clk_names[] = {
-	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
+	"aclk", "hclk",
 };
 
 /* VDPU1/VEPU1 */
-- 
2.42.0



