Return-Path: <stable+bounces-132481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9885BA88253
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352747A2C5C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B8284685;
	Mon, 14 Apr 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgUfvESC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172F28467F;
	Mon, 14 Apr 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637234; cv=none; b=J4FJZHbcuNkFzrVMQIAg1KkR4wMLMIF+cslikF0eiLj0QBqhkwbkLiFhJUBzoRd43D+LJgJkMSsALFx2nrqEcLuLOukuOowdUqLPlWkAPV8BdDR+E6W6e93rn3awrjZU+1molieajVuKfU1z3Yv3V1+diS/gpvpdnQGEoF67Zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637234; c=relaxed/simple;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqt0VAt1yzv8B1yJt7n2x6RTSRHLKDKvrCBMZ9u/BpqPW805X2omT4mS9neaRbPQGiTgYs736pHmP+1abBJnJgNZbfx2sZwM5/WdC6l0ninXsJlYG87okbDFfZEvwTZW6pGhwRcVGe5O/ro/vZrut/vF0XSEdiS5BdOvzh9jpKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgUfvESC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A1C4CEE2;
	Mon, 14 Apr 2025 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637234;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgUfvESCuvkJi8aGlCDsbt71YRoDTOcSMJzMB9BlwsRu/7z0X6lKVynxVuLVGdROZ
	 BWB19ZHd5Nst2F2FwbxOqoVTpXSIwG6JwgFD4wHzVo+uWuYCZAKxsmd5A2U9MGOgIk
	 COVAhUn6pdQ8twEszcSJyQT6hFvvN1Hl87hkr2fzLuqKBNYzI2UxumBHH/2lM4qZfD
	 l0Nc1BooNAt12OVXWwuPD2JJtJ37XqU1iekX/MZimSCE7qyp5S7x4+CfIkXzfbKESs
	 6kHv+KbPJ+FydmRMAmRSWaJmCP7uNxdJ0AnBGbFRYZku3jylK8WwVtq/GcUIJZVj9n
	 PgadX2CqkZWVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 27/34] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:26:03 -0400
Message-Id: <20250414132610.677644-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a3a6dfe98d6fc..0dfffb3f39b06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1103,7 +1103,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool
-- 
2.39.5


