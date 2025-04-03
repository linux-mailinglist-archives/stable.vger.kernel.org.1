Return-Path: <stable+bounces-128001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93457A7AE18
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F6D1886EA7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAB1DDC3E;
	Thu,  3 Apr 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvS5mkb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654671DC9A2;
	Thu,  3 Apr 2025 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707721; cv=none; b=Zbrk1GVrZbL+rQGdQero7QYqQSQnw/S7KoRgD7u0arNxx5aH7Mge5rIPTnSYhQDM14jqwUzt6tk70HQz6/owWmyS4buBcy4/GVrO6n02HZAmLYIozmodkktn2feqVenwYtFv1gmmU2sev3gGMwba1r6bS3pMbCeXCgGIaebVnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707721; c=relaxed/simple;
	bh=CpVTYn9MyANMDuu9W8QVPxAeUr0kqUIv7GuCxZXQGok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHsGH1aGvtsMwntJ8x9sH3P/7GjVCIVqNemhPGgGUGzR/ppbpy11GiXBGV4EdFSTTLEFWjWgb3TgwK2DYoL/uHUxrL0lSrsztZfF1LWIaBLesxsK6cBLjZDfNZB5tYJyBdPFZmcNObJPWXHj7qF/yClxGlVNZtlIJs0RKVgOK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvS5mkb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD26C4CEE3;
	Thu,  3 Apr 2025 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707721;
	bh=CpVTYn9MyANMDuu9W8QVPxAeUr0kqUIv7GuCxZXQGok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XvS5mkb5aKPyV8zVOX8kgQkC8C/Wea2Khhtf2nMjfdDaLCLDC7/weWpCVTAN597JK
	 01e+4w0aisHeon+tpBJRXHtXE8pEPNKZpC5VD+zpe55rysmwGKPAb8T2bmCdGkmt3M
	 zYU40UZ0n8P5vin5LDyxH1IxpKau34iqilndBZcwEqwJgVYlEpbXg1bvwdG7zVTo2L
	 ie1sHB+fT9+cgQQ33enY6iHU99h0BuDl7lxEDlEFSoGHfh8zIXbdr9OmMNKoww3nUv
	 HvN4/J3KT3ewNcNNMldwZdgavmQvVKKx7lqd8UC4Fr91DIjFgo7Y5b8ec0sKWAO+r9
	 uNNCu8CGaSGfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shekhar Chauhan <shekhar.chauhan@intel.com>,
	Clint Taylor <Clinton.A.Taylor@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 02/37] drm/xe/bmg: Add new PCI IDs
Date: Thu,  3 Apr 2025 15:14:38 -0400
Message-Id: <20250403191513.2680235-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 32480b5563db3..3a89f6bb8ee55 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -817,7 +817,10 @@
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


