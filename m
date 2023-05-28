Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFA713E42
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjE1Tds (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjE1Tdr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33BC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB9F61DD8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6034C433D2;
        Sun, 28 May 2023 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302425;
        bh=JLpaEqTd1UVwxP8dStYjQPx1r3dO+9RL759twDUljpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tffhxlOoDSByFWp0nVhseJ40YmjzZaCj1uUzQEsS5rKHU8EFy+FAxcKQHo4wsNALv
         X6mkzsBRN80DI+btjD/absx1mV31RTWfiguqppbBuXZAq8jet/sEqSNhMaqxRt+b4z
         m7G83KlBTQMhxwpDg0AU/1zKea/yBxZ15S9pyeYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.3 096/127] ARM: dts: imx6qdl-mba6: Add missing pvcie-supply regulator
Date:   Sun, 28 May 2023 20:11:12 +0100
Message-Id: <20230528190839.427521021@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 91aa4b3782448a7a13baa8cbcdfd5fd19defcbd9 upstream.

This worked before by coincidence, as the regulator was probed and enabled
before PCI RC probe. But probe order changed since commit 259b93b21a9f
("regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in
4.14") and PCIe supply is enabled after RC.
Fix this by adding the regulator to RC node.

The PCIe vaux regulator still needs to be enabled unconditionally for
Mini-PCIe USB-only devices.

Fixes: ef3846247b41 ("ARM: dts: imx6qdl: add TQ-Systems MBa6x device trees")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6qdl-mba6.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-mba6.dtsi
@@ -209,6 +209,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	reset-gpio = <&gpio6 7 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 


