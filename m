Return-Path: <stable+bounces-130406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD78A80455
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA1D19E48ED
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035F269892;
	Tue,  8 Apr 2025 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zoNbr/ht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E53AC1C;
	Tue,  8 Apr 2025 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113628; cv=none; b=hAQ5+ZL4zDr5pgnrLQ3vBIinyVv4f1eTnbQb5m0mdF0fU5rK2ttqq/AIxwaFk4qxcCLC4rAzqp142MSm/0CsdES0QcENBhGmxRzk7R6gweeuERuSzf758TU1oxlvgBcMugZDu3jq5tRUTKHQmVPApej+b2ZUYHyMxWf5mCPKX90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113628; c=relaxed/simple;
	bh=4h9pSJ2yaVrTVS1YDFENzyOPeJjle+dIee+2s+6XQBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwBkiD/B4Juo1DuDm6vci5H6HGAW56XDaHcfbs0pBSrLRfEC/x5UZ1F0bVHZLAjpufrThXB+6a//v9ZMnihCrlg5c9f24oKh8JOfapI0iFHPQq8SO3Gen5iYykqy/KJgVLScAThtfD1QzHnCPpi192mG+JjDIcr6O9NMC98YpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zoNbr/ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7A0C4CEE5;
	Tue,  8 Apr 2025 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744113628;
	bh=4h9pSJ2yaVrTVS1YDFENzyOPeJjle+dIee+2s+6XQBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zoNbr/htKwgj/HxkETwGmE7XojTFBHZ9cNOhBg/MZP1k5bmdgsv0GkX6DPMTd1IS2
	 wGfuABeVrHVqdfq8KlVBRq7Pv7+C0FgM2jlvIY0/DJenicOSRbBWxNd7XRHRF7jH3L
	 NQULye7GIVphpgnngwkt6a3Lw6BxwB5qwD3S5Syw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jianqi Ren <jianqi.ren.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>
Subject: [PATCH 6.6 229/268] drm/amd/display: Check link_index before accessing dc->links[]
Date: Tue,  8 Apr 2025 12:50:40 +0200
Message-ID: <20250408104834.765354864@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
References: <20250408104828.499967190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf upstream.

[WHY & HOW]
dc->links[] has max size of MAX_LINKS and NULL is return when trying to
access with out-of-bound index.

This fixes 3 OVERRUN and 1 RESOURCE_LEAK issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[The macro MAX_LINKS is introduced by Commit 60df5628144b ("drm/amd/display:
 handle invalid connector indices") after 6.10. So here we still use the
 original array length MAX_PIPES * 2]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -37,6 +37,9 @@
 #include "dce/dce_i2c.h"
 struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 {
+	if (link_index >= (MAX_PIPES * 2))
+		return NULL;
+
 	return dc->links[link_index];
 }
 



