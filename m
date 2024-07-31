Return-Path: <stable+bounces-64850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB47943AC9
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBAB1C21CB4
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6145139CE3;
	Thu,  1 Aug 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l99PXG/4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA139FEF;
	Thu,  1 Aug 2024 00:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471054; cv=none; b=SsUBTsrS+NWj1sK5xTa4RfpyhUMqvnz0d1osTm3HRm3BtZEVpZU+/0/tqj9DiK2Yev0/Ud001lfV23Njy0U8FynpUwlX757l+bnyWLTVdFeFCRVIRRawRd5XNx83Pmc9BO+5gaLS2nXExq91m5BorOik7H+key4GApPH8WwiMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471054; c=relaxed/simple;
	bh=lnGsopCdQ3YCETQ6p1SzZFA1vxl8RvJ0QmX27zQcH/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhyaOzcUXzlbfVhxsWGXFiezUFiDKoq/cAM84K9ouxt6Ww6zk2zq7tJoerc9Y8U+Z4OJiKbfiWelnbG4uqlVmR+k9l5klX8atDjTiwpz0R/uU0suKHNs5+h6bbaac5vXIGKE/mdz5WQeBMThA388rY92OF9t2rYuCOA4K7Y0Kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l99PXG/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F08C32786;
	Thu,  1 Aug 2024 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471053;
	bh=lnGsopCdQ3YCETQ6p1SzZFA1vxl8RvJ0QmX27zQcH/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l99PXG/4W8ab8bWT2T5ns+8DGMYmdygZ+8RZwuupENianq78YSgw1zxxwFg8Jjqiw
	 eQoW664v3mddedHfKp6e069BQY2UK7QXBEeS1CZi7v0MPJjzzrNqJPOuEUKPAmxoQx
	 K5kB1Ko2VGbc9nSxfkJnLVyXMLMu6TWZQUsfwjILPWEhFGdO/TgbbpbSsyCxfyjSo8
	 +7PbS5TiX62hkTYywddhw+KC7sn6DyYYmGoeHoDjsVt/OGWr6t9K3F3aExARjjKMZE
	 Z56idNHAAtOSEPEUeQ85Hcq8E1VgboUkX92+wjLVblZNe2i73PwsA7CQKP5hK06Ydp
	 6Lpb6FqNmbZVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alex.hung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 025/121] drm/amd/display: Fix Coverity INTEGER_OVERFLOW within dal_gpio_service_create
Date: Wed, 31 Jul 2024 19:59:23 -0400
Message-ID: <20240801000834.3930818-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit c6077aa66fa230d12f37fef01161ef080d13b726 ]

[Why]
For subtraction, coverity reports integer overflow
warning message when variable type is uint32_t.

[How]
Change variable type to int32_t.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index d19d5c1770222..f344478e9bd47 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -56,7 +56,7 @@ struct gpio_service *dal_gpio_service_create(
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
-	uint32_t index_of_id;
+	int32_t index_of_id;
 
 	service = kzalloc(sizeof(struct gpio_service), GFP_KERNEL);
 
@@ -112,7 +112,7 @@ struct gpio_service *dal_gpio_service_create(
 	return service;
 
 failure_2:
-	while (index_of_id) {
+	while (index_of_id > 0) {
 		--index_of_id;
 		kfree(service->busyness[index_of_id]);
 	}
-- 
2.43.0


