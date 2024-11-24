Return-Path: <stable+bounces-94904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A29D753A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEA6B3CFEF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB831991CB;
	Sun, 24 Nov 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vaoeu/IL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A89198E84;
	Sun, 24 Nov 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455199; cv=none; b=QpBk83W17dmAA6VnYoKUQW1iOOOpLr6T/47y3tuGmxFrKKz7fWYBL9QYgkOrRA+gJ02QO7BQxqVhLGporBfqapoOF39jdt8dzBw3nY5WbszvIUNi/H9b5EVKH4Si8/OBZ38zc6Ch5lz0SyikYzZyXx1ogvZHxMX6ucWevcdd1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455199; c=relaxed/simple;
	bh=M8vWynzc5IbnBUi2s8iUj8xr3SRbhHvpKk1BCl3C+H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO/P15kb7xCab8rDwF5mJ9rNA438YCtKwJeeFxHOIMMHe17QuI/qeYKWEOMHON+KBjvB80qv6jc1iMQBzJNI4+s9V++jQ+CmFwT3mQq8UBK77Bv8IwJOMNBFKXy6l1/J24QCF+T5rvVbJ2Iu+7gkrcPxpsQodsEnpZHXxtxB6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vaoeu/IL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8C1C4CED1;
	Sun, 24 Nov 2024 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455198;
	bh=M8vWynzc5IbnBUi2s8iUj8xr3SRbhHvpKk1BCl3C+H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vaoeu/ILfPRj0gHzZtN8IQ7OupROBm3ImThcnFT+7cntDe/vEyTTEtB516EL2xxFS
	 WGybTrNL6pmwwJ1P+Wr1/d0fRMXIW2M9lwH6ceozcAxzGUYNlfCj6rkgTBri4+c8kJ
	 aUH3StyUuTpZvQE7hqaupRpstNiDMZhXwd/r6CPyVf4lOU6EjZv2HEgrl0PkHOEE7y
	 ofkluPJOGeocM3kIk7FOLvekLF9Y2rfW0ynzEA3cTZqE5egYWOL6IiBBQ7ob0B5DbK
	 f5BG+qnHaSO1RtIWctwMPyC2SXc5KaESMS+OAxZuBXs5oUescwAtJRmSAmhjIMQJhu
	 hiW11JAtNzesg==
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
Subject: [PATCH AUTOSEL 6.12 008/107] drm/xe/pciid: Add new PCI id for ARL
Date: Sun, 24 Nov 2024 08:28:28 -0500
Message-ID: <20241124133301.3341829-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


