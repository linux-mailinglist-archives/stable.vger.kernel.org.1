Return-Path: <stable+bounces-43352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B208BF1FC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390371C236E9
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5455E14BFB0;
	Tue,  7 May 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ2pAqzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A314B963;
	Tue,  7 May 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123473; cv=none; b=YedJgDVVvlnOr0RWHIPlLVCdzZOMYVB0/UIBmXL3IgocQsIOZ5eFORqqT42Hn2La4h4TpZmMJA/IbZ/EJuXkRz4kuORzFleiqkIWHT4FLuacAfzRGcinWBcZ5/YPV7+6FkSNSBC73JPO0haEHRM3MoYJDAPuChlMe8G5V7/5ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123473; c=relaxed/simple;
	bh=xexA27Mt4oEuII0u/q/FpJT4grps7/6vevw9C19Zmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzhbklZJyvCaIADXBp+JifP4I7cS7rmlE8KO8XvwwIHBeJ1WHnICNZ+EGxgg1kqqu1AVZJAFhLegzwc/YI1HXDO4dyox1sVjdcIL8Bbrb4uWT3lM9z6+VfPwwE4bAW+V62ybozM9oywHfx4QX7pEkXcY8mfp9Zl5Banu1066uOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ2pAqzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9BFC3277B;
	Tue,  7 May 2024 23:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123472;
	bh=xexA27Mt4oEuII0u/q/FpJT4grps7/6vevw9C19Zmiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJ2pAqzVR4KefxGVnGNNe+ujbhAz10ks/ahvO2CMlY4cs8bVaaOsEIgPgR+3setbo
	 6suXHRhPcWx4up3wy91TW0gP4QhGgjksA7UB3IgMtj/UmV65oCM9o8RMHHvAPIqCG8
	 8PWSrbTMmtuRDrBlBjy0T644nYby5Xf9kVra0zshWQgi1+OlsEh5vWvGYz1NeLb0B6
	 ompYo7/6sUjn6bNF4MR7x92zNQe8933t8dYCcCBedD2KA6tgftbekmmpk9sZJeiTcC
	 CyVSFLMOeJn/rSk7eRMIXSyiNfC2jB2VayL4euvopk8As70QAUX9HHxS/J7xhYrzSg
	 jdM7iPAXbti3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/43] ALSA: emu10k1: make E-MU FPGA writes potentially more reliable
Date: Tue,  7 May 2024 19:09:41 -0400
Message-ID: <20240507231033.393285-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

[ Upstream commit 15c7e87aa88f0ab2d51c2e2123b127a6d693ca21 ]

We did not delay after the second strobe signal, so another immediately
following access could potentially corrupt the written value.

This is a purely speculative fix with no supporting evidence, but after
taking out the spinlocks around the writes, it seems plausible that a
modern processor could be actually too fast. Also, it's just cleaner to
be consistent.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Message-ID: <20240428093716.3198666-7-oswald.buddenhagen@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/emu10k1/io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 74df2330015f6..5cb8acf5b158c 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -285,6 +285,7 @@ static void snd_emu1010_fpga_write_locked(struct snd_emu10k1 *emu, u32 reg, u32
 	outw(value, emu->port + A_GPIO);
 	udelay(10);
 	outw(value | 0x80 , emu->port + A_GPIO);  /* High bit clocks the value into the fpga. */
+	udelay(10);
 }
 
 void snd_emu1010_fpga_write(struct snd_emu10k1 *emu, u32 reg, u32 value)
-- 
2.43.0


