Return-Path: <stable+bounces-92257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61499C5342
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9ED1F23B41
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F172123F1;
	Tue, 12 Nov 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+VGKeJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D882123C8;
	Tue, 12 Nov 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407064; cv=none; b=T1+tAb1GMCMb0QzpbtOoqoFLCn2P+OEEeOgcNK9LtRJslcSgJNayNkM69uJWOP9ykMcXA/o4OZtk3/r5EHSyVkv319fcSkzbzFX3/6/MtW9x++GWhq6iagvAivY4VdQk0tGSgX6NhXdHpe3Gg/HFCv0VTFPsmqNmp99mJVeeKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407064; c=relaxed/simple;
	bh=JK3b3oJIvKWGlV1+SyeD0OKZjfazv7PH3GQcGZ9qpFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVnNDn5p3jFP9M170ZG4FR8OezrvChrsm37SpzEP9OpKQAGVnHmUmCt0IpT6XZfFQqwLc3X92ZPFT0ofBx9Vkg4uNseQDNifWDC/LeLbW/PxgCu6OkMHWDOpIcYmtVP42ZVkkSFA1lKoawP/2h/xl//pt47FKq7C4pT5wwR7UEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+VGKeJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25044C4CECD;
	Tue, 12 Nov 2024 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407064;
	bh=JK3b3oJIvKWGlV1+SyeD0OKZjfazv7PH3GQcGZ9qpFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+VGKeJnYgbpk5LGQyGTm+gMM080kkKmdICK3OGigXeWk0xKKNf7Z1GkCZDTTcU78
	 7zpCfkTY79ITUu+JdgPxyS1at2lpLm0O+1gxDUQa3981tinTZQBufpRNeTPwYeTJEN
	 qOm4D4sjob6XB75uD082pVsQsl7CNnl7f2ZgVd5w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 40/76] drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()
Date: Tue, 12 Nov 2024 11:21:05 +0100
Message-ID: <20241112101841.310832049@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 4d75b9468021c73108b4439794d69e892b1d24e3 upstream.

Avoid a possible buffer overflow if size is larger than 4K.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f5d873f5825b40d886d03bd2aede91d4cf002434)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -401,7 +401,7 @@ static ssize_t amdgpu_debugfs_regs_didt_
 	ssize_t result = 0;
 	int r;
 
-	if (size & 0x3 || *pos & 0x3)
+	if (size > 4096 || size & 0x3 || *pos & 0x3)
 		return -EINVAL;
 
 	if (!adev->didt_wreg)



