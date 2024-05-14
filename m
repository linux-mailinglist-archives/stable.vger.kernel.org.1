Return-Path: <stable+bounces-43998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D88C50B8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E80FB20F57
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90274E10;
	Tue, 14 May 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jdi9Jt7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D76E60F;
	Tue, 14 May 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683608; cv=none; b=IjHBwtG9jk0JWQahGg4FZ6+rjnsgA7+RraFaxNY82mveg4Nv9FkC+jnNFCBiATUhZayQ3kNMsLo8xWEc3pqkpRXYr17M+uY/XdDVoVbzpm5ShknXNBI0xokBVP2VWE5CwYbgbZN9DlKfJB2fAuFed01eLBFRwZc+hMK0VCImE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683608; c=relaxed/simple;
	bh=YttjMzh581FiVqt4jfpoVa/ODbabL01hqyAnDIAZT9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU+4XBnwYkZ30DkUTAC26q8LsvfigCZUoLK7a8B3Ah/s8htwcT4ixMmGGS4OeuGrNnVS8msKUJxugUqdFTs3NbISzcp+mJ7x8rcalZlcLxOMoBfEJHdU+vswx9XXvsNp1fH8HFGmMxl5f+KMGg18OeZpwwYRTZcsNbWu7G4yYtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jdi9Jt7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A5C2BD10;
	Tue, 14 May 2024 10:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683607;
	bh=YttjMzh581FiVqt4jfpoVa/ODbabL01hqyAnDIAZT9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jdi9Jt7WjqbUzSxiyFvHVeTyOBOq3OUGUvC8CN6aa9wiTvb35/DWslz7dXiwxnMIR
	 5aOo4YghFE4YP5XCN1DtaZ6q8Kmfr75dXia6h+eCwH9b/GtCXphLixlDDj8GvNvBsF
	 D6RpXYs2iRRg1tRq+dWsEBmlvFEh02/2POUc77tU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
	Jeremy Day <jsday@noreason.ca>
Subject: [PATCH 6.8 241/336] drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible
Date: Tue, 14 May 2024 12:17:25 +0200
Message-ID: <20240514101047.713008755@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Dänzer <mdaenzer@redhat.com>

commit 8d2c930735f850e5be6860aeb39b27ac73ca192f upstream.

It incorrectly claimed a resource isn't CPU visible if it's located at
the very end of CPU visible VRAM.

Fixes: a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reported-and-Tested-by: Jeremy Day <jsday@noreason.ca>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -432,7 +432,7 @@ bool amdgpu_res_cpu_visible(struct amdgp
 
 	amdgpu_res_first(res, 0, res->size, &cursor);
 	while (cursor.remaining) {
-		if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+		if ((cursor.start + cursor.size) > adev->gmc.visible_vram_size)
 			return false;
 		amdgpu_res_next(&cursor, cursor.size);
 	}



