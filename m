Return-Path: <stable+bounces-189947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FBC0CA17
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 10:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAB274F14F2
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024A26FA50;
	Mon, 27 Oct 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz4VuvRN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790922E7165
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556871; cv=none; b=E7sL/rVB4z1JeKOcIbww4wctbNLkLwm21w0zLZN0I81apjqdvSZMq2QB0m06exUrBbumydTcAowYd30bnRLTOOegl0OTb6DDcJEmV3wwTdSBkGzVDRB3JjvqzufhJYy1gPPRPGpPxH7tkHIT3rjVmyu+kJNENZXGCWEsi9JD2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556871; c=relaxed/simple;
	bh=T2FiuKY307QUDrwGy2QITvUy0qfdAG9Duzl2cYto9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okabpmBMDYjspvFG1Jjt2/UO+l0fydTcWyhY5q+DkLQydShXvW0R5mcZnoK1CcisHJGjwxTypwX9FGPKF8u5xvNDJXnc3ew9KmFQ5c4tvyebmRqV3SZRrHaBkT1Ku2VDr1ZxLNechIHSkM8eYk91STU9rjp9w3v5McUn3vURE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz4VuvRN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso3645049b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761556870; x=1762161670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=gz4VuvRNEdsyV2CwQzjgnFa8e2EC1C+ncCogYY5YYBJfGvdT137LLLvEldbGt9Skdd
         piyvtiRZfVdUqmIqBH5fenhgFCzGbf8DFKT9X/Cp8/nig4/KvxBZ3doKipj7WIPxaer3
         HqFTrOLdImrd+il0+dAV2e/kj3J05gmGq8Kdnz2Zl3sisYBZ0zi7B/PnTy58EFRb36Q1
         BNoEe7EziK1UnKnYwVp0+9U/AOVTaJ4+bDgGMXr56I4rQXVSKQoGvDJcI8l8vhX9lMWO
         irnIotddwQ2cv5YYM08QuWCwX5poJxmi9J1ec66ioFsZkXi+FOCPkm2ios66KL1gPBvp
         n9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556870; x=1762161670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/gIU/tSFOCdbD2UtPR/QSZA0FQ48iXUTaxg/wbjKYU=;
        b=qgdcrKs7xh5IEyaXUlkmjKRxdZRaZjv53Ad2x8JvrZs9xxGE9BKyQh6qaJyDTTCB6y
         QSzrSQMeQYtze6HHtnQ+7gCdXeM16SAK2OcN6jtiUAV699PBSEV96eeQ35l5lYUBQO8S
         a6aRx0M1PoVMbReRYZmeblzHrooDW5ys07InosKtaCsN4QcSP6WATkyUdPJBDhng9IT7
         WVkQU6owl0tLo/N4dRHK2Md7rPMYbZPuiK+lI4fqkv5xxmKDUcPWjPx1qPfo+vZl5YgR
         QcteBHC0zEml0bl1mDLkbY+hKCgV+A3oVcpWBRG4v6KGD5FSQn+3gkjxYkfqUsavR1Mm
         Wbcw==
X-Forwarded-Encrypted: i=1; AJvYcCVlMdKG9CKvXNrCaE0T1KkHKeV5OWO/uA5KQ82Ph+LNsSsH7vF639ugZXo6b29OFOdH04ilpes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuH07wlscW6aVCtW/V6tnL3T3P7I411Ekzcov10F6SY//z/oTp
	Bbl6DAiUHMhHPSm/+Is9ZgYCtLHmGgsmX2YVO9w5ZKeXTcMfW/fiBy/w
X-Gm-Gg: ASbGncv5dpMzbYX3JkDJNzPGubgWK5+m0M3tzBu972/4uPCDxyywW7M2ip4ICHGRHHB
	/L+ocNo3IRIuh5f8Hr8GkShRsj7FZzl3e1Yx1YKmFG915vCvy3PXwYMW2sdmHfT2V3aGoJhsjy6
	WfxamD9sqefIw1l1LLRNdYALs4e8cIjpUxeWCrxztYoXw4enQHohaUw28Gk9GUCYyGAhaMnh/d+
	DCtm2xsCms98FHT4cM8CTOjjrRmBeWi6d8XmkYWrdhVrJHZIH0i9Qgg3aGlBvcKDuEvpeSo1FYE
	qkyuSMnLJeHxEk/fr9AOAWyNFE3fcRaAtk3x+p0yAJzq6hX+NfBR9j3DAT3lp2Hn7qi6C1NHA/F
	f+i+r7PJ7WKSY35jdT3OavYc0k3AoVbKjSewG7prW2G/cmiMNq3MayITQdIuiL8BBj15GVC/rTG
	7nmit/HItGqpaVdFPoUWtuVZSkx0HtLKuD
X-Google-Smtp-Source: AGHT+IEcpagKOyJV1fsrM6dM/HwYD5VenCjDTs/rQ5hoHhvZqYSFHENXuZ7ikBTfiwnPt270HOJ/6A==
X-Received: by 2002:a17:902:e552:b0:290:ac36:2ed8 with SMTP id d9443c01a7336-290c9ce63d6mr414278245ad.24.1761556869605;
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b712ce3a90bsm7017409a12.25.2025.10.27.02.21.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 02:21:09 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Miroslav Ondra <ondra@faster.cz>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: prefer dma_mapping_error() over explicit address checking
Date: Mon, 27 Oct 2025 17:20:50 +0800
Message-Id: <20251027092053.87937-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for returned DMA addresses using specialized dma_mapping_error()
helper which is generally recommended for this purpose by
Documentation/core-api/dma-api.rst:

  "In some circumstances dma_map_single(), ...
will fail to create a mapping. A driver can check for these errors
by testing the returned DMA address with dma_mapping_error()."

Found via static analysis and this is similar to commit fa0308134d26
("ALSA: memalloc: prefer dma_mapping_error() over explicit address checking")

Fixes: 58ac1b379979 ("ARM: PL011: Fix DMA support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 22939841b1de..7f17d288c807 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -628,7 +628,7 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 	dmatx->len = count;
 	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
 				    DMA_TO_DEVICE);
-	if (dmatx->dma == DMA_MAPPING_ERROR) {
+	if (dma_mapping_error(dma_dev->dev, dmatx->dma)) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
-- 
2.39.5 (Apple Git-154)


