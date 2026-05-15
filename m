Return-Path: <stable+bounces-247571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA87JwfbBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA154B70B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FD303044A18
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445CC3FFADF;
	Fri, 15 May 2026 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGngcQ98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C30402BA7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834052; cv=none; b=EPAKOV2FYoexou7pMVeTR0dbQRnjO6KjIq3Jg8negfrICq3HYMpilwbJSfSlQOkDU0vLGVdVkblYliBU3wB4kcntIRgB40ciMRVgrSeyDMiPdMapzkjnn4URVjMpMiRGpCN3vh1wNBOGmYOkdDn7H7XzV2R1zxSPofTxEIjt2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834052; c=relaxed/simple;
	bh=3w2a4p8+NPfNjE2LX5fuRvTJIuMqL7NoR+QwxO0izOg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tH967CY0Odl2/ihlJ1t4MWkzazHWA5SaaaArY6g6eseQ+T7exXXhpsDCeDBHfeU1wTC5OMM11pUUVM5UhdGK6jvC9iHtjWntLdFkGvVEEF5JRXpDeZaU+SxWihmv7N0T+POh/ebV2sLXw5KYioZnLfof6pWuwQRaBxlFblaeE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGngcQ98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F5C2BCB8;
	Fri, 15 May 2026 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834051;
	bh=3w2a4p8+NPfNjE2LX5fuRvTJIuMqL7NoR+QwxO0izOg=;
	h=Subject:To:Cc:From:Date:From;
	b=mGngcQ98aBAhAyCMbq2bgN250LRHdHlgBkgtL0/LReDGE/jDYEXf3ZEKy+++mbxwK
	 NebhC0KCGDYxHbXshH/zDuBLgrSwS5GHnVz6gRzZjL2T9vrlUBgqBQ8Noho5cjCGXo
	 lcxqCH+DQ09g56PXLXN8e0BSAY1gTGQcsWLjPyO0=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix clock imbalance on probe failure" failed to apply to 6.6-stable tree
To: johan@kernel.org,a-dutta@ti.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:34:05 +0200
Message-ID: <2026051505-regulate-earpiece-97bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FBA154B70B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247571-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cba53fe20c18688c17ca668ad0e4ec05e31c70d3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051505-regulate-earpiece-97bb@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


