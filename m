Return-Path: <stable+bounces-140684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B0AAAACC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BECC3AE586
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D32394A1A;
	Mon,  5 May 2025 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9L11rqN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D32DA83D;
	Mon,  5 May 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485919; cv=none; b=C0X8FqMSb5iobY7S6wErP6VvtqPMldNrUL1HgMDo+iryqPf7mrlsBVFOqRceOdpCmRnzx6fTeBvcrjT5GEe6otcRZA9F97U9fypMesP5RuaOZk40yrL3ZyNXkhrzOm5ZnbTqvNTsIwlehCmXW6bkfM9Enrrb5HYMMKLJtNLQsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485919; c=relaxed/simple;
	bh=uvxc/RwacPLT4GamWlVGlBY+24pUFkBWyeL2EjRSZRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHzNm/FE2eP+I1gKOZhqDKXs4JGxMpy0qncncjsCATZgtdQljLVJup86zL/YrDXkNKfA511rBsIOpUNxtcHwwsPJ1vIat4255Z27XmMPhWXCtfsStMXki/B8nCHRFTQG6iC18aSxMEe6EAMkXnUxWxOwPvHLFg2JKyrkoa83fJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9L11rqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA3AC4CEE4;
	Mon,  5 May 2025 22:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485919;
	bh=uvxc/RwacPLT4GamWlVGlBY+24pUFkBWyeL2EjRSZRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q9L11rqNe3PjOMkewIox1eO+45/8SlvNC5T4PSwZVCDqxCy740kQ7BDwqXrU0aig+
	 Oz1SToiv55DDjB7OWDYDa34SPEGvHcTMUYdWJ4EpA6Vc9w+dsOVdnV3RzsP3cmBVtR
	 I9RnfPLLRR6elZYIy0A8tT+C4Ijv773/evdUZi6eZOViyOFUbe4/GGA2qOzwAJoH2U
	 mDImS7qhnX2k6sPFBAfnyKSfdlrAc0hONGkx51BjqiptybWQi2dLOYjOpZw88YZwWb
	 2TCuOImfyCZDon04yi86qb1H3e3gCmrGSCfTGsN7bC3LUeP0FnNbRheWxErFEcnlF2
	 IDKRLSnp2CiOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 066/294] thunderbolt: Do not add non-active NVM if NVM upgrade is disabled for retimer
Date: Mon,  5 May 2025 18:52:46 -0400
Message-Id: <20250505225634.2688578-66-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit ad79c278e478ca8c1a3bf8e7a0afba8f862a48a1 ]

This is only used to write a new NVM in order to upgrade the retimer
firmware. It does not make sense to expose it if upgrade is disabled.
This also makes it consistent with the router NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 2ee8c5ebca7c3..43146c0685dfa 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -89,9 +89,11 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	if (ret)
 		goto err_nvm;
 
-	ret = tb_nvm_add_non_active(nvm, nvm_write);
-	if (ret)
-		goto err_nvm;
+	if (!rt->no_nvm_upgrade) {
+		ret = tb_nvm_add_non_active(nvm, nvm_write);
+		if (ret)
+			goto err_nvm;
+	}
 
 	rt->nvm = nvm;
 	return 0;
-- 
2.39.5


