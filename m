Return-Path: <stable+bounces-221676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKstKjCYo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8041CB23D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55927302692E
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A4E2D24B7;
	Sun,  1 Mar 2026 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeN4nlyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B32882D6;
	Sun,  1 Mar 2026 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328862; cv=none; b=srQNSc49Q4DmahDsjC34Uqe+ledh2iH32horuqX2e1qL32IMcnhLs7DgVvQpKAlTDv+PXJ+AFB0/bzyfYJT8e80c6dYXxKQljvSf0+0F5rPLixEe+mMpbgcC6rNZs4MctBJjx/INwXXvByXR3ojUGzFsstXqQXF9cJG6Atyuy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328862; c=relaxed/simple;
	bh=n2PTJ53uLgQNFe3B/9BBiJ37WSZJQx7ZUSFP2gloRqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twSJbxH7aN7eb4qG4sLBkM0jv9TP6V0v5yagFZmfaBCQcUH0KzyCnWJ7X+ra0b1HyH/UrpBNBpYpOUKSXdzeBiz73Ty7LJ2eXX9QrnL5Y/a58b7hafGPMGTQczwVRezdvbB1RfuQU9Vm6CffRgQ6EGsi90HjliyNkOyj2qoscnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeN4nlyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F7CC19425;
	Sun,  1 Mar 2026 01:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328862;
	bh=n2PTJ53uLgQNFe3B/9BBiJ37WSZJQx7ZUSFP2gloRqI=;
	h=From:To:Cc:Subject:Date:From;
	b=AeN4nlyUavmr6PBDc60MMzTnAu2xDXNcF1kXeoBDEV8jTgAHG2/pzM1LGUnjTDaig
	 62LgeILZo3br1rs0H1h2Au6AN8asB49teyMijQS3Y0jP83nu1kt0kB3iuawSbRAR6Z
	 U4eNPRBN7ojOt4ReWX/dcwMCSAO0bLHVcQ0E/LjpqpSqtKAVlcHUIn2XsZFoQPeg4H
	 AOPIFai1pQWDCmpLd4uJWw+vWiGl/tWvkDeh9LW+95h72cR75la3REhxAL4aPaJS+l
	 Piev4R4wU7ZZ1HlHzrYu+utDxVURXJtEU8f2+dquj/dqq3qgSSyccA/koTyKnMcTWX
	 RHnQLNTFx1YMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	johan@kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	linux-omap@vger.kernel.org
Subject: FAILED: Patch "mfd: omap-usb-host: Fix OF populate on driver rebind" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:34:20 -0500
Message-ID: <20260301013420.1693800-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221676-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5E8041CB23D
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
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





