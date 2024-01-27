Return-Path: <stable+bounces-16220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40983F1BB
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801C41F22DFF
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A5200BC;
	Sat, 27 Jan 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uN9jMHDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D711E86A
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397469; cv=none; b=ZyNW2SCZNXSUxCNlAnfw8BB+k11BXZGu2ZL0meQTGKK6hJvBxbQqy+1i0fnn18FbgGxgmHR3KHLCELmJ++P/fVsg+OywQ2q9YvwuCTgF+8ssoo3Keiu8J7d8J3i16BZtnmijMqgzYtYBtORTG6xUnl7oqu2qxRIuqSmzFiczPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397469; c=relaxed/simple;
	bh=8Ynzaqoh2ywBOXo98nnxZFapHvOWww17WRJGqSS5nBU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tf9ITNl9jp/fN6hJ7l9WVRKjZnMgi5voT9Lp56yqf8GSTe6/nZdtvdrxic+DJnClPUpj9ro303wCX5or2pmXi/08OZLchu9VJsbfH/O9F3a9yyL9i/HW69j8r3Htiui49QcGwNsScik/aK+41TRCZPvVXRCsTvSOK7k9H9/CiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uN9jMHDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1016CC433F1;
	Sat, 27 Jan 2024 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397469;
	bh=8Ynzaqoh2ywBOXo98nnxZFapHvOWww17WRJGqSS5nBU=;
	h=Subject:To:Cc:From:Date:From;
	b=uN9jMHDyfKpo05F+7JQ49KYrw5MrhNRcKx3VYHzEwaCD1/bq7Iyt9HiqcBE9YZzjp
	 8nV0Ql3DZ6vPacf5mhscaoRLRJ01rZGAWipjM4dX5AiRIn7EXpttoIlHU0gANzim+p
	 Www7VEafwUL6601j03i6Y6uSaXvR3qXyWCHVCjgM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix null pointer dereference" failed to apply to 6.1-stable tree
To: Hawking.Zhang@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:17:47 -0800
Message-ID: <2024012747-stimuli-imprudent-3db0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bc8f6d42b1334f486980d57c8d12f3128d30c2e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012747-stimuli-imprudent-3db0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

bc8f6d42b133 ("drm/amdgpu: Fix null pointer dereference")
9a5095e785c3 ("drm/amdgpu: add amdgpu_reg_state.h")
c8031019dc95 ("drm/amdgpu: Implement a new 64bit sequence memory driver")
2c1c7ba457d4 ("drm/amdgpu: support partition drm devices")
4bdca2057933 ("drm/amdgpu: Add utility functions for xcp")
75d1692393cb ("drm/amdgpu: Add initial version of XCP routines")
ea2d2f8ececd ("drm/amdgpu: detect current GPU memory partition mode")
3d2ea552b229 ("drm/amdgpu: implement smuio v13_0_3 callbacks")
2fa480d36eb3 ("drm/amdgpu: add helpers to access registers on different AIDs")
1dfcdc30270a ("drm/amdgpu: switch to aqua_vanjaram_doorbell_index_init")
cab7d478da11 ("drm/amdgpu: Add IP instance map for aqua vanjaram")
6df442a03d1a ("drm/amdgpu: add new doorbell assignment table for aqua_vanjaram")
8078f1c610fd ("drm/amdgpu: Change num_xcd to xcc_mask")
36be0181eab5 ("drm/amdgpu: program GRBM_MCM_ADDR for non-AID0 GRBM")
5de6bd6a13f1 ("drm/amdgpu: set mmhub bitmask for multiple AIDs")
ed42f2cc3b56 ("drm/amdgpu: correct the vmhub reference for each XCD in gfxhub init")
74c5b85da754 ("drm/amdkfd: Add spatial partitioning support in KFD")
8dc1db3172ae ("drm/amdkfd: Introduce kfd_node struct (v5)")
e6a02e2cc7fe ("drm/amdgpu: Add some XCC programming")
bfb44eacb0e2 ("drm/amdkfd: Set F8_MODE for gc_v9_4_3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc8f6d42b1334f486980d57c8d12f3128d30c2e3 Mon Sep 17 00:00:00 2001
From: Hawking Zhang <Hawking.Zhang@amd.com>
Date: Mon, 22 Jan 2024 17:38:23 +0800
Subject: [PATCH] drm/amdgpu: Fix null pointer dereference

amdgpu_reg_state_sysfs_fini could be invoked at the
time when asic_func is even not initialized, i.e.,
amdgpu_discovery_init fails for some reason.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
index be519c8edf49..335980e2afbf 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_reg_state.h
@@ -138,7 +138,7 @@ static inline size_t amdgpu_reginst_size(uint16_t num_inst, size_t inst_size,
 }
 
 #define amdgpu_asic_get_reg_state_supported(adev) \
-	((adev)->asic_funcs->get_reg_state ? 1 : 0)
+	(((adev)->asic_funcs && (adev)->asic_funcs->get_reg_state) ? 1 : 0)
 
 #define amdgpu_asic_get_reg_state(adev, state, buf, size)                  \
 	((adev)->asic_funcs->get_reg_state ?                               \


