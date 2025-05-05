Return-Path: <stable+bounces-140352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99519AAA7D0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120BA1887AA2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB1340A9F;
	Mon,  5 May 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmNhzzf0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3499340A9E;
	Mon,  5 May 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484682; cv=none; b=TJ+TdC07eTTIFJng0Y8Lk4zSHQS8JLGUO69CGxZ+YBkrT7y6yIkUYHDb9rENFa8FFKK7iAEsfIV5qTQEsdENrVHd3OgvYoHA0R+PC0clRfhDF3qIyGhTTdvbbdzTr+eFk6lRV0PiNPZTLm36sJ6vtgCk9W303ztlMUzu7lVCGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484682; c=relaxed/simple;
	bh=sFy+V0bk4z2DlSuJsUd5HnI9H7emle+TTChKsuH8Nsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcr8hIzCbMvV1JhZ2F5BewjlfG3RQwEfq9FAuIlYQQ9bmDITuNmNRaQPGTxaCYvX4ezV/xR8JRK1N6dTgc4SJe57vJiNmjr8WvdrpVzT8GETrbBOH8HLr8n4/dC4BlMKCdaLU1m6YqjsCP+Y2n93ym3twAu02byU9zSSnzFJS3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmNhzzf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F0C4CEE4;
	Mon,  5 May 2025 22:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484681;
	bh=sFy+V0bk4z2DlSuJsUd5HnI9H7emle+TTChKsuH8Nsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmNhzzf0LHoWRUshjY3HlX0PRieb8n7OOHZZ50Y9ZzXQGjbgXYO7ZC7n7s1xCMA6C
	 rKiYYwrudtuVucefQoGZaIGwiT7mbv2vdtNEES63Pt7YCTHdJyP0IVFV5L6sTYAyOb
	 jmi1IbQAAZD7+qxa38sSCIgNukXugO3Mq0Eusj2BIcd527eIHVaSZJhE2K6I4WeSo2
	 mJ/gvMGK6xiyaLoJpd008IItGgHkeXEPcw2UIcI65tfZEI9Erq4vC2UNELPrucd0Vt
	 0suJ4vZXDqGRKrZ+E8FJu0V0FqZTU0YbyEZx1pt1zUgE2RuyK8pqQQxVln1GOLApWa
	 FxA6mmy/CgyqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhi Wang <zhiw@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lyude@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	ttabi@nvidia.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 603/642] drm/nouveau: fix the broken marco GSP_MSG_MAX_SIZE
Date: Mon,  5 May 2025 18:13:39 -0400
Message-Id: <20250505221419.2672473-603-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Zhi Wang <zhiw@nvidia.com>

[ Upstream commit bbae6680cfe38b033250b483722e60ccd865976f ]

The macro GSP_MSG_MAX_SIZE refers to another macro that doesn't exist.
It represents the max GSP message element size.

Fix the broken marco so it can be used to replace some magic numbers in
the code.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250124182958.2040494-8-zhiw@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 58502102926b6..bb86b6d4ca49e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -61,7 +61,7 @@
 extern struct dentry *nouveau_debugfs_root;
 
 #define GSP_MSG_MIN_SIZE GSP_PAGE_SIZE
-#define GSP_MSG_MAX_SIZE GSP_PAGE_MIN_SIZE * 16
+#define GSP_MSG_MAX_SIZE (GSP_MSG_MIN_SIZE * 16)
 
 struct r535_gsp_msg {
 	u8 auth_tag_buffer[16];
-- 
2.39.5


