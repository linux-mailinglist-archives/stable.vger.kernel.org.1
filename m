Return-Path: <stable+bounces-196521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D1C7AD0F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A929C4E12E9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B5298991;
	Fri, 21 Nov 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koo/4pwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F53BB5A
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742129; cv=none; b=MTZ3Ef5lXCoCMLZq/4UGFEvjR+y8St02s80EhEY5V8OpkIZDo2bCmut9GMDUGVlUUErgaadR8tJKz/hOYsPPgNLqZQdru+fFpR4KOD/uMjW8nkOcRTJWnPcQdRst1951HT2RYeoTjTXhJcLOo2hZxnqnGWBUNvGy3XwbbhsIg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742129; c=relaxed/simple;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m15CpT0TZj/EqT/pInCbRosjyaQdROaUZb3PTDaVhv3SU4v/3UpaITwo+7kP3ztNp4U0tHQDYJ5AtHB8wS2KjdL5mDTzOaXPcSOdoUk19k0AX+JEwGuKaVORNasWE+lq8ru5uIED+R1REh/Q6o/6nr4r5t4it2JdBUkC+tBS8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koo/4pwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3630EC4CEF1;
	Fri, 21 Nov 2025 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742128;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Koo/4pwzdmncqIWW3RLGVewlBlWJpawmexHe2uzrJuS2jAQvmL2WeZlRxuHwtAtZk
	 Wko1OTpANlQhasgGDewus4Cwt+IYSmpodOQoJCSu2hIi/iqdq1nu8VcJW1V0AEp59r
	 23igPvutLM9FFCMmooDdGUXY5F17XlTGA/S4YfSn7Uku+cLygzq6u/Cr+KpWVEVFP5
	 fvr8cPah1bUsV0gJHSoWXSxxe4ep3Dsd7OrRzf9gti54Ts3yPbDZyU/SuWxQPLjiiW
	 OQv186rQk/jhVpwuWw6aXhoBtrl1Q6SPSzaSv3IN7OD9TgUqGJ0SkwCANbJCvA2IWs
	 +o9v2Fi21XdBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: imx: Fix reference count leak in imx_gpc_remove
Date: Fri, 21 Nov 2025 11:22:06 -0500
Message-ID: <20251121162206.2595501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112010-chop-refurbish-3f6e@gregkh>
References: <2025112010-chop-refurbish-3f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit bbde14682eba21d86f5f3d6fe2d371b1f97f1e61 ]

of_get_child_by_name() returns a node pointer with refcount incremented, we
should use of_node_put() on it when not needed anymore. Add the missing
of_node_put() to avoid refcount leak.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ drivers/pmdomain/imx/gpc.c -> drivers/soc/imx/gpc.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 90a8b2c0676ff..8d0d05041be3f 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -540,6 +540,8 @@ static int imx_gpc_remove(struct platform_device *pdev)
 			return ret;
 	}
 
+	of_node_put(pgc_node);
+
 	return 0;
 }
 
-- 
2.51.0


