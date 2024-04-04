Return-Path: <stable+bounces-35916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B58984DB
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E228204E
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF107581F;
	Thu,  4 Apr 2024 10:13:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D783D96B;
	Thu,  4 Apr 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225631; cv=none; b=RbaljSFUI1ExRKX3Y1sPsdnJLFVEJi4is/xCA5w7fkxNjzc6loGYy1l3OwQiVV+pPbQeAbuB1ewMI3Ev/woLVszalYk0eZ8Us/8fWQ7/usLlyrgIM3TJelM3xEh1JXRKQialRJJWRAUYqhDANeHH2Lws/HvPRBf9pYNI7XNmzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225631; c=relaxed/simple;
	bh=1g2lgazccbIgiKqk/5FBTyjfoksupEjMYOaoWUKxbCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jd+3Exg2uOERi7+CJJCv6gC6EqxhXY718Ub0FhjvWbvgE6O0qFiuMAHK7MrsqB8BU++3A6UJtg9ARY7rxQeYogebnFoPDmc+yE6y/Q8St5dfgA+FZp06Vs67ZPa8C/M0tNZDSqSPz4jEdqz0MdZ6M6OMHNd/4LVlId5EVP1HkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 110B8FEC;
	Thu,  4 Apr 2024 03:14:18 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.73.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3D693F7B4;
	Thu,  4 Apr 2024 03:13:45 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: lukasz.luba@arm.com,
	stable@vger.kernel.org,
	ye.zhang@rock-chips.com,
	d-gole@ti.com,
	rafael@kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [STABLE 5.15][PATCH] thermal: devfreq_cooling: Fix perf state when calculate dfc res_util
Date: Thu,  4 Apr 2024 11:13:29 +0100
Message-Id: <20240404101329.1956664-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ye Zhang <ye.zhang@rock-chips.com>

The issue occurs when the devfreq cooling device uses the EM power model
and the get_real_power() callback is provided by the driver.

The EM power table is sorted ascending，can't index the table by cooling
device state，so convert cooling state to performance state by
dfc->max_state - dfc->capped_state.

Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi Greg,

I have solved small backporting conflict to that v5.15.
The patch is based on tag v5.15.99 and it's for this
failing backport:
https://lore.kernel.org/stable/2024033050-imitation-unmixed-ef53@gregkh/

Regards,
Lukasz Luba



 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index d38a80adec733..5be79b5d788e5 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -199,7 +199,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
-			state = dfc->capped_state;
+			state = dfc->max_state - dfc->capped_state;
 			dfc->res_util = dfc->em_pd->table[state].power;
 			dfc->res_util *= SCALE_ERROR_MITIGATION;
 
-- 
2.25.1


