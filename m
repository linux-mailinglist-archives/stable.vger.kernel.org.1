Return-Path: <stable+bounces-64952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD19943CF0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E4B1F2115A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E413C9A3;
	Thu,  1 Aug 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx2eHovW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B713C90C;
	Thu,  1 Aug 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471696; cv=none; b=EzjU76ZdXSsJERPsqySFb17tTi3/3tdgAmA2Log6gYgPJ//GVBj1RySiiLf+RHQ0lCFr4iTCa/YVCDlOGY8ZPeIXM6QngzX/QclRHIHddCOr6oDAMqRXgGoasaXGXQPtrMUzQjAZ/OKST6yYWA63BSIwqeJ+ykee3UXlS14mcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471696; c=relaxed/simple;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eg82ESNO8BFmVrOtSYQVOXaSdQZx2AiNG/AfIFGQAif18NiIsgVAZOU3+n4gxYOgM/oC2dEAHgq+iTZMKiRyXi7fNHB2g9Z0Rqkih5PkCahkpMYNn7PiBLqo3wuQ8VzvgIW6NNN5dO+g74kuAPlG7HdaYhgxbnUdihU3Bz3UN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx2eHovW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C57C32786;
	Thu,  1 Aug 2024 00:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471695;
	bh=yyIy12MuIvwSP1zwHXQiXi9ByeNiR9pxRihShyI6+ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sx2eHovW/IEIYyQ0bhB8aSRfLI71gUlyqJo5ftLQ5LyyRQRCJm8PGvCR7HMdRzNSJ
	 tESK+k+muaJ2axFMULGfpYhJm7pcLFpoMVx1xZxOpXdcCaDYPGm7cU0Of5zDIT4HSO
	 nvieQHXlYk8PjwLjKO0T5+fl+7cGjOqUFuDsxPOb2kkV/QzBpOecQmjb8Mi0XrXjHn
	 0r3TfZQYE+8g8QUC2sbBEVi1dEfyffkSPp+9txU65EHd1617R1c/+UP9OKEl1I+ZwL
	 vjh6IKSJANR5QRy+VWhhPSGz4HPVT77l6LTRcT9GgneLdiJjIg+3Zc3RrGcBJBBSAP
	 z9VKHnzbwM2xQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	kenneth.feng@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	electrodeyt@gmail.com,
	samasth.norway.ananda@oracle.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 06/83] drm/amd/pm: fix the Out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:17:21 -0400
Message-ID: <20240801002107.3934037-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit 12c6967428a099bbba9dfd247bb4322a984fcc0b ]

using index i - 1U may beyond element index
for mc_data[] when i = 0.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index f503e61faa600..cc3b62f733941 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -73,8 +73,9 @@ static int atomctrl_retrieve_ac_timing(
 					j++;
 				} else if ((table->mc_reg_address[i].uc_pre_reg_data &
 							LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
-					table->mc_reg_table_entry[num_ranges].mc_data[i] =
-						table->mc_reg_table_entry[num_ranges].mc_data[i-1];
+					if (i)
+						table->mc_reg_table_entry[num_ranges].mc_data[i] =
+							table->mc_reg_table_entry[num_ranges].mc_data[i-1];
 				}
 			}
 			num_ranges++;
-- 
2.43.0


