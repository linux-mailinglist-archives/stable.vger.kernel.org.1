Return-Path: <stable+bounces-155978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C5AE4488
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032071BC0882
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922832550A3;
	Mon, 23 Jun 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xOL7pgxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51631347DD;
	Mon, 23 Jun 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685831; cv=none; b=ZUSkn23Nm5mEdCNVyUFp+VZ5Pkjkr/NZ0HF/a8LK6Ozf/2oouRD0P9v2rVNFhU/EbKU7/GPslpbiAb/SmXE92dE7fT7CLNLanSMc0B6aXQeHLDVtlHqsFTX0NZZuT4FrM6XWtte+xgMcNkILWmxrKzYkRt+9Qo7uinrBJ+TRNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685831; c=relaxed/simple;
	bh=KEOLCHl4dIJrEdmKZSmk1r0SBQHFm184WaTdjT5U7mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqVnk7QyBkSNa/BW0ZjX3bpmMt/GT8yWgWZx4DyK/mCj81zABy5N1siMM9riPwFBgBmwDMfec1x3iwckzRLsCcM9pdU9X8LijnsFK+t0F0zpgh9ys51L1lIvrSac3qHFzZB7mzNY7KgXvnSMcmc+e9DL15P44nd/vhneG8Xn5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xOL7pgxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A8C4CEEA;
	Mon, 23 Jun 2025 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685831;
	bh=KEOLCHl4dIJrEdmKZSmk1r0SBQHFm184WaTdjT5U7mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xOL7pgxUGRto4oSj97z0xdwqddipM3JS2eb7HWJPSW5cARR04y1PyiLnRuj61PbsO
	 x6ONdOYnza5CPiYUlQ2f0GcR5yqKBWgnCxfoSUDuxU1YB5TZwT11TVx9i5/4ugNUWe
	 Zsw31TJeRdeV+iSmaCdzdtufTNhSgrOoXO3n3/KE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/355] gve: Fix RX_BUFFERS_POSTED stat to report per-queue fill_cnt
Date: Mon, 23 Jun 2025 15:04:57 +0200
Message-ID: <20250623130629.676180837@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit f41a94aade120dc60322865f363cee7865f2df01 ]

Previously, the RX_BUFFERS_POSTED stat incorrectly reported the
fill_cnt from RX queue 0 for all queues, resulting in inaccurate
per-queue statistics.
Fix this by correctly indexing priv->rx[idx].fill_cnt for each RX queue.

Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://patch.msgid.link/20250527130830.1812903-1-alok.a.tiwari@oracle.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index b76d1d019a81d..f458a97dd7910 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1086,7 +1086,7 @@ void gve_handle_report_stats(struct gve_priv *priv)
 			};
 			stats[stats_idx++] = (struct stats) {
 				.stat_name = cpu_to_be32(RX_BUFFERS_POSTED),
-				.value = cpu_to_be64(priv->rx[0].fill_cnt),
+				.value = cpu_to_be64(priv->rx[idx].fill_cnt),
 				.queue_id = cpu_to_be32(idx),
 			};
 		}
-- 
2.39.5




