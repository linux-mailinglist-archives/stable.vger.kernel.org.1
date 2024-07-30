Return-Path: <stable+bounces-63569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9894198F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C81F25F4F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15364EB2B;
	Tue, 30 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqS5cc3p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF458BE8;
	Tue, 30 Jul 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357249; cv=none; b=BgqR82ZcM2MJ5ccH7Rk3ksQIdESWUgxXzPdR8LvV8KzTV77+Nzs820J4wK9Zx2kIVFAm+HG5dXEjILeQAhI2b1Qe9UovRE0Mk4/XywIKpeTXM2pK7gCtlZe3P43RyL1W2ncdo/cOIUgEezakuaSNLgWIr/66r7EWwnql3rMVhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357249; c=relaxed/simple;
	bh=Ig3uoltJ1QiiNV4+VrrjtzHP8DIedBvTR3vcFEi0jts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcMHqcHU6K5qdGIN4rqYyLTuJWSJaG/6QmLgAnG1xM1kMCrDnyplTqnc06w5rmshk3I8i+LLjXka/3cSXSHPBaMxMTB7chV9apykUklek9YuMhvpJhfPYwrKctpLyJ0Cq7gOC+c85UKa8g+1/zaEoDGxn3zYjcd+arbOZQ1fokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqS5cc3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07B0C32782;
	Tue, 30 Jul 2024 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357249;
	bh=Ig3uoltJ1QiiNV4+VrrjtzHP8DIedBvTR3vcFEi0jts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqS5cc3ppEZCPH7kS1iU8hbJa1exVE5l8YhhMCXRrIywYEb078yERBWmTMAAWDoju
	 JUgEtmRR3stsaefuxdbA0lBhXSuTybhSbbVNiL3b9YhOYhHiUY7gYS5rrDcTju4f/t
	 nJ+/t4No1jrcQnKuws1mUuR9TnJb3EM3fBBiUiGM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Walle <mwalle@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 233/568] drm/mediatek/dp: Fix spurious kfree()
Date: Tue, 30 Jul 2024 17:45:40 +0200
Message-ID: <20240730151648.987878456@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit 8ad49a92cff4bab13eb2f2725243f5f31eff3f3b ]

drm_edid_to_sad() might return an error or just zero. If that is the
case, we must not free the SADs because there was no allocation in
the first place.

Fixes: dab12fa8d2bd ("drm/mediatek/dp: fix memory leak on ->get_edid callback audio detection")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.kernel.org/project/linux-mediatek/patch/20240604083337.1879188-1-mwalle@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index ff8436fb6e0d8..48a4defbc66cc 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2058,9 +2058,15 @@ static const struct drm_edid *mtk_dp_edid_read(struct drm_bridge *bridge,
 		 */
 		const struct edid *edid = drm_edid_raw(drm_edid);
 		struct cea_sad *sads;
+		int ret;
 
-		audio_caps->sad_count = drm_edid_to_sad(edid, &sads);
-		kfree(sads);
+		ret = drm_edid_to_sad(edid, &sads);
+		/* Ignore any errors */
+		if (ret < 0)
+			ret = 0;
+		if (ret)
+			kfree(sads);
+		audio_caps->sad_count = ret;
 
 		/*
 		 * FIXME: This should use connector->display_info.has_audio from
-- 
2.43.0




