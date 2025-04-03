Return-Path: <stable+bounces-128104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33213A7AF43
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697EC188ED86
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7C23C392;
	Thu,  3 Apr 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un7CgENr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABF23BFBC;
	Thu,  3 Apr 2025 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707978; cv=none; b=ERJn7ECH30KFad77xE1D1uwKGHRyTHNODm6kkUe3B1lMPlrwLhsvHe23ou6J16+lyEh45y4AoxZX2LrKMkNXjS/fPSCBRj7B9rlIFJ3oC5meIPnh4kExilNM7+CgPIQ5MEray8c6tGPHbPS8+aYgA0Ulo438PuCLdd99H0LZTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707978; c=relaxed/simple;
	bh=0kgwTRCEtBEzBgu+kF1qMTp8q+Ccqf1TuFatw8OGfNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2WylUF62XQLXmV8kPiz5yX0zFOMgc1kMFpsq4Xk40aie1V1DXejLeDPdRwTjmMa59UdHc/Zlf3LxZqoooAYZjKpXE7zKjMkQoiumhBFSSA9PhFgju4PLaG6jDCWDN3OhFGmOXOjKSRrk8IyCm5VytQr7WaaW0nQX2IUcPUoPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un7CgENr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4065C4CEEB;
	Thu,  3 Apr 2025 19:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707978;
	bh=0kgwTRCEtBEzBgu+kF1qMTp8q+Ccqf1TuFatw8OGfNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Un7CgENrieYWfTZQ43J5kdjo+l1KlPfF5Zj9nPKD6uUBZULDahJY+QPUxAJq0Q1F8
	 xnLeUnhpjFLSyomQvi5NL0qckrzxzooax0HhdfVF+kTrjVeOr2GB+o4my6Thqy+lDh
	 48RbXBXoKO5Vn14IWPUbfuZIG95hdm7SZ8fIZDiObA35jcNE0p65rrwasFHs3VWQkd
	 1VFt18ZP/JLdYIKukeBdoEkQRQdTnFyrXUWAWnkrmSRlxFHAHpRh6KIEWxZXhb/bSP
	 Rgfy4h74RPDgModC5urln9aUINS1KWNNPub5jMaaAyOKEEMla7VUxNAS2EvjK6A6EQ
	 MiziVumatT5nA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Yat Sin <David.YatSin@amd.com>,
	Jay Cornwall <jay.cornwall@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 10/20] drm/amdkfd: clamp queue size to minimum
Date: Thu,  3 Apr 2025 15:19:03 -0400
Message-Id: <20250403191913.2681831-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: David Yat Sin <David.YatSin@amd.com>

[ Upstream commit e90711946b53590371ecce32e8fcc381a99d6333 ]

If queue size is less than minimum, clamp it to minimum to prevent
underflow when writing queue mqd.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 ++++++++++
 include/uapi/linux/kfd_ioctl.h           |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f83574107eb85..773913a7d6e90 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -208,6 +208,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	if (!access_ok((const void __user *) args->read_pointer_address,
 			sizeof(uint32_t))) {
 		pr_err("Can't access read pointer\n");
@@ -464,6 +469,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 42b60198b6c5f..deed930ed3051 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -55,6 +55,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
-- 
2.39.5


