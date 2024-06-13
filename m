Return-Path: <stable+bounces-50979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103B906DB7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EC2286B16
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859EA146A65;
	Thu, 13 Jun 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XuhdQJto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EC51465A5;
	Thu, 13 Jun 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279950; cv=none; b=YIHSjmAi92OiuD+tZM/Tl571te+ARdrR9f6/okdnAXHCW+qOntriSo0LByApVgPjG4hgIc5wrrzheGC8+k2ZwQRa2Go1NPTVmPte+cm90EEd2f2NhCDYAyhax2CJZ8YlpMHy8ttTguBcSn0T3CZu6AoleykTcFlcK3WgBdndP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279950; c=relaxed/simple;
	bh=FVI5Wn8ZvtmMrTB/qECVPMqdDxsgT8+DPOFsDjJuOF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2QFMVje8ww5JUfuQJKDbKE4cM8/dZwj5YKacIHdGZK6QOZisD4nfTzc7r7Eqv2WxGVptvLxj0bymenCBO3JI89rmCojMTteoIZKMeQzQq6BJqjujnuZZFFtugNvHAAs3GgDs8AfzcFuhU/75lx3Oqi0H7fikyszZaO5SnJC928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XuhdQJto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0245C4AF1C;
	Thu, 13 Jun 2024 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279950;
	bh=FVI5Wn8ZvtmMrTB/qECVPMqdDxsgT8+DPOFsDjJuOF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuhdQJto+AVd+h7i7a9iOJ7WjHtnY866wmO9baZICW5UAoPUjdJo8Q1xR2gGmhzpY
	 3UHFmnzcWRbWKvOaFmZ6WKWH9w/mZ0VQpJZ95TuUCNmWUo1TP9JF3ilGjqCb3ySQ1c
	 3plp70LTPXGNtLL+qM7lhqRLqOcYQcrI1SUY/jJ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>,
	Stan Johnson <userm57@yahoo.com>
Subject: [PATCH 5.4 060/202] m68k: mac: Fix reboot hang on Mac IIci
Date: Thu, 13 Jun 2024 13:32:38 +0200
Message-ID: <20240613113230.093248570@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@linux-m68k.org>

[ Upstream commit 265a3b322df9a973ff1fc63da70af456ab6ae1d6 ]

Calling mac_reset() on a Mac IIci does reset the system, but what
follows is a POST failure that requires a manual reset to resolve.
Avoid that by using the 68030 asm implementation instead of the C
implementation.

Apparently the SE/30 has a similar problem as it has used the asm
implementation since before git. This patch extends that solution to
other systems with a similar ROM.

After this patch, the only systems still using the C implementation are
68040 systems where adb_type is either MAC_ADB_IOP or MAC_ADB_II. This
implies a 1 MiB Quadra ROM.

This now includes the Quadra 900/950, which previously fell through to
the "should never get here" catch-all.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/480ebd1249d229c6dc1f3f1c6d599b8505483fd8.1714797072.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/mac/misc.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 90f4e9ca1276b..d3b34dd7590de 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -452,30 +452,18 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II &&
-	    macintosh_config->ident != MAC_MODEL_SE30) {
-		/* need ROMBASE in booter */
-		/* indeed, plus need to MAP THE ROM !! */
-
-		if (mac_bi_data.rombase == 0)
-			mac_bi_data.rombase = 0x40800000;
-
-		/* works on some */
-		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
-
-		local_irq_disable();
-		rom_reset();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
-	           macintosh_config->adb_type == MAC_ADB_CUDA) {
+	if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	    macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
+	} else
 #endif
 #ifdef CONFIG_ADB_PMU
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+	if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
+	} else
 #endif
-	} else if (CPU_IS_030) {
-
+	if (CPU_IS_030) {
 		/* 030-specific reset routine.  The idea is general, but the
 		 * specific registers to reset are '030-specific.  Until I
 		 * have a non-030 machine, I can't test anything else.
@@ -523,6 +511,18 @@ void mac_reset(void)
 		    "jmp %/a0@\n\t" /* jump to the reset vector */
 		    ".chip 68k"
 		    : : "r" (offset), "a" (rombase) : "a0");
+	} else {
+		/* need ROMBASE in booter */
+		/* indeed, plus need to MAP THE ROM !! */
+
+		if (mac_bi_data.rombase == 0)
+			mac_bi_data.rombase = 0x40800000;
+
+		/* works on some */
+		rom_reset = (void *)(mac_bi_data.rombase + 0xa);
+
+		local_irq_disable();
+		rom_reset();
 	}
 
 	/* should never get here */
-- 
2.43.0




