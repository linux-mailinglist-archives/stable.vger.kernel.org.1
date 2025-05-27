Return-Path: <stable+bounces-146587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE74AC53CB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F78A1284
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8B276057;
	Tue, 27 May 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siOZXYK0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6819E7F9;
	Tue, 27 May 2025 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364685; cv=none; b=UAK09ETOXXXxpbCfhhTY3sLtQQ+WXJDcGCl8mzLa1tiqAna3/fKrSvztkPkTENLxy2mbZsXJBg5UnaDrobabAi/mLak0Um2Ao/LLC3prn+NhRKhVTlhVtzwSncXmYCFmaoLaHXM2usaA2xkyLJ692+TjIdBszGFcuyWAir6ZeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364685; c=relaxed/simple;
	bh=17Vlg6JWq7KMo+sBnt11+WR9lsB7JREkGVAFx21daik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTH4UOoEGsAqj5xyHkb3WWQRkeECHXeI69z2UC58geM5wOgqeYV8tIU/X/zLD74RmugYBS5cKJAIH6jkXq7z2mLleS31l85L9V7iZP3fX/ZR0EKfB2THqihlmPt2mIbbW0dn3Z2ZgvaIF1rVbM+wOMe0ZDVk/2YYInkOb7xB2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siOZXYK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BBFC4CEE9;
	Tue, 27 May 2025 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364685;
	bh=17Vlg6JWq7KMo+sBnt11+WR9lsB7JREkGVAFx21daik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siOZXYK03LXOQMTV8Lo6tEjmhrowJOteZsXPPx6UlEFN8yepd2e8C8YT6I5kaLFPS
	 RWlHYt1PNtRa4ulltDmYDBXLSIxr8Xa2w8683fR8sbe4eM5iminUUCyE8eyyg/Fioi
	 5vK4zM4384w97Wr8RvREL3IlIofPV3fPyk+M0cE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 134/626] hypfs_create_cpu_files(): add missing check for hypfs_mkdir() failure
Date: Tue, 27 May 2025 18:20:27 +0200
Message-ID: <20250527162450.474906188@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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




