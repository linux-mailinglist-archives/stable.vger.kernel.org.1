Return-Path: <stable+bounces-82770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFD994EF6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CADB23FC3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDA21DE8BE;
	Tue,  8 Oct 2024 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="al35JHq2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA451D3653;
	Tue,  8 Oct 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393371; cv=none; b=SVJBgW6qaGl1tfEjJ/4DgGx/2ZaCD/NqIB06fVcvaFjfpMfRI+61zLMMJeOCRyFwn4ykbkp+oKZOY1RpHM3tl+RR1Yy+3+2tnopHwj3BzReFBlZ5m4JPfUF2pmlitI/FSI0Kmsldnm4sBFDtlCPaeZqfNBMZeafE4n3b5jznLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393371; c=relaxed/simple;
	bh=nbYhhTVOs0QvdQ/0Uk/Q3rbs0wuylCyQnF0cueUvF9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQ8/toPoQaz7Z2PqcZGwfVCFhdX+5PcGftOKNA/744PwFsoDwA6Scf4SGUS+TJr5Cxyr6c0nPeIxbuF+IcFrFhvorQUIF8rv+hYs8QvIKhmJ/sZX5gxnrmYK+0BnqGve6RmlZmKETS84v+4BUXefh3mu6EacaT9P6kXCJ+6Ll8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=al35JHq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE0AC4CEC7;
	Tue,  8 Oct 2024 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393370;
	bh=nbYhhTVOs0QvdQ/0Uk/Q3rbs0wuylCyQnF0cueUvF9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=al35JHq2UzTLvpRNXYQ/3t6Ns5QmjRnTH93ATO0d9/XxZMJn9utPUF5e5zdkHoquL
	 S6ksgKsTjccU3YL13cD44ZJ0qcJyDFgsZQl9CME3w4PZVXZjzWXzS0JYJWwDRZweJG
	 a6H4HPSbcDXSGw6KoYLTHInGNqxSSW0+2BmCkr1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 132/386] drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit
Date: Tue,  8 Oct 2024 14:06:17 +0200
Message-ID: <20241008115634.630879400@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index e361dc37a0890..7abcd618e70bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -263,6 +263,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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




