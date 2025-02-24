Return-Path: <stable+bounces-119302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD87A42576
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9545B19E1880
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590224397B;
	Mon, 24 Feb 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1+WMqyv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371624169C;
	Mon, 24 Feb 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409003; cv=none; b=iblnwp6MsGJX9S85dkHSOs8tHkX4Z1X268pRj/L1//mx6q9gjmtb56ty/hmcskNvxSCIdFzqspHs1cW8k1qr+No7b/FUtxsjYanjqf4kGKebadyMa+Wd2dhJ7HfVWAaz5GTI2mMszSNmkMRJHBk69cxDa3vC/S4ZlQkt8EU6AGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409003; c=relaxed/simple;
	bh=Pyyb2lLDraUSxTi8GsvFJ8ynCHbXsbcDYdUJF0bvR80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qohx8ZkW/cm/94K8mGzuKjFbQESBFjI9uWxuETrMhbx1VFXiVmHHdIRZXVr5da2RfV921+hf0f6NmS7arf77Ah6fYxOJ6rJza7y6Z8tyLIhE5zs2Yv9vqbdqvJyFkMUfI/a9T9fmkvfS9dLACzUMGHN2tuV9GWtZHdf2kmr4pDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A1+WMqyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE28C4CEE6;
	Mon, 24 Feb 2025 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740409003;
	bh=Pyyb2lLDraUSxTi8GsvFJ8ynCHbXsbcDYdUJF0bvR80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1+WMqyvE9eo7zm8GSm/VvIiCcyEBoSSuevMRyyzcyD7fMAGBo4eJY9l0btqoGsbv
	 pp4LLZZFEPdVabSQJoKfnyamjpe3CSppenytyeHka6/66F78sT60VO3QFYNuNRLWDK
	 +3Qy+in6w+4e6Yfi8naMo78wSIeOsRXF1jdAH0CQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 069/138] drm/msm: Avoid rounding up to one jiffy
Date: Mon, 24 Feb 2025 15:34:59 +0100
Message-ID: <20250224142607.186685977@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 669c285620231786fffe9d87ab432e08a6ed922b ]

If userspace is trying to achieve a timeout of zero, let 'em have it.
Only round up if the timeout is greater than zero.

Fixes: 4969bccd5f4e ("drm/msm: Avoid rounding down to zero jiffies")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/632264/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index d8c9a1b192632..f15962cfb373c 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -530,15 +530,12 @@ static inline int align_pitch(int width, int bpp)
 static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 {
 	ktime_t now = ktime_get();
-	s64 remaining_jiffies;
 
-	if (ktime_compare(*timeout, now) < 0) {
-		remaining_jiffies = 0;
-	} else {
-		ktime_t rem = ktime_sub(*timeout, now);
-		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
-	}
+	if (ktime_compare(*timeout, now) <= 0)
+		return 0;
 
+	ktime_t rem = ktime_sub(*timeout, now);
+	s64 remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
 	return clamp(remaining_jiffies, 1LL, (s64)INT_MAX);
 }
 
-- 
2.39.5




