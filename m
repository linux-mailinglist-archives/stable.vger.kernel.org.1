Return-Path: <stable+bounces-165122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED0B15369
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927483BB29B
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B15234964;
	Tue, 29 Jul 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsDDjh/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD2347DD
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817134; cv=none; b=G4ghSmQcD3MQjEGgSWpqnfYybCFjz6+4bb5JEJDuXdvhAOQPIemdxFNLO/98AXv1BpgVeHD/FUPlQDipdikaGDfVBkZ3poFubvB7XWiHgVDFPm7m9NnuKg4wLjUoPsQ0OpS1BQNnYxG6xFihn9mCPpIN3S7b/W9GdZfvsnWE790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817134; c=relaxed/simple;
	bh=Ob3nrXcC0YDa5cEtCMvRn2vKvPc8VzIOg9H1f3sMtNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vGJ7kqVe3v1h51FO00Zj7nZTvQAwp5dXizRU9or7ZoWSRQxLs3SYtfc1AJ9Tavy6pemCjOSAJfphTK5NvvgUPL+33g03fFQWRPaiJApZrf4sfgVyoW+v83pwdf+5MPHx5PIiAcQEia1Fe22IuXDsEkNtTE4bsMuna0IXb6CXDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsDDjh/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368F5C4CEEF;
	Tue, 29 Jul 2025 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817133;
	bh=Ob3nrXcC0YDa5cEtCMvRn2vKvPc8VzIOg9H1f3sMtNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsDDjh/ElgX/xOtGao6CbAmIKrlCZlKHHZdOlk1gRdQLzLZ4EBnv7wLk0O5oh52vZ
	 RG4MWRIp1AxpwzVZZU2EYLK4XXBvMg88/q3BBPZ9bM5W+dhaMP5RLq2XPWsxrNmP0N
	 HHhWr84jo0HjIGH4z8WWxRpzbzc1oyyfwydWDXSRhdArB0YMSjNjGqEz87Vkpslgpw
	 WviiQzvHXEGfGKTCAL7xizjzWOmB9WGbOmUOVkd5z+ebMXsbq8NQdUJbap1OGB2oTF
	 nqA/OIY4T1XlYusUu0F+XiJcowkIKK71QZe9vjMsf91UXhPnkkAwRaMqPYNw6JZ2KO
	 ZBU1+ZsQt4l/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
Date: Tue, 29 Jul 2025 15:25:14 -0400
Message-Id: <20250729192514.2872668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072801-groove-marauding-e4a9@gregkh>
References: <2025072801-groove-marauding-e4a9@gregkh>
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
index a81be917f653..da2906720c63 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1449,6 +1449,8 @@ enum ice_status ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf, u32 len)
 		return ICE_ERR_PARAM;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_ERR_NO_MEMORY;
 
 	status = ice_init_pkg(hw, buf_copy, len);
 	if (status) {
-- 
2.39.5


