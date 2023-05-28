Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29396713E1E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjE1TcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjE1TcK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FAA8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E14261D9A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C25CC433EF;
        Sun, 28 May 2023 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302328;
        bh=+JYt3p0XP3EDMuzLeobbsdevTRb4nvQByz4E98TxOmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NthsyIntRxYFzgsuPoab2QRWy2lr1fpZzF3YQVWbFkjmioaxmFA8bvg4k16/2oRof
         WqACMwBbmj4AxX6ysRgJSooOUD05jJJVja+ez7dI+R8AG1SBFQo3y0yyYwdIcrQe1O
         kA1e6V0aTWR0UVu/L56kRd3BZzIrOEl/7LoDfHxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 6.3 090/127] firmware: arm_ffa: Check if ffa_driver remove is present before executing
Date:   Sun, 28 May 2023 20:11:06 +0100
Message-Id: <20230528190839.254922581@linuxfoundation.org>
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

From: Sudeep Holla <sudeep.holla@arm.com>

commit b71b55248a580e9c9befc4ae060539f1f8e477da upstream.

Currently ffa_drv->remove() is called unconditionally from
ffa_device_remove(). Since the driver registration doesn't check for it
and allows it to be registered without .remove callback, we need to check
for the presence of it before executing it from ffa_device_remove() to
above a NULL pointer dereference like the one below:

  | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  | Mem abort info:
  |   ESR = 0x0000000086000004
  |   EC = 0x21: IABT (current EL), IL = 32 bits
  |   SET = 0, FnV = 0
  |   EA = 0, S1PTW = 0
  |   FSC = 0x04: level 0 translation fault
  | user pgtable: 4k pages, 48-bit VAs, pgdp=0000000881cc8000
  | [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
  | Internal error: Oops: 0000000086000004 [#1] PREEMPT SMP
  | CPU: 3 PID: 130 Comm: rmmod Not tainted 6.3.0-rc7 #6
  | Hardware name: FVP Base RevC (DT)
  | pstate: 63402809 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=-c)
  | pc : 0x0
  | lr : ffa_device_remove+0x20/0x2c
  | Call trace:
  |  0x0
  |  device_release_driver_internal+0x16c/0x260
  |  driver_detach+0x90/0xd0
  |  bus_remove_driver+0xdc/0x11c
  |  driver_unregister+0x30/0x54
  |  ffa_driver_unregister+0x14/0x20
  |  cleanup_module+0x18/0xeec
  |  __arm64_sys_delete_module+0x234/0x378
  |  invoke_syscall+0x40/0x108
  |  el0_svc_common+0xb4/0xf0
  |  do_el0_svc+0x30/0xa4
  |  el0_svc+0x2c/0x7c
  |  el0t_64_sync_handler+0x84/0xf0
  |  el0t_64_sync+0x190/0x194

Fixes: 244f5d597e1e ("firmware: arm_ffa: Add missing remove callback to ffa_bus_type")
Link: https://lore.kernel.org/r/20230419-ffa_fixes_6-4-v2-1-d9108e43a176@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/arm_ffa/bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -53,7 +53,8 @@ static void ffa_device_remove(struct dev
 {
 	struct ffa_driver *ffa_drv = to_ffa_driver(dev->driver);
 
-	ffa_drv->remove(to_ffa_dev(dev));
+	if (ffa_drv->remove)
+		ffa_drv->remove(to_ffa_dev(dev));
 }
 
 static int ffa_device_uevent(const struct device *dev, struct kobj_uevent_env *env)


