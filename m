Return-Path: <stable+bounces-135346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FBAA98DC6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27C116FD6F
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2C9280A4F;
	Wed, 23 Apr 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dglmIhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845F27B4F2;
	Wed, 23 Apr 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419681; cv=none; b=ZPcogk8HEzRMPJcdPHS0uThTuruQCk8jVZjOOktnYhe32QCXbK4qHyHlW4/NAIZ3gsqnkrPFcemsMy5xavfnwGoP4RiV5VTJ+YgD5WfNocWeo64UYkbPhyyQsAAAxDlvC47Lnmvp0xM9fPUwLWUq4Y+PphiDUmnn/zwm+d/9lfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419681; c=relaxed/simple;
	bh=8040pgTKB+yh2mZ3Kw0pPpMhuwkyesGe0TVcHi2a5mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdjA+soiVWbP3x8mWQfKLWkpgIGEd1UhJUEcnxewLUNIsEStn5jp98hPEliR9t5dYvNQOF98tfjNx9OHh4lEpbHCHtKnu2XtPkI1hv9xElUUocPxSsYtxJE4zfwpTCFVkqib/JqeQnzzP6DXDElVl/22bt8sft47t6ToIgmCC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dglmIhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF56C4CEE2;
	Wed, 23 Apr 2025 14:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745419681;
	bh=8040pgTKB+yh2mZ3Kw0pPpMhuwkyesGe0TVcHi2a5mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1dglmIhz1SyiPjH3lZRB80Vs1VnELvxxJy3prls14GkuyffaWTjbC5QzN8DqjTiY6
	 DQhyP0qwhIEVWiik9nrr41kw5xPtZwcHwB0G/QV2TCs2Flpb5QHoAcyhcl0OzkqRlz
	 h2gipU4kC6vhlT9YUubS9x0Zg0PmmRdY9it61cCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 007/241] scsi: iscsi: Fix missing scsi_host_put() in error path
Date: Wed, 23 Apr 2025 16:41:11 +0200
Message-ID: <20250423142620.826698515@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 72eea84a1092b50a10eeecfeba4b28ac9f1312ab ]

Add goto to ensure scsi_host_put() is called in all error paths of
iscsi_set_host_param() function. This fixes a potential memory leak when
strlen() check fails.

Fixes: ce51c8170084 ("scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://lore.kernel.org/r/20250318094344.91776-1-linmq006@gmail.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 9c347c64c315f..0b8c91bf793fc 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3182,11 +3182,14 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	}
 
 	/* see similar check in iscsi_if_set_param() */
-	if (strlen(data) > ev->u.set_host_param.len)
-		return -EINVAL;
+	if (strlen(data) > ev->u.set_host_param.len) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
+out:
 	scsi_host_put(shost);
 	return err;
 }
-- 
2.39.5




