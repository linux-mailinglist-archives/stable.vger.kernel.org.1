Return-Path: <stable+bounces-13523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89498837C74
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC771F27C01
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA3242A88;
	Tue, 23 Jan 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2GLmodr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23033CC3;
	Tue, 23 Jan 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969624; cv=none; b=SnfwoGqXd1Yy3ZtFzHmoECu7CQ1uQ/y9hvH9whXRIbvfek/q1X4cQozoRPAwMo0lZ1UaOz8UNYKIr1LT1Pco+sQrdPRc2hj9AfrjDdhIERnZQ1CvvAPl1irF4o0r+IMGAxt8KmaYQlBrqETGQCSXS8E9ImIbDi0o2KO0lVo82x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969624; c=relaxed/simple;
	bh=Vv7rpulk2d0P/0fFsWxBSr6wiUanAEN5GECX4jHDmVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5k7r2zIK5/7eRvn8awSHIR5nXHo1kVydHI6F++t1F7CqldNCSRAEOyGwg5/cEnYJdU6hTeEJHUqeGkSWfCRsqJw/MAOW7nlO+8oe4f8RuJhxkN+FFG7FwERsiwCl0mniHFT9aWc8PU/jA4KexOswF5XtUjSBAnTDaiC4v22xjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2GLmodr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D344DC43390;
	Tue, 23 Jan 2024 00:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969624;
	bh=Vv7rpulk2d0P/0fFsWxBSr6wiUanAEN5GECX4jHDmVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2GLmodr1rd4xztOJj5eTfsv7/i11e0wbJ3mT9KA+6txX0kkp6JAjMsr6cLB3NSpEy
	 om3yuJp3G4coJA467Ehuoer3O3LBVYBjXzrX5BFoo9BYUBo5r8dZryqNq8D5+YDi02
	 bObHQ+vnc0x2NnFegua7US/O+HFoG07UcvDJGIIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 365/641] drm/amdkfd: Fix type of dbg_flags in struct kfd_process
Date: Mon, 22 Jan 2024 15:54:29 -0800
Message-ID: <20240122235829.363888739@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 217e85f97031791fb48a2d374c7bdcf439365b21 ]

dbg_flags looks to be defined with incorrect data type; to process
multiple debug flag options, and hence defined dbg_flags as u32.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:117 pm_map_process_aldebaran() warn: maybe use && instead of &

Fixes: 0de4ec9a0353 ("drm/amdgpu: prepare map process for multi-process debug devices")
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 4c8e278a0d0c..28162bfbe1b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -971,7 +971,7 @@ struct kfd_process {
 	struct work_struct debug_event_workarea;
 
 	/* Tracks debug per-vmid request for debug flags */
-	bool dbg_flags;
+	u32 dbg_flags;
 
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
-- 
2.43.0




