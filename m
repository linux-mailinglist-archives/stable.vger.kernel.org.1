Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904FB77F7FD
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351577AbjHQNoE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351621AbjHQNny (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:43:54 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C102D5A
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:43:53 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id AEEC72F20238; Thu, 17 Aug 2023 13:43:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
        by air.basealt.ru (Postfix) with ESMTPSA id C41572F20236;
        Thu, 17 Aug 2023 13:43:39 +0000 (UTC)
From:   Alexander Ofitserov <oficerovas@altlinux.org>
To:     oficerovas@altlinux.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     stable@vger.kernel.org
Subject: [RESEND 3/3] pinctrl: tigerlake: Add Alder Lake-P ACPI ID
Date:   Thu, 17 Aug 2023 16:43:36 +0300
Message-Id: <20230817134336.965020-4-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20230817134336.965020-1-oficerovas@altlinux.org>
References: <20230817134336.965020-1-oficerovas@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Intel Alder Lake-P has the same pin layout as the Tiget Lake-LP
so add support for this to the existing Tiger Lake driver.

Signed-off-by: Alexander Ofitserov <oficerovas@altlinux.org>
---
 drivers/pinctrl/intel/pinctrl-tigerlake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/intel/pinctrl-tigerlake.c b/drivers/pinctrl/intel/pinctrl-tigerlake.c
index bed769d99b8be0..3ddaeffc04150a 100644
--- a/drivers/pinctrl/intel/pinctrl-tigerlake.c
+++ b/drivers/pinctrl/intel/pinctrl-tigerlake.c
@@ -748,6 +748,7 @@ static const struct intel_pinctrl_soc_data tglh_soc_data = {
 static const struct acpi_device_id tgl_pinctrl_acpi_match[] = {
 	{ "INT34C5", (kernel_ulong_t)&tgllp_soc_data },
 	{ "INT34C6", (kernel_ulong_t)&tglh_soc_data },
+	{ "INTC1055", (kernel_ulong_t)&tgllp_soc_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, tgl_pinctrl_acpi_match);
-- 
2.33.8

