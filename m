Return-Path: <stable+bounces-37134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ADA89C379
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD7C1F21DE4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75286AC2;
	Mon,  8 Apr 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1q1pjyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC17D401;
	Mon,  8 Apr 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583346; cv=none; b=dx+mgpIH5HgzdCMfQRq4qakqVCo/+RKhdRJnQ1lVfMPBVuuy060+Rpf3tRMJ3fqn+GP5cd+Dlom/5fjF2uOMBTorpwpCF0N+5C5IuHmqhcGvjT5VUqXkV6PqolNMpDmipWZVGQs7lXPJYhqBMBDKKFVgoAbz28SbBYgogY08pOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583346; c=relaxed/simple;
	bh=g3IxR/V1WRB+ObeqX3zOi+My7XYKIzN14RrrdMyfKXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqVhsMnrCzrcdKNTD/cVRqsZvUc3jzFi/aCgmZ4pr3RIAgTX5Hdvx7bZhbT39zdNLnrvu2bpL1m/y3hiQPL9fcql2ddiF2Mwx57rbbFvJy04yaG6I79B1EnC0kG+KPUX2xuNpeYgq+KNzgJ6qQssdzUCsdsbRlL5TSvqZ3ZARNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1q1pjyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C3FC433F1;
	Mon,  8 Apr 2024 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583346;
	bh=g3IxR/V1WRB+ObeqX3zOi+My7XYKIzN14RrrdMyfKXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V1q1pjyhBGNPoaysHr3Df0vInH2g6ZV4z6dLazDYu/G+XQmsHCIkM8dUHHF3bxF2h
	 oVDE2ko1tBb+MsTgma3gZOaKd8+UiATpeSX2xHla/AuauevWLxzgmqDPFpgvMYNAGx
	 5Ujele0hp0r/e2qQgjARXGCTeQ8jrQ+eN+WnySOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 184/252] ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
Date: Mon,  8 Apr 2024 14:58:03 +0200
Message-ID: <20240408125312.375958017@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 52f80bb181a9a1530ade30bc18991900bbb9697f ]

gcc warns about a memcpy() with overlapping pointers because of an
incorrect size calculation:

In file included from include/linux/string.h:369,
                 from drivers/ata/sata_sx4.c:66:
In function 'memcpy_fromio',
    inlined from 'pdc20621_get_from_dimm.constprop' at drivers/ata/sata_sx4.c:962:2:
include/linux/fortify-string.h:97:33: error: '__builtin_memcpy' accessing 4294934464 bytes at offsets 0 and [16, 16400] overlaps 6442385281 bytes at offset -2147450817 [-Werror=restrict]
   97 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:620:9: note: in expansion of macro '__underlying_memcpy'
  620 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:665:26: note: in expansion of macro '__fortify_memcpy_chk'
  665 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
include/asm-generic/io.h:1184:9: note: in expansion of macro 'memcpy'
 1184 |         memcpy(buffer, __io_virt(addr), size);
      |         ^~~~~~

The problem here is the overflow of an unsigned 32-bit number to a
negative that gets converted into a signed 'long', keeping a large
positive number.

Replace the complex calculation with a more readable min() variant
that avoids the warning.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_sx4.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index b51d7a9d0d90c..a482741eb181f 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -957,8 +957,7 @@ static void pdc20621_get_from_dimm(struct ata_host *host, void *psource,
 
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long) (window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_fromio(psource, dimm_mmio + offset / 4, dist);
 
 	psource += dist;
@@ -1005,8 +1004,7 @@ static void pdc20621_put_to_dimm(struct ata_host *host, void *psource,
 	readl(mmio + PDC_DIMM_WINDOW_CTLR);
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long)(s32)(window_size - (offset + size))) >= 0 ? size :
-		(long) (window_size - offset);
+	dist = min(size, window_size - offset);
 	memcpy_toio(dimm_mmio + offset / 4, psource, dist);
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
-- 
2.43.0




