Return-Path: <stable+bounces-71711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C2D96776A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1E03B21237
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B5181B88;
	Sun,  1 Sep 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCH8Kluj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D932C1B4;
	Sun,  1 Sep 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207564; cv=none; b=KA5nKhh81QyhMRkwEHBhoTFwo03n33Soz1LsUh4xtVvZ0vqiPFT9R9vK+pI1nKtIwV0WfjP/BImZX+OrpOeqGinikGBZXtjnnwzpE+bMPLR4POjG/B6NcLvwEQsP1h1TtBCRlZP3ZvxeIRTsq2MBj0wOgABFndrjp6npDOJkOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207564; c=relaxed/simple;
	bh=x2jY0IqM+dp2sXdJSht1vUq7GkP7My1Wa3FHYrSL41o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOznafbjgcHp9gemMIJ3sba2Vk9tFtC+h438J+6FRLSRWqKcX5LcCdrHRJ4uzW3Tx2D7Ont1VcqDrYBWTI9wlfHW2gq7aCbLBHddWvfqpgSvpoIK1j3yCDq3uFqoKdo/7oXubt7z/AQbtrEmrJRhuGUsYeNlx7JLdWInXWeCmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCH8Kluj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2067FC4CEC3;
	Sun,  1 Sep 2024 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725207563;
	bh=x2jY0IqM+dp2sXdJSht1vUq7GkP7My1Wa3FHYrSL41o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sCH8KlujgeTPbABa6rk8SWx/OUIWpMOTjNefXnjPVdrFYP+Wnsfal+2SVnjDo5qeS
	 D/66JAGwUdcNZPOfDT1G2IU6IYfXxDIeFxqC8/bZFIERvS6NHfTjEKn+zJwIQfjevj
	 iFy2oATPl2c0wPOuZrCfzEEV91Syi9yUj4N482W8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 10/98] drm/amdgpu: Actually check flags for all context ops.
Date: Sun,  1 Sep 2024 18:15:40 +0200
Message-ID: <20240901160804.074581592@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160803.673617007@linuxfoundation.org>
References: <20240901160803.673617007@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

commit 0573a1e2ea7e35bff08944a40f1adf2bb35cea61 upstream.

Missing validation ...

Checked libdrm and it clears all the structs, so we should be
safe to just check everything.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c6b86421f1f9ddf9d706f2453159813ee39d0cf9)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -288,16 +288,24 @@ int amdgpu_ctx_ioctl(struct drm_device *
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_alloc(adev, fpriv, filp, priority, &id);
 		args->out.alloc.ctx_id = id;
 		break;
 	case AMDGPU_CTX_OP_FREE_CTX:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_free(fpriv, id);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query(adev, fpriv, id, &args->out);
 		break;
 	case AMDGPU_CTX_OP_QUERY_STATE2:
+		if (args->in.flags)
+			return -EINVAL;
 		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
 	default:



