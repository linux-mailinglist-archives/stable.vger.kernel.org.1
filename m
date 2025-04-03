Return-Path: <stable+bounces-127959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3319A7ADA1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D86D1B603EF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC625D1E9;
	Thu,  3 Apr 2025 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4nhbtwx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D4225D1E6;
	Thu,  3 Apr 2025 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707605; cv=none; b=G3stJJENo7AJn18D2ryaYR/+hTRi0fd46FzDHfs8RoBvKsQA4sCHKAHRaQgSiNG2hWlanWnRO+p/aIkYzPMqqhDIqYHIWtq5gdl3QFADa6BbGvtS/QrB7yLPmiL7XZRUy9vUVCL085oaqWrMZiZiHgaKpB7QfQsGq1i9InSZ/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707605; c=relaxed/simple;
	bh=EKdo6glVJ5uwfI//1+P8dkxEj9XhjdNxCeuyPd/eAPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lsf9ODgERioAdUNt3ZsWeMc+uEb9pryV9axyzqaXJNPI+R8jH4Egsn8K4WMWBTUBDfb/2mZ4DMZPrdJsYTl6lBNHCgnTozSLZUlTDBWxdEButiDZE7ElvhHIF9nGp1WpBsCN1mjKuYglG7eXbMC/vCE4zHyTxyE1Jv5J/g3RDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4nhbtwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43347C4CEE9;
	Thu,  3 Apr 2025 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707604;
	bh=EKdo6glVJ5uwfI//1+P8dkxEj9XhjdNxCeuyPd/eAPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4nhbtwxVtFV98KFbap5pev82KSlYL52LiWhtk8yKSdQaFJ2ImEehxKXZ6Aey3k/Q
	 5aj+GUl1JStMZeh6nXuUG/gszDD7GUd0s2NBYobcHWPokubqAjxgH28mxN4sBj1GXU
	 eeq+2N8tlIjRmbWbWgg+U1G+9QFECrJ4RSwPcMVrCCVjxYKuWLImucbELIaobVgUqD
	 /vIZ50nE+22XxtZGZBBLYzUqMFU8J47k2aQmjM+VXvQcdbQf+M0c+p2+ThhS1Lm2Y4
	 1+hoC1sKNW5QKneKYy9eRZddJDNbcA/q3vN38LZFjQ4jHajFeRpspWwgjd5xPM9OZC
	 0DkoCrh/p0pPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Clint Taylor <Clinton.A.Taylor@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 04/44] drm/xe/bmg: Add new PCI IDs
Date: Thu,  3 Apr 2025 15:12:33 -0400
Message-Id: <20250403191313.2679091-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Shekhar Chauhan <shekhar.chauhan@intel.com>

[ Upstream commit fa8ffaae1b15236b8afb0fbbc04117ff7c900a83 ]

Add 3 new PCI IDs for BMG.

v2: Fix typo -> Replace '.' with ','

Signed-off-by: Shekhar Chauhan <shekhar.chauhan@intel.com>
Reviewed-by: Clint Taylor <Clinton.A.Taylor@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250128162015.3288675-1-shekhar.chauhan@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/pciids.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index 77c826589ec11..4035e215c962a 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -846,7 +846,10 @@
 	MACRO__(0xE20B, ## __VA_ARGS__), \
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
-	MACRO__(0xE212, ## __VA_ARGS__)
+	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE212, ## __VA_ARGS__), \
+	MACRO__(0xE215, ## __VA_ARGS__), \
+	MACRO__(0xE216, ## __VA_ARGS__)
 
 /* PTL */
 #define INTEL_PTL_IDS(MACRO__, ...) \
-- 
2.39.5


