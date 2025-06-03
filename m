Return-Path: <stable+bounces-150672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E8ACC340
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23113A4548
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C4281530;
	Tue,  3 Jun 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WdVEm3Ii"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AF25D213
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943427; cv=none; b=BsatcC7162EroKNIrbh7JRTj/wIdmahmPESCl3+05zDx1m+lN6xu12zBIWkQGWgjximoARhSNhNB6FuMUHMmbdAbsGbYj9nEnZ0G5esmr2YK0MpKWpqMkjx/74dqc3U7/ZsGx4MgpdcPpUXgIYwG7lj1KhTOpGfHOa24MlrQTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943427; c=relaxed/simple;
	bh=dZgbd5VNbenfed93s6UuvD46YNWULLE8qYGcEaOzscw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eq8w/1q8OrEITm0fSdJis+i8iaXjhKfvh9Ee18otCWaWlo29uoMxgPxspmEqWANdblSkH9zo8CZ498RanYi5bS+sh8Gs9UhkTbku2OKRteTxKpn2srY8AUvsKCVjWdklY3GQA24mJK13FUwQyfsLFuoyez2ZXIcYsE/tdG78gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WdVEm3Ii; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-606741e8e7cso2984051a12.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748943423; x=1749548223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rz50O4tFPfOsIoY+ElVL4w6KOi16FpvJLTsGkNiubU=;
        b=WdVEm3IiJSwFHpmFRZjOkJEGw/lwdu4cl0CBB5FwmwNEZF0CwcEE+sOhmMqvn7lB9a
         T6RxzrzwFK3CBfotsRSILduT8WNuRQfr5t+eHvMjziZMOINYpFmgtmPs4b5eW9HcfPW2
         nQ16/ejT/XWFoUuhr66UggrlscSe0hrWtIohajv0t5PbCurEyliqOFg2dB6Zxl5FRb8W
         ROMGsbrwP8XiSZylmNKbMKgLH1+02R1Ppu/CDZnzE5mI+M5K60QIjeGeCmBlChVVCmbJ
         7wRQyK2RvQ82wWKoaD6JVGplueEsJq8zPNFUr1h8JsHgx6154BKNroN8sTa0qswajCqO
         64Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748943423; x=1749548223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rz50O4tFPfOsIoY+ElVL4w6KOi16FpvJLTsGkNiubU=;
        b=nj2Fx7epxfbERpuZh66JDpmLv/mfIMOzipPlYG9SK/fx0yMIDKhZ5g6DP1FpkJ9eUv
         bAN2duCsP0vN7cuCn6SXir47CFDH9JyQiJ6fdhxdJqF/XEUEKklk/tCH6QgIZIh8maVY
         DlpL0Wwr7gMDc2jDKh7x4nBa06qUhMNK+SMnBO3rRlJYh7VFc+1xtiqBq1eEwqDAOyIN
         FE/TQMOVytP2exQwi6/tAXT+wKAqLErDmxMecG6Lga85P53tvqj1vXTgvO5rl1A6IyZ0
         14HCStNYpqlOXt6nTehp8aMLAiJqCsvHcvPNdYkjIrIS3kozFBNMmcXzgXCrbjqELDNT
         LYog==
X-Gm-Message-State: AOJu0Yzd63XTVT60NEbmTtDq5s88Jai+GrI2jYrTfRIvQE5Z6atHtmBG
	q2Awc6iDI4ETrgwY2BeXWs/IFeG0wqJG+qZ9m9mBk/+DOviuLw7Gl9a/L8/rM/ChkVdjOyfaNLs
	R/Fcw
X-Gm-Gg: ASbGncus1pfC1A+smviZJC3Ig5wD+0LtXekXGmAZFD8u2wbaU7CyolpkPEOycWlvp/h
	fXEu/O1bN67i3bnM4qvH0Zjpf9bGL4Kgov/wk9nbdTTNGL9t43DToontItA6IPu9RYYRjqtMGaQ
	o1E0SppmfhOxGpqR9LBs0LoP98Ln8cgH/nsqAVBsxwjYJH6y26xunTpD2aV/180jPpOBrzEM4VW
	DNLxfVNPpSotjNpg4jitpvA5Zx48Dh54k8F0pQ/pJH3u/VzC7xQCuMqgjUy9YEdzc3NsR9hR/QB
	OQf4tL5DDd3nfsgP/Q9D4dLmt3SpaT0vagnurP/HXFt+GS3SYG4owQQGeC6tUWKSZQyS7lJoXYH
	xyiPknQ==
X-Google-Smtp-Source: AGHT+IGCAL9ZiKorbhLFdFDPy4Pqp6/4pVlsCqxRexVlA4Lr0+mhQgOGNRi+wZg6MbUdgjndkuxFKg==
X-Received: by 2002:a05:6402:4407:b0:604:e82e:4bd8 with SMTP id 4fb4d7f45d1cf-6056dd3961emr14244926a12.11.1748943422662;
        Tue, 03 Jun 2025 02:37:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-606af7bafedsm779334a12.57.2025.06.03.02.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:37:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 0/4] serial: sh-sci: Backport fixes
Date: Tue,  3 Jun 2025 12:36:57 +0300
Message-ID: <20250603093701.3928327-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Commit 653143ed73ec ("serial: sh-sci: Check if TX data was written
to device in .tx_empty()") doesn't apply cleanly on top of v5.10.y
stable tree. This series adjust it. Along with it, propose for
backporting other sh-sci fixes.

Please provide your feedback.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Move runtime PM enable to sci_probe_single()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Increment the runtime usage counter for the earlycon
    device

 drivers/tty/serial/sh-sci.c | 97 ++++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 18 deletions(-)

-- 
2.43.0


