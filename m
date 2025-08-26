Return-Path: <stable+bounces-174483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B173FB363D9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9450361976
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83361EF39E;
	Tue, 26 Aug 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x07pom/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A67393DF2;
	Tue, 26 Aug 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214511; cv=none; b=WLqFvfZ84F5BXWQk9S7k/t925tKkNhgwrtCuVIApp+ZlCYO+i8xaiaTF1WUaMe1PiqrxyA4X1d2XOqBVKBTsPiPYFdEm+NBicjzhI6MHjVgZANF/Q+WjW7LQZxFmLE1JN1k3eULVLyWjvyb69W6S05r6Sf/08Z5TUkUpd6mqktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214511; c=relaxed/simple;
	bh=Bp22QZkKA52yeEV5ii1X6Dqm3a6USQXT0KFKw/S4RAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vszlr0GnTc7S/lY02wXLEpg4dXVegK/X/qwInKvKuU1vxZA83Qpoe4l7Nqp46aWCiPBcsxqCVoj30Hfb9rvnnFT19rXJTqHqU0P63Md/jwK3ICfvIhNKwjETPa1CigBqYbxqq2F0FOT6Ui8LuMzUha0tNb3qR1pkg/pyzskbZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x07pom/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A593C4CEF1;
	Tue, 26 Aug 2025 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214511;
	bh=Bp22QZkKA52yeEV5ii1X6Dqm3a6USQXT0KFKw/S4RAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x07pom/wdnueo8ktuKtq4wQNu933MlvV6UFRe6SOI9GYtUcSSSBLxMEGE2k5IRIfW
	 VA63DBnzp8PuT5bMBuRwr+al+U+ZHnfuA5t23QV2ILKbtrn7VAgyd+H1kmlFs84HyO
	 1tkAb1WRuD2knpEBUvuFu4D2X2dSz7go4kKOUaCI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emily Deng <Emily.Deng@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 166/482] drm/ttm: Should to return the evict error
Date: Tue, 26 Aug 2025 13:06:59 +0200
Message-ID: <20250826110934.912918704@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit 4e16a9a00239db5d819197b9a00f70665951bf50 ]

For the evict fail case, the evict error should be returned.

v2: Consider ENOENT case.

v3: Abort directly when the eviction failed for some reason (except for -ENOENT)
 and not wait for the move to finish

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250603091154.3472646-1-Emily.Deng@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 3287032a2f8e..ad3c398fc278 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -437,6 +437,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
 	}
 	spin_unlock(&bdev->lru_lock);
 
+	if (ret && ret != -ENOENT)
+		return ret;
+
 	spin_lock(&man->move_lock);
 	fence = dma_fence_get(man->move);
 	spin_unlock(&man->move_lock);
-- 
2.39.5




