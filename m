Return-Path: <stable+bounces-49859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B77E8FEF27
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE41F246A0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3531C9EC4;
	Thu,  6 Jun 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vutOD3j3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198041A186B;
	Thu,  6 Jun 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683746; cv=none; b=bRkd7R7Wbfe/MjABUSK5te9nkbAfxsJfMfgrQrmbkpreemjgsEa1q5D5uMwwMo0TwSF9o9lxNZDxR2nCgL1cuCPRpfFxk/frav6/EUpRg7uUYZaCKxZPSPmYUzTpStsnJgbBM78Sf6hLwGInWEPqQrrTbHA10MawxJ8GJX2QhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683746; c=relaxed/simple;
	bh=+VKwCNJN9Ztlk5J7KXeF/Dm6Bply3IpCHCgVtNU1FB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNRkV+vccqDw1H50eg6ixEJK4zoBkIONUzacP2kb5EDV7Uj3SYtEUXUvMDtkkz0tQoOTGGw0WAwjFcH2RZFlZNoSeCzuQ1nuDwd1WoF3bpKI/nmq0lpctEbEL4l7ht5yJOFHO1vEpB1H+qsHbttVhK0H2gM5hxIHOIg/RIBmHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vutOD3j3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE738C2BD10;
	Thu,  6 Jun 2024 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683746;
	bh=+VKwCNJN9Ztlk5J7KXeF/Dm6Bply3IpCHCgVtNU1FB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vutOD3j31MASSjWvFM0tqf7YyR6Gr8Fyc6FTy/to99DzagH+ofdcYApi5PfyM2eo0
	 ToSCdpI0Q/cDMH1mZ4Dtbi6x3zw2xpw5H1AyvBtJCWhOiMhxR7UykQJCemAIjb5nVx
	 Bu1JXc+e2u8iFgOWW/b2UD6nCg9P+1XHTx2rlHKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	MD Danish Anwar <danishanwar@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 711/744] net: ti: icssg-prueth: Fix start counter for ft1 filter
Date: Thu,  6 Jun 2024 16:06:23 +0200
Message-ID: <20240606131755.281604935@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: MD Danish Anwar <danishanwar@ti.com>

[ Upstream commit 56a5cf538c3f2d935b0d81040a8303b6e7fc5fd8 ]

The start counter for FT1 filter is wrongly set to 0 in the driver.
FT1 is used for source address violation (SAV) check and source address
starts at Byte 6 not Byte 0. Fix this by changing start counter to
ETH_ALEN in icssg_ft1_set_mac_addr().

Fixes: e9b4ece7d74b ("net: ti: icssg-prueth: Add Firmware config and classification APIs.")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Link: https://lore.kernel.org/r/20240527063015.263748-1-danishanwar@ti.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_classifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 6df53ab17fbc5..902a2717785cb 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -360,7 +360,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
 	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
 
-	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	rx_class_ft1_set_start_len(miig_rt, slice, ETH_ALEN, ETH_ALEN);
 	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
-- 
2.43.0




