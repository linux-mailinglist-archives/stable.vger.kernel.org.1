Return-Path: <stable+bounces-84715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E599D1BA
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D64B1C23A2C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FDF1C876F;
	Mon, 14 Oct 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGYDXt0W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45D1C7265;
	Mon, 14 Oct 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918960; cv=none; b=PsIsLVYvESsDsXNRDFSjzmdfj4l23nbC2LiBWUn8IZ13hX2WIILtNfy461/uL8pYtv8NV7XUTvJBlYC1GDFPt1dCwofzfYsFeQ0qlW0gaaX5nNpA0+rYL3ZWId7hAE2st9+/F7mCC2DsLQelkxPGo0gim0XYo1YqSERxodh6JcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918960; c=relaxed/simple;
	bh=tU5BZpveGBbJLdt72bPg9ZsWNisasdO67UmtjPo0I/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPp047btJuLF96xIsS8lM0EOmsBmhcsegWGExod5D8+4adZOHbonb6X7IXwzhnPg/DhS0Qlge5fVCV/2CbiF3EtBgjbz9jog3Z7owAHqyDYYglJFVPYSunVdKt6/MDHDKmWlI5wvIb9+Esr1R1O8wDEznv6rWS/06X5th8++WlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGYDXt0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC7C4CEC3;
	Mon, 14 Oct 2024 15:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918959;
	bh=tU5BZpveGBbJLdt72bPg9ZsWNisasdO67UmtjPo0I/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGYDXt0Wc0FJ3Q9XSEBq/RLbUcSxfEsiC3HLKUFIzF0MA2VU803eQAVABCAEywPVs
	 93u0bTD6jHdvFJAdoxjz6Ga8z9HMiL5ySCGLcWDxc+LOwTLNoIj4DMkDZmFNPXEKst
	 R9t4ui6W6pvBjfylqlZEASEOmM4pvaloZVGRY2s8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 473/798] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Mon, 14 Oct 2024 16:17:07 +0200
Message-ID: <20241014141236.559205377@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit fec5f8e8c6bcf83ed7a392801d7b44c5ecfc1e82 ]

Before this commit, only submits with both a BO_HANDLES chunk and a
'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).

But if UMD sent multiple BO_HANDLES, what would happen is:
* only the last one would be really used
* all the others would leak memory as amdgpu_cs_p1_bo_handles would
  overwrite the previous p->bo_list value

This commit rejects submissions with multiple BO_HANDLES chunks to
match the implementation of the parser.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 133e4e03c143c..91c5bb79e1678 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -257,6 +257,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_bo_list_in))
 				goto free_partial_kdata;
 
+			/* Only a single BO list is allowed to simplify handling. */
+			if (p->bo_list)
+				ret = -EINVAL;
+
 			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
-- 
2.43.0




