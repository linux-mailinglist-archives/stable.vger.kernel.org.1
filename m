Return-Path: <stable+bounces-196509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832AC7A99C
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D0C6343364
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E92FD7D3;
	Fri, 21 Nov 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5rC1xE6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB62ECE8F
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739644; cv=none; b=D9E9UQZZ22e250xesHphA2SF97p7hzcV0/t1bw3yfshzcaeuhEGhGEnwhxyzIkTfBX7uBr8jV0b0x1wC1Dlj2y5EAwUI1iKq+pFvXVlh/DksWtUxLYnt6rZFhp80zz+wiG75XZ551kmJy8rYxhWrl2M6fEHNxoXMyt5lkFd9cNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739644; c=relaxed/simple;
	bh=ogVV9WPN6ucVAfsGqZXuLzP50TtlMVeGKbOmoNxyMA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzSKwgVW75j6nOMoqZE6PlQaAN+C1mrdniVy9i4Aq9CRdeJ27XI1DXgsJprJWxHAck0t1DQWSDrwgwvXuWzKoNAJS+z+7j0t6OxEky29C49IKf9XACTa02nETjB7D2B/0z+eUuOxuD4Net+OCiitZDrLIga26Ob2lFr8aOgy/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5rC1xE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EA7C116C6;
	Fri, 21 Nov 2025 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763739644;
	bh=ogVV9WPN6ucVAfsGqZXuLzP50TtlMVeGKbOmoNxyMA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5rC1xE6AiSnz50SizXRW9Qv8nGffT+T6a8KqI9t42ijtDVR1vDYFlXiVUgFUeMce
	 JMK35ApR4ZOZilPxuKsgqooDn10Z0qRBhsOBmcuETNBNHU++TBMiCyy6PD3b1PCrMd
	 bqIA1THM+JGIHwLD83Ko6AB4+oXcJdLGKrqY6QuaFcespVDjzWaGI/M5xTlsdeuy73
	 PI+Eh/dCkOoBKwagh5drZWAQ4Einn0kiPP5WUhevuScplBh/TtFtt44PtBtE5ZZq/q
	 nCmgWh3OrH9bZHPHb9FWrG6APiOLtwsIqJgO9JYKO8iJStis/wLy9DR4oixLFT1Ubk
	 KBfbOBsElTpgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] pmdomain: imx: Fix reference count leak in imx_gpc_remove
Date: Fri, 21 Nov 2025 10:40:41 -0500
Message-ID: <20251121154041.2577393-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121154041.2577393-1-sashal@kernel.org>
References: <2025112009-appliance-symptom-7a59@gregkh>
 <20251121154041.2577393-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/gpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 66703395b1795..d7c0301a7121b 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -546,6 +546,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
 			return;
 		}
 	}
+
+	of_node_put(pgc_node);
 }
 
 static struct platform_driver imx_gpc_driver = {
-- 
2.51.0


