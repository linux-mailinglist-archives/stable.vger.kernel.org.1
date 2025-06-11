Return-Path: <stable+bounces-152375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3957DAD4A25
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D5A317A128
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957411D7999;
	Wed, 11 Jun 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VCscoTrk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22D2F509
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618060; cv=none; b=qZCzGuNecE/Paf+k892BlyaS+Br2EQ6LNdCyKEH1yjFnKj54hSMLMmwA3N/XfmNLKk23jYJXEI8BI9VS9BX2TBG2N0MqMDB8mTmLqOLyfafZptOg7XztVwgIgasN7RxoDbUxIA7CMwmWL786ieMlS7pGAVftZ1m3lYBanx3Hh6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618060; c=relaxed/simple;
	bh=dZgbd5VNbenfed93s6UuvD46YNWULLE8qYGcEaOzscw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWzmyOGdsDvNSi0S8mbxVESAdZ+uYipRiva2O6fl3y2UAYd3n2ZocbR+wclDoJOZol5YBcEX43MNgZ9WtoHwA77hrxRPOdxFldGafr+ejwuc9TZzUVuLsrbuaslAI2SDB8hSQAf5pTrYpnL0AuE91GNAARB+9+4GN/6ZvB28r+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VCscoTrk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so5191684f8f.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 22:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749618055; x=1750222855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rz50O4tFPfOsIoY+ElVL4w6KOi16FpvJLTsGkNiubU=;
        b=VCscoTrkq6V52fxI6tP1Ta0eWZuNv2n5HotUyDXxlg1eKdrfeduGnKiTC+X6rPPjGo
         S6utR3HZ85lU4j2QvQTA5aDcfOgRth0trU1FWlUYwjUsDJNdDLSe66KtOi4Wnj/NB4+x
         /lVt5ZW+s0dx64cX/vCNjVWMD/E6BwRLySPP4cFxBYWD4zIGlU/IMa3rI3dteAoN7mH7
         miQXZ5nzHx8InSo3ST9EuMQMENGLF5fSW6sM92IlQIKLzOYQ6DwWs0d9UU/VSSJx2h3p
         1CA+CeBVPQQBTvNcKKd7qyBpi5eqx9RYqhrpz7mDgsjkTMbGIgGYi4mfddLNs1nEnqWK
         Gqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749618055; x=1750222855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rz50O4tFPfOsIoY+ElVL4w6KOi16FpvJLTsGkNiubU=;
        b=qnmkuiW/XoNMnZQutdjjgpWnJ1n0E8RpeeN/yKdrOosTDj1dB7A4haOsKwnyJ/m+yF
         cj915bcGsIF3Uovu1ZvGCVwnKzZ9xghX4IAR20JebxCQQPsg5pkPW3HsO/0XMmRHpG0g
         W0qTeR4bR3AA9R4Q4UceR+XSeCw3OQGRc4+q5hRhVqIYseBwivm4vSzx+WnVEtFrOwKJ
         B+44B1X/zze+ge/BdD8rBRjXVDQHip5TFvbuLpYvSi0pI1i1IvsLOwergvBLwNwjjKhW
         tAE2BHSwq89ampT8+HD+Lq69HWDEosxw0h9YnURgqso2iHVEOdPlYvMUvmF4+6g5nizK
         G4pQ==
X-Gm-Message-State: AOJu0Yw/vcJ3B3WpHF3YPEJRMiqS2u+G2cTQdllGtxpGdYFnIQrtRJtQ
	Ow3ahmpHsawUYrugXdxrtRYp3dB19LLgJ6jEOi+qvRC599u6xCaffj7DqSO38dPAOLlsRJSLVPE
	5mT5b
X-Gm-Gg: ASbGncvQEDV3HaS4LJsVIzQwxnv9DV/mOcjRIUJSgsXK67whoezU8X1xGAPogv/2n1W
	zRwZ9ozeo8YShBeF4LkSPM9DvmshccFM1F2wTR82bsRcqVKYPKBPIA0TdCcBdoM9s9ss2lWgKAe
	xNP87soId4sGgpFEI1zPRNW8rBI8Pm6vOPz5HTN512u96WOE9IFlM27mwuGt4OjroCQWd0c/MTC
	eB8b3tdklUqrp8seDc7C+gGYN8Ce2cc8VXq4gT4StjSoTL7z/bYPhbs/Az9QFFLkl0empok5MUq
	yP4UQWbu5aEs2PXXlFR3eXYkNVelvCtdNfeKIEwEZ7MjAMswl0xD0drHNBOmOKb3QfqVdxGnLxB
	dQ0mAQXDgval70Fj+
X-Google-Smtp-Source: AGHT+IGN79ccPV+1IH6LPRwvfC/gY/OewyuuVDNXOxjkZS3qcmmjjtwOkXAHxk7a1B0gflVjI2Sj7Q==
X-Received: by 2002:a05:6000:4205:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a558a27a9dmr1155454f8f.57.1749618055566;
        Tue, 10 Jun 2025 22:00:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e3csm14252044f8f.99.2025.06.10.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 22:00:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH RESEND 5.10.y 0/4] serial: sh-sci: Backport fixes
Date: Wed, 11 Jun 2025 08:00:49 +0300
Message-ID: <20250611050053.454338-1-claudiu.beznea.uj@bp.renesas.com>
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


