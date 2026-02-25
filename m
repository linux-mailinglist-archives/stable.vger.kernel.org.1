Return-Path: <stable+bounces-219116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DVoNeZWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC419040F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73A5D309D461
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BCD24A05D;
	Wed, 25 Feb 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaXb579R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A449F1FC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984163; cv=none; b=VvxNjQKt4ihvqrHr5eB+FLu9yzLd/9lfCNsiUDIJzs3cJBfexx92Cn3f499nWAGh8FfiN5ne4lFnLCO2uLzhyI4JL0UVEAcHu0WC1qDYBalayAz8LZWED6qRt1iYy/690HN7mN+ON0aTCEqMLlGfdfQ2g8jwOrhP2VVZ4bJUNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984163; c=relaxed/simple;
	bh=b3hIQ/tm/f5ntnHP9AHqDiJIgjXCTIBnn1hVm2BXAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/vLWiM9CpJUtLLbGXFyeA06yYrFfMtrRWSfM1HOdVirLSp76lHCwxcFf0wtrGsxsds7Q/hPOuNb95NC8L2KbHVUsmVuqi9rGdKaFYw5dJJ17XrUvllMyrYeeHFe9gsm/oPGuPeAGTVjppTPBvQdbOZoMWLNI5SojA0bHI7yXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaXb579R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44AFC2BC86;
	Wed, 25 Feb 2026 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984163;
	bh=b3hIQ/tm/f5ntnHP9AHqDiJIgjXCTIBnn1hVm2BXAds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OaXb579R9PJYxeAvEPeFK36oSia8pGq2zmv3YlHFov+lrJBaQfpqhUegGf9nJGp0Z
	 3bK6bVP3bJMB11eUL3t9ujqSHxG3165aOmWtRC2ljWzu4GRVU3VI2POxnR+Rjsc6ty
	 Ie6CVHlJSWo6HMQWiFWAgvzSEvYQFdy4M2HFwjuEDgrxduVmAe1FM4LseL3cw9/AR1
	 oUTm6kJkv+G0jYv0UeJKJacEksOG7yRsWNXTdf236h2HJ0KCLWZPIHDd1k3Jkvw5Hh
	 g793QTdR/BqZrfqLzvsSVvz4UQBbyYI1A+B0q/YeiEOU2xRjbyxRT6OSD3MUImXUlv
	 v1vXUd8L87eOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Thomas Richard (TI)" <thomas.richard@bootlin.com>,
	stable <stable@kernel.org>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] usb: cdns3: fix role switching during resume
Date: Tue, 24 Feb 2026 20:49:19 -0500
Message-ID: <20260225014919.3767757-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225014919.3767757-1-sashal@kernel.org>
References: <2026022420-straddle-unquote-c2f6@gregkh>
 <20260225014919.3767757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219116-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,bootlin.com:email]
X-Rspamd-Queue-Id: 7EDC419040F
X-Rspamd-Action: no action

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

[ Upstream commit 87e4b043b98a1d269be0b812f383881abee0ca45 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 1243a5cea91b5..f0e32227c0b79 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -551,7 +551,7 @@ int cdns_resume(struct cdns *cdns)
 		}
 	}
 
-	if (cdns->roles[cdns->role]->resume)
+	if (!role_changed && cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, power_lost);
 
 	return 0;
-- 
2.51.0


