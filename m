Return-Path: <stable+bounces-54911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB0913B16
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF9A1F20FAA
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE5F188CA6;
	Sun, 23 Jun 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDV2zOGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8318757A;
	Sun, 23 Jun 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150277; cv=none; b=mPd0xkuJH4UySvJIrEIrSdkK8SnctJETsdwt8c/SMG2T5K4UOnXNu4H+fa8yIBsSVPYpJexakMvcezk6zxseHs18AWeTAQzYyltYXihMEW3TKg2pi2DHC7MURwlkbWzHS36z45AVhdWh6709KIDXOknr3PR+GCuCF+uX3qMOQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150277; c=relaxed/simple;
	bh=TfjV0MENPXTWlCS1EqhPF4BJdBl8Pbb0PXittkmlkt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyFMJs098ZZkbWjW4vs6y772PrF3cpfImjV/snRIBxTzD1ePLvdH4hGn43wpdPhalUWyYiZ8wmLFzVhwAGDOsCao5bXRbKIk5fuxxhgmX5NEt9YxPV5IeWiDNq7G3CCuFyu5zoSrKbjquPguMuK7raePah/liRMbW9wkb4OlJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDV2zOGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F3C4AF0C;
	Sun, 23 Jun 2024 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150276;
	bh=TfjV0MENPXTWlCS1EqhPF4BJdBl8Pbb0PXittkmlkt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDV2zOGhrszZyaEB2RqRzs8i2laYSurqyVfANvbZWbtwAhSPmBIGk0EWXHxDp7D/K
	 RYy/5h4FSoE9jeP+m4zT/jpjanIylISDwIXnePB+Zlt7/zCsqLm0AJFgj1fjKxi6s0
	 udmvThkdopT3IPQ/HNpzNhzKzMvrx0J9dZzDfDYckYmyZHlE6rsTxJf1pBi80rgVuE
	 h30IdsQWuX3LIS29QCBVU/A5zZWcCgpn5TO5EfUAf0KK3tbO33QMgydOpAJCWoR6CQ
	 6yA/6qBxqPVA5sriMhJj+ViGA8m/NL3qQdrJ95wtuye5ryW0625IA34eyfkMT7k9Nl
	 cXSq+HSNWuhAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 18/21] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:43:51 -0400
Message-ID: <20240623134405.809025-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
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
index d513fd27589df..36f30594b671f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -998,6 +998,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


