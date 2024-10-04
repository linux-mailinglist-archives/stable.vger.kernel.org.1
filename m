Return-Path: <stable+bounces-80851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE18990BD6
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B0B1F21D9F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ADC1EABAE;
	Fri,  4 Oct 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMU3oGa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549CD1EABA6;
	Fri,  4 Oct 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066043; cv=none; b=stUAdSKEvPkQ6xhFXhRcT9/IPQavuFbx3flrGl42T7CNp1Zpise0sAuo+9sDS1dhEmtZy4uoGLyGu8DXuIrgf45tEo5p6qjzfTY5BuSLHFu04nzQ72UeWrW0oA/hREpACms4/ee235+te/76uKlGpfCfwNJql1DhYHKAGmxywrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066043; c=relaxed/simple;
	bh=qCUkdYZFENPx3eZTiw+UAraDYp+IYqhWq1wkRorpgGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6Vzqiv5BIMZfUtRNBfAbr1dmXqgEZp2boM3PykERrElnfW+SdVXDZdCkk7ejmw7oeI9HwyrmMfKXYwSzemGbMr+IJD4x2D3p+4+/UPicLgtuiKNn+Jo6kV3OEH6F58nxRiPKiNmK3hK/rN26JAvfV43SgVToC0k0YppOscuAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMU3oGa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C9C4CECE;
	Fri,  4 Oct 2024 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066043;
	bh=qCUkdYZFENPx3eZTiw+UAraDYp+IYqhWq1wkRorpgGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMU3oGa0KwsARgkSpaqjVdPLvhDS5EkpPYJaJvoO3xj2LKqPs08rx+TpwSiHD89xC
	 agVCtln4lPqTO5eYKUlBY2Tn5leqZoT2rh+/kcC4kn3e81FVAV28huXL6ovVo0U6Su
	 YKhWIGdI686BvOVbtbB5jr+dGk2E7gQi5edsEtlJG1+R2ekTG6xifTanlZdKjqeOy+
	 gM/NH1xeCFCrKghkaWekBF4Q6pP2w1RGNYU6D0SsPGhHRqeqKnk7b4tOCwKfuOHpfh
	 ZUhrNZf4sznq7PglcDA3qo5fCSdVFnmseOrcXtBmKmhEWx1q2CHxFwtVVt4/dBRv49
	 2FhHtni7TAraQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 71/76] drm/xe/oa: Fix overflow in oa batch buffer
Date: Fri,  4 Oct 2024 14:17:28 -0400
Message-ID: <20241004181828.3669209-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: José Roberto de Souza <jose.souza@intel.com>

[ Upstream commit 6c10ba06bb1b48acce6d4d9c1e33beb9954f1788 ]

By default xe_bb_create_job() appends a MI_BATCH_BUFFER_END to batch
buffer, this is not a problem if batch buffer is only used once but
oa reuses the batch buffer for the same metric and at each call
it appends a MI_BATCH_BUFFER_END, printing the warning below and then
overflowing.

[  381.072016] ------------[ cut here ]------------
[  381.072019] xe 0000:00:02.0: [drm] Assertion `bb->len * 4 + bb_prefetch(q->gt) <= size` failed!
               platform: LUNARLAKE subplatform: 1
               graphics: Xe2_LPG / Xe2_HPG 20.04 step B0
               media: Xe2_LPM / Xe2_HPM 20.00 step B0
               tile: 0 VRAM 0 B
               GT: 0 type 1

So here checking if batch buffer already have MI_BATCH_BUFFER_END if
not append it.

v2:
- simply fix, suggestion from Ashutosh

Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240912153842.35813-1-jose.souza@intel.com
(cherry picked from commit 9ba0e0f30ca42a98af3689460063edfb6315718a)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bb.c b/drivers/gpu/drm/xe/xe_bb.c
index a13e0b3a169ed..ef777dbdf4ecc 100644
--- a/drivers/gpu/drm/xe/xe_bb.c
+++ b/drivers/gpu/drm/xe/xe_bb.c
@@ -65,7 +65,8 @@ __xe_bb_create_job(struct xe_exec_queue *q, struct xe_bb *bb, u64 *addr)
 {
 	u32 size = drm_suballoc_size(bb->bo);
 
-	bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
+	if (bb->len == 0 || bb->cs[bb->len - 1] != MI_BATCH_BUFFER_END)
+		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
 
 	xe_gt_assert(q->gt, bb->len * 4 + bb_prefetch(q->gt) <= size);
 
-- 
2.43.0


