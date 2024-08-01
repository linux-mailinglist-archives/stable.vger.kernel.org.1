Return-Path: <stable+bounces-64892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652BC943BC1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E721C21CCE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA55194AC7;
	Thu,  1 Aug 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5H6PFjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743C19409C;
	Thu,  1 Aug 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471312; cv=none; b=lKA7Xkl7HjdPjdOGMbf3joIuAz3UrK4bfJIKx1/8f5u+GbX0htwj3sHvr/hZDj/+/jOJNDLs7G2lUh4KSbptQMmi1EMNoQEUTtPCTeWd0Mby8s/i6BYVetI3MaQr5yYBshkxZChoZFPUny64QTv0Bh9yUOtUGY+agYOjhYtK8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471312; c=relaxed/simple;
	bh=4jGE/HMHzC1CdEpHNS0Zke1c5VcLzul6vO3XVwoF4Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qgts6W9o8PcvM+HB553IM8RXuriXqOd+71antehClzNbShPfJ3wvccjeZT5bJGfewztyJAhRNaBEViqHU/cTfxjI9i+YgwwARdnLedu64nBHdEfpglP3RACQ030lMZk7mpcAoru9Ard/1E1uPBmZFaM+RwzQJk9HLChQ4/fkqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5H6PFjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26D5C116B1;
	Thu,  1 Aug 2024 00:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471312;
	bh=4jGE/HMHzC1CdEpHNS0Zke1c5VcLzul6vO3XVwoF4Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5H6PFjAacbTEc3ZFhuA78Rhp5eFmWjoWJxUs20y0Xvet6sel+vna2G50iszrEGCd
	 G90RkkD3SguVQsXNa4Exmm6wcMQ4CKQkBUtePs5KPE38egPG+53vSWTelY0/yah1hL
	 OcrGn+Yyp+T+uZ35wzFgj7/BUbx4ZCBp6UcazTIPDHFW64Sq4xVml7wPIStPYAvHHj
	 DrjlHkKuEXTOTKYxuSQ0K7xvSe2DCeKo6zJ2/mDr3exOxicsq/bXGBi5jmZLmOJhBj
	 PV/4rjYsceSF2QryHOyhRI+r3VrC7wLYmjxLsJWuM2aAJDpLx4jqSd7tNCAimVo7Z1
	 t1ZLn2eeo49Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 067/121] drm/xe: Check valid domain is passed in xe_force_wake_ref
Date: Wed, 31 Jul 2024 20:00:05 -0400
Message-ID: <20240801000834.3930818-67-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

[ Upstream commit 35feb8dbbca627d118ccc1f2111841788c142703 ]

Assert domain is not XE_FORCEWAKE_ALL.

v2
- use domain != XE_FORCEWAKE_ALL (Michal)

v3
- Fix commit description.

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240607125741.1407331-2-himal.prasad.ghimiray@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_force_wake.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_force_wake.h b/drivers/gpu/drm/xe/xe_force_wake.h
index 83cb157da7cc6..23b36d13f18a6 100644
--- a/drivers/gpu/drm/xe/xe_force_wake.h
+++ b/drivers/gpu/drm/xe/xe_force_wake.h
@@ -24,7 +24,7 @@ static inline int
 xe_force_wake_ref(struct xe_force_wake *fw,
 		  enum xe_force_wake_domains domain)
 {
-	xe_gt_assert(fw->gt, domain);
+	xe_gt_assert(fw->gt, domain != XE_FORCEWAKE_ALL);
 	return fw->domains[ffs(domain) - 1].ref;
 }
 
-- 
2.43.0


