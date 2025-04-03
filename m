Return-Path: <stable+bounces-128049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E87A7AEAC
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA423A9937
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272922155B;
	Thu,  3 Apr 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG4vp5mm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF426221546;
	Thu,  3 Apr 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707853; cv=none; b=t7qHUhS+1fzPRLrlLO40oDv9PbP5JcoiAKsBbaYd8+d3LsQapjI5BufkJgvDoOIUfi7aJpMLasCb7f4J1QuexfjDSxU2Fj4gouQiE7vOSToM/d3hrn8dRpS07clL1UiVqRn9iZIkSjiHXucMQr0RgxiXDm0SvMltkGZECf2MyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707853; c=relaxed/simple;
	bh=/n99OrJr943Fv7M+mK6QQYkLZijWdXT6pptPvMBNrBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UMrq8rwn/8lk7yP4unVXir1WuGUzI6pO7pb3otuCtl3wp20ZCZmlYN5hH4Qbw63IdMb8zth4G7T/yc8juWFiIIDnc0cbot3WIxu/fYVLuUIC1J8n7mCAx9cGGlkpQ9U+jqvVGxUA8dJy9rzbFbeSqbTYHQKuSjHbWpEgVMHBqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG4vp5mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C014C4CEE3;
	Thu,  3 Apr 2025 19:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707852;
	bh=/n99OrJr943Fv7M+mK6QQYkLZijWdXT6pptPvMBNrBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UG4vp5mmALBM7EE1EBKe/R2obKdr51hSoBsaAyVIvtX80afBpgOAkGvYa0pFMp5ll
	 jJc96NzEOzpZ5vTn+QkovU2ypwGYxHRRjzKm3eTbgGxWYLGcR3E6ScPdL+EVvnH6MI
	 wmqcTNFGAMsUzL/Za+zk0sBWIiW1usQ2/rtVaqjJ5jbjtIkCFHJ8x1lcBIvqVzyWTa
	 BvCzBNuElr13CmVr5WYQacV5/I9sC13AYvQeShErcEIkYG9HwVIopYWXItNvQoHvSQ
	 Z+CXAWQvEB3G0EpXn4UR8DyH07FFOP/qUjft5a72OlbOW3vfZbPKNa4o54EeowG8TZ
	 AZ1SxMhN1iFtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 11/33] drm/debugfs: fix printk format for bridge index
Date: Thu,  3 Apr 2025 15:16:34 -0400
Message-Id: <20250403191656.2680995-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit 72443c730b7a7b5670a921ea928e17b9b99bd934 ]

idx is an unsigned int, use %u for printk-style strings.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250214-drm-assorted-cleanups-v7-1-88ca5827d7af@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 9d3e6dd68810e..98a37dc3324e4 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -743,7 +743,7 @@ static int bridges_show(struct seq_file *m, void *data)
 	unsigned int idx = 0;
 
 	drm_for_each_bridge_in_chain(encoder, bridge) {
-		drm_printf(&p, "bridge[%d]: %ps\n", idx++, bridge->funcs);
+		drm_printf(&p, "bridge[%u]: %ps\n", idx++, bridge->funcs);
 		drm_printf(&p, "\ttype: [%d] %s\n",
 			   bridge->type,
 			   drm_get_connector_type_name(bridge->type));
-- 
2.39.5


