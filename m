Return-Path: <stable+bounces-14059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1FB837F56
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA22328CF2A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755CE12AAE3;
	Tue, 23 Jan 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVw+hFoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B812AAE0;
	Tue, 23 Jan 2024 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971071; cv=none; b=I0qtumVkq2TgZ7DgpFmMJBDk1KVacL4vpTapv1L8yqzyzGcZf95Nl09lDbMl5dfmsSuKCkwWxo/EWFZNS1nyTqXRw+k/NnfcPtvX58FRZ3OQ6IBkjbvBZohifI8hFs50QLiZ09YzdMQhER82wydyhdvs6IZRnWI5kyd44IPqnZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971071; c=relaxed/simple;
	bh=SancLkbnlsFSNSBMxgSWHEBNQ6+GHi0y2pJwkZ2rOe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWKxaLQaTUQdGKXAH8E3flLRnyn9OvuLxUvlXPTiJ8Yog+117QXZdbvWP4Ouc3yzBtaxMVbEdhzIdi/K+gAVuTZ3FjVdMKFBIHR8P6SDVrMEN1GHoTUTIuEyC/YlhuVKtp29/Wc22FH9m8LWcTxzZ7dszUJPmH+zINcaUDEsWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xVw+hFoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E1FC43390;
	Tue, 23 Jan 2024 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971071;
	bh=SancLkbnlsFSNSBMxgSWHEBNQ6+GHi0y2pJwkZ2rOe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xVw+hFoQJHyZikpMyvOJgU9FOCDNZU1Ihl4RYtNGCxc7XSgJB3jAurmf6y2DjwKG/
	 zvMeSIDEwjF8/hziFeEnq9pByIHjWHekRjXiHn6d+AJWfwy9nQedgvt8T1Qafohzdq
	 zzPnWTzC5PHl1kIgO1Fkp/4Wem4Irm/KlCdh1Qi4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/417] drm/tidss: Move reset to the end of dispc_init()
Date: Mon, 22 Jan 2024 15:55:43 -0800
Message-ID: <20240122235757.929391336@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 36d1e0852680aa038e2428d450673390111b165c ]

We do a DSS reset in the middle of the dispc_init(). While that happens
to work now, we should really make sure that e..g the fclk, which is
acquired only later in the function, is enabled when doing a reset. This
will be handled in a later patch, but for now, let's move the
dispc_softreset() call to the end of dispc_init(), which is a sensible
place for it anyway.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20231109-tidss-probe-v2-4-ac91b5ea35c0@ideasonboard.com
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Stable-dep-of: bc288a927815 ("drm/tidss: Fix dss reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 16301bdfead1..9ce452288c9e 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2726,10 +2726,6 @@ int dispc_init(struct tidss_device *tidss)
 			return r;
 	}
 
-	/* K2G display controller does not support soft reset */
-	if (feat->subrev != DISPC_K2G)
-		dispc_softreset(dispc);
-
 	for (i = 0; i < dispc->feat->num_vps; i++) {
 		u32 gamma_size = dispc->feat->vp_feat.color.gamma_size;
 		u32 *gamma_table;
@@ -2778,6 +2774,10 @@ int dispc_init(struct tidss_device *tidss)
 	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
 			     &dispc->memory_bandwidth_limit);
 
+	/* K2G display controller does not support soft reset */
+	if (feat->subrev != DISPC_K2G)
+		dispc_softreset(dispc);
+
 	tidss->dispc = dispc;
 
 	return 0;
-- 
2.43.0




