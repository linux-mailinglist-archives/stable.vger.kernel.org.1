Return-Path: <stable+bounces-101211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFB9EEB5F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0101B1883AB4
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC72153F4;
	Thu, 12 Dec 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="js4B+XkT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2961537C8;
	Thu, 12 Dec 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016744; cv=none; b=nKup23O33SAzKvPAa6PFBnckD7ZbKkYnF7eaBxj+jFOwOg0xOrHLB+HjMc9gR5FGkN9mCTcD2EIaezhQvQ0wTMRRv2iyhwsNVQWDOR+mN/u0K5AUgVzIya8sfJrPfsLVimdLFx7puqOdRu6L3yRs0kBU3rPRHBF4BZPjqr6fIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016744; c=relaxed/simple;
	bh=OFR30SyCMz1moUpUKU2DkM4fTyG9KmnyeEhQhfLcUpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTIa+g+VyYFlMrro0opwv07U1fgwlyGakSzjejqjl0GqUGV3TYgxO91eqRA5VunY36wk9EJF0ouKXbYV6sT8P7shPMWS1KdaB6HML2bjc3tH5U/WF3FudHiWKKEBaYsDX0SheWoDYzE49oImCLLocI86c4p2x3UwmnJnnMtiies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=js4B+XkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1EAC4CEDF;
	Thu, 12 Dec 2024 15:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016744;
	bh=OFR30SyCMz1moUpUKU2DkM4fTyG9KmnyeEhQhfLcUpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=js4B+XkTj8/SL9JLm2njHhbOuYy4+6iNee9PDn2Bj7n+t4stlf85pAObjPzEPKhfK
	 CMhuJ0R0T4c/nkvJJtdjHM3tK688+ENUoQ82K8EGIt/ZxPwk6919xxwuq2WAP4xFAl
	 sPORnmxYO8s+nG3gW2olNtDT0wny+xVYk908vuj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 259/466] drm/xe/pciid: Add new PCI id for ARL
Date: Thu, 12 Dec 2024 15:57:08 +0100
Message-ID: <20241212144317.032245528@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>

[ Upstream commit 35667a0330612bb25a689e4d3a687d47cede1d7a ]

Add new PCI id for ARL platform.

v2: Fix typo in PCI id (SaiTeja)

Signed-off-by: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>
Reviewed-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240912115906.2730577-1-dnyaneshwar.bhadane@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/xe_pciids.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/intel/xe_pciids.h b/include/drm/intel/xe_pciids.h
index 59233eb008628..4ba88d2dccd4b 100644
--- a/include/drm/intel/xe_pciids.h
+++ b/include/drm/intel/xe_pciids.h
@@ -179,7 +179,8 @@
 	MACRO__(0x7D41, ## __VA_ARGS__),	\
 	MACRO__(0x7D51, ## __VA_ARGS__),        \
 	MACRO__(0x7D67, ## __VA_ARGS__),	\
-	MACRO__(0x7DD1, ## __VA_ARGS__)
+	MACRO__(0x7DD1, ## __VA_ARGS__),	\
+	MACRO__(0xB640, ## __VA_ARGS__)
 
 /* MTL */
 #define XE_MTL_IDS(MACRO__, ...)		\
-- 
2.43.0




