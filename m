Return-Path: <stable+bounces-217718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKATJJwpnGl1AAQAu9opvQ
	(envelope-from <stable+bounces-217718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:19:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0534174BA1
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B20A30142AD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E36435B64D;
	Mon, 23 Feb 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ4NRp74"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177E34FF4A
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841870; cv=none; b=JNBo6omV6oBz6roGmNHu8f3KKlEQ1rkWf3OeuEy8ThEKHgD+Bxn8bzf4jETn9UY2SRJWiVvJ8B2tXpaSXCB/Vo2UJHdkzxG2uo9y3aBZL6MgOmqhVbNaJwq9e8wQUHHKg0FcQas8zEJVLK03Xgc5g7OBY26orpoZEpZdFFz/Ags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841870; c=relaxed/simple;
	bh=kPoRVNxNpO3Z50WxHXMMyqAvSb7QbpFQJukqGhW/z/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DscArjNMIJ5FDyg0Wbl8bvMvcdFp60ag5OQ3+fG3JW50qwtznw7EVmYIOKYR0nbeq5fxFtQnxwPRzN1Md+Eu1Bx4SO8HnWIbemxsOA1xnw5Vx3+HWDivq4KwL117tnfO+SSl9ZukIi4BT98jHwycvBf4fjMj/OprNwv4yZyHJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ4NRp74; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1410338a12.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841868; x=1772446668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68kFT9M+v1YFr8fLxiUdg7OyCK95BGAep7GJPhPQZJ0=;
        b=FZ4NRp74IAvPu8rwJR61Zyz7ImSvEqWC1Y2//oSxQMiCiMmR3Wgl67PA/aqkki7SDj
         rgV2Fxrm1mhQgmbwPGND6P4lzglHuey/NAxCvahNFZnH4aHnl+KM1auziRe7/yrGHekF
         MgxICmGZvzmR3ymZoVuHDWZ59wnqvIucqe3B5ZDNSLuXuCfsFO5WiPCZ5athgem+n8BT
         mhzTwfbFYvOBCEiBlYdqekd3X2PPtG8E/CaCbpriwkuIj++IiF6hmQttoBz/AuRAlawj
         YAJfuMWBqou6B0zv6uJb6WI1Tndxunw8T5r2SYHbJhibTdPpjj/0Z5ZdfKdNtzDHMxPa
         kTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841868; x=1772446668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68kFT9M+v1YFr8fLxiUdg7OyCK95BGAep7GJPhPQZJ0=;
        b=IeqDS7qf7nRzmyL7mZoP0m5s8dRsWsb/wd0+2kAzzTfZBymCbgQ7b9tvKwixEtTWq/
         /hkLvqZ7of+PYl/L4i86BouhdyIIM6VLVElAQNeCGDVTcmNwhcfUaQj1Ddf2rEy/b8s5
         91lNmJO3p4EaEW0EA7V2ws30dVR82Lq00OJDT8TuP8Y9fMWRsiQmpfN+WwZIBw8dVGwP
         yrv+PVGdTMdmRzFnxkW36OVCbnEyrVd/qKiC4ly0mff/+uNcVnng+AaXWm9ha7K1zcXX
         Y84Ib0fWqA2wqghc3ZNsMfl71d7zAIk5OzoZEwYHRai8fCSUzRLY+rV8qqcnd125BPOk
         EV2g==
X-Forwarded-Encrypted: i=1; AJvYcCWujyIS+0FsIYq+tRS9W8DW6TDWgcQAjbCCAnXUuno6ivp0j5+b1lfbxK2ZXHT0fpws6aALxI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5uLThUnJxcMefG4E1fmdRBoZYMO/eyGai7dxzDivfhHoBZ3C
	4omLLwQP8pg4SRgd+P9KAzj+7aOKlCnR75IWlMNKvyrmAq9kvPKDBKgQB6Q8DA==
X-Gm-Gg: ATEYQzwaVS/0hbNQ9+dZiQ9XYNksN/f9VfLjZw7DMK5zFrDaCFWX6Y3XU1/y/WlYgXc
	0rKR4YqOye0v58FJVKGmfGwGv7Gcw8vlsvkVeEoOS3pNLsNTUlVuAmqVZVs0q+BqJrjZ5iJeMFZ
	wQq3q19NvHt+svxQc1T47+j8ZZlddyDm6Xei3zt8nxfZGmQaEd0Fam+pF/D2DpjPODbGV1BWprA
	zzJ3+opeKq0enhTr/dN7k7VpMlIPgodIJ0PlP73YmUK9l4WhoNo+47sRk45vZ3il3FSSchQ7vQ8
	jdpgFfcC2TufEJtDPl7w8EYnaCxf4CXDeeA+5KthmALH5G3o6i29qVTcC4oVvpzwFhYwgJEMCsC
	kHXSXZ2Nr+4KgSUEnIdXkzBMqac46wtfiFYiPyzkQPUKCm7u3J/bzZ5p43zvYsSdIHEnxIQ+nC8
	0uEt0aJH5SvwGwveLRHWv/E6GaqKp6IElYC5wKC49X
X-Received: by 2002:a17:903:2c05:b0:2a7:d5c0:c661 with SMTP id d9443c01a7336-2ad7443a1c0mr70941425ad.15.1771841867797;
        Mon, 23 Feb 2026 02:17:47 -0800 (PST)
Received: from c6dfb3cc7c9a ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3425dsm66574795ad.16.2026.02.23.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:17:47 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumarvs@gmail.com,
	sanjaikumar.vs@dicortech.com,
	tudor.ambarus@linaro.org,
	stable@vger.kernel.org,
	vigneshr@ti.com
Subject: [PATCH v3 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Mon, 23 Feb 2026 10:17:17 +0000
Message-ID: <20260223101718.89-2-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223101718.89-1-sanjaikumarvs@gmail.com>
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
 <20260223101718.89-1-sanjaikumarvs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-217718-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,gmail.com,dicortech.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dicortech.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0534174BA1
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program when more
data needs to be written. Use a local boolean for clarity.

Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/sst.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..db02c14ba16f 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -203,6 +203,8 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
+		bool needs_write_enable = (len > 1);
+
 		/* write one byte. */
 		ret = sst_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
@@ -210,6 +212,17 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/*
+		 * Byte program clears the write enable latch. If more
+		 * data needs to be written using the AAI sequence,
+		 * re-enable writes.
+		 */
+		if (needs_write_enable) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.43.0


