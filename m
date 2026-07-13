Return-Path: <stable+bounces-273855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 663LGP36VGpTiQAAu9opvQ
	(envelope-from <stable+bounces-273855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:49:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC36D74C976
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 16:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=D5WpgTSH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273855-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273855-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CD2B3033D00
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E078435EEA;
	Mon, 13 Jul 2026 14:44:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C0438028
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:43:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953841; cv=none; b=rO/XzUaMm0Kknki7Y6QTXYxnlKX2eia4V/oZujIb2bnQYCggO+fGqyt/wobh46fcDWjriwf+0EVDQvPjYJAZzEMcX0fJwxGiNMRLEwmCM/W5Lg6kB+GcCr6llY1WeOwOeMigK9byPQBu/i99uuslWMA00W3XdEmN0BCZ1fFA4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953841; c=relaxed/simple;
	bh=QFScjVTqoh4F0Ect2GX8qD5z7jKyTtnc9qxCnA67yGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lltOyyHfRoWVCcA2fu3fZASYS7YorwvgvrM7VHA2rur/XgBZHBKqq9IgmnuiYYP841TrorTrfW1ENnILelVShmHqP14ODKfcd/+xLD5HD4DWSvQOYrXGAaoegW+IwMSNyUW6hTVG6PaSiBpsod222WPJl4559SqHePGOBH/VJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D5WpgTSH; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1540B1A0F9F;
	Mon, 13 Jul 2026 14:43:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C763E60345;
	Mon, 13 Jul 2026 14:43:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1393411BD05B6;
	Mon, 13 Jul 2026 16:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783953831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=mgoRmfCNtNFVeeYwLQYefomCmpA70gvR/bkP8iy2YoI=;
	b=D5WpgTSH/+zxYt0fMiG8fUyIRa92WBF0B/56UVukU+YWHH5IgOsCpJPm/FS4b/ETVcM3Xw
	ITl/b84y54UNQ89WbObtUz6AeOEj/gDJFVexg5uw+A3AWqK8S6od9poK/beIXK05foNU80
	nZ7GS0B1Ss28OQysXqPEQVGgBeUOZhydKh7n7x75HKJh2lxhT9BCp2B2ZL4LRgaDZBJcAC
	y09MZ6rgM9MtvKf8oaaYClsuK/tp1Gv3sBlLDiWs76fH6dIvvISuM84rk5moINhzXokuLQ
	kktd2MoiGp7bFNYjkmzM1ygGqm+r03YMP8MILC0kZARXPkVBGxo79Pmgn3jwdA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 13 Jul 2026 16:43:43 +0200
Subject: [PATCH] mfd: cgbc: Fix teardown ordering in cgbc_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJ75VGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MD3eT0pGTd5PyiVN20zAoIryg1N78sVdfUIDnJKNXSwigpMUkJqL+
 gKBWoBGx2dGxtLQCxK7IWawAAAA==
X-Change-ID: 20260710-cgbc-core-fix-cgbc-remove-50cb2e982bab
To: Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273855-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:thomas.petazzoni@bootlin.com,m:mfd@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:thomas.richard@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.richard@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC36D74C976

Release Board Controller session once children are removed by the core.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1783507945.git.u.kleine-koenig%40baylibre.com?part=19
Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 10bb4b414c34..2becaf797646 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -364,9 +364,9 @@ static void cgbc_remove(struct platform_device *pdev)
 {
 	struct cgbc_device_data *cgbc = platform_get_drvdata(pdev);
 
-	cgbc_session_release(cgbc);
-
 	mfd_remove_devices(&pdev->dev);
+
+	cgbc_session_release(cgbc);
 }
 
 static struct platform_driver cgbc_driver = {

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260710-cgbc-core-fix-cgbc-remove-50cb2e982bab

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


