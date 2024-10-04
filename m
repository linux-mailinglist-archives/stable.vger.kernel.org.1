Return-Path: <stable+bounces-80953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE8990D2B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC10A283343
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C5204F7F;
	Fri,  4 Oct 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLynnvVI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984020565B;
	Fri,  4 Oct 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066352; cv=none; b=ezpWE8pmMjHet+jdL1HStOo7USukttUXZJARko2w5wKy7tlJumDiMf6L4TLddfayBwvuQM033sLIM1fc78jCk15LCYUgUCaiCqy5qRVJltawrYP4wud3VLjDJJ8Wh+hetRZdMdt2j36IqHPKGeunW4ykFpZwAtWVpKOjWdLzaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066352; c=relaxed/simple;
	bh=Zj9rmh2rnOJxYJnL3zci9fXQ6CbXnNVzM2e17ws8fwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9KK75YIK5HKXPq33aeIpxKu3csGxyvCxvMTL2gp7rKGqJaFMWtuJs9yF/emwkwthf+A9LuPuS5ZCM8nNvYwqXyTRR2bplldu3yS7WHxYj+spCv8cTuS4YfFLekagUMx1VCxxl35c4zTXEZCjVPA5qC2VG/RlZRj/vX8xbr/Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLynnvVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F88C4CECE;
	Fri,  4 Oct 2024 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066351;
	bh=Zj9rmh2rnOJxYJnL3zci9fXQ6CbXnNVzM2e17ws8fwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLynnvVIl3ueKBRV/gTmD3f3xlNj7qP1G1/+SW4zcwpjIgbGcwC/CKgMcVs0Kbnip
	 IIQLQ9RfeA6sAM8cCkGb4fg7GlCS7uOkNFVvVQ0wlfYpAi8rjX5MKYX686X+O1rzvb
	 OMWP21WJVRYb2tgz5+rkQ3cRERUap+WdoRgfajr4h3u/tPHT4dmxoB5EJfN1h858GK
	 hryZvEk4Y8jFGwr7JMpe6+byI1lPhlWXlV0AqB0jNd3J+blAcy0WaLz7ma02W3XeK0
	 EpR2VjqPodSakgvO6zh/tTwSkOvEyDginUSTQHEoFHzqF4132la6r7uX2x/BFOYsFi
	 Sam2XdXGjQ05A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kaixin Wang <kxwang23@m.fudan.edu.cn>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>,
	pgaj@cadence.com,
	linux-i3c@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 27/58] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Fri,  4 Oct 2024 14:24:00 -0400
Message-ID: <20241004182503.3672477-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index fa5aaaf446181..d8426847c2837 100644
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


