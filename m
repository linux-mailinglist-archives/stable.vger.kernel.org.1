Return-Path: <stable+bounces-54941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC82913B67
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310761F21D65
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618D19B3E4;
	Sun, 23 Jun 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd9Qk15l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD519B3D4;
	Sun, 23 Jun 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150335; cv=none; b=KCGTcMKd0mMjBxFTySawzY3mWyNIqDrLRGjQS5XI2i23EPeC8s9HTwHfbMi3fgEEmOu278R1M6pwEC0DjCKtjYeEPqfcSxUlru6X2SRnB5Ujtejsz5bTBwN/RTXtPcrDqRVkQMW3MqZm/nOcC5hivAp30DKltJFcZlRCpiG3cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150335; c=relaxed/simple;
	bh=2Z3XvizxzJMSuoKNyBEDeSZ+eIoOmFz6jrU/KbpNV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX+rpQRvXIC+TOrHCrLjlgZEee4UbgJxGe8CJTFSLDw7lMxl7W6ptHxm82jpL5CG6VueqjHtXhoU6P8ZDvcPN1b7AjaJpEqFvwUrLHJFItd44kNmMgxuhQOSErs+UKC3F56+AMW7eaRhunenhBfiLg0WKguxlqND7BoVM6pjvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd9Qk15l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8257CC4AF0E;
	Sun, 23 Jun 2024 13:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150335;
	bh=2Z3XvizxzJMSuoKNyBEDeSZ+eIoOmFz6jrU/KbpNV4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rd9Qk15laXk8eMGGFjIzlyHGnF1RaYvL+qGNKoMKMwB9E2xej3fWod35pcULeH1+R
	 qq4jpbiO9uQL7oHPtEF4y8ozn2pZEl8J1CmGn2UviTzbKF30AKJex+u2qK2lH8EuJy
	 5fj+xDbNtdLVRhpXI5Nc3EiHLruk3XZEapk9qVNWi5C1bK+BygaTdrMolU6K8H5+Vj
	 pj+1xaC05139rWb7SxISR8aoDSJagcjZryjxSJsUXYvpz/U/ch7nvUrL2BNNhnAtNU
	 7i8tFaHHaeMfURZBZ65s5x0F82XbZZ5vfGWXZ0S7KdnYVLlTkScitwSqJsziWJxdqk
	 D2AabxOYtJ7pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/12] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:45:14 -0400
Message-ID: <20240623134518.809802-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit e5d574ab37f5f2e7937405613d9b1a724811e5ad ]

If a discard request needs to be retried, and that retry may fail before
a new special payload is added, a double free will result. Clear the
RQF_SPECIAL_LOAD when the request is cleaned.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75b4dd8a55b03..1aff793a1d77e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -954,6 +954,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


