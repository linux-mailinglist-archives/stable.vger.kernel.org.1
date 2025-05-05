Return-Path: <stable+bounces-141192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BECAAB159
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B94617F65B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14F93CF346;
	Tue,  6 May 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKySiQYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EA2D1116;
	Mon,  5 May 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485462; cv=none; b=ONYSDZv3CEF6qDJmS+VioZvERImCKAPx0GJ6iTtSm3Xv56oiK8tQ+csUdMgfxRzcWtKXVICcgkl5fn32DOmFCv74p46AEi5Rpn0aPsRnmX/BOLnIh/fW+8lgCZOMRhwEmilVswTs/Nd1gen8JHQ15o/ty6g/OjEyQgYYl1mfY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485462; c=relaxed/simple;
	bh=Z9LX6s23ZuIXyzShDrnweBPy3s35tSG0fmfwXhPvyag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yahj5VNUndiSUonYU3BoOoxKpAVhPb8jMCYcJRQyMfxlsFFJKOYdXuCOpI4mPV+C7A98ymjIJ/j3oRpz1FKhBm8hb7x31tUhXotzl9xHKHrKeJfA1gMBp2ah2tW8uOzu1O96St0grpWqawDu6VzO3SnI/7d89qWSkYJLlDj5pVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKySiQYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20982C4CEEF;
	Mon,  5 May 2025 22:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485460;
	bh=Z9LX6s23ZuIXyzShDrnweBPy3s35tSG0fmfwXhPvyag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKySiQYZxcB3offOww41/agfyooS+ED8J3qnkljU4ffY+u2WpZ5QZud+VuUr9QmwT
	 ssal1PrBIG1EYx/WbswjJYDNeedm3iNUcZuPWinxBKxyEl22kDKLKyw5U1X/JSi3IO
	 O5mIlvbZHMKCYSgRsJh0zI/xGRnqLGkc31cNif5Q4I/DPx9DbUBiBbCPlxynonzmxC
	 UHmd/XDcqRnDg0Q09NUQ/L23tQQTYOUw+ohUdC1euHdvlBjFS3ujbClT2UGtsgJqf6
	 RFpPDytPJ9bsK4qKAv8yhsDQXGmK3QFvg9x1f01jfDm0qJ9MetI0hmS9VJuqLU8ds2
	 Jv6jkqxyMLP0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 324/486] firmware: arm_ffa: Handle the presence of host partition in the partition info
Date: Mon,  5 May 2025 18:36:40 -0400
Message-Id: <20250505223922.2682012-324-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 2f622a8b0722d332a2a149794a3add47bc9bdcf3 ]

Currently it is assumed that the firmware doesn't present the host
partition in the list of partitions presented as part of the response
to PARTITION_INFO_GET from the firmware. However, there are few
platforms that prefer to present the same in the list of partitions.
It is not manadatory but not restricted as well.

So handle the same by making sure to check the presence of the host
VM ID in the XArray partition information maintained/managed in the
driver before attempting to add it.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <20250217-ffa_updates-v3-7-bd1d9de615e7@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e8efa6cfd58cd..52e1cbaab856d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1448,6 +1448,10 @@ static int ffa_setup_partitions(void)
 
 	kfree(pbuf);
 
+	/* Check if the host is already added as part of partition info */
+	if (xa_load(&drv_info->partition_info, drv_info->vm_id))
+		return 0;
+
 	/* Allocate for the host */
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
-- 
2.39.5


