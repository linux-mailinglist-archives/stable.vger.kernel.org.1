Return-Path: <stable+bounces-34068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DB893DC0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB310B216D8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D14D11D;
	Mon,  1 Apr 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPimu3qY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719504778C;
	Mon,  1 Apr 2024 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986898; cv=none; b=l7bwVKgVRyc0PaGamiNvJzDe8urtmqUeYfEvoQkynXYJ4057vkaXUrwqQLQs65P0vy3Qg3bAHQTWPH0b+AbQwvH8LwnmtScZa/6/6kL2K81B9E0YBpd41IHwNkST2LN8FGti8UuYBDiXy17emzZpiSX0tjQzodUu2/RvTXQhXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986898; c=relaxed/simple;
	bh=6qmK7ewB6zPaVtWdMDClz5M6CD5/Z/zP2n0TcCRvLBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apRDeTpNlKJ9tnEC6gwtI8gJkRxK9x7c7bHhUi1owey4ReLMWpxPJm2QKOHfRXQGLJEVH6dwYAtkuFoDrpx1yW6eo3Eke+K6KAd/BDSRTk9wETOxfltsZ7jaFPMiDkkbRBNukxq+GeLmgyg46DdT4rFTWnkUwI/UC78UODOq0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPimu3qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF19C433C7;
	Mon,  1 Apr 2024 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986898;
	bh=6qmK7ewB6zPaVtWdMDClz5M6CD5/Z/zP2n0TcCRvLBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPimu3qYOrelPpQlUu7D2M0dP79PZ5FD8JFeh0kHyYxE1h/tFHiRtSU/ynQkB9Lag
	 exUgWzMvJrFur/2uZ8ugR+2JOdWbGVhWceJ7DwH9mXzbQ8wX39Tj4LKdpJOrQ5+XH0
	 pcJOruO77DhM6GWfEtEoALS6lMiy0ff/aH4yP2TA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 120/399] drm/etnaviv: Restore some id values
Date: Mon,  1 Apr 2024 17:41:26 +0200
Message-ID: <20240401152552.770449690@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Gmeiner <cgmeiner@igalia.com>

[ Upstream commit b735ee173f84d5d0d0733c53946a83c12d770d05 ]

The hwdb selection logic as a feature that allows it to mark some fields
as 'don't care'. If we match with such a field we memcpy(..)
the current etnaviv_chip_identity into ident.

This step can overwrite some id values read from the GPU with the
'don't care' value.

Fix this issue by restoring the affected values after the memcpy(..).

As this is crucial for user space to know when this feature works as
expected increment the minor version too.

Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c  | 2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6228ce6032482..9a2965741dab3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
 	.major              = 1,
-	.minor              = 3,
+	.minor              = 4,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 67201242438be..8665f2658d51b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_chip_identity *ident = &gpu->identity;
+	const u32 product_id = ident->product_id;
+	const u32 customer_id = ident->customer_id;
+	const u32 eco_id = ident->eco_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
@@ -278,6 +281,12 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
+
+			/* Restore some id values as ~0U aka 'don't care' might been used. */
+			ident->product_id = product_id;
+			ident->customer_id = customer_id;
+			ident->eco_id = eco_id;
+
 			return true;
 		}
 	}
-- 
2.43.0




