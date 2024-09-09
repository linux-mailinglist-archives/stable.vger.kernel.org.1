Return-Path: <stable+bounces-73954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE1970E01
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC3A1F228B2
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750261AC8B0;
	Mon,  9 Sep 2024 06:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE01AD410;
	Mon,  9 Sep 2024 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864019; cv=none; b=eLsJ1aIOlaJvJ0SCW37bAESSX+UDTx7VhQkkUgJznII52zwU2Fwz94bcY8C8mM/5wyum9wD3Y6H1YlHO+HdkN+RYoq0y/npzLacT7jQCR9EbbpRqrxM8ICkqPMJHHTl6WVYeFdF0xDdp8KSe1m6LGC04eafg4iUY4XvIXfLx64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864019; c=relaxed/simple;
	bh=f1R0koMml7lKfyHh7RQ05dSO/br5e+PtMQqNKcmrDHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nq3FpVz5DiBSh2SiECHsnjdgkCTMKfd3S9OO20WYV9IvGS/+2pci0VDsI2IfO8Rp4egppIXlp3dH0wP7RfbxZTyStWki8rte2DGYfOB1s1Rwh1sUfjiN6YF6AQ++PDdSeTxkTz9bXSsg9Dz+/zre/kFyk/H1jGisjD+E0s2Ql14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAC3vn5BmN5mcIQUAg--.35475S2;
	Mon, 09 Sep 2024 14:40:09 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	roman.li@amd.com,
	dillon.varone@amd.com,
	moadhuri@amd.com,
	aurabindo.pillai@amd.com,
	akpm@linux-foundation.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/amd/display: Add null check before access structs in dcn32_enable_phantom_plane
Date: Mon,  9 Sep 2024 14:40:00 +0800
Message-Id: <20240909064000.1198047-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vn5BmN5mcIQUAg--.35475S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFyftrykJF1fAr1fGrWktFb_yoW8Jryfpw
	43Gayakw1DJrnFga9xJ3WjqFZxW3WvkFZ7KrZIywna9ayjyr93C3s8ur9xCrWUGFyjkw43
	tF1IyrsrKF4qyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRH7K3UUUUU==
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


