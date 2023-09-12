Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CDD79BFEF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379575AbjIKWow (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbjIKOCk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29971CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB77C433C8;
        Mon, 11 Sep 2023 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440955;
        bh=UuMt43T0kAd1f+3FmCQcfSdrtDrpsq1WYoOpIUbW64w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dA+rDRbFPX2S5tBQ93JLGn8WAbvjnScJVOBWPd8sdNn+AzPtaPu3GKUZOjfNhe8YS
         CrJbS4jl+ar40MdEhnck5BFpELyMVN4ql2yb3hxoCyI8MKs04GDyCPY2z1teLhpZXa
         km5Y6vtbIsp47fKwfHdAHx7XZMIJzbQweFcym4jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Francesco Dolcini <francesco@dolcini.it>,
        Wadim Egorov <w.egorov@phytec.de>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.5 244/739] firmware: ti_sci: Use system_state to determine polling
Date:   Mon, 11 Sep 2023 15:40:43 +0200
Message-ID: <20230911134657.976198909@linuxfoundation.org>
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

From: Nishanth Menon <nm@ti.com>

[ Upstream commit 9225bcdedf16297a346082e7d23b0e8434aa98ed ]

Commit b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled
mode during system suspend") aims to resolve issues with tisci
operations during system suspend operation. However, the system may
enter a no_irq stage in various other usage modes, including power-off
and restart. To determine if polling mode is appropriate, use the
system_state instead.

While at this, drop the unused is_suspending state variable and
related helpers.

Fixes: b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled mode during system suspend")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Reported-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62
Link: https://lore.kernel.org/r/20230620130329.4120443-1-nm@ti.com
Closes: https://lore.kernel.org/all/ZGeHMjlnob2GFyHF@francesco-nb.int.toradex.com/
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/ti_sci.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 039d92a595ec6..91aaa0ca9bde8 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -97,7 +97,6 @@ struct ti_sci_desc {
  * @node:	list head
  * @host_id:	Host ID
  * @users:	Number of users of this instance
- * @is_suspending: Flag set to indicate in suspend path.
  */
 struct ti_sci_info {
 	struct device *dev;
@@ -116,7 +115,6 @@ struct ti_sci_info {
 	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
-	bool is_suspending;
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
@@ -418,14 +416,14 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 
 	ret = 0;
 
-	if (!info->is_suspending) {
+	if (system_state <= SYSTEM_RUNNING) {
 		/* And we wait for the response. */
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout))
 			ret = -ETIMEDOUT;
 	} else {
 		/*
-		 * If we are suspending, we cannot use wait_for_completion_timeout
+		 * If we are !running, we cannot use wait_for_completion_timeout
 		 * during noirq phase, so we must manually poll the completion.
 		 */
 		ret = read_poll_timeout_atomic(try_wait_for_completion, done_state,
@@ -3281,35 +3279,6 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 	return NOTIFY_BAD;
 }
 
-static void ti_sci_set_is_suspending(struct ti_sci_info *info, bool is_suspending)
-{
-	info->is_suspending = is_suspending;
-}
-
-static int ti_sci_suspend(struct device *dev)
-{
-	struct ti_sci_info *info = dev_get_drvdata(dev);
-	/*
-	 * We must switch operation to polled mode now as drivers and the genpd
-	 * layer may make late TI SCI calls to change clock and device states
-	 * from the noirq phase of suspend.
-	 */
-	ti_sci_set_is_suspending(info, true);
-
-	return 0;
-}
-
-static int ti_sci_resume(struct device *dev)
-{
-	struct ti_sci_info *info = dev_get_drvdata(dev);
-
-	ti_sci_set_is_suspending(info, false);
-
-	return 0;
-}
-
-static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
-
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3516,7 +3485,6 @@ static struct platform_driver ti_sci_driver = {
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
-		   .pm = &ti_sci_pm_ops,
 	},
 };
 module_platform_driver(ti_sci_driver);
-- 
2.40.1



