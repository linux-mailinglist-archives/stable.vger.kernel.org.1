Return-Path: <stable+bounces-217949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM7cNNkanmntTQQAu9opvQ
	(envelope-from <stable+bounces-217949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:40:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4432918CD2D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 22:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B10AA3033AAC
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 21:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB633DEDD;
	Tue, 24 Feb 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpW346vY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A1330D5E
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969236; cv=none; b=tUyHVwWuEiwp8E91a2eATAx4qLlIXw1HBs/g8vPfsKi26iL48qeyrM1pEWTGcmLEQmIVsC8gjHaBThL+06AvpZMGGaNKm5jlxqA8hIWOz7GprbS3Vnf/7ixennH43WZi8z+whkRYrQCnsxXUX278h/5ly1nvicZx7dMRgiFblS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969236; c=relaxed/simple;
	bh=o9u+fqijSVHxtegruvufZy5n3nSFRk8ospyGdRbZ1yE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=suQ1//S6HV8Z1/iusBIn6vR0Us8V1LuGGiNayKBVq9A4ZtCAl/rfmBqRkwNDpu6MfZM3n3YqFjTZtMHoo3EdtuTJ/vsvA1DxCU381anOxwWiNXBCCaz3ZOSdxitrhIbpAgDisyMgsK+7FkwMtRwfBec06cBDngnRGzG+RaM/GwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpW346vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B95C116D0;
	Tue, 24 Feb 2026 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969236;
	bh=o9u+fqijSVHxtegruvufZy5n3nSFRk8ospyGdRbZ1yE=;
	h=Subject:To:Cc:From:Date:From;
	b=DpW346vYGXSm8ldYS3XUTBVF3zIBbrSUCpeeaGAL8DGiobxda0qxy79QGcVGNfp8C
	 7pleg5Qsc6Wua9x0MMM4FJIs8hcSv+nP1KcuLs5R7tOZvQ8X2IGDSDnevJ/3vZtv3e
	 6fQ0rJNVeawZMzzOdfZdL/zmONpIKYxK6Nl65Mw0=
Subject: FAILED: patch "[PATCH] usb: cdns3: fix role switching during resume" failed to apply to 5.15-stable tree
To: thomas.richard@bootlin.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Feb 2026 13:40:24 -0800
Message-ID: <2026022424-backshift-doily-d162@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217949-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:email,bootlin.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 4432918CD2D
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 87e4b043b98a1d269be0b812f383881abee0ca45
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026022424-backshift-doily-d162@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87e4b043b98a1d269be0b812f383881abee0ca45 Mon Sep 17 00:00:00 2001
From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Date: Fri, 30 Jan 2026 11:05:45 +0100
Subject: [PATCH] usb: cdns3: fix role switching during resume

If the role change while we are suspended, the cdns3 driver switches to the
new mode during resume. However, switching to host mode in this context
causes a NULL pointer dereference.

The host role's start() operation registers a xhci-hcd device, but its
probe is deferred while we are in the resume path. The host role's resume()
operation assumes the xhci-hcd device is already probed, which is not the
case, leading to the dereference. Since the start() operation of the new
role is already called, the resume operation can be skipped.

So skip the resume operation for the new role if a role switch occurs
during resume. Once the resume sequence is complete, the xhci-hcd device
can be probed in case of host mode.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000208
Mem abort info:
...
Data abort info:
...
[0000000000000208] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 146 Comm: sh Not tainted
6.19.0-rc7-00013-g6e64f4aabfae-dirty #135 PREEMPT
Hardware name: Texas Instruments J7200 EVM (DT)
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : usb_hcd_is_primary_hcd+0x0/0x1c
lr : cdns_host_resume+0x24/0x5c
...
Call trace:
 usb_hcd_is_primary_hcd+0x0/0x1c (P)
 cdns_resume+0x6c/0xbc
 cdns3_controller_resume.isra.0+0xe8/0x17c
 cdns3_plat_resume+0x18/0x24
 platform_pm_resume+0x2c/0x68
 dpm_run_callback+0x90/0x248
 device_resume+0x100/0x24c
 dpm_resume+0x190/0x2ec
 dpm_resume_end+0x18/0x34
 suspend_devices_and_enter+0x2b0/0xa44
 pm_suspend+0x16c/0x5fc
 state_store+0x80/0xec
 kobj_attr_store+0x18/0x2c
 sysfs_kf_write+0x7c/0x94
 kernfs_fop_write_iter+0x130/0x1dc
 vfs_write+0x240/0x370
 ksys_write+0x70/0x108
 __arm64_sys_write+0x1c/0x28
 invoke_syscall+0x48/0x10c
 el0_svc_common.constprop.0+0x40/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0x108
 el0t_64_sync_handler+0xa0/0xe4
 el0t_64_sync+0x198/0x19c
Code: 52800003 f9407ca5 d63f00a0 17ffffe4 (f9410401)
---[ end trace 0000000000000000 ]---

Cc: stable <stable@kernel.org>
Fixes: 2cf2581cd229 ("usb: cdns3: add power lost support for system resume")
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://patch.msgid.link/20260130-usb-cdns3-fix-role-switching-during-resume-v1-1-44c456852b52@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 1243a5cea91b..f0e32227c0b7 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -551,7 +551,7 @@ int cdns_resume(struct cdns *cdns)
 		}
 	}
 
-	if (cdns->roles[cdns->role]->resume)
+	if (!role_changed && cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, power_lost);
 
 	return 0;


