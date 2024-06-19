Return-Path: <stable+bounces-53677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E890E197
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 04:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED07C1F236E5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 02:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69536224DD;
	Wed, 19 Jun 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="FkH41XZW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B92E859
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763448; cv=none; b=F8cqW7tc4G/g89Q0v0/6w0k4yMWvmSBvHK3GMDWFEC2qZ4jr+vxlFFnb4vQxZKE+euRHrk2jIqz+4BvhoxoMltW6u+4igP9uYX+1IOznYAgE6XoThp+/kLtK9xWL9voO/54mDu/7UgkJza5XIp8tIuaeb5u/OVHjtZ09lUZXapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763448; c=relaxed/simple;
	bh=q2YGzhO8UrTaJ+Y8fuj2TS8BD0FNqLIzJndeKvmJQss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3PMmc5xa0NQXYS2yCSV1MDtTujupsgCln59r3mihpZwaNZs+Y1HBJNLDO9D+PVf9H7DrK/YgMy2yVgf6kVhsMtPd2+M+QYHVb2Qz/rImr/5g7zxLZh4DjpgzUV+LYpJ81ODK2yt11A3bULHvmP4jU7XaIHHMsHUThMRupOECSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=FkH41XZW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c036a14583so1143098a91.1
        for <stable@vger.kernel.org>; Tue, 18 Jun 2024 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1718763446; x=1719368246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkZFb4EXZYqzUEjX1RAn9tzpuhmFQrMHo0qA6DbBo+M=;
        b=FkH41XZW1S83qKvL8p7L5WQd9rK3DrpwCEIwLrlypody+6t41Hls3yqth6DnL/x+gG
         f4l/y8csB46KLGrvv9PN0Z106+SeWvrpk4WwFYL7V/RoXFs14nwCY2WP4p5UttxBs/Gm
         WdwdHEX7tMNJ7XFeHoYB7nkdhXvYodbgFAk3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718763446; x=1719368246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkZFb4EXZYqzUEjX1RAn9tzpuhmFQrMHo0qA6DbBo+M=;
        b=XV5U7Kigcpph+HCFM7gNtyC2j6fjAc0Pf9JBNMRAW7bjiyg5XKZUkJ1d9iX+MX0hzZ
         a0eODPI+iu8NcbwJxtE8LrHtrMSQFLyz05LyatCIWoBzgqJYoX+TBR7o7T8vjIFCZoSQ
         hyFIMNRoOYX5SFG9OrnkcgXgsYPPUbNNXpbCOIQXv8huOE0I0Uxq/eeRt58gDTwOY6cI
         BqRi8Y47YByjgbta9XYvEWGOSTjxmpJxXmC40z/56Iy3inQsRoLuLWS3tldruYhxk9Jy
         B+Mw0VIrEQK61vfF8r8lDuunpsa85XME1D1gL5Uw6fIAUWukVGNhjazhIb90HCBS8XSX
         Drtg==
X-Gm-Message-State: AOJu0YyCMW4ZqeNtNW6EXeInRXQ83T3Vvi5wLnTpmjhdD/A3NwqMuBkt
	ximh40y0WHnLpb1/+F5280AY3Uf+i02wePlvwF4UE1+OmFmKFuUD0LvljP9cCcPMOWWPa6neMIp
	I4vE=
X-Google-Smtp-Source: AGHT+IGIsVvgJ/XfSfGhGaUSObS5DzcxTgF+cFpgAiW52pX+vkNS4Fx49u+D1dy4wgCVwyMp12kmtg==
X-Received: by 2002:a17:90a:6787:b0:2c7:ad55:85d8 with SMTP id 98e67ed59e1d1-2c7b5d76cabmr1346937a91.2.1718763445416;
        Tue, 18 Jun 2024 19:17:25 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.120.71.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7a2ae3f36sm1608755a91.13.2024.06.18.19.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 19:17:25 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: stable@vger.kernel.org
Cc: Doug Brown <doug@schmorgal.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.10.y] serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level
Date: Tue, 18 Jun 2024 19:17:02 -0700
Message-Id: <20240619021701.503264-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024061757-squid-skating-bd26@gregkh>
References: <2024061757-squid-skating-bd26@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FIFO is 64 bytes, but the FCR is configured to fire the TX interrupt
when the FIFO is half empty (bit 3 = 0). Thus, we should only write 32
bytes when a TX interrupt occurs.

This fixes a problem observed on the PXA168 that dropped a bunch of TX
bytes during large transmissions.

Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
Signed-off-by: Doug Brown <doug@schmorgal.com>
Link: https://lore.kernel.org/r/20240519191929.122202-1-doug@schmorgal.com
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5208e7ced520a813b4f4774451fbac4e517e78b2)
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/tty/serial/8250/8250_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 33ca98bfa5b3..0780f5d7be62 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -125,6 +125,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.irq = irq;
 	uart.port.fifosize = 64;
+	uart.tx_loadsz = 32;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
 	uart.port.uartclk = clk_get_rate(data->clk);
-- 
2.34.1


