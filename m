Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931D77F7FE
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbjHQNoG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351615AbjHQNnx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 09:43:53 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B82710
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 06:43:51 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 00FDE2F20233; Thu, 17 Aug 2023 13:43:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from shell.ipa.basealt.ru (unknown [176.12.98.74])
        by air.basealt.ru (Postfix) with ESMTPSA id 8B8E02F20231;
        Thu, 17 Aug 2023 13:43:39 +0000 (UTC)
From:   Alexander Ofitserov <oficerovas@altlinux.org>
To:     oficerovas@altlinux.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH RESEND 0/3] Add support for Intel Alder Lake PCH
Date:   Thu, 17 Aug 2023 16:43:33 +0300
Message-Id: <20230817134336.965020-1-oficerovas@altlinux.org>
X-Mailer: git-send-email 2.33.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch series enables support of i2c bus for Intel Alder Lake PCH-P and PCH-M
on kernel version 5.10. These patches add ID's of Alder lake platform in these
drivers: i801, intel-lpss, pinctrl. ID's were taken from linux kernel version 5.15.

Alexander Ofitserov (3):
  i2c: i801: Add support for Intel Alder Lake PCH
  mfd: intel-lpss: Add Alder Lake's PCI devices IDs
  pinctrl: tigerlake: Add Alder Lake-P ACPI ID

 drivers/i2c/busses/i2c-i801.c             |  8 +++++
 drivers/mfd/intel-lpss-pci.c              | 41 +++++++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-tigerlake.c |  1 +
 3 files changed, 50 insertions(+)

-- 
2.33.8

