Return-Path: <stable+bounces-196757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05610C8146D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6113A6A9F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93830AAC1;
	Mon, 24 Nov 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqTN4nS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28A27FB1E
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763997438; cv=none; b=VD61yFb6hACGPvmILNjJCW3AY+jIHnHDpJ1wvv3B1aJFfQ1Q3VaHsJhk5fqFloi0G6I4gXFaUC93hA2M5WidP9cZlV2T6Yu0gpK4/eo+gxlqldOIvpuode2/JeUIOUiWzn9sMlI15UAMX1+zAh7I2uFGWyZMT7Ug0DFbG5ASigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763997438; c=relaxed/simple;
	bh=Nk0YN+p8v8KJrzkDJDh6E3VhHTzIkwwtIdtQIr/ka44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUP9gNY0Sl7Cp8GRe/l8VxHoJcGCD8ouDrqljeGeoH/H+Fo4JdC2NyGyFVZkgyh8C7Y7XyJerZHUWfSrGeOu3FH6jQw9/3V/2oV185S7YDTQKtzNvlsTJ6nBZKSTgPlkKrkXKl7zKH6wVK1rzriYp6Q4L+N531Lq1YFuCNyjUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqTN4nS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBA4C4CEF1;
	Mon, 24 Nov 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763997438;
	bh=Nk0YN+p8v8KJrzkDJDh6E3VhHTzIkwwtIdtQIr/ka44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KqTN4nS1UEJxNHxJGDZR08YFpc+ZjSdQbpnVWPwYAyrZ12C1ZH76I9taxWsv4SiIy
	 4S7J+OGHkgtJL3AVoGE8OibZRe+Av6aMA5qlGY8ygA6rwU4mr2FL2QBkER9jiMKqM1
	 WNQfuw8ixk8HqtENs92kmbXZeC4Plg0y47W4oiUzqTv4H7KjkC9dSHJtrUA/do4vkz
	 9+uPr7E1iBaGQKynuKpaoxN0dgmAr/t3fKjwdP582/mVjOHb11Z2FmpB0FPdW/4r1C
	 Dx6guGdBpPJ2Ri2rKiAJC+eACIzdy2cGjZwlO+hs9UTXLpKJlFHaW9iW+hWLr+MOQb
	 2gMcbhlOnaNXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Titas <novatitas366@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] HID: amd_sfh: Stop sensor before starting
Date: Mon, 24 Nov 2025 10:17:15 -0500
Message-ID: <20251124151715.4125733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112405-dispense-dealing-3eec@gregkh>
References: <2025112405-dispense-dealing-3eec@gregkh>
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
index eda888f75f165..4a62edd430f29 100644
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


