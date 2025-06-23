Return-Path: <stable+bounces-156226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889EAE4EB5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F79317C837
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE222257E;
	Mon, 23 Jun 2025 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guNGg11z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659EF222571;
	Mon, 23 Jun 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712892; cv=none; b=t3YULQ4WrG6n4q6QIgCkyPfvkh/pac4/FlN5rZ6UI2aGt2+BiJ/umIXAjeYv7eu3ipbw89kYEEEvyq8DPzh7WNF9mJ0N8mVyE5gQrxEN1b9vUrIwFSNPs5hMTeejB2K9wR5nme97grPIlVrwSVowqzkjty/OsVTowl2ujFbqSmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712892; c=relaxed/simple;
	bh=+o38zznj9MnH0ZpBLQNJLM7iEFbbkN7TLZ7pbSgd8n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3ULzYopbuVW0h/fgqg1UgfAXgcI6oySFZxzrFsJ5ZGiCobQJpunq35CIBpUMBFuNkSEzIKhhTZsZlz6GLs6Zw6W+Amb+MT4G0EcmeUf7k9dFBBuYbdQEf6teeOwIdU0fthfkD5JYYlzWgK+ctkpXM797+RNd3aKT98C/NKV5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guNGg11z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD1BC4CEED;
	Mon, 23 Jun 2025 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712891;
	bh=+o38zznj9MnH0ZpBLQNJLM7iEFbbkN7TLZ7pbSgd8n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=guNGg11zf6y5jMJZn7KjWA/QjDeOoms38nzdojywcDb+KaaVO8LF2KODAZXXuDx/I
	 SqiT9XExsUcYOa3D7+JOI9jdi8hQ3noTzGVTimFRdliTmRKUnEO7LYXcYoLqwuEmq/
	 4hdS/azJYK3XijU80GKQIyyqJdHx1sialDJlWLA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 6.15 299/592] drm/msm/dpu: dont select single flush for active CTL blocks
Date: Mon, 23 Jun 2025 15:04:17 +0200
Message-ID: <20250623130707.501458537@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit e93eee524bb78f3ee4b78654d0083382f98b3d23 ]

In case of ACTIVE CTLs, a single CTL is being used for flushing all INTF
blocks. Don't skip programming the CTL on those targets.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/641585/
Link: https://lore.kernel.org/r/20250307-dpu-active-ctl-v3-5-5d20655f10ca@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index abd6600046cb3..8220a4012846b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -372,7 +372,8 @@ static void dpu_encoder_phys_vid_underrun_irq(void *arg)
 static bool dpu_encoder_phys_vid_needs_single_flush(
 		struct dpu_encoder_phys *phys_enc)
 {
-	return phys_enc->split_role != ENC_ROLE_SOLO;
+	return !(phys_enc->hw_ctl->caps->features & BIT(DPU_CTL_ACTIVE_CFG)) &&
+		phys_enc->split_role != ENC_ROLE_SOLO;
 }
 
 static void dpu_encoder_phys_vid_atomic_mode_set(
-- 
2.39.5




