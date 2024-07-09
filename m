Return-Path: <stable+bounces-58445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AD92B707
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42131C21895
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A7157E78;
	Tue,  9 Jul 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f2FM1pCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B213A25F;
	Tue,  9 Jul 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523956; cv=none; b=a60poYaiHdxO/cJvRp0GC9ZOVz3FluRnA21AxsMPgSLHSdjMx58NBYdP3zIDuqfdf6JJ90hmpgcy3fHekga6tf1jgYZodI65pm3HWIjRWNT2HXOdBC78yQlS+x0WwCvZCj9OIprRfTLsqVavJC/F5oTSuU2hXVA5XOBJWvij0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523956; c=relaxed/simple;
	bh=qh5vnWV2Yf7nfIDb/XSaTTvUM/lq5sLqGcKY6ZZY7bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx+ny1JHBU54mHOi7AJhM2zCpGHUfvaeLAmxgfXsOpdLsPTcxdfgSBTrqMvfLvw3GAthUW9xztpdADE1XsTD+sYu+rH4KCOWKObDJqPXibmLovNtotD7xNyVPLZNho2dcEYCbFQ3iSaIiQ0zXBY7SaGC6WdxRsUAYkPq+XTmAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f2FM1pCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F2C3277B;
	Tue,  9 Jul 2024 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523956;
	bh=qh5vnWV2Yf7nfIDb/XSaTTvUM/lq5sLqGcKY6ZZY7bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2FM1pCc2Hhq6PtUM4JaaHxKSqoTcHcz9krdcQOL4r/UHA1goFhrGvYXv668GVpm0
	 MiaPdL0529uOJzFF+SLPs6zXXWc6ojuJNkjWd2MilhLSv54xyShlFhHC5LmMMAKOYD
	 aMtiDTo8y0D9n/dH22gNQvMgyNxga1pcw30CoUZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Jun <Jun.Ma2@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 024/197] drm/amdgpu: Fix uninitialized variable warnings
Date: Tue,  9 Jul 2024 13:07:58 +0200
Message-ID: <20240709110709.853404769@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit 60c448439f3b5db9431e13f7f361b4074d0e8594 ]

return 0 to avoid returning an uninitialized variable r

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 576067d66bb9a..d0a8da67dc2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -97,7 +97,7 @@ static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 93f6772d1b241..481217c32d853 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -92,7 +92,7 @@ static int sienna_cichlid_mode2_suspend_ip(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
-	return r;
+	return 0;
 }
 
 static int
-- 
2.43.0




