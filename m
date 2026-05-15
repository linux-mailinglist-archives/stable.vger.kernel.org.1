Return-Path: <stable+bounces-247483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MnYFZnZBmrsoQIAu9opvQ
	(envelope-from <stable+bounces-247483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:30:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93154B4E5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B4CA306412B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5553FE647;
	Fri, 15 May 2026 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClmBHjOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006073FAE07
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833733; cv=none; b=g9092WJmVdWIsCe/guKPXRUXkazHijxrJcHfDSUkLQMilj7znoxC7dwo4bktst39U1Wf8rf821eIcs5e6dxk8SGKviDsCuKbCuh6XG6tyB60cIdlxdgVYd7ORmpbc9mNqV+HEN+yLpELyGbjJqnc0OX88GIvRfJ9gFG1xOR9C6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833733; c=relaxed/simple;
	bh=sGoPgh31Q6+1vSRRsDmEvQ0r/5BPuwG0Y7MBCzcUpW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ds635auRKJWEKhQlb92RpzCdP902BPN7FFmOFRwKUsVRwpJoflKhbYnKXTxrV97oxmMfyILs2jI97r1JnjCT5eHR+pybuHkGKvdZ/2dEdhnpwXzxcC5CalQXi6fTCoQHBteSrnLLaHAJYNnj8wTCY851NNsjjhrQizx4VUZ5NJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClmBHjOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30563C2BCC7;
	Fri, 15 May 2026 08:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833732;
	bh=sGoPgh31Q6+1vSRRsDmEvQ0r/5BPuwG0Y7MBCzcUpW8=;
	h=Subject:To:Cc:From:Date:From;
	b=ClmBHjOP8ZOxlrmEzOR2ETRxgzHNfv3F2AwGykGcGIM6pMs8s2/NH0F7cPbCPgdKX
	 tibtIj/hLtHvwPHS3+8+fBoCsRQIOz3In7G0spJMpEe7KMaSux+8VvL7QVzonaF6EN
	 rMmbmBehO7vHdOM+5i/LAvlZw+11cXhb/WyxEgNU=
Subject: FAILED: patch "[PATCH] spi: bcm63xx-hsspi: fix controller deregistration" failed to apply to 6.18-stable tree
To: johan@kernel.org,broonie@kernel.org,jonas.gorski@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:28:32 +0200
Message-ID: <2026051532-scrap-impeach-a562@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF93154B4E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247483-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ab837c51899d7595c1165a45dfb631facad49461
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051532-scrap-impeach-a562@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab837c51899d7595c1165a45dfb631facad49461 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 9 Apr 2026 14:04:05 +0200
Subject: [PATCH] spi: bcm63xx-hsspi: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind to allow SPI drivers to
do I/O during deregistration.

Note that clocks were also disabled before the recent commit
e532e21a246d ("spi: bcm63xx-hsspi: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 7d255695804f ("spi/bcm63xx-hsspi: use devm_register_master()")
Cc: stable@vger.kernel.org	# 3.14
Cc: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260409120419.388546-7-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 266eabd3715b..e935e8ab9cfd 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -857,7 +857,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -880,9 +880,15 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_hsspi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP


