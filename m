Return-Path: <stable+bounces-24407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242986944D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36F31C234B9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A925913F006;
	Tue, 27 Feb 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uq1hjyOx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2C13B2BA;
	Tue, 27 Feb 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041915; cv=none; b=lw8LiZYiGdOlcf+/eTcZadzxGaGo4k3mvWNpX2VqHpKHjZ8j4Sk85bNCIoXf47MHYHSLdssNyeyIQQQ2zkh0Yliw+VrUQS4eI3fAGJCM/3EwLkAlNnVnptGDZsHWzphElFmN6fBPwZD3xZAbcVVneQLxF32GrR1m+gE+S6HIuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041915; c=relaxed/simple;
	bh=gw/oWp744+lfec61lM5eEexY/jr9qeV9H8FIlcGRYyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJIwr8L2bwoIUVzavL5BHaEbyoxtmyk+QHAeuv14gJSRuFvq/UMRBnmjSaeggiF5tswrWxojdzni9z7kMCZ+0tV7ty65ks3aoU4Sx1TRB6mGS7vRuNlWPiK8pHDEJgxRHvLCcs+TJZCryImXhb9o80wIK3E4c9hUk/lkj37eN1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uq1hjyOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DDCC433F1;
	Tue, 27 Feb 2024 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041915;
	bh=gw/oWp744+lfec61lM5eEexY/jr9qeV9H8FIlcGRYyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uq1hjyOx8klujiNoI5ZpAe1RUyWsW71okDO/19QoPs6YMTlyOYLSS9RsGOvDb6Sy+
	 VFIx7NxRLr9uS8N4g9/iYGvpwMU9H1HjyyS4w6mQfg5B8Vbkb38c9r/srEObzs3Ily
	 pOeQDmkUFNhi7Va66n3FHf8tULnk2FGbW3RFBNGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Stanley.Yang" <Stanley.Yang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/299] drm/amdgpu: Fix shared buff copy to user
Date: Tue, 27 Feb 2024 14:23:44 +0100
Message-ID: <20240227131629.508362716@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Stanley.Yang <Stanley.Yang@amd.com>

[ Upstream commit 2dcf82a8e8dc930655787797ef8a3692b527c7a9 ]

ta if invoke node buffer
|-------- ta type ----------|
|--------  ta id  ----------|
|-------- cmd  id ----------|
|------ shared buf len -----|
|------ shared buffer ------|

ta if invoke node buffer is as above, copy shared buffer data to correct location

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4c..ca5c86e5f7cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -362,7 +362,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		}
 	}
 
-	if (copy_to_user((char *)buf, context->mem_context.shared_buf, shared_buf_len))
+	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
 err_free_shared_buf:
-- 
2.43.0




