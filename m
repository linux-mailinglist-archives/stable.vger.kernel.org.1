Return-Path: <stable+bounces-165123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0250B1536B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1DDC7ADFD7
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFF01F4295;
	Tue, 29 Jul 2025 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5euAnIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12A290F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817488; cv=none; b=FzOZb5hayMSNlNLRriVAV2Tbj+9Qz0KscT5l0mfK4R1l519jGD00EYdby9muQeVFD5nzfJ4ASzStgAk9aMOG6r/9a6rpjBgNg7OPWbKMoK4zVU0KeVEwIn95xYBrB7/lYgcnJPS1TrVau5vaFRAPluElWUL0XS4BtpOUjcOz+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817488; c=relaxed/simple;
	bh=xqqs8ehmPAZoB/krkxs9MowobDaiy+kO1er+qnMveLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nr+aOEcbsv3BJuwNUJK1hNd8j0DIS6TUXP20/BMfAHYs9V1rPIs880kA7ougoM6RQEeTSo2Rv9Kx5jSBOGkYAdGq4ezQxoo9YCOHTegNIzKZLbHDDj/yTUrVFu2AFxiip5knhoVS9RUZy9da34AczHPf3sg9CJHPh+Dti3YQZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5euAnIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154C0C4CEEF;
	Tue, 29 Jul 2025 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817487;
	bh=xqqs8ehmPAZoB/krkxs9MowobDaiy+kO1er+qnMveLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5euAnISeiMZl5EAd+en8BqDY1NLOkjm2Iiy51hdBoD3bnoAlBs8OB9hyH12h2lJ0
	 Y/EoTsVq+eIrXda6SZsEONG8+JNpal/0rGF2EmZA87wjfRcPlYSp5EXMRUcC8Zlr7Z
	 uyrTEXE6kE0igIqM9g32JZ0++OLUsItjhDvNmBk8CBzWF63CgEgGRQtkL9lQitmRjr
	 wOnm3mOtAdCd80SSuftcrqpp4/hLDFBuloiu25p5S2W6Oh0uKRCNKVGf9E3HkNpBmD
	 Mcusf1RehOq8WDPv//TxKDG/xvfqGQQz1xU3wyRhLw2ynlezGnOsQ8ZyK8P6u0SboN
	 BCCMbk39T+sEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Tue, 29 Jul 2025 15:31:23 -0400
Message-Id: <20250729193123.2873807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072801-game-appendix-1d20@gregkh>
References: <2025072801-game-appendix-1d20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 4ff12d82dac119b4b99b5a78b5af3bf2474c0a36 ]

Add check for the return value of devm_kmemdup()
to prevent potential null pointer dereference.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ applied the patch to ice_flex_pipe.c instead of ice_ddp.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 6cfe8eb7f47d..14fba20ab7f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -753,6 +753,8 @@ enum ice_status ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf, u32 len)
 		return ICE_ERR_PARAM;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_ERR_NO_MEMORY;
 
 	status = ice_init_pkg(hw, buf_copy, len);
 	if (status) {
-- 
2.39.5


