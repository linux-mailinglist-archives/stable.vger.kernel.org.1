Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB416FA762
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjEHK34 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjEHK3u (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994E8171C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B59F626A7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36704C433EF;
        Mon,  8 May 2023 10:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541788;
        bh=azGbbQEulxIH67EX9WHACidebc1MNeevVtf+OG9YJdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICSXmNCNCa3sOqzVgdvSHuthZqsZ/wFklVEsoE7gnAvoiCnJUkX2SpzEd1GgX9Wv/
         kHmPhGel/TZDOK4AAnU8O/x3/gqOb/sMChTVcJSOPWjG7Tqs5jr7DauAdYp/HuJjPR
         xzgJ/QOX3ab5qK+QKj8XSnbXzKo2IjIyOQtHFVAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 226/663] soc: qcom: rpmh-rsc: Support RSC v3 minor versions
Date:   Mon,  8 May 2023 11:40:52 +0200
Message-Id: <20230508094435.646169162@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Tushar Nimkar <quic_tnimkar@quicinc.com>

[ Upstream commit 88704a0cd71909c3107561261412a5d5beb23358 ]

RSC v3 register offsets are same for all minor versions of v3. Fix a
minor version check to pick correct offsets for all v3 minor versions.

Fixes: 40482e4f7364 ("soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets")
Signed-off-by: Tushar Nimkar <quic_tnimkar@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230406115732.9293-1-quic_tnimkar@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0f8b2249f8894..f93544f6d7961 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1073,7 +1073,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	drv->ver.minor = rsc_id & (MINOR_VER_MASK << MINOR_VER_SHIFT);
 	drv->ver.minor >>= MINOR_VER_SHIFT;
 
-	if (drv->ver.major == 3 && drv->ver.minor == 0)
+	if (drv->ver.major == 3 && drv->ver.minor >= 0)
 		drv->regs = rpmh_rsc_reg_offset_ver_3_0;
 	else
 		drv->regs = rpmh_rsc_reg_offset_ver_2_7;
-- 
2.39.2



