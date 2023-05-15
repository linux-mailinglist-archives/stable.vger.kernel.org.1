Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD770339A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbjEOQjP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242833AbjEOQjJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355D40D8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D412F62858
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47F3C4339B;
        Mon, 15 May 2023 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168747;
        bh=of5SpBz90v7O4iAoUywKhpVfD6CXHkr/ChzRtk4IMBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovCnjZG4N4uyd5dxkO1TZa4GIskmdCau+W19Uhop6n25jbDhz43Yt82/bR6/coMfR
         9EuCkoqSSKbfSu9Oa74ZPLdpDEsgkPGgePFg7nLyGxRTwi4YfZ+cqVEyNLZMx1L/Vs
         nQW9xX9OHgPD29usTw4nATrrLJeU27YoPz3fh0ZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Jun <jun.li@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4.19 008/191] USB: dwc3: fix runtime pm imbalance on unbind
Date:   Mon, 15 May 2023 18:24:05 +0200
Message-Id: <20230515161707.496127318@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 44d257e9012ee8040e41d224d0e5bfb5ef5427ea upstream.

Make sure to balance the runtime PM usage count on driver unbind by
adding back the pm_runtime_allow() call that had been erroneously
removed.

Fixes: 266d0493900a ("usb: dwc3: core: don't trigger runtime pm when remove driver")
Cc: stable@vger.kernel.org	# 5.9
Cc: Li Jun <jun.li@nxp.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20230404072524.19014-3-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1563,6 +1563,7 @@ static int dwc3_remove(struct platform_d
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);


