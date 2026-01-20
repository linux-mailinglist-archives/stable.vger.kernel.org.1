Return-Path: <stable+bounces-210575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AWYANLWb2mgMQAAu9opvQ
	(envelope-from <stable+bounces-210575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:26:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E64A4E1
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06569EB31D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BF44A728;
	Tue, 20 Jan 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="dqGuTuRt"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AFD441048;
	Tue, 20 Jan 2026 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923913; cv=none; b=jXiUJarJnwXLqot0xS7xS2sB6u9vYTJPaMnbKrpEdg5wZAuYAORNxAxiO474DSfC5HcLZsiQMOHH35Z53l5fmnt+4qqRKRDJshh2D4OoK9W5jPFWO8NOIKKoEfgtm52isGAJgv7tYnaakhgjzq+o7FkDGEIzoyb5F2dEzQREOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923913; c=relaxed/simple;
	bh=MrzdPhBUci1zYJK7hvuXCS+eCmE9nVICFETQlx7Jbys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw69M1fJ6ezjI2iQ/A30VFjFLJ55ux3FXXiQpgBUNdeFVTMfhGs1C/bTbXb2UkpT6NO0+yRgWf8bOjY+6EDqswkwBw1AjufLS7AQJnV6KGwlHWhZ/+97Zz343efNe7P+Yzkkf5hsJhTFdEAorWGxrr+GNEkpj+rV98+pw3efKCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=dqGuTuRt; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21B44148AD5A;
	Tue, 20 Jan 2026 16:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1768923909; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7NkEtjVarcSoHp8QOC/pznn28WeOYOUP6CtTrfas8ew=;
	b=dqGuTuRtpVogREVnWV1N6aV6D2osb3MFMfy2v/X1Xr3m2zdJAD4/z9iFtK2xFiE4pYF6lf
	H/JVPnqCQb2mU2Exirnxo9dU7jgjJd9Z0lW4HvwxKz8BbzcPKWtK3C4FmZvk8qDCwm7R3+
	Hn1jo0x14Ibq7/V27iGrgRh6vEjCU5UpVLnfq2TzVqJ4X5CfncXEzcbi5bhwiRlIctD8LG
	NmJO1cR5XmHgNLPxfQ2qmE8yCtpBr4aTvl9U615wTVKvVFrITfac6Hp2bNArnoSxIbs9+T
	b/nR7kt4Qau/tNf7RUQ7k5F1SxBL/IIAa2qFJKH/UrQk/WyWTZWYPZOAk0SWvg==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 11/19] nvmem: microchip-otpc: Fix swapped 'sleep' and 'timeout' parameters
Date: Tue, 20 Jan 2026 16:44:45 +0100
Message-ID: <20260120154502.1280938-5-ada@thorsis.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120154502.1280938-1-ada@thorsis.com>
References: <20260120143759.904013-1-ada@thorsis.com>
 <20260120154502.1280938-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210575-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[thorsis.com,quarantine];
	DKIM_TRACE(0.00)[thorsis.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,thorsis.com:email,thorsis.com:dkim,thorsis.com:mid]
X-Rspamd-Queue-Id: 542E64A4E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Makes no sense to have a timeout shorter than the sleep time, it would
run into timeout right after the first sleep already.
While at it, use a more specific macro instead of the generic one, which
does exactly the same, but needs less parameters.

Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v3:
    - Reorder tags
    - Add stable tag
    
    v2:
    - Add Fixes tag

 drivers/nvmem/microchip-otpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index e2851c63cc0b4..bf7e5167152cb 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -85,8 +85,8 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
 	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);
 
 	/* Wait for packet to be transferred into temporary buffers. */
-	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),
-				 10000, 2000, false, otpc->base + MCHP_OTPC_SR);
+	return readl_relaxed_poll_timeout(otpc->base + MCHP_OTPC_SR, tmp,
+					  !(tmp & MCHP_OTPC_SR_READ), 2000, 10000);
 }
 
 /*
-- 
2.47.3


