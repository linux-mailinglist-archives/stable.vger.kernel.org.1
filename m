Return-Path: <stable+bounces-257296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HGWAjcaG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B460F10A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4B0305A5C5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11283A3E74;
	Sat, 30 May 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9wvELHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ABD2690D5;
	Sat, 30 May 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160510; cv=none; b=OQJCtG8StxpQs86jFJkDdvHJYQ6HzKSWvYbGEIsI/WsdcJVNm/Btws2WQRjrxpCl4ky1WA1JS4B3b/uDvuHYLEVSX3p/C5TJWpkgRWLbxxAAvpwiZbQRyrbl+CWAzyIrnKlUqQrrIdrHqNgWQu+PZyaoayUO3eCWg0VTvSUOJVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160510; c=relaxed/simple;
	bh=jncns+CMVAUZUYWYeGmfCPU0vfuWNvSpu0peDpdiofU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAHu5AqCgg7qMH/84iLcfj7FjxkE7RsoFsJ+p0VbiCtZPhBLDtSe86hA/f9lGk9SsJHa43GloH9gSCYPwEN9v2EQB9XwqgmHYBkKbHCxXrne3ZiCJbap2C6IGDHcheXgimMnjRPYjv/6i7ZE0u+GQMFOkvB2aYPfGJo/ovvqXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9wvELHj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B81F1F00898;
	Sat, 30 May 2026 17:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160505;
	bh=kiUyZaYo/hthBqyamGjkk2+RsWJVqdVB0zOF/rOZ95U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9wvELHjTnzO9vhxtauxM7G/3DO6O0kOsFVv3kCp6zpuvypjge+0KUA/upZObzhMw
	 kVo3/ENNV1q/ilKh0x4EiuUrzpMUCYOmDyBCxgM9mowUlRFVc4JFW4+tNV/DoZ9jcY
	 Jrd0U5S9UMHHAaIkJcdNy5IehT/oEybgnPOAhmNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 339/969] spi: topcliff-pch: fix use-after-free on unbind
Date: Sat, 30 May 2026 17:57:43 +0200
Message-ID: <20260530160309.729989621@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257296-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5C9B460F10A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 9d72732fe70c11424bc90ed466c7ccfa58b42a9a upstream.

Give the driver a chance to flush its queue before releasing the DMA
buffers on driver unbind

Fixes: c37f3c2749b5 ("spi/topcliff_pch: DMA support")
Cc: stable@vger.kernel.org	# 3.1
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-9-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-topcliff-pch.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1406,9 +1406,6 @@ static int pch_spi_pd_remove(struct plat
 	dev_dbg(&plat_dev->dev, "%s:[ch%d] irq=%d\n",
 		__func__, plat_dev->id, board_dat->pdev->irq);
 
-	if (use_dma)
-		pch_free_dma_buf(board_dat, data);
-
 	/* check for any pending messages; no action is taken if the queue
 	 * is still full; but at least we tried.  Unload anyway */
 	count = 500;
@@ -1432,6 +1429,9 @@ static int pch_spi_pd_remove(struct plat
 		free_irq(board_dat->pdev->irq, data);
 	}
 
+	if (use_dma)
+		pch_free_dma_buf(board_dat, data);
+
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
 	spi_unregister_master(data->master);
 



