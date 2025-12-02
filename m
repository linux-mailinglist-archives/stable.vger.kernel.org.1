Return-Path: <stable+bounces-198128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B2C9C935
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80BB04E369D
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63A2BDC27;
	Tue,  2 Dec 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QU3gFqS8"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10C21C9E5
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699422; cv=none; b=UYl2J6vPPD4+SHyWVUvtNIPH84zzmmlNGGWvvfkTl5VpNawCklY+GxVHUiDqocSw+7zuziUHr9tuP3hwur5znMlIAqYNC6imjY+SX4kvFDX779kNsAwU04flCJvUYXMVN2Q0xqEbXYEKCBQQTTvCUMjuVb4dHuydpXA327V1SfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699422; c=relaxed/simple;
	bh=Gkf9/viPqGJiUs2DsUJKG0ohtBxtunbn/hMJY79K2ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwicVt59O6tioBolIgK1cAXhN+d6RPzXjIGD4/THJMIIsfbNrDoMvSnn6kPkqNArTnDzlrpwS+Ea2QQ949xKoxyWcFa/ZA/i1BcwMfMh0HZJjvFOB5tN1Vn8yMb3wXneUab/am1zlsLwqvfVlXpGzKqGZ2t4fFZmsdlZbfMTWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QU3gFqS8; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764699418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pl72qzIOzrYUk8v9JNDm8vYai5+J2tm/+q9u/2KEJQg=;
	b=QU3gFqS82ZU9PLt/RC6mfJ3vzXtBVuZkYYa8LQsocu/eqqHZuyshvW7lqYb5vddPkY27rE
	oZ9ZBYCtF5/tr33zIHsCW5R4XcFmCq78N+IWTh+62JRO3Bvtu6Qlcq2blwT4RXsUpo5Uet
	HwSIen91KQK5rRHOGlyL+3vScF6kojs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Helge Deller <deller@gmx.de>,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/pxafb: Fix multiple clamped values in pxafb_adjust_timing
Date: Tue,  2 Dec 2025 19:15:32 +0100
Message-ID: <20251202181600.511166-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The variables were never clamped because the return value of clamp_val()
was not used. Fix this by assigning the clamped values, and use clamp()
instead of clamp_val().

Cc: stable@vger.kernel.org
Fixes: 3f16ff608a75 ("[ARM] pxafb: cleanup of the timing checking code")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/video/fbdev/pxafb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index b96a8a96bce8..e418eee825fb 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -419,12 +419,12 @@ static int pxafb_adjust_timing(struct pxafb_info *fbi,
 	var->yres = max_t(int, var->yres, MIN_YRES);
 
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
-		clamp_val(var->hsync_len, 1, 64);
-		clamp_val(var->vsync_len, 1, 64);
-		clamp_val(var->left_margin,  1, 255);
-		clamp_val(var->right_margin, 1, 255);
-		clamp_val(var->upper_margin, 1, 255);
-		clamp_val(var->lower_margin, 1, 255);
+		var->hsync_len = clamp(var->hsync_len, 1, 64);
+		var->vsync_len = clamp(var->vsync_len, 1, 64);
+		var->left_margin  = clamp(var->left_margin,  1, 255);
+		var->right_margin = clamp(var->right_margin, 1, 255);
+		var->upper_margin = clamp(var->upper_margin, 1, 255);
+		var->lower_margin = clamp(var->lower_margin, 1, 255);
 	}
 
 	/* make sure each line is aligned on word boundary */
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


