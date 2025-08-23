Return-Path: <stable+bounces-172609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E736B32960
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C5AA44B3
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7929C347;
	Sat, 23 Aug 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVM5v8GE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5329D273
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960280; cv=none; b=OiMmlhakbzNiwiAivQNgR2coqtxMMYFX2BtIwoiCFXQVyxTi+8Me9fhdjs9qnHLebgO/76F6GBu16oRH97Ux0VsQeB2D+d/eW1lCvHfblVlAe9qneHkS6L3WA5O1aixmyBqh9XEHmsKZP480/wyGTpsmKxgBAzAycFg8a+WClKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960280; c=relaxed/simple;
	bh=MBj83L2XbYnUn0rIiKVsJPDCV1CCI9e8/b4STVOoen0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXiDiHFFCccB//uGN63IuXqiRoY8x+1Pla71cpv91JHl2F3dnklGQ6OG/JqZVxVmL/lzTbZ/cW7pWlz6EhAIlILA4qpkgoaSzr74LP5ENHzPV1py9l51QsUOIR1tCclvKzdgqMdvgTwP+N8Ckql1523p3Lgh/MRgSQQuuJAlME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVM5v8GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0B3C4CEE7;
	Sat, 23 Aug 2025 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755960278;
	bh=MBj83L2XbYnUn0rIiKVsJPDCV1CCI9e8/b4STVOoen0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SVM5v8GEv5oaB5qvxuYYzJ6jhYJ1P9QGZbn0PJ9VLKEygWTwUK2B0SW+jmwpJngVf
	 2W5s8LhIKEVsv4fE2LIUJbkII7/TPRKRnZQfijeSPHttjAzZD0aHwxMT0/wKQ7oexP
	 2f7UzZd8kyD21SJupF1g6chxc6vqUHutFuJ4yxM5rQMZc/wS6XlsUlrCZ563EV9mpK
	 lZZlZkM1ju282dtndsp/AmLn8ZWw/sREJ3e7j9j0nz+jd5PIhTFknUEsTmKMXduw4L
	 YMkYMjsRCKQFJfGEPE/2Lmt2EDuGa/YV3AEL97dIZZLn5j43u4siOTls3w79d3X2u7
	 FJjKN9w4cD4dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
Date: Sat, 23 Aug 2025 10:44:36 -0400
Message-ID: <20250823144436.2255063-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082152-monkhood-dig-c861@gregkh>
References: <2025082152-monkhood-dig-c861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f ]

Reading DPCD registers has side-effects in general. In particular
accessing registers outside of the link training register range
(0x102-0x106, 0x202-0x207, 0x200c-0x200f, 0x2216) is explicitly
forbidden by the DP v2.1 Standard, see

3.6.5.1 DPTX AUX Transaction Handling Mandates
3.6.7.4 128b/132b DP Link Layer LTTPR Link Training Mandates

Based on my tests, accessing the DPCD_REV register during the link
training of an UHBR TBT DP tunnel sink leads to link training failures.

Solve the above by using the DP_LANE0_1_STATUS (0x202) register for the
DPCD register access quirk.

Cc: <stable@vger.kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250605082850.65136-2-imre.deak@intel.com
[ Call to drm_dp_dpcd_access() instead of drm_dp_dpcd_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ffc68d305afe..4eabef5b86d0 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -280,7 +280,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * We just have to do it before any DPCD access and hope that the
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
-	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
+	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS, buffer,
 				 1);
 	if (ret != 1)
 		goto out;
-- 
2.50.1


