Return-Path: <stable+bounces-3239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB57FF20C
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5BC28264C
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97015103F;
	Thu, 30 Nov 2023 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RPpHE1cm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826151016
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 14:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D61C433C7;
	Thu, 30 Nov 2023 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701354882;
	bh=E0k3F8LrhtQAvT0Z5mvZElIprpvWuTm/wkWwcwVuplQ=;
	h=Subject:To:Cc:From:Date:From;
	b=RPpHE1cmcb8NgbBzqVBafcnq828fNI86tx5nd3fBmcTGzKiSrVM8BBfuLX51n3YGY
	 TlEspP6nfaWMuk5ff22N1iV1IwaP5W8irxEQj29B2Rg97I9kopXgXfI9wFludfmRjL
	 aDFVldtrlsiAyvEioBQpwFJ4bdNydcGVM+OQWlrA=
Subject: FAILED: patch "[PATCH] hv_netvsc: Fix race of register_netdevice_notifier and VF" failed to apply to 4.14-stable tree
To: haiyangz@microsoft.com,decui@microsoft.com,pabeni@redhat.com,wojciech.drewek@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 30 Nov 2023 14:34:39 +0000
Message-ID: <2023113039-aged-crook-4078@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 85520856466ed6bc3b1ccb013cddac70ceb437db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023113039-aged-crook-4078@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier and VF register")
a7f99d0f2bbf ("hv_netvsc: use reciprocal divide to speed up percent calculation")
6b0cbe315868 ("hv_netvsc: Add initialization of tx_table in netvsc_device_add()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85520856466ed6bc3b1ccb013cddac70ceb437db Mon Sep 17 00:00:00 2001
From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Sun, 19 Nov 2023 08:23:42 -0800
Subject: [PATCH] hv_netvsc: Fix race of register_netdevice_notifier and VF
 register

If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
but NETDEV_POST_INIT is not.

Move register_netdevice_notifier() earlier, so the call back
function is set before probing.

Cc: stable@vger.kernel.org
Fixes: e04e7a7bbd4b ("hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_probe()")
Reported-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 5e528a76f5f5..b7dfd51f09e6 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2793,12 +2793,17 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-		return ret;
+		goto err_vmbus_reg;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
+
+err_vmbus_reg:
+	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	return ret;
 }
 
 MODULE_LICENSE("GPL");


