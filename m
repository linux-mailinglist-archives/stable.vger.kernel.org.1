Return-Path: <stable+bounces-95010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779E59D75E3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5550B649A4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04571BE23E;
	Sun, 24 Nov 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7B0nEyo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA811BDA9B;
	Sun, 24 Nov 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455678; cv=none; b=lue27OUosLJOUn7UTrQ42oPwOnDwFc15sODOcCY1fnWIWnkZ77ZRU5nBv6sxSA2tOeNtCy4gQrHSo8fMt/tymbrdw3gjaFrnnQd6QKDAbDYP14ioOO1KEu7+6nGT7/8IStNAgmm5q+e8YRE7sRYMnHgBOipeBbk7h9XMT8nWnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455678; c=relaxed/simple;
	bh=M8vWynzc5IbnBUi2s8iUj8xr3SRbhHvpKk1BCl3C+H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmf4uV/l7T55e886t+j/tE8dfPzOXRkBwnBwuh/RCSguFMNJGdg5uosJvKSJWdCsaNqZv1uU8ENdBCziBJZzPyFdXwDicnQuDqBLIZlWzA+iadgbrzvnf22YibCokgdJyKhGMuzB8jHyjbLGejTHAtVI+ELBwYJs4sJUWhqVrvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7B0nEyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EF0C4CED3;
	Sun, 24 Nov 2024 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455678;
	bh=M8vWynzc5IbnBUi2s8iUj8xr3SRbhHvpKk1BCl3C+H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7B0nEyo9DbQ8XqPCQakpeLGNgDaUbu6Lw589cgIpdsuPgokC0jJjWguoZ/CW6NCT
	 iUjJ4FeaVkGfoD978fa/ckyd6bR3pX0kk1izlTnPB4C6BGGd6XTsS8cCFLaAkMEgwm
	 zDUjHvO/CtqiGGV5cPkw5RP331O/2ykQmTdaBChvZniciZB8MSALOmhXBDpT4N6f30
	 wHYj7KQsg2dTw22R4xY1oyMdePzGaArFKwULGAseGfUJ/bfVCODAzjXZp/a3A/jhma
	 cRp0qam5G1lj793F0SN/xWXJgHVWUZEPqXtSwPKgE/GeKIjIyBoWgtREN6KBG4Sdwv
	 gkY1utDeruYIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 07/87] drm/xe/pciid: Add new PCI id for ARL
Date: Sun, 24 Nov 2024 08:37:45 -0500
Message-ID: <20241124134102.3344326-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

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


