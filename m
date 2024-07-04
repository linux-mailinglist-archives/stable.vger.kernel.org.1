Return-Path: <stable+bounces-58076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A396927A65
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2751328252D
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A6B1B14E2;
	Thu,  4 Jul 2024 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oQ2x3qwm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F91E861;
	Thu,  4 Jul 2024 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107942; cv=none; b=JYf/mUStkLO5LfV4fSZ9Y/PV19DV/Jce42l3UFw93/RXTppJvPHudORb+KTqTuUrCzSYebnl05pBhPbSPJg8R5D9LwPyaz7AxSoLChydLtj9IE98tZFjGt6+/Ykv9i+QYSAmaRC31B/75n/iVfRuUqoZT/zTL12HbdGtHyt0d6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107942; c=relaxed/simple;
	bh=egf/NogojxYlVhbIl36DFaMxrtmn9gD2oDV/ECsv8+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StNWviyFAimRClvAYMmTjymlwt1DQppLZNteV8aUjBbnauHLYV/ZaQ2gHOLzR6YzYwC1sMJfg4Rt7h+TihGBuz61OLCXstQ9qzVbXoYMW0dQ0ynPYX2w4JKUDDgKhu39bFOCyjPLZ1sbHR5p4bfpW5wGuh/nUkZFeXMtNvp7Yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oQ2x3qwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98762C3277B;
	Thu,  4 Jul 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oQ2x3qwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720107941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKo+ZyGaQ2EoSeO4/oIDVU7iVMp8bIw2iMxwxEC2mbI=;
	b=oQ2x3qwm1WACbQg8j0p1vcmrlVqYZx2Fp7ILKojgUgtX8nWj++ozTUF0fO50JkyT4xSVOa
	8MreIRzXF5i87DjeU1Zn8jseSm8YpKeTF3lqiNclBAwyTPy6tCMVR43HS0aeiOjwo+Lk4F
	mNC/KFlzLUXeKffqWn91j+8QOvm0pVM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 66ec19bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 15:45:40 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Helge Deller <deller@kernel.org>,
	Helge Deller <deller@gmx.de>,
	stable@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 2/4] wireguard: allowedips: avoid unaligned 64-bit memory accesses
Date: Thu,  4 Jul 2024 17:45:15 +0200
Message-ID: <20240704154517.1572127-3-Jason@zx2c4.com>
In-Reply-To: <20240704154517.1572127-1-Jason@zx2c4.com>
References: <20240704154517.1572127-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@kernel.org>

On the parisc platform, the kernel issues kernel warnings because
swap_endian() tries to load a 128-bit IPv6 address from an unaligned
memory location:

 Kernel: unaligned access to 0x55f4688c in wg_allowedips_insert_v6+0x2c/0x80 [wireguard] (iir 0xf3010df)
 Kernel: unaligned access to 0x55f46884 in wg_allowedips_insert_v6+0x38/0x80 [wireguard] (iir 0xf2010dc)

Avoid such unaligned memory accesses by instead using the
get_unaligned_be64() helper macro.

Signed-off-by: Helge Deller <deller@gmx.de>
[Jason: replace src[8] in original patch with src+8]
Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/allowedips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 0ba714ca5185..4b8528206cc8 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -15,8 +15,8 @@ static void swap_endian(u8 *dst, const u8 *src, u8 bits)
 	if (bits == 32) {
 		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
 	} else if (bits == 128) {
-		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
-		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
+		((u64 *)dst)[0] = get_unaligned_be64(src);
+		((u64 *)dst)[1] = get_unaligned_be64(src + 8);
 	}
 }
 
-- 
2.45.2


