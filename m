Return-Path: <stable+bounces-266043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ptF1OXeVMWqqnQUAu9opvQ
	(envelope-from <stable+bounces-266043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D510694212
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:27:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qAbS2AM+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266043-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266043-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED9F30AF48D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB647D92F;
	Tue, 16 Jun 2026 18:26:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141047CC96;
	Tue, 16 Jun 2026 18:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634360; cv=none; b=DY8S1ovJPdLjpL9ePjCFciGg/hOIb7AUVU4QxQGPY9B7cZaddHdxKgElnDlCDTsx0OINGEXt58EJblO6YYlwdLZV2nA2wymaKmOvVpyKyf/gBcgQca9v11AMTXNPniW5BhGiqOyO6u/845CVrv7Ew+kVSH518XW0QJZKmR8avf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634360; c=relaxed/simple;
	bh=5eI5mt+GHLc9Rl2BY2sGdudW6tWTE+AtHhDHCp+Sswg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGpNTkgJi4IlnmT4nIjN9xDxUXEYkxyr6xhN/SwSAz2TJ+QCRS7ez36SVy30PQxJIE1CI9uEwfqWBXpSYnUhxQYs4W2g3nTRagbCWoJx5SKvPwHKhIhcXWRn1zbtvSW4Esd7xADnE2YCnDS/nyEs81DvJfDrk0M6qVZlunZBVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAbS2AM+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D61F00A3A;
	Tue, 16 Jun 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634359;
	bh=W/m2kUhuPZasE56CC99GT/TNhd33LXxtROQXJgUtEwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qAbS2AM+D/6I9ivlJq5myb3+4jTu9zrP0sV3pUOkiLSUZqH2nYCJ55IqwV/PhmAKE
	 vk+X/pIWfjQV3L8adWUYe49RyQXpIcyxnVZ7sAzGKCL7iijMGiUvxfgu0+cSGobviJ
	 DK+bNdnrTbzLSBy4gSJCnf/TJfwntcqvb143WJwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Akhil R <akhilrajeev@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 5.15 223/411] i2c: tegra: Fix NOIRQ suspend/resume
Date: Tue, 16 Jun 2026 20:27:41 +0530
Message-ID: <20260616145112.654594634@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266043-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:akhilrajeev@nvidia.com,m:jonathanh@nvidia.com,m:andi.shyti@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D510694212

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akhil R <akhilrajeev@nvidia.com>

commit 656646b3847ac6a21b074a813223feef2aadd6e2 upstream.

The Tegra I2C driver relies on runtime PM to wake up the controller before
each transfer. However, runtime PM is disabled between the system suspend
and NOIRQ suspend. If an I2C device initiates a transfer during this
window, the I2C controller fails to wake up and the transfer fails. To
handle this, the controller must be kept available for this period to
allow transfers.

Rework the I2C controller's system PM callbacks such that the controller
is resumed from runtime suspend during system suspend and it stays
RPM_ACTIVE throughout the suspend-resume cycle until it is runtime
suspended back in the system resume. The clocks are disabled in NOIRQ
suspend and enabled back in NOIRQ resume by calling the controller's
runtime PM functions directly.

Fixes: 8ebf15e9c869 ("i2c: tegra: Move suspend handling to NOIRQ phase")
Assisted-by: Cursor:claude-4.6-opus
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Cc: <stable@vger.kernel.org> # v5.4+
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260518114013.62065-5-akhilrajeev@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-tegra.c |   53 +++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1874,28 +1874,37 @@ static int __maybe_unused tegra_i2c_runt
 
 static int __maybe_unused tegra_i2c_suspend(struct device *dev)
 {
+	/*
+	 * Bring the controller up and hold a usage count so it stays
+	 * available until the noirq phase.
+	 */
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int __maybe_unused tegra_i2c_suspend_noirq(struct device *dev)
+{
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
-	int err;
 
 	i2c_mark_adapter_suspended(&i2c_dev->adapter);
 
-	if (!pm_runtime_status_suspended(dev)) {
-		err = tegra_i2c_runtime_suspend(dev);
-		if (err)
-			return err;
-	}
-
-	return 0;
+	/*
+	 * Runtime PM is already disabled at this point, so invoke the
+	 * runtime_suspend callback directly to put the controller down.
+	 */
+	return tegra_i2c_runtime_suspend(dev);
 }
 
-static int __maybe_unused tegra_i2c_resume(struct device *dev)
+static int __maybe_unused tegra_i2c_resume_noirq(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int err;
 
 	/*
-	 * We need to ensure that clocks are enabled so that registers can be
-	 * restored in tegra_i2c_init().
+	 * Runtime PM is still disabled at this point, so invoke the
+	 * runtime_resume callback directly to bring the controller back up
+	 * before re-initializing the hardware. The adapter is then marked
+	 * resumed so that consumers can issue transfers from their own
+	 * resume_noirq() handlers and onwards.
 	 */
 	err = tegra_i2c_runtime_resume(dev);
 	if (err)
@@ -1905,24 +1914,22 @@ static int __maybe_unused tegra_i2c_resu
 	if (err)
 		return err;
 
-	/*
-	 * In case we are runtime suspended, disable clocks again so that we
-	 * don't unbalance the clock reference counts during the next runtime
-	 * resume transition.
-	 */
-	if (pm_runtime_status_suspended(dev)) {
-		err = tegra_i2c_runtime_suspend(dev);
-		if (err)
-			return err;
-	}
-
 	i2c_mark_adapter_resumed(&i2c_dev->adapter);
 
 	return 0;
 }
 
+static int __maybe_unused tegra_i2c_resume(struct device *dev)
+{
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops tegra_i2c_pm = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend, tegra_i2c_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_i2c_suspend_noirq,
+				      tegra_i2c_resume_noirq)
 	SET_RUNTIME_PM_OPS(tegra_i2c_runtime_suspend, tegra_i2c_runtime_resume,
 			   NULL)
 };



