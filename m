Return-Path: <stable+bounces-76122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8902E978CBA
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 04:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8431C23F31
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 02:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DCCD517;
	Sat, 14 Sep 2024 02:18:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB19463;
	Sat, 14 Sep 2024 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280333; cv=none; b=AAaU+aQWPgV44L6IKx9jDzfIHg/IHGHU0aDvfoeMeLXZ9pQZCsGZVRJ2m51jiQwAeanuVhhqgyiIdVAMGeRGDkULcf0lflsZ7Rh/QJLtqBwZL5HGh1UMUI2qQFc1I85A5FZ5EUfXp5Wv7vv5uZxrREUUttqZEQgxKq/oGK9jFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280333; c=relaxed/simple;
	bh=oAaqmpUJBiUQI/zZYURIWxhGmsDCIPunojLSr9Ghx/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9qE0lMEIShCtOXB78VUizHnl9m6gz1Gmjsu9DyPeCLYvBz32HyC4ZxkTmVra6j4jS+hRMofmSsu5eIhWXcp5zTDLg1Gl9HsUpI1IcRx0tjPJ2AZ+eneHLFvO+NarV0gHiyuunKwYYSTTIwibqflrtjM7dAgM0qactRP5Cy9CwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAAXHn568uRmbfmMAw--.6012S2;
	Sat, 14 Sep 2024 10:18:42 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	harikrishna.revalla@amd.com,
	make24@iscas.ac.cn,
	martin.leung@amd.com,
	alex.hung@amd.com,
	Tony.Cheng@amd.com,
	Yuehin.Lau@amd.com,
	akpm@linux-foundation.org
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Skip dpp1_dscl_set_scaler_filter if filter is null
Date: Sat, 14 Sep 2024 10:18:33 +0800
Message-Id: <20240914021833.2168183-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXHn568uRmbfmMAw--.6012S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKryfAry5Wr43CrWfCrWDCFg_yoWDCFc_Jw
	18Zrn5t34Uu3ZrXr109r4rury2v3Wj9Fs7W3WIyayakryagry8W34UWryDWwn8Aa17AFZr
	Ca4vgFn0y39FgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRBVb9UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Callers can pass null in filter (i.e. from returned from the function
dpp1_dscl_get_filter_coeffs_64p) and a null check is added to ensure that
is not the case.

Cc: stable@vger.kernel.org
Fixes: 5e9a81b2c465 ("drm/amd/display: separate scl functions out from dcn10_dpp")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
index 808bca9fb804..bcafeb7b5b79 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_dscl.c
@@ -248,6 +248,9 @@ static void dpp1_dscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	REG_SET_3(SCL_COEF_RAM_TAP_SELECT, 0,
 		SCL_COEF_RAM_TAP_PAIR_IDX, 0,
 		SCL_COEF_RAM_PHASE, 0,
-- 
2.25.1


