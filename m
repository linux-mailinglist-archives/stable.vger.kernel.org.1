Return-Path: <stable+bounces-118723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC3BA419A0
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7051889F48
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E09243947;
	Mon, 24 Feb 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GO4YtGQL"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC60242937;
	Mon, 24 Feb 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390871; cv=none; b=Yv18sNh8WSARVVAQmjQVhWm025Q4AJh6Bss+yDPDaRhrDe2ibFt+zVY2+tTa799iBqnjaaR8Iyk0wYeiMgmyhLTTUaEU9QeCWEAIfPNqEaztEYZ5voSil4kgSeG17rRUlQEnnQAbrg3QIm1IYTJcIW3uE+2hDBj60K6S72Kvoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390871; c=relaxed/simple;
	bh=g8X99TOPL0otzcxF1N+utf6ztWrEQtdujpo+L0MLn9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1dI0ZuuVlMU2y4gMLHuJVPUVAhTBXYxOkfdIvovBkLRCBM9UVlfam9gW1H2oQr4sndtpU1jgbRg7IJzHpBcIU3FWtEjVcL8+MLJuYvxw8EEHAGPpj/bn6Y42vZ+8VHmjrPrFs1RQdUSiBJNgUTcfa5LEhzFebMjb8jZWl7SGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GO4YtGQL; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Sh06N
	4SQha47MxwITMQ5mfmDR3A2miHvY6K140EwxyQ=; b=GO4YtGQLDNdTTkgestW1X
	0vnSLOEDXDA5QvtbTRxLzoPsch34UUCOnsnXWh0m1LQi7T9LOdmxF/PFBoD+RKGl
	dMTq1kP4uurH+k9x0aSj6NNFudD/vrBmeKrY3Z/0+ErNwfcaIDTqeQqgMvo4L1yg
	bidlcH4hozQd901B0ZASt0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3HSQEPrxnlgK1OQ--.21200S4;
	Mon, 24 Feb 2025 17:38:13 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andy@kernel.org,
	geert@linux-m68k.org,
	haoxiang_li2024@163.com,
	u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com,
	ojeda@kernel.org,
	w@1wt.eu,
	poeschel@lemonage.de
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780_probe()
Date: Mon, 24 Feb 2025 17:38:10 +0800
Message-Id: <20250224093810.2965667-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HSQEPrxnlgK1OQ--.21200S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw13tr1UJw1kCw4ftw1DJrb_yoW3uFX_Ga
	4ruFs3XF4jyr4UZ3s7tF4fury0qr1jqrn5ZwsFq3y3XFyUuF4xtry2qrn5Gas8ZFW8tr95
	C3Z8WFZrCa17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRApnDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkA39bme77loMFgADs-

Variable "lcd" allocated by charlcd_alloc() should be
released by charlcd_free(). The following patch changed
kfree(lcd) to charlcd_free(lcd) to fix an API misuse.

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/auxdisplay/hd44780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0526f0d90a79..a1729196bc82 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,7 +313,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
-- 
2.25.1


