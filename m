Return-Path: <stable+bounces-140631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1F0AAAA5A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B980F9A16FC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17DD3867DD;
	Mon,  5 May 2025 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeGidMev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD6F2D9016;
	Mon,  5 May 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485497; cv=none; b=bqw+9c8n7s4aclGSXnfOx/balq869F+6wgP6sHfHVabTjoCqLOD+1pJwG3JwS+bGD/p9K5ysn9s1lplpM84s/Mzduc2MBwpSWVPXWH4LQst7Rmy+noE41bV9OQ3kclpsfe9teteCa9UFSqxUVZFdyaBh3C/g0odOfFM7eP5hZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485497; c=relaxed/simple;
	bh=GWHf4Pepn5XTdcibSCyLKZaFxxZfHpk4fmNob5E8br8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCGNixxL5EG61E/0bctN0yo64wq9yOfbAGl1ieBy+HmODH2SqtC378gockQAN9XR9AyFp7IjGoAe/hjrcGQd+5DHh7Cn2kxmDwoL/Y6cS3f23BgY7rc5ENKpisZki9ibUw9KLdzLKuXfwrDJ2H2o6m5nXfabKDLKNQoIEgs7C1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeGidMev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4FCC4CEF2;
	Mon,  5 May 2025 22:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485496;
	bh=GWHf4Pepn5XTdcibSCyLKZaFxxZfHpk4fmNob5E8br8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeGidMevXyZIg+OjgkDu0kfP3xUu/KZsjB0ThEuXdogS0+U2zBZpc13SgVu8U13OV
	 l9mGrX0Q8pm+Q3jck9uRDGV4XG2JArVv/tCXzkQU+y933fZgVkvBhntXcTGtmID0eA
	 GE2oe0z8TqQDH7tk3AkQssn/F9u69AmHNvpDo7JmPiD/hjvwYfJJx5Zx5SZ6cIHKsw
	 Fco/YJKSsLcE9I6YExSeLFt/SBCjbf5q8C8Zpmd68gCymmdKOTnTTB8FlXWfy77RH7
	 VXmoScwLjT0LEYW3qCGGIYWMWzCbyslAPlirr32pbpCUc6DFLFk+E0IEr7CZ6HcA+c
	 GmuEIU0uwqN5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xin Wang <x.wang@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Fei Yang <fei.yang@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 347/486] drm/xe/debugfs: fixed the return value of wedged_mode_set
Date: Mon,  5 May 2025 18:37:03 -0400
Message-Id: <20250505223922.2682012-347-sashal@kernel.org>
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

From: Xin Wang <x.wang@intel.com>

[ Upstream commit 6884d2051011f4db9e2f0b85709c79a8ced13bd6 ]

It is generally expected that the write() function should return a
positive value indicating the number of bytes written or a negative
error code if an error occurs. Returning 0 is unusual and can lead
to unexpected behavior.

When the user program writes the same value to wedged_mode twice in
a row, a lockup will occur, because the value expected to be
returned by the write() function inside the program should be equal
to the actual written value instead of 0.

To reproduce the issue:
echo 1 > /sys/kernel/debug/dri/0/wedged_mode
echo 1 > /sys/kernel/debug/dri/0/wedged_mode   <- lockup here

Signed-off-by: Xin Wang <x.wang@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213223615.2327367-1-x.wang@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index fe4319eb13fdf..051a37e477f4c 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -147,7 +147,7 @@ static ssize_t wedged_mode_set(struct file *f, const char __user *ubuf,
 		return -EINVAL;
 
 	if (xe->wedged.mode == wedged_mode)
-		return 0;
+		return size;
 
 	xe->wedged.mode = wedged_mode;
 
-- 
2.39.5


