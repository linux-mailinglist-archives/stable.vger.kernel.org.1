Return-Path: <stable+bounces-75237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE4A973394
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F149283297
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A51946A4;
	Tue, 10 Sep 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mOPfDlg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7F194151;
	Tue, 10 Sep 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964147; cv=none; b=kW/yCz5fh5y9JL3QOU/P8WYbpQ6FBYlYFALSJR5/Kx0fBdxhzC4zNzsxCTuUFUH7fdEUUvu+eCieU/NLhWpzhN66+kE741MMTGim8GV8GWe2CTDurbaDhbkxgH+qP9+ZrQ1MCnzD6T0sHhZUW/M9Q9+2vfFRQ8KHXMaFN9aaD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964147; c=relaxed/simple;
	bh=6da+Ph35q76ukw4Cv/fZ7qEQu9u8tAEluCLN1v55K24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6II3lqND5DqH5805cQ84YB3Wz/4EAnn5J39y2EdXTQ53QRr2H0M5OsBvJG59aD55tvryduk1BuO7EyzQZG/+NKEKG4T4k5MpMA+1Zcfur6N9K9CbUav9upp0qCjHm5wydcGo0d8WZVaV9k+CMhX1bMCFoAiaypZoS4xRqmpD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mOPfDlg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595BAC4CEC3;
	Tue, 10 Sep 2024 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964146;
	bh=6da+Ph35q76ukw4Cv/fZ7qEQu9u8tAEluCLN1v55K24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mOPfDlg5ncIhlNAFKw/kZ4PPeHSjaC2sHaI5z2D/myFGMoD1DNIZc8gZvWOrOsEaH
	 IEILqSCLeEZEg6vogQ2iV8gkjUSjhIU7it3fh0/Z4kZbay1sUv/xMbTHiLQUt/2c/C
	 DiGSPy3Ufm/wnaYvPsd/YNupJBbinv4gLVnizJ7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/269] drm/amd/display: Run DC_LOG_DC after checking link->link_enc
Date: Tue, 10 Sep 2024 11:31:10 +0200
Message-ID: <20240910092611.157473176@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 3a82f62b0d9d7687eac47603bb6cd14a50fa718b ]

[WHAT]
The DC_LOG_DC should be run after link->link_enc is checked, not before.

This fixes 1 REVERSE_INULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 2c366866f570..33bb96f770b8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -629,14 +629,14 @@ static bool construct_phy(struct dc_link *link,
 	link->link_enc =
 		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
-	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
-	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
-
 	if (!link->link_enc) {
 		DC_ERROR("Failed to create link encoder!\n");
 		goto link_enc_create_fail;
 	}
 
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+
 	/* Update link encoder tracking variables. These are used for the dynamic
 	 * assignment of link encoders to streams.
 	 */
-- 
2.43.0




