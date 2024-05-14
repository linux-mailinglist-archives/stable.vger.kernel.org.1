Return-Path: <stable+bounces-43785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024FE8C4F9D
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05471F23ACA
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D4912DD84;
	Tue, 14 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+d2p7MS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5826CDC4;
	Tue, 14 May 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682214; cv=none; b=Zybfyf8nUHPHavoC+ihHoHy910vvvpVjaHe5z9jH+gR2/Q6iZ9+9ggaPI0aNkgsC7CEo/8NP9uQB3delPs++Fq0npGqUboDngkOvFh59H83Hur6YcumpnLLdkdxQQ9mOFvFcUaXl+fDnuN2eyVAzq0sywAtBOL8z2sJkVRH993Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682214; c=relaxed/simple;
	bh=6Y1BBv7lQ2ynoKTZyT5VhdZLzSM1eqnrisD3mdtj9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHB1DqWudt4sOdx2luw/QDet2D4pfYL7qowOw/r8/hWjyx0gjs2PmUmgT7uZcMGtj4jKWlsnNWi+YWIbTzJFZ858FcJKVtprOnAP1MWM1YzwgGu8C2AUMdQ9yRVPFGk9WFiTpfoL4/qlsAV0rCTphvcAH7iLE58Sfe5MB7Nxb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+d2p7MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF1C2BD10;
	Tue, 14 May 2024 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715682214;
	bh=6Y1BBv7lQ2ynoKTZyT5VhdZLzSM1eqnrisD3mdtj9V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+d2p7MS+wZA17dSGnET2aNSZcfcVqa/NSKYmRW4UoPbTpNqOTAgs8S6oASxIz81Z
	 KDoLX1wFoRx/WAGh0K/uWaCBfj0BFfNKI/XeBQOBY4Ed1Mj3ciehUw9lXfQRFWZ9jG
	 +WDpqZEidpMAvISFn3Ovf/1Aa9BIxrqkWf7s9Co4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 029/336] nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH
Date: Tue, 14 May 2024 12:13:53 +0200
Message-ID: <20240514101039.705717845@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Zhang <yi.zhang@redhat.com>

[ Upstream commit 0bc2e80b9be51712b19e919db5abc97a418f8292 ]

Move the stray '.' that is currently at the end of the line after
newline '\n' to before newline character which is the right position.

Fixes: ce8d78616a6b ("nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe3627c5bdc99..26153cb7647d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3630,7 +3630,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
+				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
 		}
 	}
 
-- 
2.43.0




