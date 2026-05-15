Return-Path: <stable+bounces-247570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBBYDFPdBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1154BA6A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA432309F48B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750140B6C3;
	Fri, 15 May 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1WUo/pup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12E41B34D
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834049; cv=none; b=Yc5dCihFehTV8+gCqZGrTZEXhPZac3qSDpgBE9XLVbyGOWAyqebIF3J4vwzFbgx9CQNH1mq40uRIRoRAi470tQBqeU9MiSg/AmJKA/bHxuA+Y9G3fs6mUXqGNu0Tn2OnKhNUPsFfFZg3zYaphg9bFmbpZOofbRa1eIFtWjpheXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834049; c=relaxed/simple;
	bh=n0zCNCiKhUNFgelYF0D9aUwVSuYn2nkifFcovk4hxI8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=taw1QvWYKEG4+YeQFVEzV9XDwGVnFaEcHcxmnKeFVXMIe2IIqGsarAzJd0+vJy7OxdSUN3eSHqh70tpNpmEqkcGoVfnHOgvCFfEALvhXHsGWypgUFhidSUS0+cxNzXDHITUWVyPkASJxSTSBo/oZtEik7h1ifFVuMbxdq8Bt+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1WUo/pup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F9C2BCB0;
	Fri, 15 May 2026 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834049;
	bh=n0zCNCiKhUNFgelYF0D9aUwVSuYn2nkifFcovk4hxI8=;
	h=Subject:To:Cc:From:Date:From;
	b=1WUo/pup3r5QhvA7a7Y2H7MCQpoB81zgNpk2upFt+JHU8ReGsuL9yrqm04R8/B1vx
	 FsyWlqkQWj75lWpQI6D6gHtKO9Iv2/XMsvfKNucLONYC71q/vkzJuHe7v7wN0XQa5h
	 vUbMErX+rC6QSc/T15bPIbwGi8TfRWlqAE0OUASo=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix clock imbalance on probe failure" failed to apply to 6.12-stable tree
To: johan@kernel.org,a-dutta@ti.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:34:05 +0200
Message-ID: <2026051505-attribute-rescuer-9f22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A7D1154BA6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247570-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cba53fe20c18688c17ca668ad0e4ec05e31c70d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051505-attribute-rescuer-9f22@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cba53fe20c18688c17ca668ad0e4ec05e31c70d3 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:53:50 +0200
Subject: [PATCH] spi: cadence-quadspi: fix clock imbalance on probe failure

Drop the bogus runtime PM get on probe failures that was never needed
and that leaks a usage count reference while preventing the clocks from
being disabled (as runtime PM has not yet been enabled).

Fixes: 1889dd208197 ("spi: cadence-quadspi: Fix clock disable on probe failure path")
Cc: stable@vger.kernel.org	# 6.19
Cc: Anurag Dutta <a-dutta@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ab6d2a81865..87e2bb66ad6c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2000,8 +2000,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		pm_runtime_disable(dev);
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 
 	return ret;
 }


