Return-Path: <stable+bounces-235616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOCxFrnH2GlQiAgAu9opvQ
	(envelope-from <stable+bounces-235616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 11:49:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1CC3D533D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 11:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1FEB30041FE
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02227375AAD;
	Fri, 10 Apr 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8DcPnUy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CA347BDB;
	Fri, 10 Apr 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814580; cv=none; b=bxqOmiI9RmspG7x8oALy9KIx780lHDSVIRfrLuDjYiOCOoCdTWqHDs5x/Ix7Z/fnXgNhtxo8rhF9TzTtHZRJG7E608ChJAA0iogpUYV2ApHpya++P7bwX+oYWJaRLKogmUWgSU6jTzSkC9D7y+Q+BwOgzqsWQW/i3P20ejlvTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814580; c=relaxed/simple;
	bh=CytAY+vUrvcJliMfskIBZQZ1+nqbDtxvrkk8RxKdCwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkKRWg59pIfFPNpor05f67oAnztGcK2VwZKFdoKmla6BRa2xXmh7SEfVvLXuOCexYJD5lE0FhZ6Tj1XNadL94TGMAutSrp82OcwFuk6A5pY1sCcfh8ccLlSsfKWIJ//v6nkHdSgiNwwzMxezaYUia++WCpLTDtMXjcKajVCmga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8DcPnUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6DC19421;
	Fri, 10 Apr 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775814580;
	bh=CytAY+vUrvcJliMfskIBZQZ1+nqbDtxvrkk8RxKdCwo=;
	h=From:To:Cc:Subject:Date:From;
	b=V8DcPnUyq55QjOFQSsrfH6XDrIwDODcW0eLK2vZ0UeoNOpdhEahSqRyFuFSt00iM4
	 qWflQJuBqu1FD0cWNvyoSK9YeSTL858A4dFmEmW1zAoI6g1SQGQH/xGlLGX0PPRAdk
	 PGuCRJjl4NmQjKB/xIftbAYSZS10UrWafxaL756qX/RaZR4MFt5qwrSEVCuegsbNma
	 FJBXWTWdk/OjW4Qe/24s50+Wg9kVFq2Ep3pxScpV6liHkY3pKa6t7eOVtIf+iCdjJe
	 QNAFbwU9SwH+cGXkN4wyEW/GaAZ95F7JnCou1GEgkYzFf+O3RrmTC0b0Z3udyLftDr
	 BQlqEZ1Zxqmjg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB8Uc-00000002Aqk-0eKl;
	Fri, 10 Apr 2026 11:49:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Adithya K V <adithya.kv@samsung.com>
Subject: [PATCH] spi: s3c64xx: fix NULL-deref on driver unbind
Date: Fri, 10 Apr 2026 11:49:25 +0200
Message-ID: <20260410094925.518343-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235616-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 3B1CC3D533D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A change moving DMA channel allocation from probe() back to
s3c64xx_spi_prepare_transfer() failed to remove the corresponding
deallocation from remove().

Drop the bogus DMA channel release from remove() to avoid triggering a
NULL-pointer dereference on driver unbind.

This issue was flagged by Sashiko when reviewing a controller
deregistration fix.

Fixes: f52b03c70744 ("spi: s3c64xx: requests spi-dma channel only during data transfer")
Cc: stable@vger.kernel.org	# 6.0
Cc: Adithya K V <adithya.kv@samsung.com>
Link: https://sashiko.dev/#/patchset/20260410081757.503099-1-johan%40kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Note that this one should be applied on top of the deregistration fixes:

	https://lore.kernel.org/lkml/20260410081757.503099-1-johan@kernel.org/

to avoid a (trivial) conflict if applied in reverse order.

Johan


 drivers/spi/spi-s3c64xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 95b61264b679..37176e557099 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1403,11 +1403,6 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
-	if (!is_polling(sdd)) {
-		dma_release_channel(sdd->rx_dma.ch);
-		dma_release_channel(sdd->tx_dma.ch);
-	}
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-- 
2.52.0


