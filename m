Return-Path: <stable+bounces-16218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9683F1BC
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0727B23552
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D000F200AC;
	Sat, 27 Jan 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nz2CmKrJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92649200A4
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397463; cv=none; b=HDCUepU7sOjyZ24jh5KcwD0yefhNXPn/cNJstbz2mioKoXMa17vC8KinkqzEqhZ2mhCVw3nRKgHd06y7x53afDWliy0bzoqXFJ/YYKSdSoYm0WrebcCesHd3vdQbfrukKHJEENJltGdFAalmdQdYdKniVI2Y9TN2YfocM2sY9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397463; c=relaxed/simple;
	bh=VJ2gV/koupta1iXdmwgyKtT3QWzHYPI/bxXsFAXopT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gezadyLqNJc8guIuARuS3Iqa3U03K/Yoa+XFK1WVIu77rnJrPf6ELmvkGtAGKjLmTffI+sxQtA/FXiVGFDvVhSSV7Wsy4B21Q12EydVw6lPhDmsUsmkuVukUl5H08kFw+eTbiNlPsir1c8CUaG5krxlbYmpYmep1ZIhbfHCD7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nz2CmKrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A875C433C7;
	Sat, 27 Jan 2024 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397463;
	bh=VJ2gV/koupta1iXdmwgyKtT3QWzHYPI/bxXsFAXopT8=;
	h=Subject:To:Cc:From:Date:From;
	b=nz2CmKrJmwqNJLFHKd7/4HPnuqhbE2zMZDSbkIYldFPwrd68tEDNwwwIlPLghTUQK
	 +4bksHt1yl7DgbPGZpmnJ5s7bqqVW4UnIPCWr2YFdqfkAPD650MiJUi3N60RK+x2Pt
	 EEtGVfGzeJJDo4Hs7L2Jfw2gl0V3ZeUgpcBt+PWo=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix null pointer dereference" failed to apply to 6.7-stable tree
To: Hawking.Zhang@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:17:42 -0800
Message-ID: <2024012741-district-sheep-fcc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x bc8f6d42b1334f486980d57c8d12f3128d30c2e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012741-district-sheep-fcc1@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

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


