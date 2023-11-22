Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0EE7F4E54
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344084AbjKVRZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbjKVRZS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:25:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643DA11F
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:25:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD54C433C8;
        Wed, 22 Nov 2023 17:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673913;
        bh=jEHGYboK0haG3aoXfgmhkpSaVevmbl64K5OzF2inIaI=;
        h=Subject:To:Cc:From:Date:From;
        b=CLcSOTKg0X0Xs6nEDN2rHXEgCyxOKwOHKtMsxIWVyMT7+jmVwnouUXJUrZBB65Uqj
         2BfULxNKvmmxxBxTrUi6tMgfVHdLwfmBrw+1bwy62AGHY3Ewalv+5D1lBlTLFkcG5u
         KZxe+YlpuiTM1CEfoCfMbTaAZ8E6jzbyMq5ptpYs=
Subject: FAILED: patch "[PATCH] hvc/xen: fix event channel handling for secondary consoles" failed to apply to 5.10-stable tree
To:     dwmw@amazon.co.uk, gregkh@linuxfoundation.org, jgross@suse.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:25:10 +0000
Message-ID: <2023112210-salt-repossess-a9d7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ef5dd8ec88ac11e8e353164407d55b73c988b369
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112210-salt-repossess-a9d7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

ef5dd8ec88ac ("hvc/xen: fix event channel handling for secondary consoles")
fe415186b43d ("xen/console: harden hvc_xen against event channel storms")
3bd5371a4da6 ("xen/events: Remove unused bind_evtchn_to_irq_lateeoi()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef5dd8ec88ac11e8e353164407d55b73c988b369 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Fri, 20 Oct 2023 17:15:27 +0100
Subject: [PATCH] hvc/xen: fix event channel handling for secondary consoles
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The xencons_connect_backend() function allocates a local interdomain
event channel with xenbus_alloc_evtchn(), then calls
bind_interdomain_evtchn_to_irq_lateeoi() to bind to that port# on the
*remote* domain.

That doesn't work very well:

(qemu) device_add xen-console,id=con1,chardev=pty0
[   44.323872] xenconsole console-1: 2 xenbus_dev_probe on device/console/1
[   44.323995] xenconsole: probe of console-1 failed with error -2

Fix it to use bind_evtchn_to_irq_lateeoi(), which does the right thing
by just binding that *local* event channel to an irq. The backend will
do the interdomain binding.

This didn't affect the primary console because the setup for that is
special — the toolstack allocates the guest event channel and the guest
discovers it with HVMOP_get_param.

Fixes: fe415186b43d ("xen/console: harden hvc_xen against event channel storms")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231020161529.355083-2-dwmw2@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 98764e740c07..f24e285b6441 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -433,7 +433,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
 	if (ret)
 		return ret;
 	info->evtchn = evtchn;
-	irq = bind_interdomain_evtchn_to_irq_lateeoi(dev, evtchn);
+	irq = bind_evtchn_to_irq_lateeoi(evtchn);
 	if (irq < 0)
 		return irq;
 	info->irq = irq;

