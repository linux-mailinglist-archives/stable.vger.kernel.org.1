Return-Path: <stable+bounces-196535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBA9C7AF83
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 727A035150E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6162F12A8;
	Fri, 21 Nov 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNVv0XEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067B2EAB83
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744270; cv=none; b=DjDPyOdM7rkldLTUdprzNqL17Xh+5gwzozkb0WpTpUzfREJra9+FVvonVGkXvFCjOuQr/zDtMzuuREtSII3ZR/pDKWhsjluR5sJ0jJ3bm12ZqQT4h4EGA9v0hIfim/EF76L1/ZzXNe6+VOI4AZJsU/cYwprk8FTnYK20fZNwMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744270; c=relaxed/simple;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJVz0/c3tdlPib9OvvEmr75YklWqdxtpHk0Jag64NJb5J6oafZDublJ3A8euxfcMTwP+yEo8uVUnu69J7u5pL2yPyrr/6KlNOIglZO8Nn7NY1VwsrxgxVE0GFNeecDRMxxdCBkA8+H9baFyC+RPUk6z8RpI2jagSLru+eqnd5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNVv0XEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5024C4CEF1;
	Fri, 21 Nov 2025 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744270;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNVv0XEpZ148vGobD1TSmJH2WGp1XU7nySXApg18LQ5N+bbN+pkMHzL+nvSW/LY68
	 OylS5/cwjACXuhJxuqgeYE4nebFTsi3PBVyffXqIauB0XT5vr5dyEvAVWQ94TqDuOE
	 waudJh2UG5k1dXWW9zw3Z20Iokt+X3HzD+oirC4ZfcBGePGtx1zWSpJIURDTNs7g79
	 7TRfP2O4VMEnwWaoqkMQAki7BnU3UfsFy6afP8mVZNXBF+AoikZznEMJ1yRgdjcesn
	 +BHP7r5eKCZvrZzybjbwVl5qW+fnPR1cQEyNtXDyvX2/pl5yKvWkml674g1Ze7SUsS
	 kQUAaPT0x6vyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: imx: Fix reference count leak in imx_gpc_remove
Date: Fri, 21 Nov 2025 11:57:48 -0500
Message-ID: <20251121165748.2605755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112010-prewashed-hatchback-7cb7@gregkh>
References: <2025112010-prewashed-hatchback-7cb7@gregkh>
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


