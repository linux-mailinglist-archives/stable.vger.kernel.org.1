Return-Path: <stable+bounces-35227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE4894302
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29611C21DF0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF2248781;
	Mon,  1 Apr 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lB3ivhQv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17020482CA;
	Mon,  1 Apr 2024 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990711; cv=none; b=K+eci9OXuX4iuFOgDnqGNQ+RMJVtPomYuyw8kkhnK7hcOGmEtHeP/aBtOKhu6MUnoNrDbJjfDBlPfERX1zeq2DOgLL+0WHabuhXqgn45QyLw6QYI/wTEIaLwF91oASKcvHqnnZrDrKuiKL8P/MrOJYxmqd1EBX5a1UmL8wUqt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990711; c=relaxed/simple;
	bh=9GCJ23lDPe7LHwFdZBAiOhHaLCuV62vOLBcAtnwc/HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTV6ICRldTKjfToulDQYf15N7GyH6/fDEj+FDTJZPj+kOSY/DU6B2YqgQgrz8iYxpSzG1YHxgs5f+3huUk1jmUtEwlWLPOB1ONNexO+qsJpS12cytGuUJ6O5n/VKwJuU/PY7Qia3Gqg5fQlB1xPlyU8ktKEByCB0cDu3yNUIt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lB3ivhQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904BCC433C7;
	Mon,  1 Apr 2024 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990711;
	bh=9GCJ23lDPe7LHwFdZBAiOhHaLCuV62vOLBcAtnwc/HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lB3ivhQv16DxiJjMtIJNlIKz3dWdoyPatCgaeRzndm5s1OBWUv7ai8XHxQLqb/IHT
	 ofZDBvvJcaO8JVxJKTK5apyCMTYpIVEjp1fWqC2MfnJc/R+vQlNfLmo1xacnFbOBWL
	 s2Kbqu9/rcwsIbdyZc2Q/sNp0KRGmPho70EyFiUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 042/272] ubi: correct the calculation of fastmap size
Date: Mon,  1 Apr 2024 17:43:52 +0200
Message-ID: <20240401152531.709409705@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 7f174ae4f39e8475adcc09d26c5a43394689ad6c ]

Now that the calculation of fastmap size in ubi_calc_fm_size() is
incorrect since it miss each user volume's ubi_fm_eba structure and the
Internal UBI volume info. Let's correct the calculation.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/fastmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index ca2d9efe62c3c..1060e19205d2a 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -85,9 +85,10 @@ size_t ubi_calc_fm_size(struct ubi_device *ubi)
 		sizeof(struct ubi_fm_scan_pool) +
 		sizeof(struct ubi_fm_scan_pool) +
 		(ubi->peb_count * sizeof(struct ubi_fm_ec)) +
-		(sizeof(struct ubi_fm_eba) +
-		(ubi->peb_count * sizeof(__be32))) +
-		sizeof(struct ubi_fm_volhdr) * UBI_MAX_VOLUMES;
+		((sizeof(struct ubi_fm_eba) +
+		  sizeof(struct ubi_fm_volhdr)) *
+		 (UBI_MAX_VOLUMES + UBI_INT_VOL_COUNT)) +
+		(ubi->peb_count * sizeof(__be32));
 	return roundup(size, ubi->leb_size);
 }
 
-- 
2.43.0




