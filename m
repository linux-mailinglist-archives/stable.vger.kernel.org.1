Return-Path: <stable+bounces-58270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7079192B34C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F41F22A03
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CCD154457;
	Tue,  9 Jul 2024 09:10:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BA153801;
	Tue,  9 Jul 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516241; cv=none; b=ZytyIcejyhgD0yPVz+iLIF75d3LbdmD8KKK9JPd+80CMcZ/65p70aw0V9Tm27BZYQkeeyRF1uj7Zcy9mwbg2skUxQt5iLTq5eSWOsLqBqCN/77L8Jf2BYexKA9lYuHR4tEdP0EGLgxu0e7XeaLdSH0u/DAmCgmTBd3/+hQiJZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516241; c=relaxed/simple;
	bh=evSUdxk9VbSbh6MWHJ5Q0evp+PpEsVpxagtwNVZ3zK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMz2Vb+g2yYFzYetAVBvICKt6q00ylcQTetnd9eDeuImnzUQo/Ph5yy/Qi2DyQLPpD+/mzhxJqM+LvtwEcdqHRg4SFjqyBWOjHoaUY7DgfGuAZnQ6OeFxvdwNCfREzOs6RNWf7Vu3av8v6Kn2Rirlg1hL7u6OJm7YRk3bQ77v9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADn7+d2_oxmuspWAg--.37939S2;
	Tue, 09 Jul 2024 17:10:25 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	daniel.vetter@ffwll.ch,
	alvin.lee2@amd.com,
	wenjing.liu@amd.com,
	chaitanya.dhere@amd.com,
	hamza.mahfooz@amd.com,
	sohaib.nadeem@amd.com,
	samson.tam@amd.com,
	Qingqing.Zhuo@amd.com,
	dillon.varone@amd.com,
	stylon.wang@amd.com,
	akpm@linux-foundation.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amd/display: Add otg_master NULL check within init_pipe_slice_table_from_context
Date: Tue,  9 Jul 2024 17:10:12 +0800
Message-Id: <20240709091012.3123409-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADn7+d2_oxmuspWAg--.37939S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4fZr4kKr4kXw1kJrWkWFg_yoWkKFb_Kr
	yvvrZ5tw17uFnrWF1jvrn5ur10v3yj9rs7A3Z7tayI9r17ArWUurWfu397Wr15AFnrAayD
	Aan5Krn5C3srKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUrBMNUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

To avoid reports of NULL_RETURN warning, we should add
otg_master NULL check.

Cc: stable@vger.kernel.org
Fixes: c51d87202d1f ("drm/amd/display: do not attempt ODM power optimization if minimal transition doesn't exist")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- added the recipient's email address, due to the prolonged absence of a 
response from the recipient.
- added Cc stable.
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f6fe0a64beac..8972598ca77f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1177,6 +1177,9 @@ static void init_pipe_slice_table_from_context(
 		stream = context->streams[i];
 		otg_master = resource_get_otg_master_for_stream(
 				&context->res_ctx, stream);
+		if (!otg_master)
+			continue;
+
 		count = resource_get_odm_slice_count(otg_master);
 		update_slice_table_for_stream(table, stream, count);
 
-- 
2.25.1


