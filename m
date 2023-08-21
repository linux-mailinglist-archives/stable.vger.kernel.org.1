Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B497832DC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjHUUFD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHUUFB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753A4E4
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B58A648F1
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19326C433C7;
        Mon, 21 Aug 2023 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648298;
        bh=BnfRMvWGj+yOLG3+t50I5FPVEgAalNskJrrEnB1BRGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wnijTsEuBo2y3r5x5j50w1ks2xPMU7V6y9gTP97gqizoiZrekd3x+5s7wfby/T2fT
         FK1CsUu264BKeSk1Xko8s442cxRAu13YQRbVui4/jQY90o9+xnyFmqDYEUGGZw9qh3
         6H0B6Na/OWHvyXCv0J/ERWdPfJsHTwM4wj/J+4vc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.4 097/234] fbdev: mmp: fix value check in mmphw_probe()
Date:   Mon, 21 Aug 2023 21:41:00 +0200
Message-ID: <20230821194133.099234877@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
@@ -519,7 +519,9 @@ static int mmphw_probe(struct platform_d
 			      "unable to get clk %s\n", mi->clk_name);
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);


