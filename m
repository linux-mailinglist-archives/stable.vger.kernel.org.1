Return-Path: <stable+bounces-141326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B95AAB69B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986AD1BA79D9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC10F2D7AC0;
	Tue,  6 May 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5hel6QX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D92D8192;
	Mon,  5 May 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485771; cv=none; b=ounH3eYntKZvc9u7A7Dx69l7R6vkoRkWiI73O2b9Kma8m/8JW0Oc/KMJG2tVLOWcp/GDK0bpbwp6+U1UzduqEeQHIhrUHPXNsDcWjev3iIWcD66nS1KZYZnsdTY1zcG2L/fvQKPHIEcm88PAbW7boMwnUkrf5JHkNPOCcxSAzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485771; c=relaxed/simple;
	bh=SlTQksXt8m44xfjDoWZQpuTcycqa3I09Ut1LCHhtKF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=os69JCy8qlgZkdjlYCJ8yuvP4ySdysfVUh8jzsLevZLPrbIFl492ACXItratRQRp52GZ/11HHkzObZLq9TgXJNxhzneNHTpoD3966IMD/+afqWuu7I39Vk9UGwMo+yDjvJa0n7Eg4DXMOOWQCMG+X7Mv+FWBu9qZq4jOGhkeqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5hel6QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A19C4CEED;
	Mon,  5 May 2025 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485771;
	bh=SlTQksXt8m44xfjDoWZQpuTcycqa3I09Ut1LCHhtKF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5hel6QXgPE4a6ftDa1Viv4LdBr3QC6pSL0OI12bIQLqosgB9XX7nG1nY5Iwp32Rk
	 x98+H602RMGwbh/AH3zAwb4JnNnCI4SZ1JOxM4dkleZtkk3LPPAuniJyk0UTccmuFi
	 3+XcrG7eD5T5yyoA2ysfIHf+2qqy+IBNJ0KeegBUn4vk9n15AVqbC5kxnamXCN27v/
	 R+xkI9oueag6RnIx6iZo0HSuI1BdxCjwcVhiUXhHILl+wePSntO1QMyvLGcFIS96vM
	 nmvWCpEdpl50gGO1/IjAqjggM8Bz99Z/r0QeJbZtzYB2O2hwP1UcIw37DNWA0Oz4ep
	 IsksP2t0e9Y5g==
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
Subject: [PATCH AUTOSEL 6.12 475/486] drm/nouveau: fix the broken marco GSP_MSG_MAX_SIZE
Date: Mon,  5 May 2025 18:39:11 -0400
Message-Id: <20250505223922.2682012-475-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 9c83bab0a5309..fc84ca214f247 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -58,7 +58,7 @@
 #include <linux/parser.h>
 
 #define GSP_MSG_MIN_SIZE GSP_PAGE_SIZE
-#define GSP_MSG_MAX_SIZE GSP_PAGE_MIN_SIZE * 16
+#define GSP_MSG_MAX_SIZE (GSP_MSG_MIN_SIZE * 16)
 
 struct r535_gsp_msg {
 	u8 auth_tag_buffer[16];
-- 
2.39.5


