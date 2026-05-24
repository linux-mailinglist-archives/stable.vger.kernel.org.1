Return-Path: <stable+bounces-253995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCODFjOKEmqW0gYAu9opvQ
	(envelope-from <stable+bounces-253995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 07:18:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A95ED5C16E9
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 07:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF6D300DE1C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 05:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E72D238F;
	Sun, 24 May 2026 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULfkOLEY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832F299943
	for <stable@vger.kernel.org>; Sun, 24 May 2026 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779599918; cv=none; b=CIDFod067hPHRYLLeTKmHwsXA0ECNkQF1VMLadX/MYqHe3P2X9WygxfLcX5dkeGnQNKK0H1KmPIuttkPvB8EWCJtL+TKq99eQc4stCpo0rgBfGYMLl0f/O9wb5FrqFhKTjt/eh3cVHTw0E279TAvQGG3AiuR/ecwvPuFg1mjGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779599918; c=relaxed/simple;
	bh=74V5/qnX5ZiqaQXKLlwAmqpBz8ey/SBUPUeXRx6fKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WfqH31cbIY43noioeUGUsAetfx8ZVaE+hDNl6dFYU5yeLVoDGwFbnNa/XtxkoPBK4SoVKk3SmIGNIc2eTKf+P8QfCYTcR0E69yh+Sw+pByGhm4b9L75C7sNf1UiakuPkigGJDTqDuI/sj3jxvnJKz70ZqTDIwelSkaSgLld0a3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULfkOLEY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36622412e97so6480763a91.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779599916; x=1780204716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qirud4yg6ff64Rz1Y6X2KitE2QcTgww2RA7TfD1h/wM=;
        b=ULfkOLEYcUu50+cm1GeyGnvClgfgUPfnkDiHD0Q0jvwmWsfEcjxzya7mnRdM6MSTfw
         RGAognYtxWcfbxSp79szQMKfopdqADJMdpeGy1D8IQI260JGC+WF1w2qlwgH8LJsOckS
         nln+UB2e3YDOxbqoKwgAxylAB4C68Bq8CZuooVFKyHvYjBoXreexXNvQeUIrytHF0UN2
         +Y78lpbCVmLYDzwuX9GINc0gLOdNNDP91P+JQVfPtgwJxtY6nJoldp64/YGApbl1lfd/
         egAJVOM9pRgKdat8cgyMIpGcPbkavat2E08wKSz98t+qmZHOz3V88xiiaAgYYaA3WiiT
         7tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779599916; x=1780204716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qirud4yg6ff64Rz1Y6X2KitE2QcTgww2RA7TfD1h/wM=;
        b=kemhGEbtw53VdkExc3YXU+huALqZRdMP2oYVGPn7k4T3eFfBW0Bznh4c+JpuNohVbt
         0mx0QzjYI7jOEEYIUdlxO7uF2w/uFKCznvtR54l13sxBRt7PUKh892JnXK36MxRrhOCx
         dnuMgO/1nfh7LofKliOoiWr/88ycOartjhuojYnJ4voFrIPrYHo3sXbxoZj8QMunw7TQ
         Tq6qvlRquT35yyM641/SvhQtUYBryAeKhRCWV9jihLBL1ywC2qgiJuEcMeT9FT2R+4fT
         QgktZgrHtkizeRX8ZSmU95zp5Z2p2TB7Zrf5umngr2VaMWtLcN2/QknNm6tWFwdUVLrp
         CpqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Di4+mYKTrwdIteeu1dGiOYGTyLIsx8WKEGkhfuX3n/3ZV412vIC2kE61/e4kw9YriSaqNJC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXUc2DwWf1wYIYAMhwCgAbRy3zH8mnRnqmZiR6sZQfSRuUHzb
	nRQbyAgtds6rVfy2zet/mRjLdfKkS11njuzE4kYfRb8hPy/ACySUcQau
X-Gm-Gg: Acq92OFcx4y9HCw09VV6jiqA8+vUYxBdEXjSatzCw8KGaB6tFBMEfualIK6einZoNN5
	DpldC0h8rsvuN3QKEK8UmcFyM9wUmbfFk5qUL5rSXrspzEqWo9VLKucIsx7s4An7n0tjA1jNgmJ
	eLL8t7trAWx9oHp6NDNlde8VVMsyvxu8PnGcADaLYDZz4bn4pYdcbzaXxaLx74D1ZoCKPQDN6xp
	XwU76/mj9AbrEclAhCmkeWk8CaI9GyCw8sEt2imWy+WbGvmY0uSCFycKmaUd9ttH5Z3xuB301lk
	Yl+KUBhMgLHZg7mPrqAQQfL7rs2oXIat01ln2albeKhq6fA1PucqCKBfNJAtPigojmEKyt15y2G
	6Z/VBZM0yWaQFLPaoPZGD5d9A6u2a8nTfWhShH2+RApGbENd3jT+svx2HbgijWOk+4JMfZDi5pD
	dKMbziPbji8ndRmFzTW5hHqfvaB6KZhimJQRKKvSZKU4LK+mT9CNwj846KcdTLmJsjvzxTSavbw
	twZPE0uEi0az2VaQ/obcSnzxPfU2ly24xFyv/ZbbCzy/GdMv2mwFl6n/LyQxeCRY/Z79JOqe/YF
	OKy3HJgYHDWgxco=
X-Received: by 2002:a17:902:f549:b0:2b2:6df1:1112 with SMTP id d9443c01a7336-2beb07757ebmr102149795ad.40.1779599916185;
        Sat, 23 May 2026 22:18:36 -0700 (PDT)
Received: from codespaces-78f0a7.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56c4f8fsm59058805ad.26.2026.05.23.22.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 22:18:35 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: robh@kernel.org
Cc: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	tzimmermann@suse.de,
	Frank.Li@nxp.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] accel/ethosu: fix integer overflow in dma_length()
