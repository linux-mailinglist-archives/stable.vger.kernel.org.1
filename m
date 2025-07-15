Return-Path: <stable+bounces-162873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC72B06031
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB7D5A1175
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC32EBDD5;
	Tue, 15 Jul 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmlI4uJz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8222EBBB7;
	Tue, 15 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587700; cv=none; b=gKddh3yDN/p2J/BGJxq4lwOkzmglpv5lSqXpOYLQOj+2mo6wprgvD/SPidaPNP+PXIzc2wPhnIcChToFgjFhEmSYdA2NVYxLNZKgMDI3SmrrZ/fkdvDOqjLi6z42hhKIDCOzkpKx03UNrTk5v6uTiHFQX07OMfOAlbF+khiMvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587700; c=relaxed/simple;
	bh=j2dfQEJUJImv88dekgndxfUwVsZD04Tv/KuTcpHvDMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjhT+z1ij+tT0e8VQIPjf9ano1nVi2WKHWlZ+dpLadfa0pRzwDpsB2RrHWZ1rQIKVApDr3k2rg6u/5PiE/L/hYGWu1vLjknk0pFCXMVQ3ZicaKDs9b/My/LkKqvjML4sfM4Hs4xEea7QPfgnAJH0dGQZp+RNalxTVGNLBDX6UE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmlI4uJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F82C4CEE3;
	Tue, 15 Jul 2025 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587700;
	bh=j2dfQEJUJImv88dekgndxfUwVsZD04Tv/KuTcpHvDMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmlI4uJzncQgDswuHybE4Sj8kybv23c278yj/O/PvDvE7xh9AeH04+S+zp3dkRV4O
	 ZP6WZJXtXJjTnB5WNH9qZKZZpDP/u3W0/Tn0uylu7EwxlrC1Tr9Ecw3uz8MwF+gqrc
	 +z9aXUyIC5j6f8DOu0ii29PZQO/TsdF3cCwNp0mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 111/208] mtk-sd: Prevent memory corruption from DMA map failure
Date: Tue, 15 Jul 2025 15:13:40 +0200
Message-ID: <20250715130815.395291448@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
References: <20250715130810.830580412@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit f5de469990f19569627ea0dd56536ff5a13beaa3 ]

If msdc_prepare_data() fails to map the DMA region, the request is
not prepared for data receiving, but msdc_start_data() proceeds
the DMA with previous setting.
Since this will lead a memory corruption, we have to stop the
request operation soon after the msdc_prepare_data() fails to
prepare it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index f6bb3b45b37ff..2c998683e3e33 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -718,6 +718,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
 	}
 }
 
+static bool msdc_data_prepared(struct mmc_data *data)
+{
+	return data->host_cookie & MSDC_PREPARE_FLAG;
+}
+
 static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
 {
 	if (data->host_cookie & MSDC_ASYNC_FLAG)
@@ -1282,8 +1287,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	WARN_ON(host->mrq);
 	host->mrq = mrq;
 
-	if (mrq->data)
+	if (mrq->data) {
 		msdc_prepare_data(host, mrq->data);
+		if (!msdc_data_prepared(mrq->data)) {
+			/*
+			 * Failed to prepare DMA area, fail fast before
+			 * starting any commands.
+			 */
+			mrq->cmd->error = -ENOSPC;
+			mmc_request_done(mmc_from_priv(host), mrq);
+			return;
+		}
+	}
 
 	/* if SBC is required, we have HW option and SW option.
 	 * if HW option is enabled, and SBC does not have "special" flags,
-- 
2.39.5




