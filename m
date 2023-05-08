Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18B6FA6A3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjEHKW4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjEHKWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96075DC6D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 086DD62542
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8395FC433D2;
        Mon,  8 May 2023 10:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541285;
        bh=u2ifpftMhKqpEYDiTOHYOLI0gumrbaP0Xx5/Ggt+uT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3y1l+hQgY3QNUo3PQ130y9TioVNyFJ1/HdXB4JK8+oflzntzFwqhtXRivycQpNoJ
         FuA925LUquJtnBs/V8Y9Wk9IioZQW8WLywbwazR8qjq/WsS+4G7Cnc7F/legBMKp4U
         CnUvfgncZM76G6S0jtoOXNeR/hAk1fCvKoyHg4D0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Jun <jun.li@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6.2 036/663] USB: dwc3: fix runtime pm imbalance on unbind
Date:   Mon,  8 May 2023 11:37:42 +0200
Message-Id: <20230508094429.633101282@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
@@ -1979,6 +1979,7 @@ static int dwc3_remove(struct platform_d
 	dwc3_core_exit(dwc);
 	dwc3_ulpi_exit(dwc);
 
+	pm_runtime_allow(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);


