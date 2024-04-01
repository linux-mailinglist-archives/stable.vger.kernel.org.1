Return-Path: <stable+bounces-34278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E7893EA7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E892D1F2116B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C86B4778E;
	Mon,  1 Apr 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YjZkmliB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2BD1CA8F;
	Mon,  1 Apr 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987583; cv=none; b=ipS/E5h17tjQhUqwN2hYP6/N6JCKdMAvPU5ez2jZIZPo7vnM9WojVzsKeCtcQ/tlFe0hSmO7IBgnMg0cegcSa1CMiZtAIH86yiZwIJ2UzM8x+kadTOA1oK5bjW8nZM9U1B2GFT/RJ4qrbwxF9MMUUw/tpNtH8S9rRt7TBX7tk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987583; c=relaxed/simple;
	bh=p1pw49vTsizSbVyH8NJk+2H99YQdWrKDwJyG3/3/56Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAF07p1t6a5JeY51UhIfj1RGkMpRQ3Kvat8vwXSGIkJrIsDldPw8XcmUyPTs+QdH6ElGLkLD2odzx0rHbmwQk5oPeJvdRf8FHfejmE8lxHN8UdxtdZCSRrspIc8YWbQlQylFJpFq5JABK7xnRY3qN5mZtRuHwPD9xJ5JC3Drt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YjZkmliB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9372C433F1;
	Mon,  1 Apr 2024 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987583;
	bh=p1pw49vTsizSbVyH8NJk+2H99YQdWrKDwJyG3/3/56Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YjZkmliBbKfXQKq87vHPV+6VZ8KPcSQDxKv2lYeaFKnMz6lpg7iTXwGsn63/Atupu
	 vxehLeop/BeDKauBkbbTHOxYYPu6i5p5VhkdlmGVctaKUVMeESuIvqwRzwzgUZ7pzB
	 AMCjNFWncNR71pG9K0Yd2HjiE5bRBBfz8PbW2p90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.8 323/399] drm/xe/query: fix gt_id bounds check
Date: Mon,  1 Apr 2024 17:44:49 +0200
Message-ID: <20240401152558.821707367@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

commit 45c30b2923e5c53e0ef057a8a525b0456adde18e upstream.

The user provided gt_id should always be less than the
XE_MAX_GT_PER_TILE.

Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with better accuracy")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240321110629.334701-2-matthew.auld@intel.com
(cherry picked from commit 4b275f502a0d3668195762fb55fa00e659ad1b0b)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_query.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 92bb06c0586e..075f9eaef031 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -132,7 +132,7 @@ query_engine_cycles(struct xe_device *xe,
 		return -EINVAL;
 
 	eci = &resp.eci;
-	if (eci->gt_id > XE_MAX_GT_PER_TILE)
+	if (eci->gt_id >= XE_MAX_GT_PER_TILE)
 		return -EINVAL;
 
 	gt = xe_device_get_gt(xe, eci->gt_id);
-- 
2.44.0




