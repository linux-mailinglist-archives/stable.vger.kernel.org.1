Return-Path: <stable+bounces-253795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFhMDHlgEGobWwYAu9opvQ
	(envelope-from <stable+bounces-253795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:56:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF03C5B5A02
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A56083109E93
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 13:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB253BB69A;
	Fri, 22 May 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfYe2Dbu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049313BD62E
	for <stable@vger.kernel.org>; Fri, 22 May 2026 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456643; cv=none; b=rcJLWSDCpkepyksiRYq68zPL47UplZoqtRZtBdrqo/ZOo3+YxXISSrHPxtLNDmppkN29oZn0erIlN1x3ALFIQatjd+KvRHSkhhP9de+y5n/Tyhg7jX47/affv7SoyU6u+6PuN504akBqhcoZcEO6kAIgeONwBEBrSxiSA1tNy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456643; c=relaxed/simple;
	bh=50z5aLe/utRyMRS+DG9tTAyot6zu9u8aqp2TcBzvdwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2+9xI9UjuPS0Vm4eyGH3J7YBAJY5xzgVG1y41ICzyWZ20Sdoyo5d5ySJyWsdz3+owXgnRXcj/ip146hmVUGLmeI/YQkaxH8krlulmGJdw+Le/NHPjTNDEPbz5n+55YMbuuQx9H7SsBe/3dkESRzyPJWR0wyKN2GwHuO/1NvrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfYe2Dbu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3698e34a567so6449782a91.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779456641; x=1780061441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCbc6evCAnW5/Lk0bejiMZ9J5LObQXJ3ouBPH/v5c+8=;
        b=XfYe2DbuB34FZb8SQXY4wpNoPLDesRoVUR4xPnZFLs+eQ8DA7SpBzNDsFTUJaZHzGf
         zFUsoIN30IGqV7ub0vN382Zq84aLiW50NcxLuJfg4kgQAkTiXQIj0ZWd5mVi6Tqz9V7t
         T+roTdbpH3NuvqWQiBBdtiUSvNcSEtJwRSr/JhCjlB44zrx1Z70Nb6zZXA3Pk516FK4T
         oFfUPU8aRjdm55ZBVGUOFkBgVMXOxwCLyBHbZkewiopcrfOV1KI/6W88Bg+kLh2kCiix
         lZzmCOoo5E42Bhh9Vbh3r1tCK8K0THHMWHRqcyuJKMlQPEeX+ZphLtZpVVgjQs5CzmZ9
         +IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779456641; x=1780061441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCbc6evCAnW5/Lk0bejiMZ9J5LObQXJ3ouBPH/v5c+8=;
        b=e0TmPM8MhauMVYrJu4ZPlKhF+OoIDxR2X9VlV30T87WzR4BUKiOgciwOFxGsY6BCnB
         0Gw2Rcp3Tqt46ysM6zHhMbUJi0zSNYhkK+lfO51MgUSjx5s7wA8AB4HQ9zxb5qLOSjSY
         dAWYev5vAgJDeZRkxijGRm14QjPbLsoXBx5xbBjj9y7/PcDAEtKxXXI1ZtQgi0QXupFP
         ++EaOLbGpB6CCnLvmWSIgHAiTaiLTNg+Nerbq/rgEVAtuvEvI1iD4SGqPYnnbdCvl/l2
         7xZ9ZCbyNzROxsd3Tx4ncUkqC7zn8nwUcQCRwpg6y2NYgv/ToZJQAoK880QqjzsT/QJC
         AUJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UuMZMPUjEwWhScRNgLGsL45h8TOWOBOqN78hMfUgUOQX+Yub+P586XaGIlB+MfuZfp24nQGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiCH7lmZC0TzK6MwAHKtI49dPTYYI6KU2J44kfgqv2RqEm5/v
	lcNhgDKJ8Ix/Fot1a5HX8aeksFemnwOMkkbo7vt/wqhLYehYZhg+QL/R
X-Gm-Gg: Acq92OGHcuVs1xRdVmwc2E57UoAlOn2W2nG3Lbo9Ggiw3tR3ZfGN5tLlz5Z7jQQZgDv
	wUQYFpGkNfeBcFVnS7r3PAOqeEfjzPU37bpzrDU8mZGqobnihdurjD2DEO/VLF3g7nFXq/PKbsr
	rRBro5QIXBTgXJkmxMsh8NXiNXLFioExkABl+j4C7ce4gSpZLW7QQgbJj1fgm0j0nkJgibHbSO/
	6LbaWVAtLu+s0JYLu3AHZ3wBHCAfMQrkhr35u8SIAK9Ojlr9fTm8fVgHzoDnDQoGf4Q9uLMropg
	CWtTdNQKyC8GutAf2gYh0jHeGO9qSrzrcIqsrP9hV5f79kiRSh3CQW4Q8xgCOGo+H+E8masc19r
	pH46koii8xZBDJxmykkjR/n99Jzhg63kgFX3FPI17KDjfKDqsN+i8+8sbcn0s2u2dgE9Vm7Jqj+
	0JBLZdIRjqYiTxkSBaAwmgMOR222MaRPly4zWl2+kl0UsatjkBPniQGOTzjHtQwCmIjZn6B/FpT
	HwbJ6I=
X-Received: by 2002:a17:902:ce84:b0:2bd:3bfd:74f2 with SMTP id d9443c01a7336-2beb0593137mr38054985ad.10.1779456641134;
        Fri, 22 May 2026 06:30:41 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f05sm25147605ad.6.2026.05.22.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 06:30:40 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	laura.nao@collabora.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: mediatek: mt8196: Select REGMAP_MMIO for vlpckgen
Date: Fri, 22 May 2026 22:30:23 +0900
Message-ID: <20260522133023.355404-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253795-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,chromium.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akkun11open@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AF03C5B5A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MediaTek MT8196 vlpckgen clock driver uses
__devm_regmap_init_mmio_clk() by devm_regmap_init_mmio(),
which is defined in drivers/base/regmap/regmap-mmio.c.
However, the driver's Kconfig entry does not select REGMAP_MMIO.
This causes a linker error when REGMAP_MMIO is not enabled.

Fix this by selecting REGMAP_MMIO in the Kconfig entry.

Fixes: 2f8b3ae6f0cb ("clk: mediatek: Add MT8196 vlpckgen clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2c09fd729bab..fd8440122ec2 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -1006,6 +1006,7 @@ config COMMON_CLK_MT8196
 	tristate "Clock driver for MediaTek MT8196"
 	depends on ARM64 || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
+	select REGMAP_MMIO
 	default ARCH_MEDIATEK
 	help
 	  This driver supports MediaTek MT8196 basic clocks.
-- 
2.54.0


