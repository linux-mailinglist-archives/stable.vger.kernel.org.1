Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385175CEC1
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjGUQYF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjGUQW6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A4D49F7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A70036108F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9BBC433C7;
        Fri, 21 Jul 2023 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956411;
        bh=LD7H9eyyp3eJncPpC27NUvEoR6amhvpT9RBKP81hHcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNlvwfncX4Y2X4Fn+VYzq3VUvLy3sRs3acWWHTcgrmWx23qBSjDvOhySvy3jBj8sq
         riY1BYbo78ZGMhxfq5Ar6LswK18ghib2NI5KZFHSYgpfOW0w7uWYr/V+bZhO5mfma8
         IkObM0lWWJn5uhB6FwOH6Iosi3k14dHWIs+Vpddw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>
Subject: [PATCH 6.4 184/292] mfd: pm8008: Fix module autoloading
Date:   Fri, 21 Jul 2023 18:04:53 +0200
Message-ID: <20230721160536.802312016@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johan Hovold <johan+linaro@kernel.org>

commit d420c9886f5369697047b880221789bf0054e438 upstream.

Add the missing module device table alias to that the driver can be
autoloaded when built as a module.

Cc: stable@vger.kernel.org      # 5.14
Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230526091646.17318-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/qcom-pm8008.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -199,6 +199,7 @@ static const struct of_device_id pm8008_
 	{ .compatible = "qcom,pm8008", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {


