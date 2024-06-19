Return-Path: <stable+bounces-53993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7590EC32
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E7C1C248B7
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFC6143873;
	Wed, 19 Jun 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hENNH3m9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3982871;
	Wed, 19 Jun 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802279; cv=none; b=YShgbvFb2fRf19YW8KYJjBIuxDwZTfxUtbp+yubvbmyhNcAtwAmsV7LZPTXlPTLHz6MwolgbYE6RSi9QYzipGs0pljeCziDGsOBYSWKNRIxyxwP/gSYSfahUeEsYvjyPfD/sU+wTRUUVw6VFdxlk4bPa4Yc3NWJ+jQwvmSBsuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802279; c=relaxed/simple;
	bh=hrvJDAL00385htg4HuwHVpd6NxahzzR4MW7E6vXVl8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHFVdY9FXo5dWX45awG2OigexMCHvNnZSMEeuj66szOvgMz61CAZc8b4QF5ohUVHWYWAPD2Yt8Szf3W9aHhfpXXK1yW70dnGCuEPro3szSuz1J28Gf9irKlVka8dXuwA4eEY4uP5SfyrO/avHwFlkgaGuI/NfSE/3qIlhMh700I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hENNH3m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D3C2BBFC;
	Wed, 19 Jun 2024 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802278;
	bh=hrvJDAL00385htg4HuwHVpd6NxahzzR4MW7E6vXVl8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hENNH3m9qJOS65tNIe3HsCdORt93T4kSdRWvW9TjslYMtQf+ay6PgcHLB/PsG8jo1
	 O9QLQjcTk/ZAfdmogRjQBy2KYFJOiC1Ww4hVQ4liHmcKycXuNXxIUkliKmC2OBMtHq
	 rcaJrC+Kp0txG4hyMA6B5z1INz4i2fuBDWKupA0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s@web.codeaurora.org,
	=20Bence?= <csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/267] net: sfp: Always call `sfp_sm_mod_remove()` on remove
Date: Wed, 19 Jun 2024 14:54:53 +0200
Message-ID: <20240619125611.796554842@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Csókás, Bence <csokas.bence@prolan.hu>

[ Upstream commit e96b2933152fd87b6a41765b2f58b158fde855b6 ]

If the module is in SFP_MOD_ERROR, `sfp_sm_mod_remove()` will
not be run. As a consequence, `sfp_hwmon_remove()` is not getting
run either, leaving a stale `hwmon` device behind. `sfp_sm_mod_remove()`
itself checks `sfp->sm_mod_state` anyways, so this check was not
really needed in the first place.

Fixes: d2e816c0293f ("net: sfp: handle module remove outside state machine")
Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20240605084251.63502-1-csokas.bence@prolan.hu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 3679a43f4eb02..8152e14250f2d 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2394,8 +2394,7 @@ static void sfp_sm_module(struct sfp *sfp, unsigned int event)
 
 	/* Handle remove event globally, it resets this state machine */
 	if (event == SFP_E_REMOVE) {
-		if (sfp->sm_mod_state > SFP_MOD_PROBE)
-			sfp_sm_mod_remove(sfp);
+		sfp_sm_mod_remove(sfp);
 		sfp_sm_mod_next(sfp, SFP_MOD_EMPTY, 0);
 		return;
 	}
-- 
2.43.0




