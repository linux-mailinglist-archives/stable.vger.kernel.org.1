Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9675D3DD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjGUTPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjGUTPR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA9189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0BF61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08272C433C7;
        Fri, 21 Jul 2023 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966915;
        bh=WjA1bGH1z7X+onK7YlGAUrilWkzEXOrdXbWPhLZn5e4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUKah10YSZjjLSfzh6Ac9uV4nj9SYOa7X62ow+SPn9UUklUOIh+vC6RBjlC9mK0Pa
         R5O1ATXWyvFM5zLUldS4qpQljy4cLy6RzsP4dgd9qaNrWhkdKcnJcSofTM/oueciKN
         e2U0xXSGlyRITa1buWPCMvD132WBsbzm3ayDYoXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krister Johansen <kjlx@templeofstupid.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 513/532] net: ena: fix shift-out-of-bounds in exponential backoff
Date:   Fri, 21 Jul 2023 18:06:57 +0200
Message-ID: <20230721160642.476375220@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

commit 1e9cb763e9bacf0c932aa948f50dcfca6f519a26 upstream.

The ENA adapters on our instances occasionally reset.  Once recently
logged a UBSAN failure to console in the process:

  UBSAN: shift-out-of-bounds in build/linux/drivers/net/ethernet/amazon/ena/ena_com.c:540:13
  shift exponent 32 is too large for 32-bit type 'unsigned int'
  CPU: 28 PID: 70012 Comm: kworker/u72:2 Kdump: loaded not tainted 5.15.117
  Hardware name: Amazon EC2 c5d.9xlarge/, BIOS 1.0 10/16/2017
  Workqueue: ena ena_fw_reset_device [ena]
  Call Trace:
  <TASK>
  dump_stack_lvl+0x4a/0x63
  dump_stack+0x10/0x16
  ubsan_epilogue+0x9/0x36
  __ubsan_handle_shift_out_of_bounds.cold+0x61/0x10e
  ? __const_udelay+0x43/0x50
  ena_delay_exponential_backoff_us.cold+0x16/0x1e [ena]
  wait_for_reset_state+0x54/0xa0 [ena]
  ena_com_dev_reset+0xc8/0x110 [ena]
  ena_down+0x3fe/0x480 [ena]
  ena_destroy_device+0xeb/0xf0 [ena]
  ena_fw_reset_device+0x30/0x50 [ena]
  process_one_work+0x22b/0x3d0
  worker_thread+0x4d/0x3f0
  ? process_one_work+0x3d0/0x3d0
  kthread+0x12a/0x150
  ? set_kthread_struct+0x50/0x50
  ret_from_fork+0x22/0x30
  </TASK>

Apparently, the reset delays are getting so large they can trigger a
UBSAN panic.

Looking at the code, the current timeout is capped at 5000us.  Using a
base value of 100us, the current code will overflow after (1<<29).  Even
at values before 32, this function wraps around, perhaps
unintentionally.

Cap the value of the exponent used for this backoff at (1<<16) which is
larger than currently necessary, but large enough to support bigger
values in the future.

Cc: stable@vger.kernel.org
Fixes: 4bb7f4cf60e3 ("net: ena: reduce driver load time")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Shay Agroskin <shayagr@amazon.com>
Link: https://lore.kernel.org/r/20230711013621.GE1926@templeofstupid.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -35,6 +35,8 @@
 
 #define ENA_REGS_ADMIN_INTR_MASK 1
 
+#define ENA_MAX_BACKOFF_DELAY_EXP 16U
+
 #define ENA_MIN_ADMIN_POLL_US 100
 
 #define ENA_MAX_ADMIN_POLL_US 5000
@@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(
 
 static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
 {
+	exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
 	delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
 	delay_us = min_t(u32, delay_us * (1U << exp), ENA_MAX_ADMIN_POLL_US);
 	usleep_range(delay_us, 2 * delay_us);


