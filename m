Return-Path: <stable+bounces-59068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED992E1E5
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 10:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CC3284CEA
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA578152179;
	Thu, 11 Jul 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BDhNy7fe"
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4014885D;
	Thu, 11 Jul 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685932; cv=none; b=ZMCL0gbpD1+AG0hkrecWpDnTBnl8pDECBHzDUdNzcknlUeonq/0qmupiyy2IARkiGVD28cKkY0ElrD14FC8KwDKRQVdGPvZu/JcfnrDvXbsxvy8KE5K05YNdBtZ/bkVncoDfUu7FywerHp9tpvWsroLn5TvbrbFTUQiW0+U5I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685932; c=relaxed/simple;
	bh=eBSnAndKGBLv4fIbpoUVrnd4r0rXqY15awgPqI5yCz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+FkRJHoBIRhd2Cjp3dtLLRkBG3wMuC7EV0dE7l/5ESJVKyQKQohlBwNkIjGw+BO3LmFsgWikF8C2Z4EbB+3uFDbReq8IAEKFvkQlE2L5K19ByJwKmvCc8MAnwYQ4hx+R6+R/L8GZm39V+9PqpnkOTUq/GaV34jn3lnlG42+GHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BDhNy7fe; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CBF4A40006;
	Thu, 11 Jul 2024 08:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ii1N3RozxM4/rtfCLZ6uvIsvYlMTNZJP3+qKjDNPUhw=;
	b=BDhNy7feKOZF98MnmYw4Sdj32jMvGncfiHb/rckxxNZlm0Tf1VwfBcnaIrNOVi1NAoM6Qy
	CG7rpzko417cEOxihe6hLXgH2X7w70d03m8Ya7fQ2g1DSCDtl4k4KEYyaCSTvPjPWR5WPa
	pnRvCTdhiIqJl5WL4HSUdemaHYH3VQDQC8UDhsArc+y0ErUs+uMWp6Dm18a8BrWxaTy944
	ZRIiRRAuhsUJvGW3D+M1QChfYBvVsxjIgmhjjokka2VnuDVk/WlspCxkJndrz5giO/retD
	F/NQHtCpi3MpCgDvUKrdISRSlPMQHgqq6S3WxQgbPta4uq0CEEvN2uK7d6RVtg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's length
Date: Thu, 11 Jul 2024 10:18:37 +0200
Message-ID: <20240711081838.47256-2-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240711081838.47256-1-bastien.curutchet@bootlin.com>
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

No check is done on the size of the data to be transmiited. This causes
a kernel panic when this size exceeds the sg_miter's length.

Limit the number of transmitted bytes to sgm->length.

Cc: stable@vger.kernel.org
Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mmc/host/davinci_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index d7427894e0bc..c302eb380e42 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -224,6 +224,9 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 	}
 	p = sgm->addr;
 
+	if (n > sgm->length)
+		n = sgm->length;
+
 	/* NOTE:  we never transfer more than rw_threshold bytes
 	 * to/from the fifo here; there's no I/O overlap.
 	 * This also assumes that access width( i.e. ACCWD) is 4 bytes
-- 
2.45.0


