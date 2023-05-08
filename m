Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6B6FAD46
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEHLdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbjEHLcp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5B2DD47
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF676306F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402ABC433D2;
        Mon,  8 May 2023 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545510;
        bh=vA0zeCbEd66IIZ09tbi0zkeB5Meh+dk0ngEv/bIiDe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8+LNG7GaQ3+bX0Zao/bw+5bcjcj0YQC7pBZTyDTOJsc55r7wNxLrEktr+8InULc4
         Z5qL7ly2qdXzCa+L0G1DcdKO0W3wq2jGxcj2SQbYo0LqdFksAGjuXC5/2kp3pv+jGT
         9UipjhtvzUPh1lmer9jrkATC18VwCgmmNTFKDbgg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5.15 034/371] pwm: meson: Fix axg ao mux parents
Date:   Mon,  8 May 2023 11:43:55 +0200
Message-Id: <20230508094813.454536884@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

commit eb411c0cf59ae6344b34bc6f0d298a22b300627e upstream.

This fix is basically the same as 9bce02ef0dfa ("pwm: meson: Fix the
G12A AO clock parents order"). Vendor driver referenced there has
xtal as first parent also for axg ao. In addition fix the name
of the aoclk81 clock. Apparently name aoclk81 as used by the vendor
driver was changed when mainlining the axg clock driver.

Fixes: bccaa3f917c9 ("pwm: meson: Add clock source configuration for Meson-AXG")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-meson.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -424,7 +424,7 @@ static const struct meson_pwm_data pwm_a
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {


