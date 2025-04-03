Return-Path: <stable+bounces-128040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0573AA7AE9B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10111189A560
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AFC20ADCF;
	Thu,  3 Apr 2025 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBjgtHTm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7720A5F5;
	Thu,  3 Apr 2025 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707827; cv=none; b=ecj/iz1nkbhbrvBmW5IMVf0Jlymwmf4rxPkLy+/54v2i8OHV+2t/uVNqI28nKBrfaHyclSSEbtEGJnVJ/lZwSYf4mzvP+wqo9X6hlx49GoMSWj5PcwODXXZ3BoKXnmIPV2f15q0fjGqmYQhcHbqXEvKWhXpY7f46wZee6iZFUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707827; c=relaxed/simple;
	bh=yUpA0qjHvZKAAfgwXDObkqFQ3RYg+pih7cXGpVy1gts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ry9BZtppjEzTqp4Zu+yFr+3FbxUv+WKR5Jei/WgUAJfKypDBghMjzrYQF0nn91filBsT4OArA1HWt53lXj1su0RhWz8r8hYOhOhgP7eHITTdfjmM6QGYnT4+aCKps610B+NiZaBHCcDxMoj+LWobCqfNWrv5Aq9aISse169VhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBjgtHTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26815C4CEE8;
	Thu,  3 Apr 2025 19:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707826;
	bh=yUpA0qjHvZKAAfgwXDObkqFQ3RYg+pih7cXGpVy1gts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBjgtHTmW9JVQFmazjM9TFTdcpxl8Q692kxX2gRuo0tdScc8BWycK6+7NdT5DlV+1
	 hCnG1tZtIrH6ibC/wGXMibR7XPNbOkACll9uEqoRpDc/gFMZgbk4U9qFwBzdqoWEyu
	 hJvgUPRiTSdZOIuPgafJ6u10fQ+6aRPjuCHONvUlay1dCAgqH9uDoxZb+7x/qhNO7O
	 gmYqRc1vcuYK6/myIgVpfgq569W8P7/ufpid+KJDvfY2O9FksVc6pj+49quAaTfkVW
	 LIDifJNsvmPgxH8R4fwP3PyBD5arnK9vU2QA9NZnCxMZhmwez8n8BqgkHko4/jUHaa
	 4YMf/gANHSI6g==
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
Subject: [PATCH AUTOSEL 6.12 02/33] drm/xe/bmg: Add new PCI IDs
Date: Thu,  3 Apr 2025 15:16:25 -0400
Message-Id: <20250403191656.2680995-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
 include/drm/intel/i915_pciids.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/intel/i915_pciids.h b/include/drm/intel/i915_pciids.h
index f35534522d333..dacea289acaf5 100644
--- a/include/drm/intel/i915_pciids.h
+++ b/include/drm/intel/i915_pciids.h
@@ -809,6 +809,9 @@
 	MACRO__(0xE20B, ## __VA_ARGS__), \
 	MACRO__(0xE20C, ## __VA_ARGS__), \
 	MACRO__(0xE20D, ## __VA_ARGS__), \
-	MACRO__(0xE212, ## __VA_ARGS__)
+	MACRO__(0xE210, ## __VA_ARGS__), \
+	MACRO__(0xE212, ## __VA_ARGS__), \
+	MACRO__(0xE215, ## __VA_ARGS__), \
+	MACRO__(0xE216, ## __VA_ARGS__)
 
 #endif /* _I915_PCIIDS_H */
-- 
2.39.5


