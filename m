Return-Path: <stable+bounces-128082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28BA7AEFD
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2801176296
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B822B8AF;
	Thu,  3 Apr 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDIaNNxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE322B8A5;
	Thu,  3 Apr 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707927; cv=none; b=FSt6toiJMwxFwPRpglNm9ZEmhj8xp/W8ME8KgN+Mcy/ip7S4tZ1I/chRHxy3BW6CxKbpG4tAqhDq0eXKY6jKhd/lyAOqFODpNDSaOeSBjME3bUoTI4JKUsIX1btcHoiaimL8OAK5aZG3EBYkZpxpJP1TPQQOnhhtyTLhyWrvWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707927; c=relaxed/simple;
	bh=kPhaR9pu1DzL0tQw09EuWpUvDoPfhkOJEDvDGoTvV2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdn7SzQ68hLnX5xOsKlXwhipFBabuX+iNoLq27GefAgJ9JLIhIV7Z9kjDiavI5n6eiOc4YiMdDIL3+EuGV598HikJ1qjndNAnRMcVOw8+IpQK7NKECU7p18G15zploUaqBTkJd8ZIkaAd47t6KbD2CaRTw3mnSlBSwYUrFvzTcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDIaNNxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B22C4CEE3;
	Thu,  3 Apr 2025 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707927;
	bh=kPhaR9pu1DzL0tQw09EuWpUvDoPfhkOJEDvDGoTvV2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDIaNNxkN9DLi6We3QoVzs9DirAhYMJSLM4tDreUYMH1DnK/kGf//je522ufMExhv
	 nbXIdYex40NbzaNCPcaafZmQMPzV+jZqZip9hjit4Y2pr4GBsQ17SrYokvZxKytdW4
	 t6rVxngKwMJWIKfaNNgTEJ6uFWczaBUVoNIl4+ERepn0UFtchQdHgE86WQd8fQD+Ut
	 SWCDvl7a3UPOT0ffDmIs1KWKGnUqJRVlX56QRCdC+2vkYAFr0pAeuUfK+8PzxC3+lS
	 8ipIGqqchznof/mCCRVfjkGAv1zV+4z0Dmh1H3fIvka8izZ1J9LHhAD3D+gLUqtnr1
	 c55ueWRbZSbNg==
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
Subject: [PATCH AUTOSEL 6.6 11/23] drm/amdkfd: clamp queue size to minimum
Date: Thu,  3 Apr 2025 15:18:04 -0400
Message-Id: <20250403191816.2681439-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191816.2681439-1-sashal@kernel.org>
References: <20250403191816.2681439-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 8669677662d0c..35dc926f234e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -212,6 +212,11 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
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
@@ -477,6 +482,11 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 		return -EINVAL;
 	}
 
+	if (args->ring_size < KFD_MIN_QUEUE_RING_SIZE) {
+		args->ring_size = KFD_MIN_QUEUE_RING_SIZE;
+		pr_debug("Size lower. clamped to KFD_MIN_QUEUE_RING_SIZE");
+	}
+
 	properties.queue_address = args->ring_base_address;
 	properties.queue_size = args->ring_size;
 	properties.queue_percent = args->queue_percentage & 0xFF;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index cd924c959d732..1f753e72fa2c2 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -58,6 +58,8 @@ struct kfd_ioctl_get_version_args {
 #define KFD_MAX_QUEUE_PERCENTAGE	100
 #define KFD_MAX_QUEUE_PRIORITY		15
 
+#define KFD_MIN_QUEUE_RING_SIZE		1024
+
 struct kfd_ioctl_create_queue_args {
 	__u64 ring_base_address;	/* to KFD */
 	__u64 write_pointer_address;	/* from KFD */
-- 
2.39.5


