Return-Path: <stable+bounces-62150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C193E617
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10D8E1C20B05
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFD74E26;
	Sun, 28 Jul 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYcPsECY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A074429;
	Sun, 28 Jul 2024 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181384; cv=none; b=Ur0F/VczUpmMh0owrIbTo/P4N9ctJMHjdAthoH+RB/oS4Wt6qFcEUSpj7F4A0qxFXS0eeW9l5z278CFyxBR1G96gfOmHTlwhHbaKZvQ8ZzxuF8sXWz+5JO0Wu4kjdL8PIDvmNaAjikITofwsWOn3F7QGAy+DgCmR0mthYy9c1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181384; c=relaxed/simple;
	bh=W/KIzT/8ojxaMk4N7CQev7o4V8WAU8jUDQvqftuntXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi/uZHuyt6fjAaT04rbGEpI8+SPgztVcXLL++Vu4AfYJJYef3oAhzgulMnlnlLflsoZ2GVQSbXwgEcMbI9DEk1uSxM9uDlfx7ijmftmLMadlSlp+BFIHYwSHjs3o+PpJXAquWZ5hNhJEgeWQthiaKp//moCvpsA7GUnkBvePyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYcPsECY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12446C4AF0A;
	Sun, 28 Jul 2024 15:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181383;
	bh=W/KIzT/8ojxaMk4N7CQev7o4V8WAU8jUDQvqftuntXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYcPsECYwn3bmtLpjj54REe7GVOTbN51LXg2EWVD8bZ7iKmM+WWZ26sTIaFNocD+e
	 yqiMIJJ0dKH4Jial7Ga6srdajqziwl4Lo9VBwLUlQo33oK6guCciXEny0ZXVdiZVA9
	 a/aIKm2/esRfu6Z0uGoPSMmVGrHlimmPFu24lrtXWcqJUMQxleJBzwydoL1BTOY2UH
	 aqvv7T8Lin2THl2E8nVq0nyFnRosfN9jRMEf0VR++iAJhFu0kQK5Z0apxylk0vNzPS
	 G8VVxpDhIFYIsiHxSlb13n0VganwoCCllDZNuGBcEuMCyqtmM+GiatkvhhXdRfRtAB
	 I0gFdVze6AZnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 06/34] drm/amd/amdkfd: Fix a resource leak in svm_range_validate_and_map()
Date: Sun, 28 Jul 2024 11:40:30 -0400
Message-ID: <20240728154230.2046786-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

[ Upstream commit d2d3a44008fea01ec7d5a9d9ca527286be2e0257 ]

Analysis of code by Coverity, a static code analyser, has identified
a resource leak in the symbol hmm_range. This leak occurs when one of
the prior steps before it is released encounters an error.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 31e500859ab01..92485251247a0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1658,7 +1658,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 	start = map_start << PAGE_SHIFT;
 	end = (map_last + 1) << PAGE_SHIFT;
 	for (addr = start; !r && addr < end; ) {
-		struct hmm_range *hmm_range;
+		struct hmm_range *hmm_range = NULL;
 		unsigned long map_start_vma;
 		unsigned long map_last_vma;
 		struct vm_area_struct *vma;
@@ -1696,7 +1696,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		}
 
 		svm_range_lock(prange);
-		if (!r && amdgpu_hmm_range_get_pages_done(hmm_range)) {
+
+		/* Free backing memory of hmm_range if it was initialized
+		 * Overrride return value to TRY AGAIN only if prior returns
+		 * were successful
+		 */
+		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
-- 
2.43.0


