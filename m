Return-Path: <stable+bounces-132582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F28A8838A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F9B16CA62
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C225393D;
	Mon, 14 Apr 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbfKHNCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802A2D0270;
	Mon, 14 Apr 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637460; cv=none; b=bPgCKeN+c9XcZ4MZUbzDAPFQsBOLZ1+FkpqkvUwz4SWydqoCQbRWY5vWcWYZizl30vk0hYZdia74BkmqVtCgXkvrvm5SJK9azqdBBBEoFnf17YyhLctd9trYwWkDtC9rlQ2Hwrh1eYXpsZpU78/OYxB6KxG1UZSqZMjs2k4G5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637460; c=relaxed/simple;
	bh=JiNGGLDvkpSf69DH9x7QcroMSUkNyxMbco3HquxO5Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcjyt9QJCspE1j0o6ZiTKyX/2GZi63//V0DWhs/T24g0ejtoiWx2pq9ZNxx7nqnnH//Kp7yNFG7ILU5a0tSEjZ9G+xDn66HxKQJvyPHOjPF00Pr3WBWTpnWyMNmpAdVPRe9yKCb3Khmn492b4zBRAapgjVco1nUY/oJFt+hpS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbfKHNCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E856FC4CEEB;
	Mon, 14 Apr 2025 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637460;
	bh=JiNGGLDvkpSf69DH9x7QcroMSUkNyxMbco3HquxO5Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbfKHNCjBHDfi5sbg8qo0Zo9hX2HyUXHvE+O/RyzEFniCC60WN0IE/ONfZq3Bhdq5
	 9P9p9CINyqwoh76PbxOydDhy6da2CzYGc8mnPii6p6OTxHbDAqhrHLseA18bfvrUAm
	 +K9IypQReCwZtW6hHjR4v6uR375xaZtnceJ360XmOyR4Xgns+uwyLmPNVl+azXNrsx
	 SIYpyc9kfhHn0sfrcv3/YV4SFcoPD4TrK7/dO/ZKDCE+Jk04k9ppGqn0pBP55dVEdp
	 dMfxCpKYhTSZEmN6JD7lYAnd+mS3dbk6J/jolK/4QpRcHQYW0F8Bw9D4OAAE8jNmNq
	 Fk6tSRjWN4fSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 05/17] nvme: requeue namespace scan on missed AENs
Date: Mon, 14 Apr 2025 09:30:36 -0400
Message-Id: <20250414133048.680608-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 9546ad1a9bda7362492114f5866b95b0ac4a100e ]

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we may miss a Attached Namespace
Attribute Changed AEN.

Check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan has
finished, and requeue scanning to pick up any missed change.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a636fe6506b4..ec73ec1cf0ff5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4704,6 +4704,10 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_scan_ns_list(ctrl) != 0)
 		nvme_scan_ns_sequential(ctrl);
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.39.5


