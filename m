Return-Path: <stable+bounces-49067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4F8FEBB8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306F91C251E2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7819A2B0;
	Thu,  6 Jun 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gixZlYbv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0171ABCB8;
	Thu,  6 Jun 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683286; cv=none; b=f/Yz4ufcl+c24pvIA15L4QURvbvwjw/imc3nbc3at0TK7zxCN/nIRyxynaiCVFmqjEFj+qIF5tHgXnAFbfOYeHV9TMqPaO8TTGhzlD3R8HNZW7MRphjMTQ8l8hVi2H7i1qCHAk4VbHlT79QJpnx/WrbrvUE7kvSSGNDP/VdCUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683286; c=relaxed/simple;
	bh=+9X4tBQyidAZWj46Svj+LQiG97k8UngqtpZ5B1hNrE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWv2vWsnQRcqWTfUUa0Rgcfu+/jV0by1ZzXcqyAA9yRv3Gc5ly+wLN/7CUIFS/uSu5REq11z4hy+JcmR2qPah+ZrIMJAnLr7TBcG9csdnU7599K373OJQZIGpskOHCU89PkKjF6PDaCCENVRywcOx10oXVvGR+eFmSXqFAxbxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gixZlYbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06157C2BD10;
	Thu,  6 Jun 2024 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683286;
	bh=+9X4tBQyidAZWj46Svj+LQiG97k8UngqtpZ5B1hNrE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gixZlYbvsExmYZkxk56iXJjliH/d/aiy4JGJv8dkDPDYNo2Lf/QT6MeQDxrpKSJEQ
	 FsbYCSir2aD2TO6b2Yi9PQD2wfk3hgf1FD4dzbhvkZ1eN7SnVysQdOvWJ73QjGxl21
	 FYyaaVKH3YypFYpD1OuxCsmIiL88MphS2Eg/17j4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 227/744] scsi: qedf: Ensure the copied buf is NUL terminated
Date: Thu,  6 Jun 2024 15:58:19 +0200
Message-ID: <20240606131739.677680852@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bui Quang Minh <minhquangbui99@gmail.com>

[ Upstream commit d0184a375ee797eb657d74861ba0935b6e405c62 ]

Currently, we allocate a count-sized kernel buffer and copy count from
userspace to that buffer. Later, we use kstrtouint on this buffer but we
don't ensure that the string is terminated inside the buffer, this can
lead to OOB read when using kstrtouint. Fix this issue by using
memdup_user_nul instead of memdup_user.

Fixes: 61d8658b4a43 ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver framework.")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Link: https://lore.kernel.org/r/20240424-fix-oob-read-v2-4-f1f1b53a10f4@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedf/qedf_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd05..96174353e3898 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
-- 
2.43.0




