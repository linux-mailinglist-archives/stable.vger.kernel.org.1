Return-Path: <stable+bounces-247362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GzQA9KvBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:32:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57C54992B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672C93048DE5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791F335562;
	Fri, 15 May 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jZ+cBac2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD95313532
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823061; cv=none; b=VswKnyLhOb+MBDZO6Aoi5cesJ76ufT5ki7zUA01xJJEbXumx7JwJgf5DBo16n2HEONEtOMRvgLk6OjUxjt8JeELvxyri0wHkiu7Dq1BJL/zq/3klWdyAJoF8u6D7xZnhwhjT8PdAiltJCT3ZNZiMhHSvl5fBQGdpE5Ry1P1kbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823061; c=relaxed/simple;
	bh=S+XN2lgadJiQu/pvjuRA13TA2WA97ZLcVgEaN83Y9N8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jG1cvzwVdRRzU0GTzDgSqt16zyq3BH2xFKhEqP49zxxMB9yW4qkLTmpRqi1Sd9lBYXcZzqWf6DU08PHoy0rmPZqJujipaPFjtMRbhBsSlsTJQMK1jh4cDGdjdDJDzPvVPMJJMLZZ8xOxWDoIE8kHfLJ1w6/+gAG5zWYNpt/Xv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jZ+cBac2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D8AC2BCB8;
	Fri, 15 May 2026 05:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778823060;
	bh=S+XN2lgadJiQu/pvjuRA13TA2WA97ZLcVgEaN83Y9N8=;
	h=Subject:To:Cc:From:Date:From;
	b=jZ+cBac226UeRNzikx55FAkZOeswGcMHRfk3p0YPSfwOzJL8PATVF2fAfBAkIdGY1
	 i4R/Cczs2m1xDvgjjJ9M5eBxueHXC3r8pOElKdmt5V3s5pj79RtevgffLbxopxWcYd
	 RabDfkdTd372ipMxKJUJzF4KYEO6FOwxPLgu3230=
Subject: FAILED: patch "[PATCH] spi: sifive: fix controller deregistration" failed to apply to 5.10-stable tree
To: johan@kernel.org,broonie@kernel.org,yash.shah@sifive.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 07:30:47 +0200
Message-ID: <2026051547-tarnish-moisten-9082@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C57C54992B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247362-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sifive.com:email,msgid.link:url,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0f25236694a2854627c1597465a071e6bb6fe572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051547-tarnish-moisten-9082@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f25236694a2854627c1597465a071e6bb6fe572 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 10 Apr 2026 10:17:44 +0200
Subject: [PATCH] spi: sifive: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Note that clocks were also disabled before the recent commit
140039c23aca ("spi: sifive: Simplify clock handling with
devm_clk_get_enabled()").

Fixes: 484a9a68d669 ("spi: sifive: Add driver for the SiFive SPI controller")
Cc: stable@vger.kernel.org	# 5.1
Cc: Yash Shah <yash.shah@sifive.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260410081757.503099-15-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 54adbc057af6..74a3e32fd2b5 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -392,7 +392,7 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "mapped; irq=%d, cs=%d\n",
 		 irq, host->num_chipselect);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_host failed\n");
 		goto put_host;
@@ -411,8 +411,14 @@ static void sifive_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct sifive_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
+
+	spi_controller_put(host);
 }
 
 static int sifive_spi_suspend(struct device *dev)


