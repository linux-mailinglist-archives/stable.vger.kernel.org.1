Return-Path: <stable+bounces-204910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD6CF57A4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFC43098DD3
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6963321B0;
	Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN94ThFs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FD329365
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644018; cv=none; b=bBRAiDuPHQ2Zal5GjY1JsFViUy5c6Ipz4AJfnCV+7pc4D2W3lzeQZoUxKOkEXk+cLmcNSqSF/hwMD6eXJ8W9Yq9FbcA812MItpofiWFhgJCMoEwZyQoIwA+D/5gH71MR+0iFVlHhZqT8P4vNOdoIhJTZuBUd1S3hqbb/jghuEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644018; c=relaxed/simple;
	bh=K8uQ5nRlDYeyFR/jWA7dEloWW4yKHyYlECh0HS1uHzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9g8sahTBcmRyADgPpy6dg8d7Q7kajsKuLkDRL5MCDuj89sOmxfpu1LyhYTl1MxXAA9eVURZXvdhKxxqDjtITM5gCmXnljpGOPCTTKsNzDrzigammFpt8Br8MXulEd4KbZLwkgDesTpvdCIsdgKACc4DBnWXqggUZ52JCQei7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN94ThFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB98AC116D0;
	Mon,  5 Jan 2026 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767644018;
	bh=K8uQ5nRlDYeyFR/jWA7dEloWW4yKHyYlECh0HS1uHzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aN94ThFsSZ/h4NhOG8/HQoxtu3Y2evxHD3CMGfh/3ps3VULyqhkHv2mUTwxy6lGsG
	 AjN9F54Ir2oyOfBHix8OPv4Of24n9/5Z7ZDbS9BjFD32yWQMy6aFdSLtnxJxP9JT20
	 uyRHOC5U7LQDoJcgMFOQTlxgzB3ZsRU9qao434nzdhMK33VrDIaz/4oGe+N0HuVYsP
	 iDOhgFEAsLEgvmOfbwny6AWpai5b/V1ApN5rJ81OcuQpTxuxKhB5SXYLHFl7Xr0Ovj
	 5eZp8Fbw+9e+7JCLiGR8KE5Nfzbj2x8apJbyZzMT4OdcCrSlpe7qbswkcT8tHQTp/F
	 5IpSvzE+OV2CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: renesas: rcar_drif: fix device node reference leak in rcar_drif_bond_enabled
Date: Mon,  5 Jan 2026 15:13:35 -0500
Message-ID: <20260105201335.2769246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010524-purr-canopener-358c@gregkh>
References: <2026010524-purr-canopener-358c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 445e1658894fd74eab7e53071fa16233887574ed ]

The function calls of_parse_phandle() which returns
a device node with an incremented reference count. When the bonded device
is not available, the function
returns NULL without releasing the reference, causing a reference leak.

Add of_node_put(np) to release the device node reference.
The of_node_put function handles NULL pointers.

Found through static analysis by reviewing the doc of of_parse_phandle()
and cross-checking its usage patterns across the codebase.

Fixes: 7625ee981af1 ("[media] media: platform: rcar_drif: Add DRIF support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_drif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/rcar_drif.c
index 1e3b68a8743a..c3e2e4b1b76c 100644
--- a/drivers/media/platform/rcar_drif.c
+++ b/drivers/media/platform/rcar_drif.c
@@ -1253,6 +1253,7 @@ static struct device_node *rcar_drif_bond_enabled(struct platform_device *p)
 	if (np && of_device_is_available(np))
 		return np;
 
+	of_node_put(np);
 	return NULL;
 }
 
-- 
2.51.0


