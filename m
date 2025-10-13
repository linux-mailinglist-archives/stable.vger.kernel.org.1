Return-Path: <stable+bounces-185126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C2BD486B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA727346CE1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BE309EE6;
	Mon, 13 Oct 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKaiiE2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD02309DC0;
	Mon, 13 Oct 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369408; cv=none; b=azF828izdhWE40fOi1RVqdhnII4sNa8HhDqjyQFtSO3jgo56lASSmsb+8BQMxY6Luvi9l/gyjHsgv94wM5wCxerlpvbnztJ3O1Ct3mGE3PGOXecrWRPsqhVaUmzOvlh5lJRgg/PCZvSDc5pIgSFeaoDxxsKeHcifuoLp55hxsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369408; c=relaxed/simple;
	bh=F5wS2Of/fBtGjtZ5nXZh9/6YlGl6Yn86XzXyYXR5vkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtJtxX6XMBfUqh+snS/VvrJ/9lvmoAN+b1JlAYOFiNvxh6pNuW+YijlFAPKhQyTHJjWGfEHLk6EAkKU2FXguBUgRtlc76DWGnII+BCGp2G5+aPzugHH2Tt9OCEWUMvYNsnVf8NBJvS7kWTNDczs/MduqPnOxAZFi5VYyxxtIGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKaiiE2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79507C4CEE7;
	Mon, 13 Oct 2025 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369407;
	bh=F5wS2Of/fBtGjtZ5nXZh9/6YlGl6Yn86XzXyYXR5vkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qKaiiE2U6LejIhfJ5s9QL1rmQvOUm9ya+aKBLEGxgQVMYsSZGaZLDUI1Rke/XHzEq
	 YfaM3RlhP1HN8y019xqx3UhEX5BEugyRNVBjBFApNoIomZqKT1midZ1OZ4Quq0c8DB
	 UjuS/YTyVmAoRwRmObQurxhOMUfYXq3iDJlMsQfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 202/563] i2c: spacemit: disable SDA glitch fix to avoid restart delay
Date: Mon, 13 Oct 2025 16:41:03 +0200
Message-ID: <20251013144418.604959523@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Troy Mitchell <troy.mitchell@linux.spacemit.com>

[ Upstream commit 11f40684ccd84e792eced110f0a5d3d6adbdf90d ]

The K1 I2C controller has an SDA glitch fix that introduces a small
delay on restart signals. While this feature can suppress glitches
on SDA when SCL = 0, it also delays the restart signal, which may
cause unexpected behavior in some transfers.

The glitch itself does not affect normal I2C operation, because
the I2C specification allows SDA to change while SCL is low.

To ensure correct transmission for every message, we disable the
SDA glitch fix by setting the RCR.SDA_GLITCH_NOFIX bit during
initialization.

This guarantees that restarts are issued promptly without
unintended delays.

Fixes: 5ea558473fa31 ("i2c: spacemit: add support for SpacemiT K1 SoC")
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-k1.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index 84f132d0504dc..9bf9f01aa68bd 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -14,6 +14,7 @@
 #define SPACEMIT_ICR		 0x0		/* Control register */
 #define SPACEMIT_ISR		 0x4		/* Status register */
 #define SPACEMIT_IDBR		 0xc		/* Data buffer register */
+#define SPACEMIT_IRCR		 0x18		/* Reset cycle counter */
 #define SPACEMIT_IBMR		 0x1c		/* Bus monitor register */
 
 /* SPACEMIT_ICR register fields */
@@ -76,6 +77,8 @@
 					SPACEMIT_SR_GCAD | SPACEMIT_SR_IRF | SPACEMIT_SR_ITE | \
 					SPACEMIT_SR_ALD)
 
+#define SPACEMIT_RCR_SDA_GLITCH_NOFIX		BIT(7)		/* bypass the SDA glitch fix */
+
 /* SPACEMIT_IBMR register fields */
 #define SPACEMIT_BMR_SDA         BIT(0)		/* SDA line level */
 #define SPACEMIT_BMR_SCL         BIT(1)		/* SCL line level */
@@ -237,6 +240,14 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 	val |= SPACEMIT_CR_MSDE | SPACEMIT_CR_MSDIE;
 
 	writel(val, i2c->base + SPACEMIT_ICR);
+
+	/*
+	 * The glitch fix in the K1 I2C controller introduces a delay
+	 * on restart signals, so we disable the fix here.
+	 */
+	val = readl(i2c->base + SPACEMIT_IRCR);
+	val |= SPACEMIT_RCR_SDA_GLITCH_NOFIX;
+	writel(val, i2c->base + SPACEMIT_IRCR);
 }
 
 static inline void
-- 
2.51.0




