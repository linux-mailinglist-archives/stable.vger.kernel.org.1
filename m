Return-Path: <stable+bounces-261021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k8skKHhDJWpUFQIAu9opvQ
	(envelope-from <stable+bounces-261021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:10:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B164F5DF
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=t1s3P4d7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261021-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261021-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1994F3002F41
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6A30C157;
	Sun,  7 Jun 2026 10:09:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADE1DE8AE;
	Sun,  7 Jun 2026 10:09:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826995; cv=none; b=q+TuwjMhjJ96ec1wxz/1e9xLBhxVqSM+Owa5IqNf3Ue6AHKibN1ZwLfehs8a++r9BEhsO+lZvz315jtbddetBgw3IKR3UYWxag3J5L8VePHhiBgDoLBoM7Ee+QXxW4mzDfiHdBX1jgOIeIO2Pr/1ONFKaqFwNt21O0PBgnep0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826995; c=relaxed/simple;
	bh=KLDIOBYyEletGh/hdXd9xJeh7Fpf+49PtKbPNMGqNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBSxzCoRRtf4eZQvR4hmU0PdFqSq4RuWTKf0mHM7hfvu3xd6LT/AHDJJcDJM4PLEJtpPBzbhA7vXBxEyvw70pQIX1LMirkPxkknS76u1+qjVOaVSgnNvGWGWxvcNabN6Vc0Z1Do9hf0NwfppOI/r0FCqV6WEgHW6GhOOjZzQCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t1s3P4d7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ECE1F00893;
	Sun,  7 Jun 2026 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826994;
	bh=XQ1dxS3wI9IsEbBWqwjybtXPGo7zszhBi1DVCcSS3i0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t1s3P4d7N6WApvYYwMvY60//LHldwm9FxxYrtWUn+Ywkooe84VwV7a2v8YsMmrMxx
	 9AYfNxt5Dbs2eYFdEVusLpRHRP52I5noDM30fCjLLs+wP9T+QV9cNHMbM6y0axeNEZ
	 5yQ+9Qstf9x8on8jnhbEp7MqNbaFd/5fY+naALlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 049/332] ethtool: module: avoid racy updates to dev->ethtool bitfield
Date: Sun,  7 Jun 2026 11:56:58 +0200
Message-ID: <20260607095729.924248162@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261021-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:danieller@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD1B164F5DF

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7a84b965ffc12030af63cd10a8f3a1123ff39b7a ]

When reviewing other changes Gemini points out that we currently
update module_fw_flash_in_progress without holding any locks.
Since module_fw_flash_in_progress is part of a bitfield this
is not great, updates to other fields may be lost.

We could use a bool and sprinkle some READ_ONCE/WRITE_ONCE here
but seems like the issue is rather than the work is an unusual
writer. The other writers already hold the right locks. So just
very briefly take these locks when the work completes.

Note that nothing ever cancels the FW update work, so there's
no concern with deadlocks vs cancel.

Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Link: https://patch.msgid.link/20260522231312.1710836-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/module.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 594a49fdd7fd06..ce4ce514edca89 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -221,14 +221,22 @@ static void module_flash_fw_work_list_del(struct list_head *list)
 static void module_flash_fw_work(struct work_struct *work)
 {
 	struct ethtool_module_fw_flash *module_fw;
+	struct net_device *dev;
 
 	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
+	dev = module_fw->fw_update.dev;
 
 	ethtool_cmis_fw_update(&module_fw->fw_update);
 
 	module_flash_fw_work_list_del(&module_fw->list);
-	module_fw->fw_update.dev->ethtool->module_fw_flash_in_progress = false;
-	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+	dev->ethtool->module_fw_flash_in_progress = false;
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+
+	netdev_put(dev, &module_fw->dev_tracker);
 	release_firmware(module_fw->fw_update.fw);
 	kfree(module_fw);
 }
-- 
2.53.0