Date: Sun, 24 May 2026 05:16:58 +0000
Message-ID: <20260524051659.70654-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[tomeuvizoso.net,kernel.org,suse.de,nxp.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253995-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A95ED5C16E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_length() computes the total DMA transfer length as:

    len = ((len + stride[0]) * size0 + stride[1]) * size1

where len and stride[] are 64-bit values derived from user-supplied
40-bit command stream fields, and size0/size1 are user-supplied u16
values.

The final multiplication by size1 (up to 65535) on an intermediate
result that can already be ~2^55 easily exceeds 2^64, wrapping the
u64 result to a small positive value.

This wrapped value is then stored in info->region_size[] and compared
against gem->size in ethosu_job.c:

    if (cmd_info->region_size[i] > gem->size)
        return -EOVERFLOW;

A userspace caller can craft stride and size values so that the
calculated length wraps to zero or a small value, passing this check
while the hardware executes a DMA transfer with the original large
strides, accessing memory far outside the GEM buffer.

Fix by replacing the unchecked multiplications with
check_mul_overflow(), returning U64_MAX on overflow. The callers
of dma_length() already treat U64_MAX as an error sentinel.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/accel/ethosu/ethosu_gem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 5a02285a4986..1f132611a6ce 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -2,6 +2,7 @@
 /* Copyright 2025 Arm, Ltd. */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <drm/ethosu_accel.h>
@@ -165,11 +166,13 @@ static u64 dma_length(struct ethosu_validated_cmdstream_info *info,
 
 	if (mode >= 1) {
 		len += dma->stride[0];
-		len *= dma_st->size0;
+		if (check_mul_overflow(len, (u64)dma_st->size0, &len))
+			return U64_MAX;
 	}
 	if (mode == 2) {
 		len += dma->stride[1];
-		len *= dma_st->size1;
+		if (check_mul_overflow(len, (u64)dma_st->size1, &len))
+			return U64_MAX;
 	}
 	if (dma->region >= 0)
 		info->region_size[dma->region] = max(info->region_size[dma->region],
-- 
2.53.0


