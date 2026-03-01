Return-Path: <stable+bounces-221896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB0MBbWpo2nfJQUAu9opvQ
	(envelope-from <stable+bounces-221896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 650431CDFAD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06CC32E4003
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25C2D6407;
	Sun,  1 Mar 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c71p/zOm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DD26FA6F;
	Sun,  1 Mar 2026 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329399; cv=none; b=OCv5fgqZCw9m03btPz8xbDTO8I5WYeBm2r3l04H1VtRZhAFlVI14+Rp6IegWQ2viftLwFVCbVb6IIaXLtIAcEucU79bo5TQd8GppBY4oNHT5YGhynAX1HWrWPXsLhMFdcJhwRmEEII9S0QewL1PQu5DEkfZponP58BCdiWX5QZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329399; c=relaxed/simple;
	bh=3NyLcyenT7hXafUxUSYG7InSKNrpnG6mAN39Y30vksE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7uCBlq+SvJdnynsvZ69BguBi2wHSOKK/tZJ9O3U0aEHk6CfJQKI22ojk7ZxKv5Ucptb5UANoLgML+BuJaeI6vkX1llaEIjr/jlAKLXLQCqt0akRk07guvIgAZGaYp3193MbCjrCZrt+j0CXRYo7lGvPXjqtPbduNBShQkwZjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c71p/zOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2454C19425;
	Sun,  1 Mar 2026 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329398;
	bh=3NyLcyenT7hXafUxUSYG7InSKNrpnG6mAN39Y30vksE=;
	h=From:To:Cc:Subject:Date:From;
	b=c71p/zOmGVj5FajyzxEgodiYRigmIsaOUhFepVMl6+zVEKTYdB8Nkzx1SLSMQBRAm
	 GvKsbl4CS+0XhaLVmJWdYaWU4tSR/2ALWuMtZJXEkL4C8DQchh2DJbMpe+TdDMlWR0
	 11WI+fRuKDIEWbsgwJxwtp5kFfLiCFSX0P1Ph9+LTXE4bP8aiYDYuBh4CvpSDdIAtZ
	 A25/uWpFePCANOu0T0kZdECxnUUDJ0GBRnDUdIomekPEln6Jme/dEW4UqlDndhAj0e
	 l9L81AiSez3ywB0WW5ATf+lwhPbuClzLLyy81qZ0h+R1aiNNj3naFRAQ4sYy7wNXKO
	 DB8DBNoYj+ztA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "mfd: omap-usb-host: Fix OF populate on driver rebind" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:16 -0500
Message-ID: <20260301014316.1705341-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221896-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 650431CDFAD
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 24804ba508a3e240501c521685a1c4eb9f574f8e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 19 Dec 2025 12:07:14 +0100
Subject: [PATCH] mfd: omap-usb-host: Fix OF populate on driver rebind

Since commit c6e126de43e7 ("of: Keep track of populated platform
devices") child devices will not be created by of_platform_populate()
if the devices had previously been deregistered individually so that the
OF_POPULATED flag is still set in the corresponding OF nodes.

Switch to using of_platform_depopulate() instead of open coding so that
the child devices are created if the driver is rebound.

Fixes: c6e126de43e7 ("of: Keep track of populated platform devices")
Cc: stable@vger.kernel.org	# 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://patch.msgid.link/20251219110714.23919-1-johan@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/omap-usb-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index a77b6fc790f2e..4d29a6e2ed87a 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -819,8 +819,10 @@ static void usbhs_omap_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
 
-	/* remove children */
-	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+	if (pdev->dev.of_node)
+		of_platform_depopulate(&pdev->dev);
+	else
+		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
-- 
2.51.0





