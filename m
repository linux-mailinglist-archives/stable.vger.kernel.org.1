Return-Path: <stable+bounces-87839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3527D9ACC55
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E7D1F256AC
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B01C82F1;
	Wed, 23 Oct 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp3LDBJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFC1C231D;
	Wed, 23 Oct 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693821; cv=none; b=p3kwgcPZRmw2IUhiHPxB1JTu2BcAGzoCtCan7ahw1nu9TCmDPmprfVhCrn/sIRikD6u9x2IeuvPSd7aAY100U8FeLvATsedYHgPkSTWzJrzxHaD/ebYuByJ9mTN895gmdFAKPk9DdLgrJG/sT8l56olcOTbBwzxJfFcmZphNbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693821; c=relaxed/simple;
	bh=9oHXuF+qIh9hDTSdG20YAN13vLBeCWBtn9oCkmaRlQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQRz7zRLZSemuFjxCbHRYFr7mzQB60thWTZ+WkhYklPhhwrhI/iFw1hIICykspuxPDmI3Z7MNTdt9IkdVhoJLi7TnWo0AESqLppGYO+k9MLuX/oNbGvTsaONf8Y8RdkfAgyTQFkyBqW3e6CvPUl/Jf1pzHO3/lV1r0sj4PNvT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp3LDBJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB465C4CEC6;
	Wed, 23 Oct 2024 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693820;
	bh=9oHXuF+qIh9hDTSdG20YAN13vLBeCWBtn9oCkmaRlQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp3LDBJyxKwh0YroagZ8LLjHCZrTKZGxjECg0xrHbDhV0loYw4H2f1SHpCnQNLA42
	 Vizr95Oo69xavSPHQO/mmR11751WTUJt32JAsMC3DPnEAshNku4sJ/yYKh67GJ014P
	 RpXtzcgfFV27OSYI1Vn2byyYatGrkkJd590f9iwle94HvqjvOYQn4iK3Hf05PCfHNL
	 vlSWvzrUc+NAGMkNPzjL7KgHRfQQbm66kwKe5qJfgjxe34EjlaWUcV3+q2llxhbGjM
	 Eq1yzQFNkTXv4oR+t9FZJfwoqx9g0Jas6Z1KSC8VlGxm60B1aV8+ZgbJZjj/Msrgoe
	 i+tUFa12KA+Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 04/30] nvmet-passthru: clear EUID/NGUID/UUID while using loop target
Date: Wed, 23 Oct 2024 10:29:29 -0400
Message-ID: <20241023143012.2980728-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit e38dad438fc08162e20c600ae899e9e60688f72e ]

When nvme passthru is configured using loop target, the clear_ids
attribute is, by default, set to true. This attribute would ensure that
EUID/NGUID/UUID is cleared for the loop passthru target.

The newer NVMe disk supporting the NVMe spec 1.3 or higher, typically,
implements the support for "Namespace Identification Descriptor list"
command. This command when issued from host returns EUID/NGUID/UUID
assigned to the inquired namespace. Not clearing these values, while
using nvme passthru using loop target, would result in NVMe host driver
rejecting the namespace. This check was implemented in the commit
2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique").

The fix implemented in this commit ensure that when host issues ns-id
descriptor list command, the EUID/NGUID/UUID are cleared by passthru
target. In fact, the function nvmet_passthru_override_id_descs() which
clears those unique ids already exits, so we just need to ensure that
ns-id descriptor list command falls through the corretc code path. And
while we're at it, we also combines the three passthru admin command
cases together which shares the same code.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/passthru.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 24d0e2418d2e6..0f9b280c438d9 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -535,10 +535,6 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		break;
 	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
-		case NVME_ID_CNS_CTRL:
-			req->execute = nvmet_passthru_execute_cmd;
-			req->p.use_workqueue = true;
-			return NVME_SC_SUCCESS;
 		case NVME_ID_CNS_CS_CTRL:
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
@@ -547,7 +543,9 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				return NVME_SC_SUCCESS;
 			}
 			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
+		case NVME_ID_CNS_CTRL:
 		case NVME_ID_CNS_NS:
+		case NVME_ID_CNS_NS_DESC_LIST:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
 			return NVME_SC_SUCCESS;
-- 
2.43.0


