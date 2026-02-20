Return-Path: <stable+bounces-217548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdGIP8smGmzCAMAu9opvQ
	(envelope-from <stable+bounces-217548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:44:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3816662E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F6423040F9B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A031AAAF;
	Fri, 20 Feb 2026 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmiGgu0o"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129A32573D
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580636; cv=none; b=mIcwbJy3PXe3V52PDrB48vi8omgvoSR9RQcETeZ+zGQ/Xh20Byc8ndNIKi5cwPQ8wUI4m7Rs72YNt+Mx5175HT6NwWXlsKmLLKkV5MpeCAWFG4pP7vp8G8fUxUtLI0cZz4h6kmfEkXFHdvnOToY97UCgW957D/5FnyJ/FAK1/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580636; c=relaxed/simple;
	bh=4inxDekGJT14s5pRzFgIVbyyDkfJdx2aozoHWwjeCNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISAiVxDPpkbFFshDA43wTorBzKNppzj3VW0igtnzVpRLfsT39uRRq2HV6OIGvKg5hv9rtkUH+24fjLuBgPKaCw8m9x7EAPgr/vmJ09DpcpIviYZdSprCulKsTSVZUu/8SYWS5gYXTMonuPGOBLNzxex86jRSCSXEmj6HsNegRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmiGgu0o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a929245b6aso18189305ad.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771580634; x=1772185434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+8OkdNO1fPtr3MKMAcMES8k9rb9A7ACMmCYnwoCgbE=;
        b=hmiGgu0o8EtY/7W792q/4fI843+FN+NHP6FPMmHTGeqtjxfhm8xnDYHAHBuEPUJZaC
         BzS0MimGYiTCPpFozQPdusrXBCyatae4noIPY4mU7y8sktGYTx64JPLB6ozZVeWRe/c9
         OwakD3nZbmBXStOKByysGVFyZlYdOX4PyOdMn6Y/StsldFZ3/lYB1+32Ush8GXuEcdqx
         LfY1U8mJRF5LLjkujP6KdGV8ZVi4Q/qrxU1+8JEt17Hvm/KpWbCdZaX28O+WWSIQ3Mj9
         xRDqdmlv5t0YC4I/mVDTJyMJNS5m760OCnFlOZs78dZr1ICFt0+LsH7Mxhj/SAydwJqa
         wvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771580634; x=1772185434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+8OkdNO1fPtr3MKMAcMES8k9rb9A7ACMmCYnwoCgbE=;
        b=uLDp1NR69WRCFFp3t+0iREomuGhtv1YuQge6koB7AF7gnWmW0kbHL5ax+3xWhdifP5
         HiK59kLe3ShvTSoZ61vlt2kcowdG5oDMmRy1li5l/ZctsdvQUf5ch1/TBRJ+CHGfiIoX
         bdX0ahIqkyhXAro1Oai6dKA4htUZWkOHjNQnZw33j7SMMjPTaDENSr7frgSW5rjYC8sq
         dvxL+OF9W2LbkNi5rGEc8hK0B82YvKVClpuzuv/+Bs9a43wypQrT4CNJeUdQiKOWpy2Q
         V54xJgjZgUTVOTdlYCHlSdafwJeBWobYuC9h+bazOQKqvV+/hzgwjmze+4R+438FXlhW
         DWsA==
X-Forwarded-Encrypted: i=1; AJvYcCXh9iUyveGE/wd7EAWq9jyFy4WV6LqKOW2/dZWpjPnjpiodF6ePZh+/FYqs65cO13j92QdVt8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KDwe3Kk4itxlKY411kCi2lZHsLycvWDIXE6plUNi3dZIejyG
	+orgruRZnNvm9fVPvyoh501mvFfBwNuTPvblmOjFT4x5ys8UD5GZ9zAV
X-Gm-Gg: AZuq6aK0aKqvmtpM/Jssgw5R0Gcbf1uIdcRm3BtVJ4ahbSFavCHdQEBMb7LewF62Rx8
	0p46GQNX/z0Z8+24TUJUcjVFRbwnVJ7fTXQfuU2jGficY2wYqSTTvWaNV3L+pmn3/NIsrNOfx1q
	WFUL3Y3NS4iYvufKXN7LU9oidE5x+v5An8U//cOw7qwsFI3uqCQMjFOJaRGEEZhInRK8PYpnQ51
	h85lvIACglxqhp85bupQFoFYCXyFhWQ1IqfU6FrYjbnM15fa+bQgE72ta8eOIwVU5Nxeij3PzFy
	E/xehOOE5T/6yZDS/87fcCbJ2bsr6ocS4kDrQUm8PJq2uCUg0Q7mxpT2ci9eF4ekl0EthjynSGG
	yUtS6OuZ6mUIvrchsvQ8SWqrRBzPMYSiJNnwRXgPUO+7OugLdsiD+Nj8r4vopgBI8qwnuILwPxz
	WRiyWhjiSj/w6Gux9DJrq++JCURyjmjg==
X-Received: by 2002:a17:903:19e6:b0:2aa:d608:ec55 with SMTP id d9443c01a7336-2ad175017e9mr190151945ad.28.1771580634204;
        Fri, 20 Feb 2026 01:43:54 -0800 (PST)
Received: from f0d65881db18 ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5e25sm185309555ad.91.2026.02.20.01.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:43:53 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-kernel@vger.kernel.org,
	Sanjaikumar V S <sanjaikumar.vs@dicortech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Fri, 20 Feb 2026 09:42:35 +0000
Message-ID: <20260220094236.28-2-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220094236.28-1-sanjaikumarvs@gmail.com>
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217548-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: 04C3816662E
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program, but only
when an AAI sequence will follow (len > 2 bytes remaining).

Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..fe714e6d0914 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -210,6 +210,13 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/* BP clears WEL, re-enable if AAI sequence follows */
+		if (actual < len - 1) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.43.0


