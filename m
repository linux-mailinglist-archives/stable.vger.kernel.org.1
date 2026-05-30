Return-Path: <stable+bounces-258466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFh0GL8nG2rM/ggAu9opvQ
	(envelope-from <stable+bounces-258466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E0261115C
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CA053024080
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF8E3B9D80;
	Sat, 30 May 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hxL8x2db"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5283112C1;
	Sat, 30 May 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164444; cv=none; b=R5ctlKdiZy/Tf7M0ez8PJnMEtJg+fP7oZzpobGsVhP1ZzusLFP+bxo8tmobf5O4miH9oNXM2I/wJ8JY7mKR6E3er0yetyzveRsE2cehGI1jiUHmJs+EAmvl4bN86Y570wXm4Q7SQowByF1JPVgmAAuezAdDYNTOcv3Ho/XFKmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164444; c=relaxed/simple;
	bh=qDcI1FyqsCxuui6E4gIiROzYcPORIbJuuX+x0dHLPFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fq1WGUHmyeXIKKKkypk7/yGy+QRLhPWtG5tKp4krHtFt7Yqvua3NlD17g5p4MZeLH8M0tVvjSc/EuLHzE2lcbDeOwRBkVWgs/cCA4FUzJE1eRy/xertVkr77uD+JXpmq65oDTcBjF1QWKdTTB7zeC6S57kGr05LHXxeEWqt0cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hxL8x2db; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20DE1F00893;
	Sat, 30 May 2026 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164443;
	bh=dT16MGTZ1KDPyw5D63GFhAo3ulaGCy1PVvQJFYYgmI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxL8x2db2JDqlDMTnbqqQ0lBQOUdt1kxOK+tRIh/6dbeQcet/th44hesIKBABID4F
	 zrhNtTzcE1pRdYpbplKDc8XEYUTcv1ETlPpeBEJKMvfcqFNdnxzLMppcfRMpHIkXTO
	 kCaLpNOnVmR5YWFWtSaDTPuBZB8cb2wXFqKhpZ2w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 528/776] platform/x86: panasonic-laptop: Fix OPTD notifier registration and cleanup
Date: Sat, 30 May 2026 18:04:02 +0200
Message-ID: <20260530160253.860464326@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258466-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 33E0261115C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 8baeff2c1d33dad8572216c6ad3a7425852507d4 ]

An ACPI notify handler is leaked if device_create_file() returns an
error in acpi_pcc_hotkey_add().

Also, it is pointless to call pcc_unregister_optd_notifier() in
acpi_pcc_hotkey_remove() if pcc->platform is NULL and it is better
to arrange the cleanup code in that function in the same order as
the rollback code in acpi_pcc_hotkey_add().

Address the above by placing the pcc_register_optd_notifier() call in
acpi_pcc_hotkey_add() after the device_create_file() return value
check and placing the pcc_unregister_optd_notifier() call in
acpi_pcc_hotkey_remove() right before the device_remove_file() call.

Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2411055.ElGaqSPkdT@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/panasonic-laptop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 418cd4d781261..6728e24db1d2a 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -1077,9 +1077,10 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
-		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		if (result)
 			goto out_platform;
+
+		pcc_register_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 	} else {
 		pcc->platform = NULL;
 	}
@@ -1113,10 +1114,10 @@ static int acpi_pcc_hotkey_remove(struct acpi_device *device)
 	i8042_remove_filter(panasonic_i8042_filter);
 
 	if (pcc->platform) {
+		pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 		device_remove_file(&pcc->platform->dev, &dev_attr_cdpower);
 		platform_device_unregister(pcc->platform);
 	}
-	pcc_unregister_optd_notifier(pcc, "\\_SB.PCI0.EHCI.ERHB.OPTD");
 
 	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 
-- 
2.53.0




