Return-Path: <stable+bounces-196517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD74C7AB43
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E663A061D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB72D1F64;
	Fri, 21 Nov 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyaQCKxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6772C11E4
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741092; cv=none; b=sEPlAM9VmDfamu+VLsTKOroAjaAixbdRecr6ZjXMZBOzk3mU03ut69ABS5AczVSR9BMWigwFC3GpQFmr/+O8IoYea5i1degL6gzb/dzC3C8JI7mUCI2jwB0ljmKC9G07kErZ1qh63tvPLutyzMDuROss4tiCL04sL8L4/+Dea5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741092; c=relaxed/simple;
	bh=jMerSflrG/IJiWXRBJlIUku1JRqikYD8vD1cdDKP96c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKee5XUe3bVVoL7luWhi8GBN8HmxwsbELKd9a7lY4PSCRD2ZuNIwg4cfXjUVlQFy8JXDpurb2TIqq3DL4ynWHyevMIGyc9ygUMqT3Y5ZbjyNAjNRnmwitK/yPbX0QQ781qPBQE7ZZGNXErtBpzduANfrRT6Uvc3Xa9FUBfF5TuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyaQCKxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8372CC16AAE;
	Fri, 21 Nov 2025 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763741091;
	bh=jMerSflrG/IJiWXRBJlIUku1JRqikYD8vD1cdDKP96c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyaQCKxeZgXdPhEqnS1SR7Ko/wb1nf3ga5BS7/ktE1Nn0H3spCVHCE8nVLhZ2ImQh
	 XbHBfuXOBavhKtGXwF/CtLsV1FItbVETsvzvv8UxGevihVdSNb3P4BlYFqhRTyD0+5
	 7KyAxcvhIBoDHm2t66Z1tFme4sCc9eeA7JOnWyiNhHRKkzky+UsTrxkFubGzW0mzHP
	 Oouqr2j9/86wlpnfN2+DqLzlwkMsoC5wVNocJHuOUQ7cCLuCQy6BmZq5VCNejsu1KG
	 rSp+mYk6q4xeb+aUG03dAb9kDf3/ntGYKMxn8VJ3gcFbHwwhHoBH2llsvs0lwSikwB
	 IDcLmCSHJ2Vyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx: Fix reference count leak in imx_gpc_remove
Date: Fri, 21 Nov 2025 11:04:48 -0500
Message-ID: <20251121160448.2588409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112009-revenge-lazily-2aa3@gregkh>
References: <2025112009-revenge-lazily-2aa3@gregkh>
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
index 419ed15cc10c4..0b63ec213f1e5 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -541,6 +541,8 @@ static int imx_gpc_remove(struct platform_device *pdev)
 			return ret;
 	}
 
+	of_node_put(pgc_node);
+
 	return 0;
 }
 
-- 
2.51.0


