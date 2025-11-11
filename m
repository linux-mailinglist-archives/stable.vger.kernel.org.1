Return-Path: <stable+bounces-194409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C2FC4B296
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 03:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF204202DB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D3340DA3;
	Tue, 11 Nov 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lb521vry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9E18DF80;
	Tue, 11 Nov 2025 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825536; cv=none; b=romBAR5QSx+Zzxv74oykYHHre1Em98W0jhmMT4+o0xPprbYPli4beZc53Rb35ibcjxO2vLfEulwzqQmGnlD9r+Y2Dg/5DYFoU6Ca07rXjIoTZPai6XtzH4AXA3LURnapQyN34858RYrtsrV5S0wiAvOHg9M+m9pQtnoC291RqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825536; c=relaxed/simple;
	bh=TAlbN/ZO4W5B6myJkQZHOGC+v8IkODWaKX0wlVNBQ3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td8LbW6U19EEojxU1gjWbLHznMXg99WDtMw03QU7JSz0WDBypJ2cJAmzymLcDamvBuwChiW3nZzwflZJfle6O0atpqTRoZo3SmhqgIYxllz0395Rb0XXD5XRe8nqNxuK38YU636+4sHzkCu+kd/QUm0QUhykN/0qOrUw08j9aOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lb521vry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79920C4CEFB;
	Tue, 11 Nov 2025 01:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762825535;
	bh=TAlbN/ZO4W5B6myJkQZHOGC+v8IkODWaKX0wlVNBQ3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lb521vryH1ZrOoe40FlOx6e7mmRr17vlsvunZuons25HSCZg1Zmght3yzPqwm9aUC
	 oemfVOnOsih7JlxAiJIcPAvIxu57WdCEdnfy+LkHdIrbVckBj3yUbksaxJntWx6Eyc
	 OSJFMOqq7xxkKCKeIfYyVQwcSd5cKRJf05daW/X0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.17 842/849] drm/amd/display: Fix vupdate_offload_work doc
Date: Tue, 11 Nov 2025 09:46:52 +0900
Message-ID: <20251111004556.778202718@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

commit e9c840d4505d5049da1873acf93744d384b12a0b upstream.

Fix the following warning in struct documentation:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:168: warning: expecting prototype for struct dm_vupdate_work. Prototype was for struct vupdate_offload_work instead

Fixes: c210b757b400 ("drm/amd/display: fix dmub access race condition")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -153,7 +153,7 @@ struct idle_workqueue {
 };
 
 /**
- * struct dm_vupdate_work - Work data for periodic action in idle
+ * struct vupdate_offload_work - Work data for offloading task from vupdate handler
  * @work: Kernel work data for the work event
  * @adev: amdgpu_device back pointer
  * @stream: DC stream associated with the crtc



