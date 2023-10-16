Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCF7CA379
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJPJGX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjJPJGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:06:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB80FEE
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:06:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2EC433C9;
        Mon, 16 Oct 2023 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447174;
        bh=Tupbdr8b5sl72rA8Zml2tYOEHg8zR3b2w+RMubhbpLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dI5IoTWNm0bnQp4Q4wr9yW0L375cPZztMLLdBc0+rmwPZOs5YkQNt1qXOkTSvEqwA
         lZqveeIdOH3nUELHd1jqoxPQPE3aaNXSvhGQSnfeIwiJ8hWccVUUQCXPLJ6BoKS++/
         tumKfWmYSIyrEDghE8sRXubme9Sh/pHZtyMGeRnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 010/191] media: dt-bindings: imx7-csi: Make power-domains not required for imx8mq
Date:   Mon, 16 Oct 2023 10:39:55 +0200
Message-ID: <20231016084015.643576533@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit d7614a2733f5e354c075be178b068a241d5d8b11 ]

On i.MX8MQ the MIPI CSI block does have an associated power-domain, but
the CSI bridge does not.

Remove the power-domains requirement from the i.MX8MQ CSI bridge
to fix the following schema warning:

imx8mq-librem5-r4.dtb: csi@30a90000: 'power-domains' is a required property
from schema $id: http://devicetree.org/schemas/media/nxp,imx7-csi.yaml#

Fixes: de655386845a ("media: dt-bindings: media: imx7-csi: Document i.MX8M power-domains property")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20231004201105.2323758-1-festevam@gmail.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
index 358019e85d907..326284e151f66 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
@@ -59,7 +59,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8mq-csi
               - fsl,imx8mm-csi
     then:
       required:
-- 
2.40.1



