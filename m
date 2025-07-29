Return-Path: <stable+bounces-165121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA7B15356
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA72544D47
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982DB234964;
	Tue, 29 Jul 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC5Luka9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532721CC4F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816609; cv=none; b=A1F8s1s9F7GxR/595c1OwlIWtkBtfY0jQtN6uUyxRpFEd4v/D0zD5V5FoDgJCmv5iEx/D6QwN4yiul5+PCkSg4/3fis4XSYJqAuwp1v/71tvsPupGg2apBo7aIYbypcXzxlGQQ9KGatfyZJKVwZae5ciy6uPfDtFgkUxuViTkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816609; c=relaxed/simple;
	bh=hdnXpxfEqGCO5x9C2bF2JrX4CC5MYrWExS71y7c7fMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmKrlTCgL9i67aSEAhv7V0/uIIEccXm2J33HlXAjhDLeFD1nAbPlVY9k82rGtksuuiGDQ2UtFrRfPUCwZpiHAwS8QHj6NFuNNkN5X/fkeUaUG6Jn/5ZGkWd5ZWc9b6Gua2QF5l0vMJHIxw2ugfaTlxvfXiZ/+D9cX3hiWju+Q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC5Luka9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C68CC4CEF6;
	Tue, 29 Jul 2025 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753816608;
	bh=hdnXpxfEqGCO5x9C2bF2JrX4CC5MYrWExS71y7c7fMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FC5Luka9pPyoVlAjMb06ORGMv6mE0QWDBaVkc6tZkvFllC4BmRoL4D4C7xRQvoFFL
	 V3L8T98fxapvmIdw5JtgYI/iTbYdKirux5mUXjmvLefTjqr3X1oa9TQWHO/8EvGdzu
	 Ljwi+oF+bHA62r0Ua/oaeIPqXAoSvRq3b3A9fv+Kw9+ifHhrY9tsYK7cVBcKsTnIAo
	 oC6d9bEIpzgq5sEQ3Y4br4JOf8HvdG8SiYPvX+UxK6h5bZH70PqcmWf7j4HSM1R7yE
	 OM9xKZiCPNdF5Yn46ot85/RJzjsPDatrzHOAbSACcRbQKHI+ZZF1H1rDJvIMQM+tCV
	 knJO/HOtkOMwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Tue, 29 Jul 2025 15:16:44 -0400
Message-Id: <20250729191644.2869910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072858-pentagon-gumball-b400@gregkh>
References: <2025072858-pentagon-gumball-b400@gregkh>
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
index 1ac96dc66d0d..6b753fd5b335 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1448,6 +1448,8 @@ enum ice_status ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf, u32 len)
 		return ICE_ERR_PARAM;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_ERR_NO_MEMORY;
 
 	status = ice_init_pkg(hw, buf_copy, len);
 	if (status) {
-- 
2.39.5


