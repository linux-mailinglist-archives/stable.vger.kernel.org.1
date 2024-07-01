Return-Path: <stable+bounces-56233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E64291DFC7
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AE51F230CB
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869D15A4B7;
	Mon,  1 Jul 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCAluMhk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84B158D88
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837964; cv=none; b=dWOCBaVXnpeg1mhL6ThhZP690lzAIz4WGuHC1t6FdNvzQYjrKwJ19+JamOXVzu6K600eDnp1ZSk4UNHXjG7XaUAqQwksoOgUpbAqEveJIBD97qxqqEjFkPzk99IW7hzCw6NCzEqAslCbffLO87Rq8+rh5q14XnjnUF2Gt/eHkR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837964; c=relaxed/simple;
	bh=45p2f+zhCCXsu4fLEurSCj9YoWawtw28lhHnNlWxLCE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TMpC1QQXt//MCxDdqYDCldlruiZI02siklKHdPynyRJ6HL5wUncW90nB/7f/p7+c+ePheVtKFF+uztSBU1+ed5aXCVyQ5ukKXk0KxOn3pUR0GdLgLkjRRT6oHayg3m2k1qlS2YLWsE0VHsqZ+He8wBQkMlIlAq2ZP6L9r5TWAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCAluMhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E441C116B1;
	Mon,  1 Jul 2024 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837964;
	bh=45p2f+zhCCXsu4fLEurSCj9YoWawtw28lhHnNlWxLCE=;
	h=Subject:To:Cc:From:Date:From;
	b=TCAluMhkkC5efG1Ot9lOoYtOjHuBh7xsE8Vmajgi/IDgTOr6xCF8mxOQ3Mej0YJJj
	 NcegMd9LLXYWMAWVgdQrOU4973Ey1ZPHrutV286L+t454oTxeJVi1JH/4QgniDM9DO
	 y1FZvgwjGe+8is4oPuMcxoch3IuVUtCX7Fw6+rAE=
Subject: FAILED: patch "[PATCH] mmc: sdhci: Do not invert write-protect twice" failed to apply to 4.19-stable tree
To: adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:30:55 +0200
Message-ID: <2024070155-fog-devalue-3dbe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x fbd64f902b93fe9658b855b9892ae59ef6ea22b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070155-fog-devalue-3dbe@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

fbd64f902b93 ("mmc: sdhci: Do not invert write-protect twice")
6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbd64f902b93fe9658b855b9892ae59ef6ea22b9 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Fri, 14 Jun 2024 11:00:49 +0300
Subject: [PATCH] mmc: sdhci: Do not invert write-protect twice

mmc_of_parse() reads device property "wp-inverted" and sets
MMC_CAP2_RO_ACTIVE_HIGH if it is true. MMC_CAP2_RO_ACTIVE_HIGH is used
to invert a write-protect (AKA read-only) GPIO value.

sdhci_get_property() also reads "wp-inverted" and sets
SDHCI_QUIRK_INVERTED_WRITE_PROTECT which is used to invert the
write-protect value as well but also acts upon a value read out from the
SDHCI_PRESENT_STATE register.

Many drivers call both mmc_of_parse() and sdhci_get_property(),
so that both MMC_CAP2_RO_ACTIVE_HIGH and
SDHCI_QUIRK_INVERTED_WRITE_PROTECT will be set if the controller has
device property "wp-inverted".

Amend the logic in sdhci_check_ro() to allow for that possibility,
so that the write-protect value is not inverted twice.

Also do not invert the value if it is a negative error value. Note that
callers treat an error the same as not-write-protected, so the result is
functionally the same in that case.

Also do not invert the value if sdhci host operation ->get_ro() is used.
None of the users of that callback set SDHCI_QUIRK_INVERTED_WRITE_PROTECT
directly or indirectly, but two do call mmc_gpio_get_ro(), so leave it to
them to deal with that if they ever set SDHCI_QUIRK_INVERTED_WRITE_PROTECT
in the future.

Fixes: 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240614080051.4005-2-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 746f4cf7ab03..81b81d7bb3d8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2515,26 +2515,34 @@ EXPORT_SYMBOL_GPL(sdhci_get_cd_nogpio);
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
+	bool allow_invert = false;
 	unsigned long flags;
 	int is_readonly;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	if (host->flags & SDHCI_DEVICE_DEAD)
+	if (host->flags & SDHCI_DEVICE_DEAD) {
 		is_readonly = 0;
-	else if (host->ops->get_ro)
+	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	else if (mmc_can_gpio_ro(host->mmc))
+	} else if (mmc_can_gpio_ro(host->mmc)) {
 		is_readonly = mmc_gpio_get_ro(host->mmc);
-	else
+		/* Do not invert twice */
+		allow_invert = !(host->mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
+	} else {
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
+		allow_invert = true;
+	}
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	/* This quirk needs to be replaced by a callback-function later */
-	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
-		!is_readonly : is_readonly;
+	if (is_readonly >= 0 &&
+	    allow_invert &&
+	    (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT))
+		is_readonly = !is_readonly;
+
+	return is_readonly;
 }
 
 #define SAMPLE_COUNT	5


