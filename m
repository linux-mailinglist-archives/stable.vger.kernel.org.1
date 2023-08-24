Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8A7876B5
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjHXRTE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242785AbjHXRSq (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EC12C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789986750B
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D4C433C8;
        Thu, 24 Aug 2023 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897523;
        bh=S4Vhi/LE75Eztt37+w0DdeMWGVKQPg3+jzJ79L87XSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQaf+GVSQqlJ1SogCG3Kzj8/nooNB4Js0nCJb5wOF9GHTWhcuoeuhE6pA4jBHCSRW
         UVFaDYXojjx88KFGvm8T1Wnn76aZrCVpcLFnn5sYMqHK2oFZK8OA2jDCmdvX6xa70h
         jECZdwhF5eq/P1GeBNall85mxJLdhJ9VsniEuLFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 070/135] fbdev: mmp: fix value check in mmphw_probe()
Date:   Thu, 24 Aug 2023 19:09:02 +0200
Message-ID: <20230824170620.240347329@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

commit 0872b2c0abc0e84ac82472959c8e14e35277549c upstream.

in mmphw_probe(), check the return value of clk_prepare_enable()
and return the error code if clk_prepare_enable() returns an
unexpected value.

Fixes: d63028c38905 ("video: mmp display controller support")
Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -518,7 +518,9 @@ static int mmphw_probe(struct platform_d
 		ret = -ENOENT;
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);


