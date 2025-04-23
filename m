Return-Path: <stable+bounces-136434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3EA993A4
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1D1BA4146
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92E2BF3DC;
	Wed, 23 Apr 2025 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tchPv7yu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C828BAA0;
	Wed, 23 Apr 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422536; cv=none; b=BqAMdvZGIXZctbfgPmU10cZUq6pfEvbinWPCzZY/znmBQ/8tqcp393kW1BVe2OpkYzEZqGV6siTOyFVCqNUySUGptOhkSz2Kwp+oN9zAtSAtXKZFcFZEe9k9hXBrCbMxa9/urBUAQJnI6nw/h6a+y1T/m/EcXWVgScqSFxa9t+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422536; c=relaxed/simple;
	bh=R1DkDkT6iYiNHgFeqG7muc77pMyfqoEDJPrSwxfqw58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErByIrcbglOc75LM3aG5Y8dmhQSxmeVHZO5U+u6T+XehDNXmsxNR2iI9keUW2G2yvfe7WIgaprra6smBtSS7YL/Fu96rW0u20Ew81tenSIO5EZdgT1kgrR2cZghPHi8CGyZLRq0B9e7VfcPCM5xBxMM6WkEdqWntFnBS3b02adw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tchPv7yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087B3C4CEE2;
	Wed, 23 Apr 2025 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422535;
	bh=R1DkDkT6iYiNHgFeqG7muc77pMyfqoEDJPrSwxfqw58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tchPv7yuCfRYNzoR3UHWEVkCT2OeS32pDFKUrzt98qrKNFGZF3fzdP/Kr2NSoRFvK
	 7fe+3WaZvk4W8dN/sC9FzKFLR40Uor0EMjPJRhjjyUzSwhSUVlxPHW7qV8/g36kutJ
	 1+sFat8AHj09TjtCyAES3FXBAHf9ZlKgvFYqh/Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Rolf Eike Beer <eb@emlix.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: [PATCH 6.6 357/393] drm/sti: remove duplicate object names
Date: Wed, 23 Apr 2025 16:44:13 +0200
Message-ID: <20250423142658.082763298@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Rolf Eike Beer <eb@emlix.com>

commit 7fb6afa9125fc111478615e24231943c4f76cc2e upstream.

When merging 2 drivers common object files were not deduplicated.

Fixes: dcec16efd677 ("drm/sti: Build monolithic driver")
Cc: stable@kernel.org
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/1920148.tdWV9SEqCh@devpool47.emlix.com
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sti/Makefile |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/gpu/drm/sti/Makefile
+++ b/drivers/gpu/drm/sti/Makefile
@@ -7,8 +7,6 @@ sti-drm-y := \
 	sti_compositor.o \
 	sti_crtc.o \
 	sti_plane.o \
-	sti_crtc.o \
-	sti_plane.o \
 	sti_hdmi.o \
 	sti_hdmi_tx3g4c28phy.o \
 	sti_dvo.o \



