Return-Path: <stable+bounces-124119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE655A5D64B
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753453B44B3
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34B1E3793;
	Wed, 12 Mar 2025 06:31:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516731E4929;
	Wed, 12 Mar 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761097; cv=none; b=bVjU0PLx+TcenSDd2bE64GB4usfNxn+TD65Jn+/SZRcDiq1mtfRZE/RSndthg4O2Sladd3d8hbljuru8FTg3ssF2A22Y/f9N/0cgn/KpwzwTJRsgh3/jSf/h6Cye7CrXuJjNEAAwJPzfMpAt/l+PsxRgYROLEi6m/Nd10I1S8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761097; c=relaxed/simple;
	bh=1GGLTSO/cCsSpoGDptYKoajR+ZwOpgbJKrvikdoOCRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+vdR1fMvR+vu5svVbGi6sLIZiHhJpGraCp2XaeURlluJkLuz1pYRoX+pYRAEVv/Aqoh90tpsXvVA/k7r9JCvJg62s5lzbKBuL443201kctF8VSMeNtC9+4X5G5HLw0+ydLFGfW75Edlin7Gp0Vr3pJBEq9UtrHPOILBAbogQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowABXhPs6KtFneEl5FA--.37073S2;
	Wed, 12 Mar 2025 14:31:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Hawking.Zhang@amd.com,
	Likun.Gao@amd.com,
	sunil.khatri@amd.com,
	kenneth.feng@amd.com,
	Jack.Xiao@amd.com,
	marek.olsak@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/gfx12: correct cleanup of 'me' field with gfx_v12_0_me_fini()
Date: Wed, 12 Mar 2025 14:31:06 +0800
Message-ID: <20250312063106.772-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXhPs6KtFneEl5FA--.37073S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw17Aw17Kw4xtw4UZFyfCrg_yoWkGFX_CF
	4UJr93Wr4UCF1qqw1xZr1YvasFkF15ZF48Ka1aqas5GrZ8Z343Kry8Kr95WF4fuan3C3Wk
	XFyUWF1ftasxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb7Ks5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsTA2fQ4meNigABso

In gfx_v12_0_cp_gfx_load_me_microcode_rs64(), gfx_v12_0_pfp_fini() is
incorrectly used to free 'me' field of 'gfx', since gfx_v12_0_pfp_fini()
can only release 'pfp' field of 'gfx'. The release function of 'me' field
should be gfx_v12_0_me_fini().

Fixes: 52cb80c12e8a ("drm/amdgpu: Add gfx v12_0 ip block support (v6)")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index da327ab48a57..02bc2eddf0c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2413,7 +2413,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      (void **)&adev->gfx.me.me_fw_data_ptr);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to create me data bo\n", r);
-		gfx_v12_0_pfp_fini(adev);
+		gfx_v12_0_me_fini(adev);
 		return r;
 	}
 
-- 
2.42.0.windows.2


