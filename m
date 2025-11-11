Return-Path: <stable+bounces-193078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B5C49F38
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786183AA40A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254821FDA92;
	Tue, 11 Nov 2025 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NIyjLGaH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E12AE8D;
	Tue, 11 Nov 2025 00:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822248; cv=none; b=NQfL+0JkoHFz43V9cWnOGTyz3IkSoNNTPhQF0NurPmfAXrfVKX08kEelfHaSstybYmK9SLdUHdIFClfecg0E3mvFSUH17qz5oy5da4FX7Yvx+0ZdmUjIxBFnvT2vF9F+8mlr0JzBDi8CaNh5CebOMcVpVKkWhKm7ERKDCwAcNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822248; c=relaxed/simple;
	bh=3oNoPa5ALxe4GhlIBxOnoEzFYxOSys9XrKdRQqY7xC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZMUl72YmTUUfy4gynySZlBPueE4QcBi2+Jo4Cw08p/Y9IBhl1fjISm3Hc4VHY/7EVi5veQFNlzjm/bsNh2OCEz7ikNBHKQJFVd48NYUIgcaIKrSNY5IBOUdb/yzyC1KXGbdz/vTWLuUSSLeC9AbHtQ2PkTG7LuVErOI70UwZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIyjLGaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F26AC16AAE;
	Tue, 11 Nov 2025 00:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822247;
	bh=3oNoPa5ALxe4GhlIBxOnoEzFYxOSys9XrKdRQqY7xC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIyjLGaHRVu68ONF63AYIGs4Ex32ahhFZik71s5OpM4XEYqPcss0d2OhztZp8474i
	 3sJpt93pVLikaKBqRnS2YpbXL0EbVEa4KZwyIT4lRmCiOYIPBqcy9aYMTvIaSrdygV
	 siTyRhki7cpMdLcLdfE/BxE7xfhYxCpwEO2dDpeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fuchs <fuchsfl@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.12 011/565] fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS
Date: Tue, 11 Nov 2025 09:37:47 +0900
Message-ID: <20251111004527.111219370@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fuchs <fuchsfl@gmail.com>

commit 5f566c0ac51cd2474e47da68dbe719d3acf7d999 upstream.

Commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.") removed
the define ONCHIP_NR_DMA_CHANNELS. So that the leftover reference needs
to be replaced by CONFIG_NR_ONCHIP_DMA_CHANNELS to compile successfully
with CONFIG_PVR2_DMA enabled.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/pvr2fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -192,7 +192,7 @@ static unsigned long pvr2fb_map;
 
 #ifdef CONFIG_PVR2_DMA
 static unsigned int shdma = PVR2_CASCADE_CHAN;
-static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
+static unsigned int pvr2dma = CONFIG_NR_ONCHIP_DMA_CHANNELS;
 #endif
 
 static struct fb_videomode pvr2_modedb[] = {



