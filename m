Return-Path: <stable+bounces-210280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A464DD3A1A1
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7FA3304B3DC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34A33385B5;
	Mon, 19 Jan 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIxD5D5h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2A33ADA9
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768811164; cv=none; b=Yoo/6I8NgFvymRdO6mqYDNMblNrXLBTTItwUttJOJUSD3FlYZNF7ObvMV5avKA+fLSi34eLo2PwJlV3Nzl1Odlh5eplL9f6zC9Gkrxvx5tOl6qMRDXfYctiq+nBFGGfAEWQIMjCPRlkn6Bza8CWLKVSXQEvFquWAd7XaCgpmj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768811164; c=relaxed/simple;
	bh=w8UP13amm384XzZzCwddmrnWJmCBemyZWN4IAg9GFDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbKP8tWfVze9URPSWxFCMXntZ48qaqEf8ZuVU3PgFy2Y0RsmLm4s7UueQuDXw4aD+OUsDgQe/VS3IVZBjuKmyZKG39ebRzCWeiM389y8INJc2BrUhwThU2Ywa18I574q8Szz7b9z5sv8pf00yPpjj3mXhNZa5+lOJtfTYfnuQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIxD5D5h; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0833b5aeeso41642155ad.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768811160; x=1769415960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGF3kXNpuFGfHRZ/a4i+Y3oSMznaAZtKKSwOANieht4=;
        b=TIxD5D5ho/i0fVkwSu3crfT+G2sc94WKEkUTu9XyLloE1DKE2vEeSUcy6abgBKp8B4
         cafaB5xGlSicP/L86qFJRdwXJHGwxdRtoHsvyyIIrU2te1Nd8N9rO8iHPIQBmwnSL4Ef
         tah9avOGSFQ0eVdRooul5KLJA0NfVTO1UA11PjYpnOBAQPlwb8eYEtcGORJ9N38OBsik
         trkNP9Ngp2rBLnqyyl+bVbsNMueDzJaHHNlcKR5gIM8TYoFoP0g+FEnI8fKgYMp+n0MM
         fEG4P+M4/odq/6cYjyA8ITTYV4bRYHN8Lm0kORmeF81JOEGoXsfWfmwimOVZYYufK6kN
         dtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768811160; x=1769415960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGF3kXNpuFGfHRZ/a4i+Y3oSMznaAZtKKSwOANieht4=;
        b=qWfDkd0CY//Gl7vMNtbeSHjBa6k8yQgXHlLOKKVUx16qTePI1l/sY3o6TZih1KQ2Qz
         u4wRzUSpAINNxEk+C2wXJDG8RaccWDgOlG7QWk43sMCEn5G1wBiQjdLUlnqL5SFF7TsF
         Mbod8YahNImc5el1rzGS2psYSH0V/bxdo0+yKig6d+NFkR5eg686w5rvz1+11TYM5OCp
         hqzwg51MJu26zhkfLe4a7cPNUFIz2+LNs0oRYktCRQF/dUZD2unHzsU2WGWZNGESqjuc
         n9uVZt8Y1G1hX3olnOwgloebUTuJXB8fuofCx8wDV7UZhBdJhhPYEmwqPXFgShFfjJVJ
         +V2A==
X-Forwarded-Encrypted: i=1; AJvYcCX1l8N/0dbasdu+ycz71AN0Da55OIG7XNQ9M1wslobTvWMVt6X+KlBnPowwJBSCyBK+wHY2WrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZn79EDOBBU+XLbecZu86QSTxafrfAHQYktM0RMykDF727J/lv
	3+zNjiblhBJQxzf95HGOw+0HJ+4L6qQfgnDLDhV+dJZ9gaTHeoJfKGGb
X-Gm-Gg: AZuq6aJIZSPD5MFpYiygpgjOQM7XzNooFiFfgUI6zfqkTLk82JzR+IbuUUz4brnl4kK
	5xYUNwKgn8dxVx1PRY1a0OHzR/fxeabeshCfwD/Ox0thvpUN0SkWZL8P+aqifroDTTs0pMvAlA3
	hus3Xf+9sYL3t33iYax/qBd1IZ5eeGxcboTM+RIl226ebri1msuFl4stce7nt4hXQ30Cak9yYxC
	qUI+l2ycaghqPyotZfI69WMJDs9JxydlNtwiL2u/Lee263R1l9XMnt1yS313LuDKvtLVE7cznqS
	8q8h1UqVxxyQcj297kQ2frj5S8bger2lzzRYC5tP+uo43jIqlAM7HTMnZ1mzXwufbrFt/e4dR0g
	oU5XbLmC1Ktc5z48fLLNP3zyDfiwvgOVVdXfYWIsSJUGuTrJQUmWZAEzbmOYnBigm0aVkC7rwad
	QSCg7FLdkqm2HMw/jfut25clxR6yoMGl0OtYbRb6d/1i+KugO9
X-Received: by 2002:a17:903:2282:b0:2a0:de4f:cad with SMTP id d9443c01a7336-2a718954195mr91095305ad.60.1768811160125;
        Mon, 19 Jan 2026 00:26:00 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce534sm85699645ad.27.2026.01.19.00.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 00:25:59 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 0/3 RESEND] drm/exynos: vidi: fix various memory corruption bugs
Date: Mon, 19 Jan 2026 17:25:50 +0900
Message-Id: <20260119082553.195181-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a series of patches that address several memory bugs that occur
in the Exynos Virtual Display driver.

Jeongjun Park (3):
  drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection_ioctl()
  drm/exynos: vidi: fix to avoid directly dereferencing user pointer
  drm/exynos: vidi: use ctx->lock to protect struct vidi_context member variables related to memory alloc/free

 drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 64 insertions(+), 11 deletions(-)

