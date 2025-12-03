Return-Path: <stable+bounces-198233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F53C9F75C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 332C43001505
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF630C606;
	Wed,  3 Dec 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dan0PAYY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883B3081D4;
	Wed,  3 Dec 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775865; cv=none; b=eOIPnE8cI+C87VcoL+l0XBgvas6t4O8AhIzM8mD/EqRcMjxRxC5qmKQlOeDpemHAbWwlXcELBcBgQTj3DLdvWbpbHKHhVY6latlPNTJe0XkbAcWS4EMR/j0e0U+kaZtjw/Lp7YrkUvKvQDVgc1j7GSK5I1c3iqTHNF0GO/RqS2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775865; c=relaxed/simple;
	bh=f+T0wWBQ0F0u6PM4urc7GT9P4s3HtUONVu1wNjYjgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfnPBHpgOpFIwSpafIn/E47vMgkEuLZR3g97MUcNz5nP45RHdbWpO5pf83Hv0Hs0yKuUA/EYnvurUtoU4OMhlj5sxGb+ny9G9tPc5lfkhhBFKZj3D5j1eyTxZMT86smnJwC3FI8YxFuSBjOlMUAaQEoFjK2hkDLqEPZ92mIZ76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dan0PAYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BB2C4CEF5;
	Wed,  3 Dec 2025 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764775864;
	bh=f+T0wWBQ0F0u6PM4urc7GT9P4s3HtUONVu1wNjYjgFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dan0PAYYeTc39NY8fHdgpBaryw7+SnZKQ5UBn5PUv47Kmh9GQDUXezPwBODrRwfTB
	 GgiffTllAnYdwlgycQhLgf5dbtmGQXPPDlFvSEQw3LkalL3IFaMj5/JI8TEbfMdB0w
	 brOWa2I2UMZ5OWwjYtuqDd/fHCXwk798Fn9ZO3S8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fuchs <fuchsfl@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 011/300] fbdev: pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS
Date: Wed,  3 Dec 2025 16:23:35 +0100
Message-ID: <20251203152400.877418621@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -191,7 +191,7 @@ static unsigned long pvr2fb_map;
 
 #ifdef CONFIG_PVR2_DMA
 static unsigned int shdma = PVR2_CASCADE_CHAN;
-static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
+static unsigned int pvr2dma = CONFIG_NR_ONCHIP_DMA_CHANNELS;
 #endif
 
 static struct fb_videomode pvr2_modedb[] = {



