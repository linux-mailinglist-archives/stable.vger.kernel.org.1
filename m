Return-Path: <stable+bounces-132505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CCA882C1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD4F3B389D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B262BE7BA;
	Mon, 14 Apr 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvS7/Wld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C527A92F;
	Mon, 14 Apr 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637291; cv=none; b=R5Xwwgr3BHx6PRhKVPj7vm960eFo3dmeBKOirsu4HeN/BL8sdZK4WxvxzR6R1VuHkuejJtiEVXFTDMadEIEanVAV4Fw+H+B5tvv0WdXd9oVsS/To0S+JbBlE317AxDsOIrHnm7Q5Z5VHqFn2PWMKBC5NYq6n/OvVxVi7xwwwlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637291; c=relaxed/simple;
	bh=aAp+d0HOva9zbinlXjn0QPDZc+oNfOzsnaiqbkQEMKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McgI5HJRDEZMkCNaQv5yAoSXDg21g44U+0x+tTpP1z+C/xWzCbH4f2Vm/oBqzDePow63PFA6bSf9/nukVzlPUQb4XPTMRH15k+N8oAQzg+qI+v5j1Wzy4L9U7zNH22HF2yWodmhq+t04wxXBU0QMmNKsz2pO+Oj8XZ/62ds5sBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvS7/Wld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38004C4CEEB;
	Mon, 14 Apr 2025 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637291;
	bh=aAp+d0HOva9zbinlXjn0QPDZc+oNfOzsnaiqbkQEMKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvS7/WldujpeTgXTpusVUxWGQKG+dONn0SIjRaU4/TnV/Tia5cj+MwPorbbG+pTrD
	 5X7o6082pBVOraL7m1xsg1VxRBWEyPotaG+9HK4/1R2V0EH5ZoHMgnireAlD7aMxct
	 f+CpcC70tcfDAaTNwmE7WTQ+zGDYzlTYaVL3MJTmZSGwm+0SxlwYLxq9qdIWlzaZ6p
	 DpGl9aac0LkrrUCd6zE9VhT0AvVFTtOqLtL5sWYBVkpHOnPVHldmgnI+PkRmDcT+da
	 pX3yr3+H/cZcV7M6Iem+LX1LwrLgZqNU4ySY20ngeyj2wFnQPWsTib4wtHedR5A721
	 mfbC9IliIGdlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 17/34] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:27:11 -0400
Message-Id: <20250414132729.679254-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b386889242c3..33184d36310d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4286,6 +4286,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5


