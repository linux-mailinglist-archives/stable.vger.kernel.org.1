Return-Path: <stable+bounces-202846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E98CC92AA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98E331B1AD8
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12B3596E5;
	Wed, 17 Dec 2025 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fJSoMrK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64363587DE
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979888; cv=none; b=R+d9DVozJgeIDjRPplopDRdwAJ0RNMg+O8Ikx0m3OK7sZGbS/iZckhIzrv16EnyLkeR3qRYYmYyXzYUi995TC3+pbaRxSh7c7KgZKFx/QMn8/ZixcSBhlmNFYqtG4BmJplXMt0Xi0tvEwdmB9NQue61sqZ85Ru7PReSQ8GyCoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979888; c=relaxed/simple;
	bh=QpvGPI1QC38ns1TQ9emS39EWBDfc1X1yaD+QfJzzSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QF0VH73tSOIr+VFXYyYXE7o3MR/c63XUjC9+uP9FXVxPn7BjmF7IKskVN9sbNYdESgSlqP+rpnBe10ejtNp9LQQK/3U7cBLzsryCNelQhmHiJp3DohaTE9i3uMUd1gtwph1VmgHi7CifZtR3nifHlsBss+osEsjkTUZEEHPew00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fJSoMrK5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2733692f8f.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979883; x=1766584683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HlZloNFFx/UivoiHTkjRab58Z2MwleM1jMI43+NTNY=;
        b=fJSoMrK5Pyhta0KdCvvzMlPiINFDstHf5ZcYDwPP4A5GYTdzEvnhU72c20pN1PG/kh
         C/trYoGTiEL1KDeA4mUsA+sM4c66fn61cLSUFnxbkZH8zYxr2FelVOX5WeGkszCbflcj
         H1BmfBGddERO2WGXUqB69Cnx3d8zjpFwnRKRUYRgj2n63HLhZ97uXuSgpDBPx9azV5Ui
         w/ozPgMby2XV3C3VLNqJj5I4TIcHZdx82uuZzrPBZw1O1yZtc1PFDOeMV+f6LneibvER
         1cCvdH+3HQwHG4wC3h6VCE+XVm/AEmOexXn7k+1fEkEVJlkx0G1BofxmeYJl27JO/AGV
         C3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979883; x=1766584683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HlZloNFFx/UivoiHTkjRab58Z2MwleM1jMI43+NTNY=;
        b=t46nhiu9oB9FRfc35kwmtRCWmb9kRmDC425vheHx/Qc99xF5VIe7tN7RM4MrFXetxJ
         2hO5uEMUTzFoADbqRaEPoBp2HVmD8m/9iTIF3ZpNi4vuCVFr0ONIoMyhJM0qbfds1WHV
         fDRLTAxOyXCSIovCOkvUVuaP5UJqzjnxC3BsvQs8gX8r9aGN/DycF/giEJka3ABFDJUd
         1J6tEXAmREiYXYynHxym5fAqmHXCpxyKxiAjwtxU/NbM/KP0svS7tEG/QkkPHx/eK8as
         yvGv17mAph3DOn11KAi5W3OqbFbBNFrzP5ZrkgN5c2cYbTrx7WvD4M99q75DH8pdTdNf
         ppqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX93L2uSP5xgtfLf5f98PuzjpG7BFwxiGLE8cPSrHEen5nN1JSOIhcLvhzrtdp5OwwadMa7Cw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTnwbYa8i1km22MOQR+ebWKdwnATz5klc/Hvrt0klR3E7QvOP
	7ieVwsyfM3RH9cqC1Vqv++AMoAuuIiE94JGscH1vX8xdmWT6OczG3MxRoJowqUs1qBU=
X-Gm-Gg: AY/fxX5crwMcl2x89rJjBfW5SoflTE3mGz0p1D1SsrKEHItOqELN/eBVg/mR7sMeC7K
	7pCP0dp1Ul1xmmgNo+SiUpLvbm7DUzH4qq6FvhW7GDzGO4OhGNt4IXIE5xi59LJBIb2LF77lup9
	4xyTRrwsfhg7l+1Yvqn9A7oryiEmhm3lBiwp6K8MyQ7qymP+uu6kONdJOmQeFPGVVL+lE8xTrCy
	VhswvdlYKhr12x+XIWX78B71353POFy9T9LNDcdh2qtH34AQc0kRTS2QX53Y0rDsFTOBDoELV6A
	pJEe4k5DbF/LDYU2U+sr0zH/xuFGSdbKb8kP+5yd4ajFNJQq2aM3Isb20raJXNk+MeZbcuQNcFB
	aNlDMD/UzSs+83IIXVRqkD40d7hr2Eo4YFWAqt/DJqUksJVHy0i9f19rls56kx/BEbtnBhIz4V4
	/WQJamLZc5UShLPCPODt82Dw/0pthqxB8x1Va0Teh1
X-Google-Smtp-Source: AGHT+IEIS8MqzIfRpyVv3TKeZOzBwWHNPpXl+C09WJPdJfQdbR31Pfy1vU+QJIhIB6+MFCKEcYlCGw==
X-Received: by 2002:a5d:584a:0:b0:431:54c:6f7 with SMTP id ffacd0b85a97d-431054c087emr6315110f8f.37.1765979882987;
        Wed, 17 Dec 2025 05:58:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ada846bsm4852976f8f.9.2025.12.17.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:58:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	namcao@linutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: sh-sci: Check that the DMA cookie is valid
Date: Wed, 17 Dec 2025 15:57:59 +0200
Message-ID: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver updates struct sci_port::tx_cookie to zero right before the TX
work is scheduled, or to -EINVAL when DMA is disabled.
dma_async_is_complete(), called through dma_cookie_status() (and possibly
through dmaengine_tx_status()), considers cookies valid only if they have
values greater than or equal to 1.

Passing zero or -EINVAL to dmaengine_tx_status() before any TX DMA
transfer has started leads to an incorrect TX status being reported, as the
cookie is invalid for the DMA subsystem. This may cause long wait times
when the serial device is opened for configuration before any TX activity
has occurred.

Check that the TX cookie is valid before passing it to
dmaengine_tx_status().

Fixes: 7cc0e0a43a91 ("serial: sh-sci: Check if TX data was written to device in .tx_empty()")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 53edbf1d8963..fbfe5575bd3c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1914,7 +1914,7 @@ static void sci_dma_check_tx_occurred(struct sci_port *s)
 	struct dma_tx_state state;
 	enum dma_status status;
 
-	if (!s->chan_tx)
+	if (!s->chan_tx || s->cookie_tx <= 0)
 		return;
 
 	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
-- 
2.43.0


