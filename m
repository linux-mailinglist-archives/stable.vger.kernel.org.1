Return-Path: <stable+bounces-80885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54D8990C53
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC9928224F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A41F5BF5;
	Fri,  4 Oct 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfB1OTB+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F01F5BEF;
	Fri,  4 Oct 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066173; cv=none; b=jwOKV7CGtPtgD/dfK2gdSIzjHlXBuFho0YhRExTkymbMmQRMm4DUIIJ6k70GiEEVuO2Bk7LodeUrUraYdw6cezlnhiWu4ZspqCB+v0z+BylWDMyBgtCT0soXufsH1g9Cs4qhUhW6BuNLCkWQPKjf2G+Rl+0z+XFzElceJcLa86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066173; c=relaxed/simple;
	bh=NpFwHIc43h0KX6FekzSz+SQmAEBtDGBPknm+Mi89JxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThTlyja5qqraLValcMctyQjnShi1AhsDhNIDBhpnWmztUAQDUS25wW3Hnjrh1ZWI3GTP9XqqMmZ/RVV3qh1QmRbO8sNunltzUDL0MWZRpbEVLziJnPyHsoatKCgDLUUhEjEkA22PKQnD6gEN8KLZ2sg+kGIqNl69r/zednCis4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfB1OTB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BFC4CEC6;
	Fri,  4 Oct 2024 18:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066172;
	bh=NpFwHIc43h0KX6FekzSz+SQmAEBtDGBPknm+Mi89JxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QfB1OTB+N44cT557qLQK4qIq77EhvjchVQXitKBC+8Wk8fPLeu2MMynwJcPHuua6n
	 Q3A1Ysu9ENjadUwTM4COxSUzlpv+8qaxlAJ1DBWZcfLqntvanjeFvTVcfE07tsPkrr
	 CFmxQljAvRETCeWfpw4ctyrKNdGJMrIxPQ0EpxBFD4iSfKADYWzvbUd3vubl+005AG
	 7Vp/83HTMBz1iFJ+Ndc0LkHWLbDunGxX7GLfm8TFt/NVcXe5CA4EbRigR/ZgynKsMK
	 Sg0plikMoqEiy2yBSFqjlOIXkML43gduLYUnYFW2C7KTfTo4w4F4i3sTeRc6prXlhB
	 zLMueP3HUxt2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 29/70] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Fri,  4 Oct 2024 14:20:27 -0400
Message-ID: <20241004182200.3670903-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


