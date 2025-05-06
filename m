Return-Path: <stable+bounces-140533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C4AAA9A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBFE4A2271
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C036AD0D;
	Mon,  5 May 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Crmbaj0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AD298CDF;
	Mon,  5 May 2025 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484959; cv=none; b=dI8l4ylQ/wlxZRoyVlH/szsbwNlYU7c3vv48vkDhhEggzKoDVVDoUTfmq0WdmliVA4R+JHAW180hqQJHJHYWZHGQEVLsk/2/jiLgMdBaHU7KbAuG5wHOJh+S5/ILeEEHW6j/slzMSskOV6N6GcfZa664ut/3QVjEZXiCeiyA03g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484959; c=relaxed/simple;
	bh=vYBIDgjPuAT1pjrXhbJXLQ/c65u0Xv16gt1tFOp2Wa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDK1zLjHf+m2UiBnunCp+Wxn+woygvRFVIh7CNXBYXFW30SBu3W/jHri/5NYLwnQHyKWn7hqUeif8Y12rVuc9HFdunj6TZTmeYZE5QrDVgXTmdnwH5cbN9qIV92ZTw+oVlw50UoUgJ2oyhsYXVCfqzUFNi9xVDdrdN7+EQG8qQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Crmbaj0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3006C4CEE4;
	Mon,  5 May 2025 22:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484958;
	bh=vYBIDgjPuAT1pjrXhbJXLQ/c65u0Xv16gt1tFOp2Wa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Crmbaj0wYzyyOvfux//FhZlQABkO10fPXhDYuBVCWWMabPLkuddZiFq3V6jK6ky/7
	 klm0Qea27W3MWogfZ1aUvK1U6t7sa/oqXFPBx1lepL/H+Xf4MczDZMthneokwTvU41
	 o+LWS/HmF+Fc8kyKceI8Qldrgsu31FU7QRjFaTQpnVNOxn3jv/9h0m/kCoE/f2UoZg
	 9lD6mxH7wRPtTXUALHlQqXeUd2YLIYtyddxXlYuDXx51WekmeTKUZ0yjZY9kqL3Kan
	 WqsWm/DRFrlpQvAFe31ao8kXdsSTE6H+h5T7L7D0oAFWDjcrS2SrD+YpkGUkQ3r0Fk
	 k8RiRdRIPvIug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 095/486] hypfs_create_cpu_files(): add missing check for hypfs_mkdir() failure
Date: Mon,  5 May 2025 18:32:51 -0400
Message-Id: <20250505223922.2682012-95-sashal@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 00cdfdcfa0806202aea56b02cedbf87ef1e75df8 ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/hypfs/hypfs_diag_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/hypfs/hypfs_diag_fs.c b/arch/s390/hypfs/hypfs_diag_fs.c
index 00a6d370a2803..280266a74f378 100644
--- a/arch/s390/hypfs/hypfs_diag_fs.c
+++ b/arch/s390/hypfs/hypfs_diag_fs.c
@@ -208,6 +208,8 @@ static int hypfs_create_cpu_files(struct dentry *cpus_dir, void *cpu_info)
 	snprintf(buffer, TMP_SIZE, "%d", cpu_info__cpu_addr(diag204_get_info_type(),
 							    cpu_info));
 	cpu_dir = hypfs_mkdir(cpus_dir, buffer);
+	if (IS_ERR(cpu_dir))
+		return PTR_ERR(cpu_dir);
 	rc = hypfs_create_u64(cpu_dir, "mgmtime",
 			      cpu_info__acc_time(diag204_get_info_type(), cpu_info) -
 			      cpu_info__lp_time(diag204_get_info_type(), cpu_info));
-- 
2.39.5


