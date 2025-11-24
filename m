Return-Path: <stable+bounces-196754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F523C812E8
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7B4E5CEC
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CC72FF179;
	Mon, 24 Nov 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeMEAM94"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC3288C39
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996074; cv=none; b=QFcqshL1zGnp98/lgPXz16duLzEapqIXlkyBuwU3FhIyrhoJmihDt1FcMmpbyy+HX4EizaCBlhgYbdA6LjNvld6kpyPy+HjOevsvBGe8KUHIpDmBHMVKlxXVuxeRYmroMeSJJyuLs0RYkyykHPjUk6wlk9gd5SLpTBHx31ZYeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996074; c=relaxed/simple;
	bh=85pDyg8zJKMZfQQYrEnC131UsGT2eN4hvb+99HhYWgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe1nsx1u9SWDuVz02tqqiBE4qHPQ7dkALkQilmXA/v4sCHvqwoLZdVWZVtWngeYeLn10eYxeAJH9Bqfd/5MbBxvmEgE8Bai5Hfa/UZL8J7Q1anTO9WRpCVhDy/IjEOnf+Uf2T6cJdWl/Tt+WoDBLHv0xTE5jICf5jncaz5rJ920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeMEAM94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03558C4CEF1;
	Mon, 24 Nov 2025 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763996074;
	bh=85pDyg8zJKMZfQQYrEnC131UsGT2eN4hvb+99HhYWgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeMEAM94gxjZO6i0nOsuq3tL+W+v1GmNMvHwblEJzp4vFixj238eTrsCcQo2Qxd5u
	 mJ3nALPTnpYR60xxkx1vxBUCb922FqXCKiIZIh8vKOJcYbAVA2jVDf4FpK46rPSaVD
	 qNozoifQ3yS+3qVhegNFljZKpqtefxUpDhzgYTZtV95B2+ZID+u8x9F1dVvy6C0O9I
	 uojMnUB1ssaIGaaZjnTPJGOiZBhnmIGsMjAgh61kYwfLgyMEISMPcjTh7hvfccKKqo
	 lnwbNLowJEJCRHqPPkpDvlM238kxSnWhRLNtWTENi1K+HuRpcU1qGtAAgUgZX5ypmM
	 v+GuHJ3prjzGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Titas <novatitas366@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] HID: amd_sfh: Stop sensor before starting
Date: Mon, 24 Nov 2025 09:54:31 -0500
Message-ID: <20251124145431.4116539-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112405-canine-herbal-25c6@gregkh>
References: <2025112405-canine-herbal-25c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 4d3a13afa8b64dc49293b3eab3e7beac11072c12 ]

Titas reports that the accelerometer sensor on their laptop only
works after a warm boot or unloading/reloading the amd-sfh kernel
module.

Presumably the sensor is in a bad state on cold boot and failing to
start, so explicitly stop it before starting.

Cc: stable@vger.kernel.org
Fixes: 93ce5e0231d79 ("HID: amd_sfh: Implement SFH1.1 functionality")
Reported-by: Titas <novatitas366@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220670
Tested-by: Titas <novatitas366@gmail.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index 862ca8d072326..e2047ef864ebf 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -163,6 +163,8 @@ static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
 		if (rc)
 			goto cleanup;
 
+		mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
+		amd_sfh_wait_for_response(privdata, cl_data->sensor_idx[i], DISABLE_SENSOR);
 		writel(0, privdata->mmio + AMD_P2C_MSG(0));
 		mp2_ops->start(privdata, info);
 		status = amd_sfh_wait_for_response
-- 
2.51.0


