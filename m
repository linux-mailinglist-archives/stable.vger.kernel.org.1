Return-Path: <stable+bounces-80810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C511990B4F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281851F22480
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076593DABE0;
	Fri,  4 Oct 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atZlRSE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF12225D6;
	Fri,  4 Oct 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065961; cv=none; b=mnizz6M+r2ry2f3oSkk0by29/6Gq8CtIglIcNNKt+YJbQkH5+ZHCcXPJffvgZpcgKzk0VEVF7vxD4YLkssoD7B7phHxfeWfgtSybw8xVRdvVBUZfARa+p7otHRwtVOScvXC0GPyDY/4LzAmztmR6l6KxBgckPXwgnpEDXhSW+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065961; c=relaxed/simple;
	bh=NpFwHIc43h0KX6FekzSz+SQmAEBtDGBPknm+Mi89JxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VINFhtnqfLmcusK9U5Hyg9MQpbmb0wsQ45uNffPZzHgdR+d/JKcJm37kCVIKcnJxioNNjoO70MS2JE3qJeAg4cjof69SwUm98lu2FQ8XAQkhOviplhk+UhxWGHiRfi1VAgSMmbpxGqz+pV2BTS4mIOBVTAWKobuTRN/MIrLeFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atZlRSE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36ACC4CED1;
	Fri,  4 Oct 2024 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065961;
	bh=NpFwHIc43h0KX6FekzSz+SQmAEBtDGBPknm+Mi89JxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atZlRSE+feSWT/OnsAtmMaBbJfJwZh4GITdsvhiJnw0PtW3qCuODVZsnzsKKlpjY2
	 9SRZCPqnISmUFIoRRrDp/0k/XhelCSAMr2E6GelPGIAvBvBDG27hsbmiv7uM7R2bXZ
	 PJf2PaMPHcxrCye9DgU6OMQLg8vK/2RzpyHu5tdhWd86N+psgd99Sq1EPzYHmSwsXh
	 3MdBcZsBgKzq5hqMOSm6Iyzr1M7Hn2dlUcEztrYny25g1WBIScHeIk9ig58DL3uhfs
	 lfOWWHRWuwGzpsmGdINkVq5uvnQkTKV2YJBvcGhwshTPt977OW3SB8qQAjJzNTG621
	 uHh4F6W1CQf5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 30/76] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Fri,  4 Oct 2024 14:16:47 -0400
Message-ID: <20241004181828.3669209-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Kaixin Wang <kxwang23@m.fudan.edu.cn>

[ Upstream commit 609366e7a06d035990df78f1562291c3bf0d4a12 ]

In the cdns_i3c_master_probe function, &master->hj_work is bound with
cdns_i3c_master_hj. And cdns_i3c_master_interrupt can call
cnds_i3c_master_demux_ibis function to start the work.

If we remove the module which will call cdns_i3c_master_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                     | cdns_i3c_master_hj
cdns_i3c_master_remove               |
i3c_master_unregister(&master->base) |
device_unregister(&master->dev)      |
device_release                       |
//free master->base                  |
                                     | i3c_master_do_daa(&master->base)
                                     | //use master->base

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in cdns_i3c_master_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Link: https://lore.kernel.org/r/20240911153544.848398-1-kxwang23@m.fudan.edu.cn
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/i3c-master-cdns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index c1627f3552ce3..c2d26beb3da2b 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1666,6 +1666,7 @@ static void cdns_i3c_master_remove(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	clk_disable_unprepare(master->sysclk);
-- 
2.43.0


