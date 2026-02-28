Return-Path: <stable+bounces-221063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBTxKYZNo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99A1C82C4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0DA6338E807
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57EB301EEB;
	Sat, 28 Feb 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrH0MZ/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDC301EE6;
	Sat, 28 Feb 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301406; cv=none; b=SDQd35kk5s8wo5ww/NFuJb5cIPqP7oUtzs9u7FAi1RSEpCqZukv9ewctu8+1xvGZLh8eBIesqa5JMWoFiWE7lI7yU8YK9FOggGhM4iD1b0m1giPpXrTCn1gJODr+MvYTnCiPowIDfgj76gkOKQUXtvjgv9iNxzCXf/TdKaftQuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301406; c=relaxed/simple;
	bh=DfTHN1u93uLIZw+bEt+LefiO8/Gp2UrF+x2t8RkN7SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7yCg/m94hiBWZPNzUvZ2M71rgm/kW8k3I3xi8MjxdwfNXdp2lWTIHIu3ZSeyVMx2Z7osy0FzzACvVLD6oXArjKBjfTCWIhiELv5u2lIJcewOehvOmpZTLB6TQcbHCjTrMZO/ndcxHgqKzBD75AIy7KA4HrhlB0hjTx8wBjdUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrH0MZ/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E236C19423;
	Sat, 28 Feb 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301406;
	bh=DfTHN1u93uLIZw+bEt+LefiO8/Gp2UrF+x2t8RkN7SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrH0MZ/vvEXB6JOoOv/HlLiryHKUgRE8XlFH15tmrQbhG04Ug/qgSHsHu1Y13Ed49
	 +xOXMHCbTXlFRwuBIdp47vq6649etPDEFo4Kd2A49NrMrL9kwPN8KHQZ/VaVvxgHoC
	 JfB9a1b/trAODjIdunGyD/xg+w7Z2SCNdu778VLRikSg6KyjDHkSVynIl0gmDDWIqf
	 bMw0d/lhIdUbNF+JsmUSGFD3LYcvL31LCnrj5yf9XPdLrxUpU8nCFn9O1aNAsb4MqQ
	 Cv/XN0hizjcDK9ZQbvBv4VKG0ELgpPOJaVNAminjbr91QYMz3gbZOUD2R5FHTMAuXA
	 540ziuRIrx5vQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 595/752] mfd: omap-usb-host: Fix OF populate on driver rebind
Date: Sat, 28 Feb 2026 12:45:06 -0500
Message-ID: <20260228174750.1542406-595-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221063-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kemnade.info:email]
X-Rspamd-Queue-Id: 1F99A1C82C4
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 24804ba508a3e240501c521685a1c4eb9f574f8e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


