Return-Path: <stable+bounces-241420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEJ9Lhuh72kcDgEAu9opvQ
	(envelope-from <stable+bounces-241420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F1477E2D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BF6630028E2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613153E7163;
	Mon, 27 Apr 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="c53Uaxsq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA837AA88
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312021; cv=none; b=B31p1Dx4z6tA++wZ8SEE6IgATjukY9cpHuwXJLytNp395Svd64fTlXjymP/1Jo2Q5hbvxEafbPaeVFRbyt/DQnkWcqpjD7f5XcIKR2Hcbthjt+LRStTKpRWBGv2m45F3+v1TMywE56XnUnoFsG6hFwmpGrzr4xMYm+j2XDd75JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312021; c=relaxed/simple;
	bh=SCT8D80G+jmfhUjd2eDo80+D2h1zd7FvDnYKrKfZlvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbuofz2r/GL490VGHwa/WFWokpoljH0ywC8dAXxNJ/3ixbLSeBqIAy68eF3ODH7hZDDb0nLmU5FUTW04526QVNkMDv95+BF6JdzjIXbDDhx7fCAGx4i9lmPn3B0Kqi+Cl2+FWKHLYH5JuP4iQGTdKVZ1tNB9m2/JFR22UY53KvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=c53Uaxsq; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso7133711a91.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777312019; x=1777916819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtxZYUJWsG0tUhkOglqtm1G9mRh7DJSqPuF8GOXSvQE=;
        b=c53Uaxsq4nE3rDd4TaJgn083FKMCeiaWDqQvC1TgBcjzIB8nvhyBeQy3vQG4wqUJn4
         Rh4u9h+67agyO3g3a6YhOOOZydJiClmmWZXIUyMI90YTXYs8TxwkP+TCRvG94rrUJiYI
         BYwygK5DwT2u3Z5S4JrtUU0P1t//Ya7CAQO1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312019; x=1777916819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtxZYUJWsG0tUhkOglqtm1G9mRh7DJSqPuF8GOXSvQE=;
        b=QxJBhhuKT6DEW2FVjCwHrs80EXRVpFJSbOTo6mLNvHeCYo7d3k0cM3TyN+2RQHWylM
         MzxxAVaOe18mh69vaRs/BDfslIzIECB3D9tzwMAFbL0x/wGVXepgxkMiqZ5QmwyRHqbi
         2l56YhBOFLFIRGsQx9ms6HQF/SGx3sz2WCi4Y4Ld2byTsHBiW7pksAD+UggRpG8Pguv4
         1e0JoOJyE60CHamq5+PRe9HFZaKYuWkknv0bZBk40tefVVpXAfcoNlCnK86JKz98PPJ+
         T43FCNxjR/Z7vneQ5PSu91GK8QyO2RSfSj0fyph17BMz4UBzvbEbMiitMEu+xHU6+Ol3
         Cnrw==
X-Forwarded-Encrypted: i=1; AFNElJ8R7qYSwTE5ZyokeKcf5pX63uyA4c/0iA9z3acDWbPZPfwgtUCe8997PPFHPk3rZAuitRoija0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFmPIHndIZJwMo/Fnm3lEGKg0ZG0700ipkpug3rd/HXlQe0go
	aqeo6I9XyuM41Nqi/1zzHy9Fic7c625IO4IrsuMe/syudigLSfD/rYoQO9fqpWLoNzRdyWAwP+m
	Hl2VHzdgW5ogNUFUCCoN/AZ8qHmIbtxMMcw04
X-Gm-Gg: AeBDieuZ7Kmg5YcJOE2h5EbWYV0JJ25wgjcOBoKNokkAnh8OijCVu6E/s9g1BvSY7tH
	DHlkH0HZqSHfrcc+FWvqTpkIwx7/D8ERXVmzYQISHt92f7KQ2uyDYCR5AuS7DlnCjl2upCGGooh
	Ir4rMxpvqpaJB92Jhb+PBXuhievHLj5J4gWxRF8gGPhds7/nOd4XpYK/t2Sqi0ichqHtRSLhUnH
	dB5ZeaJm1QDmxk1Fz9wisFPBGmgUEyPT8EDNV2M58FdikUHDckACMDDE2cOnUIFma0k0u2qr8nD
	d5X3C0uWq1vRHyTOr316DyAcD5K4GprDl4mARTW6MiZ/UeXH1cqbiJgccIUEqTBuSl0pN2tvRAE
	k7W8HsdEEwfCiLlJVkUpsfVaPL9H/F8q+7tR01ZTADdztvmYzhDIsKMQ1bvw=
X-Received: by 2002:a17:90b:3bc7:b0:35c:30a8:341 with SMTP id 98e67ed59e1d1-36490c99b61mr60652a91.13.1777312019609;
        Mon, 27 Apr 2026 10:46:59 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-364902f5c44sm18498a91.3.2026.04.27.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:46:59 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Mon, 27 Apr 2026 17:46:57 +0000
Message-Id: <20260427174657.691272-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E18F1477E2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241420-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedTS.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits. Also set rx_buf to NULL because the value
returned does not matter. Thus moving the 3 byte pattern to clear
the command register to a single message.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1 -> V2: Don't use rx_buf when clearing command reg

 drivers/input/touchscreen/ads7846.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..93edd2419db5b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -327,7 +327,7 @@ struct ser_req {
 	u8			ref_off;
 	u16			scratch;
 	struct spi_message	msg;
-	struct spi_transfer	xfer[8];
+	struct spi_transfer	xfer[7];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -403,16 +403,10 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
-	req->xfer[6].len = 1;
+	req->xfer[6].len = 3;
+	CS_CHANGE(req->xfer[6]);
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 
-	req->xfer[7].rx_buf = &req->scratch;
-	req->xfer[7].len = 2;
-	CS_CHANGE(req->xfer[7]);
-	spi_message_add_tail(&req->xfer[7], &req->msg);
-
 	scoped_guard(mutex, &ts->lock) {
 		ads7846_stop(ts);
 		status = spi_sync(spi, &req->msg);

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1


