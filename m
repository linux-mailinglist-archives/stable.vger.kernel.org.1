Return-Path: <stable+bounces-87875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6A9ACCC9
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A22812C8
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68367200109;
	Wed, 23 Oct 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehrnwjOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235C51BFE05;
	Wed, 23 Oct 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693893; cv=none; b=SpCvdHaRNG4tpTO6ch+g/EOGlIQTzm/dkCLTBtaAI0o4S72ZRWzyiq6U5Iu6Zm613YPey5JnG/Nw4CsTl4Y4uUnclOjJyNDxjtXv112fhnspoiuKKMcxmE0yP7prq5M7cFTOUbu6a5BPcosGY/WQyl8H0VGy4FuhOxXxp85Nq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693893; c=relaxed/simple;
	bh=q1OZjb80glGL02e2p03kI221IdO0Idodp+8LAuZylP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUwv9Xeb4oAF/LkK79GXTI5PLxfgCAlPS/U5j3DgBQw/cNqty83v8nYxUusjJn/2GdqgK1KjDoBW7aLbKfqSGXMGXdshs1skkx6bihQhFB2FFwScdo3nEpAzngIwXGNSCcJfwzWEHnGjTIguz6NmeZnBgCWp/i1EcLBPBxefARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehrnwjOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174A8C4CEE4;
	Wed, 23 Oct 2024 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693893;
	bh=q1OZjb80glGL02e2p03kI221IdO0Idodp+8LAuZylP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehrnwjOrjdJMywo3g66O6qTY1POYpqq5E8q60X4Fhbvg294rBsjOCPLl9KRUtRv1z
	 PhIuFXBOFXz7HfvHKErDYTHfNI/p67c45MN48kzDzF7FmJw4jPXDeACaCWl/jkPIMy
	 +O08RuQq33XUEkvVQpa4P1zfhnCQLWtblmqnfI7PZR8ekHItg3c+xI7/XWQ27qhcs8
	 XS+UQf0VLUCmTSlvk+gFTA6KV6b8fnb2Bc470q4tKh+m6Z8vgDeKKjRQgvpBLD82TD
	 HDf71cKDKpXdWkE0hmjqDJhM4iHpspIVKqtV5RggQVPD1qZOcNAQg0zdmxfTBaNwnp
	 0bRjHXOtH74qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 10/23] nvme: disable CC.CRIME (NVME_CC_CRIME)
Date: Wed, 23 Oct 2024 10:30:54 -0400
Message-ID: <20241023143116.2981369-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Greg Joyce <gjoyce@linux.ibm.com>

[ Upstream commit 0ce96a6708f34280a536263ee5c67e20c433dcce ]

Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
is ready and able to handle commands without returning
NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82509f3679373..e25206c7de80c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2250,8 +2250,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
-		ctrl->ctrl_config |= NVME_CC_CRIME;
+	/*
+	 * Setting CRIME results in CSTS.RDY before the media is ready. This
+	 * makes it possible for media related commands to return the error
+	 * NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY. Until the driver is
+	 * restructured to handle retries, disable CC.CRIME.
+	 */
+	ctrl->ctrl_config &= ~NVME_CC_CRIME;
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2286,10 +2291,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 		 * devices are known to get this wrong. Use the larger of the
 		 * two values.
 		 */
-		if (ctrl->ctrl_config & NVME_CC_CRIME)
-			ready_timeout = NVME_CRTO_CRIMT(crto);
-		else
-			ready_timeout = NVME_CRTO_CRWMT(crto);
+		ready_timeout = NVME_CRTO_CRWMT(crto);
 
 		if (ready_timeout < timeout)
 			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
-- 
2.43.0


