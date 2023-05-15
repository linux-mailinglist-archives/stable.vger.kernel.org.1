Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85F7036A5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243828AbjEORMN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243724AbjEORL5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8576DC5F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C60662B49
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFACC433D2;
        Mon, 15 May 2023 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170611;
        bh=TXKItwxrTfBoYe0oOuo94XUFSly+tpmtflGT5Hiac+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmvpnbU13l8BbRMGIKclgwfzFmDtxPy3wM5FuMgcq80NBxKEo3rN9yeh8JaZXciNI
         +nWRBnz+dXSOQ1tpgY2+owhbC2Q2zE+1MA63/VQul4Lq4pHZotum86VXsWNiEUkVCq
         98la7gxW/EHhxrIvD3fJ5nuiwyM/jf7V7IpZniA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 6.1 146/239] ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
Date:   Mon, 15 May 2023 18:26:49 +0200
Message-Id: <20230515161726.063522150@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Zev Weiss <zev@bewilderbeest.net>

commit a3fd10732d276d7cf372c6746a78a1c8b6aa7541 upstream.

Turns out it's in fact not the same as the heartbeat LED.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: stable@vger.kernel.org # v5.18+
Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
Link: https://lore.kernel.org/r/20230224000400.12226-2-zev@bewilderbeest.net
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -31,7 +31,7 @@
 		};
 
 		system-fault {
-			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 	};


