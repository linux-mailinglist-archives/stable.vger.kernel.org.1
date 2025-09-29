Return-Path: <stable+bounces-181948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1342FBA9DCB
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1523F1921C2C
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECB30C102;
	Mon, 29 Sep 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3Gk08rU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25C30B535
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161035; cv=none; b=fDTzg98QfDFEVWM7IYm3gniLRUNDbZBdPU/0LKeASiKJJTcLvB/6c64EbAUa2GBoRjFeYXDkADdcxguk6m2q+HCRmzePdlIH2ekdGBh1AgNcjAt08rtSl7H2zw6BhofQuEKhwI6Dg7h/d94geM97H9pA/y3rprj0hysIsk8IEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161035; c=relaxed/simple;
	bh=wKmOh745tYdiNYayfBQhqKGeiFvELvAKu0H3ipoIBlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ6OgvEUPtW/8T46R9n2QTjId1Y3jt33FeC1YW1qk7q56twjtAIxxFL0JxVSOuzL00QCjfzMEPfou3g5lhvOj9TCAfZW96mOQNcxbQrC0d8w+jRxnfcqizGIFXtHMyDn+BaBQK1MM2MjK482PY2zYpp2mbt/esx4fmMWDl33qUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3Gk08rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DD5C4CEF4;
	Mon, 29 Sep 2025 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161035;
	bh=wKmOh745tYdiNYayfBQhqKGeiFvELvAKu0H3ipoIBlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3Gk08rU+/MyoqC9q19pOUBx41gA+CfO0OGQlWzDL+XsH3R2uo9EFsqdYMbVrKwO+
	 mCMGwfvm1EULUuYZh0fhOCcXOlcT4UW1VirsiSWF7dkRVidKuy/sw+ebeZAAxCYUOK
	 HN/5kyI3a7CGpUSVMX5omyK+YLnJjdej14eCmVLUVsSTP2qFwL1FWsT8Wuv0w2ToqA
	 OecNUrUBHdbOCmAunawIKpZXUMcKLCjxOLftvqhJrYpH6pGQS9yIKew0h+m+7kqNe0
	 s1U2g8an7Tv12OtUyQYCgy0PswAzcCLPBEmrWCGn3znhxYBj549P091d3QAJ4DNNLY
	 AZ8UfaZB8qX4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nirmoy Das <nirmoyd@nvidia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	csoto@nvidia.com,
	KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/ast: Use msleep instead of mdelay for edid read
Date: Mon, 29 Sep 2025 11:50:10 -0400
Message-ID: <20250929155031.137825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092920-backspin-glade-7b6c@gregkh>
References: <2025092920-backspin-glade-7b6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirmoy Das <nirmoyd@nvidia.com>

[ Upstream commit c7c31f8dc54aa3c9b2c994b5f1ff7e740a654e97 ]

The busy-waiting in `mdelay()` can cause CPU stalls and kernel timeouts
during boot.

Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Carol L Soto csoto@nvidia.com<mailto:csoto@nvidia.com>
Fixes: 594e9c04b586 ("drm/ast: Create the driver for ASPEED proprietory Display-Port")
Cc: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/r/20250917194346.2905522-1-nirmoyd@nvidia.com
[ Applied change to ast_astdp_read_edid() instead of ast_astdp_read_edid_block() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index c6f226b6f0813..fc9c36c8b81b9 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -62,7 +62,7 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 			 *	  of right-click of mouse.
 			 * 2. The Delays are often longer a lot when system resume from S3/S4.
 			 */
-			mdelay(j+1);
+			msleep(j + 1);
 
 			if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1,
 							ASTDP_MCU_FW_EXECUTING) &&
-- 
2.51.0


