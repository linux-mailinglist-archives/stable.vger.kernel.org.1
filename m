Return-Path: <stable+bounces-247574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN6TMIvhBmrLogIAu9opvQ
	(envelope-from <stable+bounces-247574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:04:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9754BF71
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 151DF311439E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E40407584;
	Fri, 15 May 2026 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NPht2rvT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1027423154
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834061; cv=none; b=SBaazfllOvUtdbzhcQ2Rq2ofHHX9Y0lL4vwrs1tOrqWbSZn9+1e4pAPQkqn3+9HTMA6OPAA6XsSdrGCYMKQJm09OXAYJQDWPMWMogVBxDsJnEkO9neCdSBFnpxeB1b7IZgxECRhSTyxsSwypkre++9/2GVX0alEOC9AHycQRHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834061; c=relaxed/simple;
	bh=3HLglpo9Jd+dn+Tm6EpMCvbaLRqRp6e6gTp+4CTsTIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AO32psPFLosyMdSJtNS96WoB8XkHcNdRjP66d+NwHviRfXl4Ym7w5fq5vyMCV9BI4iDQMYbUDVUOd+VTH3iG9+9beGbjrDFk4lu9ayWbjb5LFTWCTsqZQQ6t8a34uBRKR+t4UUhppwOeISlGVvi9hYmkEURWdbvZ0mzDvA7k+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NPht2rvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432B5C2BCB0;
	Fri, 15 May 2026 08:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834060;
	bh=3HLglpo9Jd+dn+Tm6EpMCvbaLRqRp6e6gTp+4CTsTIw=;
	h=Subject:To:Cc:From:Date:From;
	b=NPht2rvT15Pxvlk7EoXcxRghJZhyp071aWGms6Xym46A8nCD86fu00xLFIzVw3dsD
	 Mr/MCdBGn9OG609FptPx+0Pv6vXLgqab3Re8ohhLOtOTSVaxJ5+HbSd/zpaKNbquuA
	 0u+d9lpedlEDG1t92GSHNYqyDBwb1+kx/81L42uI=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix runtime pm and clock imbalance on" failed to apply to 6.18-stable tree
To: johan@kernel.org,broonie@kernel.org,d-gole@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:34:17 +0200
Message-ID: <2026051516-underfed-showbiz-1e73@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 18B9754BF71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247574-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5e8bb0cc72f1d52d8ac2a88f4c952e2e98056aed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051516-underfed-showbiz-1e73@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e8bb0cc72f1d52d8ac2a88f4c952e2e98056aed Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:53:52 +0200
Subject: [PATCH] spi: cadence-quadspi: fix runtime pm and clock imbalance on
 unbind

Make sure to balance the runtime PM usage count before returning on
probe failure (to allow the controller to suspend after a probe
deferral) and to only drop the usage count on driver unbind to avoid a
clock disable imbalance.

Also restore the autosuspend setting.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Cc: stable@vger.kernel.org	# 6.7
Cc: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-5-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9ccfdc8c36fe..057381e56a7f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1860,10 +1860,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
-
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clocks.\n");
@@ -1962,10 +1958,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->sclk = 0;
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_enable(dev);
 		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 		pm_runtime_use_autosuspend(dev);
 		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
 	}
 
 	host->num_chipselect = cqspi->num_chipselect;
@@ -1996,8 +1993,12 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+		pm_runtime_dont_use_autosuspend(dev);
+	}
 	cqspi_controller_enable(cqspi, 0);
 disable_clks:
 	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
@@ -2033,8 +2034,10 @@ static void cqspi_remove(struct platform_device *pdev)
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_put_sync(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 }
 


