Return-Path: <stable+bounces-5703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E280D608
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A42823E6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36E5102F;
	Mon, 11 Dec 2023 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqTwef/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287EFBE0;
	Mon, 11 Dec 2023 18:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD09C433C7;
	Mon, 11 Dec 2023 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319439;
	bh=d5E2ZLPMBFf1GjEfmenZU2uMxMSOhXSEKpOycUoMwfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqTwef/vlX70BjEMXEgN668LDYGdVcpnJnW3xx7Xv6CvTAyPdNDmC963YLcXb50Yc
	 2oEpcSIkfUCtDRB6O0XqTjI/PvaaOqCKAYbeIR9BEVWjMgCYbSSjvzHLRZ8xLriTuc
	 kLup7mO7b5b9NgK6eBqUoKzfZvowFORQsM7Jn/Z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shashank Sharma <shashank.sharma@amd.com>,
	Lee Jones <lee@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 075/244] drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct misdocumented param doorbell_index
Date: Mon, 11 Dec 2023 19:19:28 +0100
Message-ID: <20231211182049.154863087@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee@kernel.org>

[ Upstream commit 04cef5f58395806294a64118cf8a39534bd032a2 ]

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Function parameter or member 'doorbell_index' not described in 'amdgpu_doorbell_index_on_bar'
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Excess function parameter 'db_index' description in 'amdgpu_doorbell_index_on_bar'

Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 8eee5d783a92b..599aece42017a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -113,7 +113,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
  *
  * @adev: amdgpu_device pointer
  * @db_bo: doorbell object's bo
- * @db_index: doorbell relative index in this doorbell object
+ * @doorbell_index: doorbell relative index in this doorbell object
  *
  * returns doorbell's absolute index in BAR
  */
-- 
2.42.0




