Return-Path: <stable+bounces-86184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D262599EC31
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A72F1F25179
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641A62281E4;
	Tue, 15 Oct 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgvUyA1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195D92281D6;
	Tue, 15 Oct 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998054; cv=none; b=m+yCj8kbK4uHTOSgK6K1NUes0nqxzC/CmXZpUCEKOO3NbvwZrKzDpAdeY8RU2MXY0n2MFxK/xON77OKISzlyx8Ap7DZhHGQCoZqQV2YMkYSAoNRKQaoDt6ROIsEDBI77OGNna4asj/S9/8RNIOd7/+bib+4+vMfxXr04WmtaL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998054; c=relaxed/simple;
	bh=OIyJsdbMH0LtaiMD+SGJ3q4iK1VEy6gQIrftqjhRmbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT0HK+V29AQelQLdjX/5h3Ufdv97ZsSqMyWqZh5yYnGuQYcuUYTEz92tqCmHBUWlVmZs7WB6t2WR8Irw8wHeOyfwM4Bbe4xKU+x8hdVG0Lo9qb07++dxOFytDv2bDPrb0T3tBpirEEBuH0D7R1YX+5SBTycUPRIb+g4Fvhp+Soo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgvUyA1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F655C4CECF;
	Tue, 15 Oct 2024 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998053;
	bh=OIyJsdbMH0LtaiMD+SGJ3q4iK1VEy6gQIrftqjhRmbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgvUyA1zru34DtsLS78JqYtm2R1udEzZVlAiom5r29YDrfsARoxvVQ6JQcK0iqfib
	 Wnb89SYCrGuEwQE8ToLwOw8n/u6o6FK4VMLeIE+GheJZaidwOqs/7jAaXc43p5cTkc
	 b3rrz/HzyYy9A3K8GzQarNAXR6PQ3AcXiUe1a+7Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 338/518] drm/amdgpu: add raven1 gfxoff quirk
Date: Tue, 15 Oct 2024 14:44:02 +0200
Message-ID: <20241015123930.017684604@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 0126c0ae11e8b52ecfde9d1b174ee2f32d6c3a5d ]

Fix screen corruption with openkylin.

Link: https://bbs.openkylin.top/t/topic/171497
Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index acef2227d992b..3f320ead85d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1250,6 +1250,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
 	/* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
+	/* https://bbs.openkylin.top/t/topic/171497 */
+	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0




