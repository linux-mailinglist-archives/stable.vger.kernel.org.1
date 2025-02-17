Return-Path: <stable+bounces-115347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1234A34346
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751871881F8B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D8281375;
	Thu, 13 Feb 2025 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbCAPzbl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D660D281349;
	Thu, 13 Feb 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457734; cv=none; b=cfmlht/y3IKewnt6rcY2beKbjY5fbdZM/cOX1YlNLNzYaXiF0OmGoK6jhxKaMsGehSX4ZTQIFr5cwiIxoR6f2dProRLxYrc0CObConANz74Y3pi6KVD2D8NDBWe8qkbMFVExD/HkrDCrBzYPRY7Xe2VDjz9zzYzhI/MVldfZhEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457734; c=relaxed/simple;
	bh=u99RCkfBcaYhHWoFSxgeT1FzRgn3YFgfkCdOJqhzM4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFKlOjTe3sQu+X1YqLJymUhNygArDak0tvkP6kQ1nF79i0eFClMT+ojz9gnHSof3h3LzUtwi53VHA8v9t1QScjvZwDe5rSTcUfN0JstNNBsU9Z27YVYSuI5hba0U4PnhEZlGsr3u0pY9rDBT1CG1pCztKokCNYFG+9aWS/2oTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbCAPzbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4322BC4CED1;
	Thu, 13 Feb 2025 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457734;
	bh=u99RCkfBcaYhHWoFSxgeT1FzRgn3YFgfkCdOJqhzM4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbCAPzblqHKwTiHRpbRlaoUsnajcQdjgE8eTX/SRKEVQatySGq3StdSRZlcmW6oIP
	 AyxuOY1vnV/CdM5q685NBEysDbHZjDmBFiaZIyzZbUYLfhy3JWYhKXUUK/daWmFum6
	 IM9rNQI3eK93PQ2+2KP6JGcbJ1Gd4v3D7tmmu5jU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 166/422] drm/i915/dp: Iterate DSC BPP from high to low on all platforms
Date: Thu, 13 Feb 2025 15:25:15 +0100
Message-ID: <20250213142442.949162438@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit 230b19bc2bcc5897d0e20b4ce7e9790a469a2db0 upstream.

Commit 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best
compressed bpp") tries to find the best compressed bpp for the
link. However, it iterates from max to min bpp on display 13+, and from
min to max on other platforms. This presumably leads to minimum
compressed bpp always being chosen on display 11-12.

Iterate from high to low on all platforms to actually use the best
possible compressed bpp.

Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: <stable@vger.kernel.org> # v6.7+
Reviewed-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/3bba67923cbcd13a59d26ef5fa4bb042b13c8a9b.1738327620.git.jani.nikula@intel.com
(cherry picked from commit 56b0337d429356c3b9ecc36a03023c8cc856b196)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2022,11 +2022,10 @@ icl_dsc_compute_link_config(struct intel
 	/* Compressed BPP should be less than the Input DSC bpp */
 	dsc_max_bpp = min(dsc_max_bpp, pipe_bpp - 1);
 
-	for (i = 0; i < ARRAY_SIZE(valid_dsc_bpp); i++) {
-		if (valid_dsc_bpp[i] < dsc_min_bpp)
+	for (i = ARRAY_SIZE(valid_dsc_bpp) - 1; i >= 0; i--) {
+		if (valid_dsc_bpp[i] < dsc_min_bpp ||
+		    valid_dsc_bpp[i] > dsc_max_bpp)
 			continue;
-		if (valid_dsc_bpp[i] > dsc_max_bpp)
-			break;
 
 		ret = dsc_compute_link_config(intel_dp,
 					      pipe_config,



