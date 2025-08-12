Return-Path: <stable+bounces-168370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7661B23498
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A121B16CF0A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D602FFDD0;
	Tue, 12 Aug 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJmoaayX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7426D2FFDC7;
	Tue, 12 Aug 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023950; cv=none; b=MTq8277yfntQdkcwO/nYkWOFJQKbwvcmMTyhMyukWuXXCAPIHNNrh0WJJxJpfdttXcMfIPWWRasYuCRogi5tzQSy3eZovtaG/EcHHH+swyKb3+tuuROS6YJffSNdU+lgeO74EHt18+BhORXuF9yf8lnKRo0vcp5AjSh3bsiLR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023950; c=relaxed/simple;
	bh=AYrdJm0k6rRbQSTlKeNYJFYvBcBOLIGxMtPp7+UjDR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9mZ9y6eZ2fuf8XQtmoOo/SLSc4+Pz7+SNEQ2Q0lT72Yz+4Q3Zl+ifcrpAEnKp8fuE4jt+9p8mNzba7/3xlai636VhHflqQOHlxW6pJRDq4isXzhAV5pcFvwsXSSgtbeKt80yl7WTzi4CIdazMk8bTMmUwvPSSjZ6sb8xmOIUiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJmoaayX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC63C4CEF0;
	Tue, 12 Aug 2025 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023950;
	bh=AYrdJm0k6rRbQSTlKeNYJFYvBcBOLIGxMtPp7+UjDR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJmoaayXILdBbMNyM9LsALclN2XNLl0n2ALNPpJIfHgYvl6ognEV00dO4dsrOLE0Y
	 fKZiodyvl2TvLUSBE7CrviTvUczK5Tg7S80O1PNT16QBa6MiSShZLwahrZuw6t74FC
	 Tc+Wdav0F76hbFXX4c/ckkog4m6h+6qwX8w+UvPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jiadong Zhu <Jiadong.Zhu@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 229/627] drm/amdgpu/gfx9.4.3: fix kiq locking in KCQ reset
Date: Tue, 12 Aug 2025 19:28:44 +0200
Message-ID: <20250812173428.004393814@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 08f116c59310728ea8b7e9dc3086569006c861cf ]

The ring test needs to be inside the lock.

Fixes: 4c953e53cc34 ("drm/amdgpu/gfx_9.4.3: wait for reset done before remap")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 264b37e85696..b3c842ec17ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3612,9 +3612,8 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
-- 
2.39.5




