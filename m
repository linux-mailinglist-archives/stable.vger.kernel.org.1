Return-Path: <stable+bounces-247575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK+tNardBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4554BACC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10EAC30BD810
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F33407598;
	Fri, 15 May 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Wv3ogUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C8407595
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834064; cv=none; b=b5e4+2n8CqiGmHxSPd4MFPkMKgrcc7yity7TALgzmRcOMx9mJiasNziQndVwZUMSLfcgaYqaC1hhR6SCMKZPHyqwjfAuyUIRhIQqttxiwB6bweC8aBk7uRp45tUBWN83o+BHz8WTNy6JGIfpr6lUqJ/rYi1lQewVZmc8w2Z6DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834064; c=relaxed/simple;
	bh=2u3OzkJecYlAf9+g0cdXV86dhHddRVffa4IwdZ7pEQA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g991Ypfb6j2YGl6JTN36WckWMVt/2mBT3lKSfvUjMldf9xbtlKU/ceaSNzSdhPDv8AW7+MEPffSMq9fKX/PNtMX7Ku3dak4phuVDgJY5m19uqrxvgECBJgeLWQMDYs1gIsbJTjR2dZRzZx89/GhywTaITFjQ67QaRl4IpcdLgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Wv3ogUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54900C2BCB0;
	Fri, 15 May 2026 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834063;
	bh=2u3OzkJecYlAf9+g0cdXV86dhHddRVffa4IwdZ7pEQA=;
	h=Subject:To:Cc:From:Date:From;
	b=0Wv3ogULCPZMnLKdCjftvkJj/xPDkLNENRSV/qxc5ubp744qr8Q6HI6Yuw132EWcm
	 pLeP5lkMi8KWra68UitwYvk1T7Ph3/yBiaV8FmqrQWj96rKmxBVF2b3JkcGYVlM+wh
	 cbjEYWndhkFaM4R7RLJ9PRK3t+SVAIF4n6Oj6OnI=
Subject: FAILED: patch "[PATCH] spi: cadence-quadspi: fix unclocked access on unbind" failed to apply to 6.18-stable tree
To: johan@kernel.org,broonie@kernel.org,d-gole@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:34:27 +0200
Message-ID: <2026051527-anatomist-disengage-12de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3AF4554BACC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247575-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,msgid.link:url,linuxfoundation.org:dkim,sashiko.dev:url,ti.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 233db2cb14db8b1935dda52a6affd97276462b82
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051527-anatomist-disengage-12de@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 233db2cb14db8b1935dda52a6affd97276462b82 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 21 Apr 2026 14:53:51 +0200
Subject: [PATCH] spi: cadence-quadspi: fix unclocked access on unbind

Make sure that the controller is runtime resumed before disabling it
during driver unbind to avoid an unclocked register access.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
Cc: stable@vger.kernel.org	# 6.7
Cc: Dhruva Gole <d-gole@ti.com>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=2
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421125354.1534871-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 87e2bb66ad6c..9ccfdc8c36fe 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2024,14 +2024,13 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	cqspi_controller_enable(cqspi, 0);
-
-
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
-	if (ret >= 0)
+	if (ret >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);


