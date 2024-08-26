Return-Path: <stable+bounces-70130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF995E7E7
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 07:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3B9B20921
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 05:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E874416;
	Mon, 26 Aug 2024 05:27:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E46E2BE;
	Mon, 26 Aug 2024 05:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650042; cv=none; b=J32GlJNBPMgU8Vk85FtOmigxFKsUBUtdqRr8fNBpQtwKXxiwwJeUkcmCrrKCehklKBHVUzEgmZYN0rucntSiRsqN01NeDOm/hBtJ/G0/jpIVSFFPZadDwalM6vZ8C4oafLETeYqkqV/oW+TUSmoIdlsT4kNnlWWgT5ykaSOVnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650042; c=relaxed/simple;
	bh=mLRLWlbycz/2XLpVP7A2pAPeJvDuFOq+quk8T8Szy30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CbUCoNKJXZ7fNJKGps4vBh1M95H69dKxODvTHtMAyND6MionSC4ap3WNp8n+0nz0nutvVXcTRI5VItB0JmsZYSywI855hsjHucupFgCKeE+HIrSAronbkxV3faQKt5z5oIv9Clz27An/qj8j3nG8iACCFAfYu4rcPm4rWFbXzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAC3vUkmEsxm4vuPCg--.18524S2;
	Mon, 26 Aug 2024 13:27:04 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: alain.volmat@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	laurent.pinchart@ideasonboard.com,
	akpm@linux-foundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] drm/sti: avoid potential dereference of error pointers
Date: Mon, 26 Aug 2024 13:26:52 +0800
Message-Id: <20240826052652.2565521-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3vUkmEsxm4vuPCg--.18524S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyUGrW5Gw1Uur4fCw4Durg_yoWfuFX_G3
	WUXrn5KryDKF4jqF4jyrn8AasY93929F48Xr10qa909rWkJry8X3y7WF1rWF1UXF1UtF9r
	Ka1xu3s09rnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

The return value of drm_atomic_get_crtc_state() needs to be
checked. To avoid use of error pointer 'crtc_state' in case
of the failure.

Cc: stable@vger.kernel.org
Fixes: dec92020671c ("drm: Use the state pointer directly in planes atomic_check")

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/sti/sti_cursor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index db0a1eb53532..e460f5ba2d87 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -200,6 +200,8 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 		return 0;
 
 	crtc_state = drm_atomic_get_crtc_state(state, crtc);
+	if (IS_ERR(crtc_state))
+		return PTR_ERR(crtc_state);
 	mode = &crtc_state->mode;
 	dst_x = new_plane_state->crtc_x;
 	dst_y = new_plane_state->crtc_y;
-- 
2.25.1


