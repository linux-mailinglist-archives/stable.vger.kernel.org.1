Return-Path: <stable+bounces-212862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHvUMr+CfGlwNgIAu9opvQ
	(envelope-from <stable+bounces-212862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:06:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C8B928C
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD07300953A
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40743396E9;
	Fri, 30 Jan 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I6ouKihC"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726531ED6B
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767589; cv=none; b=o6mtClhpnkcWX9zMTMdwiSPuZy0F/rd6YPnPi7rj8K3JaGGG7LN+qPrSjaidr2aXmuoEyCTPvb5eChx+aGdx/SqCOL3fKEZHiSeFxVaiz6JrH5y4YAwe8kgEUUzoHbiOludONgqd6Bdbrb7JuKQKkNoMk7APfISpH5I1qMHjmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767589; c=relaxed/simple;
	bh=7jyevZFZLAcUnXqqzxI4skDEIwGmnlSZapSWB8fMnM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Te96+kKzkyAkyd7UVfZw8zlcMns3zFTTfswTH7dCM0+0uSxQNGupHOrZRGUUvqucFyG0sE7vm+aOVNiU3e3r1suJSUGzYlK+m9U6rAUOuthsEg8wIvdygBrHtZyaXYEBbgyjynGhEn/uNMcQQCMaTQr4STM22XEPjPvrtbWxq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I6ouKihC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2A1B3C22F5B;
	Fri, 30 Jan 2026 10:06:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C600A6075A;
	Fri, 30 Jan 2026 10:06:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0895119A8875;
	Fri, 30 Jan 2026 11:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769767584; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hLDn2ySiB0Tpsta6+/1jzi+11wm+hKE7qMJ6g6qxnDY=;
	b=I6ouKihC9TXTAqhV7SESHA6UzNTAdelgUUQMpbavPT6LcMzm4iCLTJO7lODJuPjQ7FYNqL
	rPD8Ze+K226nL0tAfoqV7NUlrfsa/GrchxiQt/agvOsCH+Xvm6/qzdQbOjugQooWHY8MJt
	EM1MkRT3a2E1C5C05peULv/uhIp9Nogc+qRKEwawCeqEIiRns5rK70Wnh4QTlxkeJc2xbn
	dvtI3+TRYS+DZaRK8KG/83coh2acMC2lyKtLWuu2EnL6OTJOO+2mNQ/c9qzQ49QXCr3Hbf
	SiSBJQAYPaM5WS5+/bkA1iPfqrjoyxzgTp3yUXAqwf0Mv0wvqiNNWRmq6x6Blg==
From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Date: Fri, 30 Jan 2026 11:05:45 +0100
Subject: [PATCH] usb: cdns3: fix role switching during resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-usb-cdns3-fix-role-switching-during-resume-v1-1-44c456852b52@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHiCfGkC/y2N2w6CQAxEf4X02SbLQlT8FeOD7BZooou2rJIQ/
 p16eZqcSWbOAkrCpHAqFhB6sfKYDMpdAWG4pp6QozF45/eu9A1mbTHEpBV2PKOMN0J98xQGTj3
 GLJ8Q0nwnjFV3bOp4oLZ2YIcPIdt8ZefLj4We2ZzTv1zXDbcUbPmRAAAA
X-Change-ID: 20260129-usb-cdns3-fix-role-switching-during-resume-d3f894d7eb40
To: Pawel Laszczak <pawell@cadence.com>, Peter Chen <peter.chen@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, theo.lebrun@bootlin.com, 
 Frank Li <frank.li@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, richard.genoud@bootlin.com, 
 Udit Kumar <u-kumar1@ti.com>, Prasanth Mantena <p-mantena@ti.com>, 
 Abhash Kumar <a-kumar2@ti.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peter Chen <peter.chen@nxp.com>, 
 stable@vger.kernel.org, "Thomas Richard (TI)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212862-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 3A5C8B928C
X-Rspamd-Action: no action

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

Cc: stable@vger.kernel.org
Fixes: 2cf2581cd229 ("usb: cdns3: add power lost support for system resume")
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
This patch is related to the following discussion:
https://lore.kernel.org/all/8743fec1-301d-46e1-89bf-7952c73faa86@bootlin.com/
---
 drivers/usb/cdns3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

---
base-commit: 9ff530af7fe2b44c93784641540d5b79fc9fe315
change-id: 20260129-usb-cdns3-fix-role-switching-during-resume-d3f894d7eb40

Best regards,
-- 
Thomas Richard (TI) <thomas.richard@bootlin.com>


