Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45E47BDF2A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376750AbjJIN1F (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376720AbjJIN1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:27:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6299
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:27:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CB7C433C7;
        Mon,  9 Oct 2023 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858023;
        bh=u9U5yFbzVvaC4RcRP2zB/AyfdpP6qKNWJyRlC31I9ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0zF463HVdnKsf7h5gldmie20kRkJ29Krga/AVgFWOelj23BTt/qdPorMy87vgv3e
         XSIlg0gQQLjcQweSvWEpr8H1ehE0B1qfV4B3odMYFsraao1teszTazDAPj1GxbRNGx
         OURD+55Iv4op8/jF7ekZqGVUkps/fG5jO75gYuxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 5.15 68/75] gpio: pxa: disable pinctrl calls for MMP_GPIO
Date:   Mon,  9 Oct 2023 15:02:30 +0200
Message-ID: <20231009130113.635778648@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duje Mihanović <duje.mihanovic@skole.hr>

commit f0575116507b981e6a810e78ce3c9040395b958b upstream.

Similarly to PXA3xx and MMP2, pinctrl-single isn't capable of setting
pin direction on MMP either.

Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-pxa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -243,6 +243,7 @@ static bool pxa_gpio_has_pinctrl(void)
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
 	case MMP2_GPIO:
+	case MMP_GPIO:
 		return false;
 
 	default:


