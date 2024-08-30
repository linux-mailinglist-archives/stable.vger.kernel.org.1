Return-Path: <stable+bounces-71652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3719F966336
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0BA1C235AE
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987BE1ACDE8;
	Fri, 30 Aug 2024 13:43:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B026ACB;
	Fri, 30 Aug 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025399; cv=none; b=mWubABkRshCEPA/RriqvRXQyzqhrHqgbSA46mdyDpQhB0/0InZKxuwsf4Jzes5uO/tuvhr8Vwvqoj0h8ZoS8hkNfvosiSTcQJGHf6lm6zOkdaxszkb8IK4kHuV364PSGbiTxdEwVFGoEnCFggfwFuuLj2petBBsxTrBynuD1W5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025399; c=relaxed/simple;
	bh=f1R0koMml7lKfyHh7RQ05dSO/br5e+PtMQqNKcmrDHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iozq3BdkAfRXg+ulV5Nx3BFizTMvumil/10dpv2eqafkXWTsYiIIbqhovTE73SZfS11fPqdpuQhDMC/WFluNQw/tw3sYC7d83BTXExFKQUlh73hi6gW3N1r+D2rArDMoRhuEk4oWbdJNsYnxfmfLKvkBko3un3+MPJF/5q6Pc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAAnDzpmzNFmqgt9Cw--.39437S2;
	Fri, 30 Aug 2024 21:43:10 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	alvin.lee2@amd.com,
	jun.lei@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	moadhuri@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Add null check before access structs in dcn32_enable_phantom_plane
Date: Fri, 30 Aug 2024 21:43:02 +0800
Message-Id: <20240830134302.3440772-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnDzpmzNFmqgt9Cw--.39437S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFyftrykJF1fAr1fGrWktFb_yoW8Jryfpw
	43Gayakw1DJrnFga9xJ3WjqFZxW3WvkFZ7KrZIywna9ayjyr93C3s8ur9xCrWUGFyjkw43
	tF1IyrsrKF4qyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRil1vDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In dcn32_enable_phantom_plane, we should better check null pointer before
accessing various structs.

Cc: stable@vger.kernel.org
Fixes: 235c67634230 ("drm/amd/display: add DCN32/321 specific files for Display Core")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 969658313fd6..1d1b40d22f42 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1650,6 +1650,8 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 			phantom_plane = prev_phantom_plane;
 		else
 			phantom_plane = dc_state_create_phantom_plane(dc, context, curr_pipe->plane_state);
+		if (!phantom_plane)
+			return;
 
 		memcpy(&phantom_plane->address, &curr_pipe->plane_state->address, sizeof(phantom_plane->address));
 		memcpy(&phantom_plane->scaling_quality, &curr_pipe->plane_state->scaling_quality,
-- 
2.25.1


