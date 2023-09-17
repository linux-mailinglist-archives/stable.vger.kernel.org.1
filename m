Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBBC7A3927
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjIQTpj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbjIQTpc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BBB138
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05AFC433C7;
        Sun, 17 Sep 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979912;
        bh=sCPtBEYNmXs54gIiv/AovSw7cQrLbOyiRcDC69vF+iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5vozvNAAIWfkYJzbQhuhyxlIryQwtTOIS58x6jJcqPMtfPRkXVHatHe8ha5nXItZ
         DqzV8ugn2opt0NvxCW6iqQ+k8Et1JZb0o/abFLrfj8hha5oEXemggMOQpmokdiGSs7
         gZA6I/4gZLqEtVfzhIugcs8ZrS/1XMNpE7QqdAFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.5 043/285] dt-bindings: clock: xlnx,versal-clk: drop select:false
Date:   Sun, 17 Sep 2023 21:10:43 +0200
Message-ID: <20230917191053.164951046@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 172044e30b00977784269e8ab72132a48293c654 upstream.

select:false makes the schema basically ignored and not effective, which
is clearly not what we want for a device binding.

Fixes: 352546805a44 ("dt-bindings: clock: Add bindings for versal clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230728165923.108589-1-krzysztof.kozlowski@linaro.org
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml |    2 --
 1 file changed, 2 deletions(-)

--- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
@@ -14,8 +14,6 @@ description: |
   reads required input clock frequencies from the devicetree and acts as clock
   provider for all clock consumers of PS clocks.
 
-select: false
-
 properties:
   compatible:
     const: xlnx,versal-clk


