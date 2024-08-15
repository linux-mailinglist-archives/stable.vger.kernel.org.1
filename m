Return-Path: <stable+bounces-69123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F162695358F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9587A1F26CB4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F791A2564;
	Thu, 15 Aug 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OFurZwdL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772573214;
	Thu, 15 Aug 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732743; cv=none; b=hUuM0dprY/mmrS8rPE/VzdNlP6VxrUwLVCgWowttqi4Ol3aK1LMTq9TIJVCVv1aB8k85oLYPITlRq2jaLDlR8+Tog5XtpO7skNcs0pMxj4mo2ZsVRl86ZycJi7yNnXwqqOXgnZZkBeCote9NHEeZN1AkmUjc43dkgFP1+AfcEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732743; c=relaxed/simple;
	bh=wA1CyrHqGbtB7MgYrop8WKR/I4Lp3U997aEFsvxJHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUqnUIfHCggJaFGXqr+tfVVzaeChofkLMdkxRgpGpjWIvkskWQHHsb1WVlikFEBu4apVOdhGOQh9Vzqsm1YV6Wofgt38LGYcipt9MMdhbf5oJ4lJAlfzRA1HBYvDOoR/P6incDvpLcgLOwdMPTdEzCY47XQKRcxhuO6WJcFAvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OFurZwdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE5AC32786;
	Thu, 15 Aug 2024 14:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732743;
	bh=wA1CyrHqGbtB7MgYrop8WKR/I4Lp3U997aEFsvxJHuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFurZwdLzv61hQRU1sOzcW7M9tYzhB8pYrcsIh5iheoxqDmTMjc1GvaxsNrxTMaFf
	 KZsPA6jhyuurzU3hQ+9knW4jlJkxn8PgrUGG9FCCB3uodLLkhehlpsUhHYfc5C2dKG
	 K2AM4Rr8B1aZstwHrvsMwwT7ch889l4uMVzqFdFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Jun <Jun.Ma2@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 272/352] drm/amdgpu: Fix the null pointer dereference to ras_manager
Date: Thu, 15 Aug 2024 15:25:38 +0200
Message-ID: <20240815131929.965377663@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ]

Check ras_manager before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e971d2b9e3c00..56f10679a26d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1351,12 +1351,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+
 	if (data->inuse == 0)
 		return 0;
 
-- 
2.43.0




