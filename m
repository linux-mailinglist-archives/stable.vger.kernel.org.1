Return-Path: <stable+bounces-54945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB155913B72
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D61C20D93
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBF19D06F;
	Sun, 23 Jun 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ/j+G0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DCC19D063;
	Sun, 23 Jun 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150343; cv=none; b=AzjTkYESTnfiBhavuRTk9DJqldVXjmMK706Ih9ysHPdXvXyR+uESxOvtDf7gFBUU2bmT/7am3NoYR/DJiCK9b+RfYsaanuF2G81TU92/k1h98Hon8iBrjNxGA2eY1c2VXtWNOr6dLVyODB+hEUmWIyVeQHKux8buX9ZBCFG8Nkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150343; c=relaxed/simple;
	bh=/9xR0m08+eK08nMnV1XouuDRAiT3dPoGZes7iFkvC7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKvwKRcoFPaXfgamZdHIYkCwweD/Im0XC4WX7+HiOXt6zBnOi51fPMLptHDG3PfJnFuD6D3GyP2UanEc2n73s8svZbo69iZu0tHRX+G7I7roBQKHYV8A1rRCy/1X3SrzAX0uSbLTVyaVii5H8CofWtRKjge7MbrRPy2Par+6TfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ/j+G0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD73C4AF07;
	Sun, 23 Jun 2024 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150343;
	bh=/9xR0m08+eK08nMnV1XouuDRAiT3dPoGZes7iFkvC7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ/j+G0AwEEcS+FlnbzlhpoGBGtJy1RboiqhTnJrqK5bEqfTdGEoYnFgWfr2wZzdE
	 qiNsZzxa2O2+NcWhHzkP2nBna+j0UtXrZ52hohE77H6yt39h/M7nQxEhaTSg0R7z4f
	 ZJhTvO50YQZ3lCfTJx1Metw5SsAOqPSNGlwJAZlclm45XJQB5whoQv41N46kOlOcMc
	 paxd+TrO3oXQUuWMviBVLZfH7ul9zdAiChpaVRvgMarvCAccvMHDe3aJwOe3xaS0Kv
	 QbXYCdu1rhW3JnKm9c8NOhdn1cEYqHFtXQrFelxUuATfpWATZPZan6uUOGVrFGiGuB
	 koyEloTR/jqWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 3/3] nvme: avoid double free special payload
Date: Sun, 23 Jun 2024 09:45:37 -0400
Message-ID: <20240623134538.810055-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134538.810055-1-sashal@kernel.org>
References: <20240623134538.810055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 960a31e3307a2..93a19588ae92a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -981,6 +981,7 @@ void nvme_cleanup_cmd(struct request *req)
 			clear_bit_unlock(0, &ctrl->discard_page_busy);
 		else
 			kfree(bvec_virt(&req->special_vec));
+		req->rq_flags &= ~RQF_SPECIAL_PAYLOAD;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
-- 
2.43.0


