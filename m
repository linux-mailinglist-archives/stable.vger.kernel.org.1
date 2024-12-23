Return-Path: <stable+bounces-105633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E379FB0D2
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87B3188350A
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20E13BAE3;
	Mon, 23 Dec 2024 15:40:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E8182BC
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.43.217.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968428; cv=none; b=LYf1aT9VVexRXFKGRSDKEUYZCEx+c1cfNZxVHUSLjwlO60nrrM6r0cqlGOHigp1jil34tnWpN3ba78j4a4hog2dBiBF9FMqHfEj5B5qJ+mdt9fzuWtpBag46S0qlDRoH0dasJYtTy4AUYgW00D5HyR4W2CEN2ONAIG3f6byY2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968428; c=relaxed/simple;
	bh=mebQfZipErWAfl9krYwUCtINFgnjKagl2c6Up302Ag8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaDY5c9SJeHDyVbGsQE4IiaWuqSmnabo+QSwt4XKgTwssD8Nha+mUXECDUMRyXZCFtUtOkwEtaFk5LSihKaMYKp+euVD7GrBlQG9mY33/8Su8Z50iBftF+t59jQ0xMQIdjSjMQ0LkiVWqfmMWuWYyIW/pKGlP/c2aQia65P4qO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net; spf=pass smtp.mailfrom=ms7.webland.ch; arc=none smtp.client-ip=92.43.217.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ms7.webland.ch
Received: from kaveri ([213.144.156.170])
        by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id 01202412231638081656
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 16:38:08 +0100
Received: from daenzer by kaveri with local (Exim 4.98)
	(envelope-from <michel@daenzer.net>)
	id 1tPkVT-00000004T3n-0d5K
	for stable@vger.kernel.org;
	Mon, 23 Dec 2024 16:38:07 +0100
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] drm/amdgpu: Handle NULL bo->tbo.resource (again) in amdgpu_vm_bo_update
Date: Mon, 23 Dec 2024 16:38:07 +0100
Message-ID: <20241223153807.1065011-1-michel@daenzer.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024122229-excusable-sample-91cf@gregkh>
References: <2024122229-excusable-sample-91cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A682F17.676983E0.0067,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

From: Michel Dänzer <mdaenzer@redhat.com>

Third time's the charm, I hope?

Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 695c2c745e5dff201b75da8a1d237ce403600d04)
Cc: stable@vger.kernel.org
(cherry picked from commit 85230ee36d88e7a09fb062d43203035659dd10a5)
---

This should apply to the 6.6 and older stable trees.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f02b6232680f..2992ce494e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1161,10 +1161,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * next command submission.
 	 */
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
-		uint32_t mem_type = bo->tbo.resource->mem_type;
-
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(mem_type)))
+		if (bo->tbo.resource &&
+		    !(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
-- 
2.45.2


