Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1195779B57A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358231AbjIKWIR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbjIKOBG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7BCCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F91FC433C9;
        Mon, 11 Sep 2023 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440861;
        bh=LEtcJZDUs+ZZFPpT3/7tYltmCkdJEWyC0QEduPwILck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sS7k/YG96k/3OR3O/gKeepi7+eWb5ZH7g6YjXQKAhMExolvjLegry98UJ+LHBHpRy
         Ir8yAr0/QU5WvJiNcqHLRM19RNiwRcAKZrXD2Z2bjY1WEIyTwRn5UlxLb8DheeoqvO
         P903Impu28NvYwyewKeW7JchVb08m3ZoeXh1GXlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 212/739] arm64: defconfig: enable Qualcomm MSM8996 Global Clock Controller as built-in
Date:   Mon, 11 Sep 2023 15:40:11 +0200
Message-ID: <20230911134657.112687957@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit dc015a3a6d6986c41a7bd12fb205a282f685e328 ]

The commit 8f680c287445 ("arm64: defconfig: Switch msm8996 clk drivers
to module") switched CONFIG_MSM_MMCC_8996 to module, which also resulted
in CONFIG_MSM_GCC_8996 being switched to module. This breaks useful
bootflow for Qualcomm MSM8996 / APQ8096 platforms, because the serial is
not enabled anymore until the GCC module is loaded.

Reported-by: Rob Clark <robdclark@gmail.com>
Fixes: 8f680c287445 ("arm64: defconfig: Switch msm8996 clk drivers to module")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230619125404.562137-1-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a25d783dfb955..28714382ce3f5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1182,6 +1182,7 @@ CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_9574=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
+CONFIG_MSM_GCC_8996=y
 CONFIG_MSM_MMCC_8994=m
 CONFIG_MSM_MMCC_8996=m
 CONFIG_MSM_MMCC_8998=m
-- 
2.40.1



