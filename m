Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A37A3A6C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbjIQUDR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjIQUCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:02:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C965187
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:02:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1802CC433CD;
        Sun, 17 Sep 2023 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980954;
        bh=Ib/M55cvfB37uLiofTWwMSszBjIXjlgqLRJvZ4US3u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZhzAkjVYslSSWF73n1g50qw8Iz6jomMHBby9gIsw5jfh3G/Oqg96K0mUIot8jQvg
         G+OPzK4SR2xvUQyoQq9Z2UH+WchM0VWSWygOnymGSvlEawgwS264/KrcRLv8fio7yp
         8O5ya5T9D/qkiufwXjKx2vx8jov8uIrILj0I/+zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.1 027/219] clk: qcom: camcc-sc7180: fix async resume during probe
Date:   Sun, 17 Sep 2023 21:12:34 +0200
Message-ID: <20230917191041.977768577@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 


