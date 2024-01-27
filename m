Return-Path: <stable+bounces-16219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F983F1BA
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44111F22D71
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2723200B2;
	Sat, 27 Jan 2024 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChPLXUUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5352200BC
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397466; cv=none; b=GmYqlSFT9XzuUwJG0niJAIq9y96E8ni5Yi3YBmUCIIqwdd3R5p//Qj8INI6pDwFH2tEtFJ4JsTigbliWrr5cMgA5+cVYLtu1VRuEXX1DS3dBJo5Pe8fncdp+60vZljXp7ZuAFajR4F0UEr2u9pS7NyNCIKZHRlS8Cd129y0XmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397466; c=relaxed/simple;
	bh=n3cl9S1dhVE3v6QggUroNQYX8tQMaROPL5g3LRmWE34=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E7h2p+q4KyrrtdwWlPhTWAEfHo6l3T+j9axFsNGG4C0vNknWiRi0cIeAmWC9aoBCIDpH3Vwla7INcCta3W7XdK/tM027P9mC8xlMlkQ/lEoU2lvSCDhKlVUnzxIltyOOXh6BkhJkh/eEu7qoufJU/cRkHFSGJvjoVJwXk0Qn7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChPLXUUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD9C433F1;
	Sat, 27 Jan 2024 23:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397466;
	bh=n3cl9S1dhVE3v6QggUroNQYX8tQMaROPL5g3LRmWE34=;
	h=Subject:To:Cc:From:Date:From;
	b=ChPLXUUSso+03yHUqSxLzl/Yhzh1ZIjyOMcX6oB4CCTx4sj1eF3UBzeGowDOjdTwN
	 e4bzHFol49XsH0RaxVicP+h4NjmSYrEgxYi1APl+xVnR+3ksZfVb9HIPRNjad1ZcRZ
	 /KNmeELAPvhQ8EVOnJ3j80fL72gLThlr6BYb+cfA=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix null pointer dereference" failed to apply to 6.6-stable tree
To: Hawking.Zhang@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:17:45 -0800
Message-ID: <2024012744-aware-crunchy-1ff7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bc8f6d42b1334f486980d57c8d12f3128d30c2e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012744-aware-crunchy-1ff7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

bc8f6d42b133 ("drm/amdgpu: Fix null pointer dereference")
9a5095e785c3 ("drm/amdgpu: add amdgpu_reg_state.h")
c8031019dc95 ("drm/amdgpu: Implement a new 64bit sequence memory driver")

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


