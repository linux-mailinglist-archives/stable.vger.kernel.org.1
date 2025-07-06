Return-Path: <stable+bounces-159617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37647AF79B5
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7710E188B51E
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4042ECEBA;
	Thu,  3 Jul 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cubw87nA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAB2ED857;
	Thu,  3 Jul 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554796; cv=none; b=AnrrF/42hHPkPVPAQKr7YqKA6kz1DsE9NbqyWa6VPpTxAAoNWvz26yFV+Nz6BPUYPp56uGewu/dyV5gb4NlrAnr6t+9Tc1JfWuU6plzRJMtBlEHhg9zCVfIZ+8iu9U51X/hxfUt8sYB6qrRzydZ7qmpJ3kUDN6bNZUJ/bl08oeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554796; c=relaxed/simple;
	bh=0CJ2UD4zfwl2yCOVqJqffdkbYr9eJzqmez3Up6nwzvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXITsEwpMCL62ymybZvPB0+GmUBd2umJb8MAbK5aixiyY0kvcPkwyBq8CTZYfIbwbBORn/3usUu95qlZIMaruYT8plgTQ9Wi4N4mGsW0Wu8Jw+iA6wxkncQGHyDi5VLaFG23N2PQjIqFnSPsfaMt+R3a0JvMqcNMWAq0IRPxyNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cubw87nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5E9C4CEE3;
	Thu,  3 Jul 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554796;
	bh=0CJ2UD4zfwl2yCOVqJqffdkbYr9eJzqmez3Up6nwzvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cubw87nAfvUaWDs3qnDnGKAsEPwl2LsifaFUeBwjItGr4MU0wucxCeSt6HfRzXnm+
	 OiRIrqRMlMBYcSzhwt8rUJDiVDe3obqRVIyQ0elWrbnjGlv7PO4biTmbNpKuLgqFuc
	 rCPHnERWHJZ+rVWEcJo37YjEpOQdzdbauk1URR6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 081/263] Revert "drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1"
Date: Thu,  3 Jul 2025 16:40:01 +0200
Message-ID: <20250703144007.551744992@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

[ Upstream commit ed5915cfce2abb9a553c3737badebd4a11d6c9c7 ]

This reverts commit d6e020819612a4a06207af858e0978be4d3e3140.

The IS_DGFX check was put in place because error capture of buffer
objects is expected to be broken on devices with VRAM.

Userspace fix[1] to the impacted media driver has been submitted, merged
and a new driver release is out as 25.2.3 where the capture flag is
dropped on DG1 thus unblocking the usage of media driver on DG1.

[1] https://github.com/intel/media-driver/commit/93c07d9b4b96a78bab21f6acd4eb863f4313ea4a

Cc: stable@vger.kernel.org # v6.0+
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20250522064127.24293-1-joonas.lahtinen@linux.intel.com
[Joonas: Update message to point out the merged userspace fix]
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
(cherry picked from commit d2dc30e0aa252830f908c8e793d3139d51321370)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 1974a300b24a1..7796c4119ef5e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -2014,7 +2014,7 @@ static int eb_capture_stage(struct i915_execbuffer *eb)
 			continue;
 
 		if (i915_gem_context_is_recoverable(eb->gem_context) &&
-		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
+		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
 			return -EINVAL;
 
 		for_each_batch_create_order(eb, j) {
-- 
2.39.5




