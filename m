Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7C7A3911
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjIQToc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239919AbjIQToB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8342E7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:43:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB52FC433C8;
        Sun, 17 Sep 2023 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979836;
        bh=zRF+DlKPj12GfWW4fgkhwCyoge/oPy/u06Rw8EvpkGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhrCcMLZ5Ox/Wu+7IZd9fw5zATiMFK+QAcoadF+2MD41BOiZo5Ppyu5Rrn1SF+MJf
         /tTdXOby2i4P63laS5JfjwajSfGMGciZuFCJPuGAi/cZOYtg3gVkCUVSUeXuonDf21
         FUuuzTeHK9sAMHRkZ9s3M+P/4lcolRLYUcwCYDrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 021/285] clk: qcom: camcc-sc7180: fix async resume during probe
Date:   Sun, 17 Sep 2023 21:10:21 +0200
Message-ID: <20230917191052.365617023@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit c948ff727e25297f3a703eb5349dd66aabf004e4 upstream.

To make sure that the controller is runtime resumed and its power domain
is enabled before accessing its registers during probe, the synchronous
runtime PM interface must be used.

Fixes: 8d4025943e13 ("clk: qcom: camcc-sc7180: Use runtime PM ops instead of clk ones")
Cc: stable@vger.kernel.org      # 5.11
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230718132902.21430-2-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/camcc-sc7180.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1664,7 +1664,7 @@ static int cam_cc_sc7180_probe(struct pl
 		return ret;
 	}
 
-	ret = pm_runtime_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
 		return ret;
 


