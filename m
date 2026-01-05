Return-Path: <stable+bounces-204923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523ECF5941
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1D830734EF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D3280A52;
	Mon,  5 Jan 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfgcwi8Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8E207A32
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646469; cv=none; b=tou5aMYnZu0b3R5um5LHgGFnIIBrL6egQ6e10NF84ZVDPmyw/gU6no7Y8z4Vr1/00YLWpodCy8mbkHkhEZlmOw4JQixIx6GX/dE0y95Af/Ei14tIpqAgMCPtNmFcklXPw5Ti5mlASRV63ccXNR+d3F+AfM0nVg2JySWrm7EDEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646469; c=relaxed/simple;
	bh=RkbwfKy0+fiKqh28GDPVoHtIQf6dL/nOS4+sZS/E1A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hB2ShT8jDJV4yzGaQ/5uhd79QXFJtYga9s+tifwkwrDEolT68Y0DfT3miCTnmjMplw76kBFmY0a7a2g45/ILJva8y/KJ76QpuVE/jkSvakJjb5Rz6cmBxVsoiVUI4ROzXYHhIevLdz1/6DtFu3WNitk3t7/Y+pKB20S7FSoCkn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfgcwi8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A23C116D0;
	Mon,  5 Jan 2026 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767646469;
	bh=RkbwfKy0+fiKqh28GDPVoHtIQf6dL/nOS4+sZS/E1A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sfgcwi8YxjCZezR4NVXKOby+stRY9oCEe1MNikAKSAIyL13UYJ59bhyzm5qP8psYT
	 Y6skdWNTrrhGGCVlPYVsImhK94R5OUFNsnJ4henfuVe1yKHKoZpjRMWRuifAy0sbLw
	 8dIrW+j3yWsVbXxm3dWp96hzXwcJqZGkHg8tKEHzCTtPzSnRlOt76lvA8sYuaeNq7f
	 o9tvwUez0Y7AgY10vN/TPKsRD6nb12pq9Ent8SjHTGjl5sr32qy+6YBi6YlYevSNxx
	 SzBGqGZ2+7LQROstr7tM2t21Aa7qRbYw12EtSOAtpLqItm2H8Fv5Ltk67Hvatet6vE
	 bFfJ6ckkD1J7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: verisilicon: Protect G2 HEVC decoder against invalid DPB index
Date: Mon,  5 Jan 2026 15:54:26 -0500
Message-ID: <20260105205426.2793242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010511-molasses-woven-927b@gregkh>
References: <2026010511-molasses-woven-927b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

[ Upstream commit 47825b1646a6a9eca0f90baa3d4f98947c2add96 ]

Fix the Hantro G2 HEVC decoder so that we use DPB index 0 whenever a
ninvalid index is received from user space. This protects the hardware
from doing faulty memory access which then leads to bus errors.

To be noted that when a reference is missing, userspace such as GStreamer
passes an invalid DPB index of 255. This issue was found by seeking to a
CRA picture using GStreamer. The framework is currently missing the code
to skip over RASL pictures placed after the CRA. This situation can also
occur while doing live streaming over lossy transport.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index bcdfa359de7f..618029926a21 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -264,6 +264,15 @@ static void set_params(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &g2_apf_threshold, 8);
 }
 
+static u32 get_dpb_index(const struct v4l2_ctrl_hevc_decode_params *decode_params,
+			 const u32 index)
+{
+	if (index > decode_params->num_active_dpb_entries)
+		return 0;
+
+	return index;
+}
+
 static void set_ref_pic_list(struct hantro_ctx *ctx)
 {
 	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
@@ -336,8 +345,10 @@ static void set_ref_pic_list(struct hantro_ctx *ctx)
 		list1[j++] = list1[i++];
 
 	for (i = 0; i < V4L2_HEVC_DPB_ENTRIES_NUM_MAX; i++) {
-		hantro_reg_write(vpu, &ref_pic_regs0[i], list0[i]);
-		hantro_reg_write(vpu, &ref_pic_regs1[i], list1[i]);
+		hantro_reg_write(vpu, &ref_pic_regs0[i],
+				 get_dpb_index(decode_params, list0[i]));
+		hantro_reg_write(vpu, &ref_pic_regs1[i],
+				 get_dpb_index(decode_params, list1[i]));
 	}
 }
 
-- 
2.51.0


