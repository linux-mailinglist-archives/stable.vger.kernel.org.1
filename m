Return-Path: <stable+bounces-19085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8884D02D
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467F21C26643
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60D83CA7;
	Wed,  7 Feb 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNIP3OYh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE183CA1
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328211; cv=none; b=UY/vYicNzHsD1HZ7FKrggpJDIDahuS7tMW0Yd/s5k40EnzCdV6qw1CEwbjR+wQ8f/cw1yAuNi/DTVX1cbaM9qMNfdks2zXBYGWe38GHUnBPu26GvZR5nB7orzCKkNT3+hUQjoLP9DBOj+Iky2Qd/6lHkR/amerOlSmKyA65a3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328211; c=relaxed/simple;
	bh=Mmz2szsEa8fRc/5VWn+xclgZaQqFrv3+O6GWDXybBIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpsEfDUilN1TAHletAeinXc+vTAJAPk5IgKrst8dbOMvlUzApWV5/gEx6r/+1qCIq63Nf+TRjlcN5W94oDJ8Fb8eA3YBOnH6+GPOHOxVC9IZ1Rt/7LguLVZ14d1Re5JcFYJtj0EG8mx6gzEROe1zLob5XTnbdJ+OnI6yy4z7Cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNIP3OYh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so1110092a12.1
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707328207; x=1707933007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGDFZCXJsgP/e+y8DEUUTJO395BJkBwgpdtBp6SsTfM=;
        b=JNIP3OYh++e1/7zr65lCKMGtr9EnkK8e7uHDHS2GLmU5Vy7/qMMEPtwU6YGr5w0bFW
         zwcWqcJOgOw5IalJtY2BmgQA/DmyL0s6MpFd4bLcL60dDJP3ABpf4ugRqC9igz4jf8pi
         uCPMht5/ZcaGopqX2D9aC5PGGNHQlnJ7MMlz/9RFVhIFQb+O7GJCQ6Wm3kdTPZHx6kLY
         uF13vXlgWyJKza+fyE5Kpvd3r5/M5rOqiQJV+8dL4AMnWvEz7CEEzoHfnhTqp1W1xKon
         32owyBQj8V2/Q8lg7lvXnIFOY1/Bh4qgR69Fs9P5PwyLyqfV5bWhokeU0xhMqqF0uH+w
         lETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328207; x=1707933007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGDFZCXJsgP/e+y8DEUUTJO395BJkBwgpdtBp6SsTfM=;
        b=pzgyr3KZN5fH6stvSR476CK7/3BfVvKJI4/1Z2Nyns2uYR1YEU7ei1RybPqxA9A3Bf
         Mupgc3OQZS0Tj/ZJAGhj5HLsloKYA2EF1quHudXNxlNXBfLap9bxw1ymIehAQX7hDdUj
         huAO/yJR3oZwWw8lWhO7kZ3bAGvNR73vXjiYzEu7vgT8bAxjIbykM+fAIP/p4ZGkAklb
         XIPRv4JgqkP6c09PIg9nmBlE1PBcIJI+ioTVXIM2oLH6rO34cCu0ZLXWI1POiOdtEyUk
         i1zB8Pr8Qa9gSLZrlrekO6rfgbgs3ynXDVMUUSxQpXam7SEh2WbBGuQXRd9Dnr8e0aHe
         ykCg==
X-Gm-Message-State: AOJu0Yy4A0IUswJVidNawzxNXEm80xAAI0Ukk00gA1948BaWBjIAgCBM
	SXvbO068j3qnIwN8G/n/vEksmpu00KMuBHQ+JTQbDmwzzfxSdQYw66hnTeBG
X-Google-Smtp-Source: AGHT+IH9xD0ZoHBG4Q6eKYQphgfJ1ej5/WN2oX5gK7W7O7t8ZQSiENBsrXlUdeTnPhAhjCDUydEiig==
X-Received: by 2002:aa7:cf99:0:b0:55f:fd10:5e73 with SMTP id z25-20020aa7cf99000000b0055ffd105e73mr4160390edx.20.1707328207371;
        Wed, 07 Feb 2024 09:50:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGu6sWkBlNncMKRcXdn/T/yb4cLtusRzgoQNkriY5/pMQCTIw63d/+IgLuLYBPVkXJw2fTL444mEkyKSiKtS/98MgjhgrRzF0xsp6Xyv7V+nWt/qz6Kx9G0WtAmr3OtwoAlGHLVwBpnkGK/P+fxqKjTWWjifA2ooXe9k673XQksK5b0MDWHDkj92uUQJ8+MUp2OLJe/kVzO0XIHH6qhDMF5Y1WMwX02A3kIJUHXMCGIeqydSRMBKyylP6WgW8oRHcC4L4ChpdVistbJ1Z5BSsjS2dayDpMvM8X7DxB+6JozeOXVVk5pp9GAsGxqGHPeQ==
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7df12000000b00560f3954ffdsm180992edy.24.2024.02.07.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:50:07 -0800 (PST)
From: max.oss.09@gmail.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	patches@lists.linux.dev,
	s.hauer@pengutronix.de,
	han.xu@nxp.com,
	tomasz.mon@camlingroup.com,
	richard@nod.at,
	tharvey@gateworks.com,
	linux-mtd@lists.infradead.org,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: [regression 5.4.y][RFC][PATCH mtd: rawnand: gpmi: busy_timeout_cycles 1/1]  Revert "Revert "mtd: rawnand: gpmi: Fix setting busy timeout setting""
Date: Wed,  7 Feb 2024 18:49:11 +0100
Message-ID: <20240207174911.870822-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240207174911.870822-1-max.oss.09@gmail.com>
References: <20240207174911.870822-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

This reverts commit 15a3adfe75937c9e4e0e48f0ed40dd39a0e526e2.

The backport of [1] relies on having [2] also backported. Having only
one of the two results in a bogus hw->timing1 setting.

If only [2] is backportet the 16 bit register value likely underflows
resulting in a busy_wait_timeout of 0.
Or if only [1] is applied the value likely overflows with chances of
having last 16 LSBs all 0 which would then result in a
busy_wait_timeout of 0 too.

Both cases may lead to NAND data corruption, e.g. on a Colibri iMX7
setup this has been seen.

[1] commit 0fddf9ad06fd ("mtd: rawnand: gpmi: Set WAIT_FOR_READY
timeout based on program/erase times")
[2] commit 06781a5026350 ("mtd: rawnand: gpmi: Fix setting busy
timeout setting")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index b806a762d079f..fdf5cf5565f99 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -684,7 +684,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	hw->timing0 = BF_GPMI_TIMING0_ADDRESS_SETUP(addr_setup_cycles) |
 		      BF_GPMI_TIMING0_DATA_HOLD(data_hold_cycles) |
 		      BF_GPMI_TIMING0_DATA_SETUP(data_setup_cycles);
-	hw->timing1 = BF_GPMI_TIMING1_BUSY_TIMEOUT(busy_timeout_cycles * 4096);
+	hw->timing1 = BF_GPMI_TIMING1_BUSY_TIMEOUT(DIV_ROUND_UP(busy_timeout_cycles, 4096));
 
 	/*
 	 * Derive NFC ideal delay from {3}:
-- 
2.42.0


