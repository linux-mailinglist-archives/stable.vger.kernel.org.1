Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5588E79B616
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbjIKVF7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbjIKOC0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE7CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C22C433C8;
        Mon, 11 Sep 2023 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440941;
        bh=pbjR07d1Z7S3ng1SSYJ0mPRCsN+YrSAiL1VjbdqFKvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQAShPCL5smHsmF0Amgy3mtilfA/lhEEJ7fonyqxkt0hEqzFPKL0MWDpuFujSBwgN
         XPUJrW+mw6eW3t23uhcRvVg8JBdOQKch/yH3Sj2+4inOhk6e2WbpZVIV23p4ChYyD8
         jY9uPKWlcJ/v29lVOaebNMUZb0mURx85AVEq/vWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 240/739] ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon
Date:   Mon, 11 Sep 2023 15:40:39 +0200
Message-ID: <20230911134657.868033971@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 0ee0ef38aa9f75f21b51f729dd42b2e932515188 ]

Add missing "detach" mailbox to this board to permit the CPU to inform
the remote processor on a detach. This signal allows the remote processor
firmware to stop IPC communication and to reinitialize the resources for
a re-attach.

Without this mailbox, detach is not possible and kernel log contains the
following warning to, so make sure all the STM32MP15xx platform DTs are
in sync regarding the mailboxes to fix the detach issue and the warning:
"
stm32-rproc 10000000.m4: mbox_request_channel_byname() could not locate channel named "detach"
"

Fixes: 6257dfc1c412 ("ARM: dts: stm32: Add coprocessor detach mbox on stm32mp15x-dkx boards")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
index 94e38141af672..fd89542c69c93 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi
@@ -368,8 +368,8 @@ &iwdg2 {
 &m4_rproc {
 	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
 			<&vdev0vring1>, <&vdev0buffer>;
-	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
-	mbox-names = "vq0", "vq1", "shutdown";
+	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>, <&ipcc 3>;
+	mbox-names = "vq0", "vq1", "shutdown", "detach";
 	interrupt-parent = <&exti>;
 	interrupts = <68 1>;
 	interrupt-names = "wdg";
-- 
2.40.1



