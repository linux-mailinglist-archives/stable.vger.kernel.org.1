Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577B878A9ED
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjH1KR0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjH1KRA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F16185
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0556C62FAD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16748C433C7;
        Mon, 28 Aug 2023 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217806;
        bh=HrBX1rclMjc37669V9luVBcGpA0yCLucmSpXIu4Wyyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeC4/zes3Odjz69fPXR8gaL6cvnzSd2z1eezY1W6tPfBKhcIEWzWdgISusluFYtr7
         hwPR2xXeMZnuoLXoqiiHvAhBhrjSSMKk398TE+dELkAPWm5Sc32jFac6UdS1HcVJb0
         djT7s8tyh3/uhMReSH1BZbe0q0c5ksKsUgcrqITE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 17/57] fbdev: mmp: fix value check in mmphw_probe()
Date:   Mon, 28 Aug 2023 12:12:37 +0200
Message-ID: <20230828101144.858438330@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101144.231099710@linuxfoundation.org>
References: <20230828101144.231099710@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -525,7 +525,9 @@ static int mmphw_probe(struct platform_d
 		ret = -ENOENT;
 		goto failed;
 	}
-	clk_prepare_enable(ctrl->clk);
+	ret = clk_prepare_enable(ctrl->clk);
+	if (ret)
+		goto failed;
 
 	/* init global regs */
 	ctrl_set_default(ctrl);


