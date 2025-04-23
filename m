Return-Path: <stable+bounces-135798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B4A9906F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B5A1BA1A59
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E817D28467E;
	Wed, 23 Apr 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qn4QBdjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42FF262FD6;
	Wed, 23 Apr 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420871; cv=none; b=PwHO1/hze1/ukCFrmapnZns/AjxUDHQWFsOWeogyxLHrj0ZeAL0+akwsN5h78JqdpMfIQB8kGS1JZOxOf2Js90KF4oJiK1qXojR9kh0qJN2bRrKw62e70Efjo0vv3C42tYiG75xmn8Ha7IIl6xP2c+sQbrQukHfkScS50Ja/xz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420871; c=relaxed/simple;
	bh=W+ZyYscZqEgE8yVNCJGBJtVG0bnN8RIGduQXhLU4H5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cy/uUKBZ08BEZ8ain3Q4J2/eKXgByVjTcVgypClDUvTPnjTo5tQHPzFwCriwFgStn9+A1BlnUMmDUPpuvDxxSDj0774r4PNQES6bdmwI6SJfNyzki2jqF1PNT2qEJxs/E8i+E51WW/YKqAyXmKP6bAeCGJixGMGZlPyG2JoV0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qn4QBdjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B65C4CEE2;
	Wed, 23 Apr 2025 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420871;
	bh=W+ZyYscZqEgE8yVNCJGBJtVG0bnN8RIGduQXhLU4H5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qn4QBdjPL3XqHZ78KDjlKwlUNCbS5laUC2Pboflj0XSa+y+FsEzOArsdYqynro3x2
	 ySi3l5jbbos5sWEVPNaW/COSEYCiItlhfuxS9s8LsOHbxDmVzTU/W0OoEzLeQVfS9m
	 p6jo0UuJGOVJTpNeC8vgi/pkmFffYHbDKux/6yJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12 155/223] drm/amd/display: Actually do immediate vblank disable
Date: Wed, 23 Apr 2025 16:43:47 +0200
Message-ID: <20250423142623.488063127@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>
References: <20250423142617.120834124@linuxfoundation.org>
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

From: Leo Li <sunpeng.li@amd.com>

commit 704bc361e3a4ead1c0eb40acc255b636b788dc89 upstream.

[Why]

The `vblank_config.offdelay` field follows the same semantics as the
`drm_vblank_offdelay` parameter. Setting it to 0 will never disable
vblank.

[How]

Set `offdelay` to a positive number.

Fixes: e45b6716de4b ("drm/amd/display: use a more lax vblank enable policy for DCN35+")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8473,6 +8473,8 @@ static void manage_dm_interrupts(struct
 
 			config.offdelay_ms = offdelay ?: 30;
 		} else {
+			/* offdelay_ms = 0 will never disable vblank */
+			config.offdelay_ms = 1;
 			config.disable_immediate = true;
 		}
 



