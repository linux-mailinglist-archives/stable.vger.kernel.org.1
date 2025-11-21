Return-Path: <stable+bounces-196541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8739DC7B09B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C8358373
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB934573C;
	Fri, 21 Nov 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Wbfu2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2B343D9E
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745356; cv=none; b=m/E72Ivw4nL0WlFRmyEs0UfHnBC5PhNAAnPXx3VMVyBa83hZuF2BkIGsBzJY+ugSuWZioqp/LDJ/m6036BajHlDZfcCkSad1F7x1xmxRq+RTfN7H7pfrBoY04LdXsWSuBh5Mfp38eri5W6QnWylEUqOha6kpIaoxcuQMdTmXdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745356; c=relaxed/simple;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1r5+6IanntUASd3fV1bz24cmVZ1jyRHxG8NiX5kpqOczDLyns7P2hTakaZ9R/57N2I4vU3FuSLz1sHiMWsQnkPIiGcp7Yd8fN3yHuctzi44ENcEB0+HuHPqfwaBAdnCP/7SwBPIf8rfiyLRW0mhv1VZ8cb/4BruujH3AXinaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Wbfu2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C5DC4CEF1;
	Fri, 21 Nov 2025 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745355;
	bh=jyCkngZT+TGN1Jbx7ybbLOzCLQJDqPgM/XFPmKi1hBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5Wbfu2oVPd4qEMS1VEA+s0zVuUHnpN7bzdQTPQRvww93kTLDkk3SM1P3tlTYv1M7
	 174oRTwu+UasQxvhAzyHd4DgdUVsQ6TX0W9TrVAWur8a6eiXVs1z3f0KCa51liQh8r
	 JUeqInG5OPDzd7kn4nPL23B5fkZ94YZxTaFGq142snqekY+W5xPdIT9my8RLREJcvq
	 QtDKbXxCf7Ft/levDVWt1Q76WpezMo43lPXhO53QZxwkeYqBTYtjQ8gOesJWC/QH0e
	 Q2z4MtLHmadtJypMepPfPku6LaH1jUTpkYbcxvLqf+4MHWHN+ZmJMtXp8rBRsDQtW9
	 CqFZ6UeoCODgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] pmdomain: imx: Fix reference count leak in imx_gpc_remove
Date: Fri, 21 Nov 2025 12:15:53 -0500
Message-ID: <20251121171553.2611263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112011-seltzer-flock-722f@gregkh>
References: <2025112011-seltzer-flock-722f@gregkh>
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


