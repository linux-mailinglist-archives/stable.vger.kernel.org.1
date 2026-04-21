Return-Path: <stable+bounces-240150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNgVC1l252nf9AEAu9opvQ
	(envelope-from <stable+bounces-240150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:06:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C943B1D9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6BF83055DFE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697303D668C;
	Tue, 21 Apr 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjD9CAl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B13D647B;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776538; cv=none; b=tDSup4lr6jgC2qnKKaDxaXpH3wXfUjDEZ4YEX4xKajt9RL9S0Mvhn1uiVr26cOMrmmDGmQvdnLp7rmAdc7AoaTk3H80QTc+auqN6z2sXWHtjcCx1i9Be2V+Dqf/3FsRHVwvKcv9kk80GyZmEGhyREDONSlbiihap1a1vTbbOryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776538; c=relaxed/simple;
	bh=CkfDx8VuNVH8TbkuU+p989cQvobVMXMonGaGvMeEicw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJn6dvNLf6Bb21vr4a8yaQ8qTxni7HBGdM57setWRwDOkNRhIRvrkf/laNieNORiCXqnoNcxrAhodAedX+rqWZjLYNjs+YvBNsdkH+0Zlf2jwISzPCrkXvBqH5i04RJ9uj9zkW8nKvMj3ZZ/3Nzaap2Xetc4y186kUKxnqpxwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjD9CAl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA2C2BCB6;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776537;
	bh=CkfDx8VuNVH8TbkuU+p989cQvobVMXMonGaGvMeEicw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjD9CAl21jtzi80KbT94A+a0cZihcpR2cDp4RmCzaq2mH5koDnhfDu3M0UHXZoKLn
	 pcUpoJSZEtzkPWn63oHHfvT4MLGwS4hwudh8Vi8xq+UXuYlvHEp73eLYXvjVAwQngz
	 2E0IZQ00Rde6RF7AcrN3dRX5eWUB+DbvfyPkFtp0unXHC9S8cJ2TVCagOKUjytDKZX
	 NNDAiPDP8JJz9wt10aJZjDTPsmL1FdXLvi4F1bIAxEn4N8ZTM9WMYNWpdHbN0mf1Wc
	 fbzEIR879aCHr36GOUu7FK7N4V89yRiw4g/tfQywdD3erNyRVB/9Djvxv3f1z44OTX
	 aBUd1dpYcHB3Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAk3-00000006S0r-2mUh;
	Tue, 21 Apr 2026 15:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] spi: orion: fix runtime pm leak on unbind
Date: Tue, 21 Apr 2026 15:02:09 +0200
Message-ID: <20260421130211.1537628-2-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421130211.1537628-1-johan@kernel.org>
References: <20260421130211.1537628-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240150-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 900C943B1D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to balance the runtime PM usage count on driver unbind so that
the controller can be suspended when a driver is rebound.

Also restore the autosuspend setting.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: 5c6786945b4e ("spi: spi-orion: add runtime PM support")
Cc: stable@vger.kernel.org	# 3.17
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Link: https://sashiko.dev/#/patchset/20260414134319.978196-1-johan%40kernel.org?part=6
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-orion.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c54cd4ef09bd..c61ebfd1d18d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -811,6 +811,9 @@ static void orion_spi_remove(struct platform_device *pdev)
 	spi_controller_put(host);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.52.0


