Return-Path: <stable+bounces-79855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AA098DAA0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F42B231F0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C981D1505;
	Wed,  2 Oct 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFR0Lkp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D31D07A0;
	Wed,  2 Oct 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878664; cv=none; b=YOsUUanteHswbsafyUwjIaGRsX8Y5qrfSuN8ipoeHnpePMNVTh9EDEOcTc2WO8DYiY3D7Uh0w8ReuZj2rAAUNHLwvB4CBbAZLc7pSfVTbGl6WqiQWYKEwrjLMTUPiOYkfA+ZfQkzJ9O2xTBLM4gYqUAVecATTjTqk7kM1dZJXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878664; c=relaxed/simple;
	bh=98tfwpIYIjjhob+JhWBKCB4USSVDiwDRMxIyZaCzIcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8T3RqYjILqbm2JR1yI5UFpZdN0lfY8oBGOLZfZVYZQoHL7t1l884dThXc9zy31SVv3r1YM1XK/TUYbIMII/tMGznVm75fEzUsmIc/hHyqgMuIwSHBGCL+b9MO38LSwbekMGwppKHlVVklLbRxltQC7rCQAzgCPX9JuyVIZvLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFR0Lkp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28ECC4CEC2;
	Wed,  2 Oct 2024 14:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878664;
	bh=98tfwpIYIjjhob+JhWBKCB4USSVDiwDRMxIyZaCzIcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFR0Lkp9C/PAARiT/nkcdIWlyUgwjbiFM0SeMddK3XqjrzJdrzlsXE7rGYw8l2zIV
	 jUUOf7V7Dbhid8DgfvbYRRRPE26Kp1FRg+V+6WKeC2s3KSj6eonvuK/CFeOj1u8tP5
	 XmoUpslsDMasys3ut8nqqBv1554InF51XUKzyw4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.10 490/634] drm/amdgpu/mes11: reduce timeout
Date: Wed,  2 Oct 2024 14:59:50 +0200
Message-ID: <20241002125830.443253011@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 856265caa94a3c78feaa23ec1acd799fe1989201 upstream.

The firmware timeout is 2s.  Reduce the driver timeout to
2.1 seconds to avoid back pressure on queue submissions.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3627
Fixes: f7c161a4c250 ("drm/amdgpu: increase mes submission timeout")
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -155,7 +155,7 @@ static int mes_v11_0_submit_pkt_and_poll
 						    int api_status_off)
 {
 	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
-	signed long timeout = 3000000; /* 3000 ms */
+	signed long timeout = 2100000; /* 2100 ms */
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	struct MES_API_STATUS *api_status;



