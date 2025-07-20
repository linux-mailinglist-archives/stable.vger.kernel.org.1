Return-Path: <stable+bounces-163485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8EB0B967
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74ADF3AC90A
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CB1F4289;
	Sun, 20 Jul 2025 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPoia08Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E78BEE
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055246; cv=none; b=tr/Dfz2Y6RepQk+7S8C4EliFQ5OWOJellAqNu/4+dgvYv5uOq/ys0rOEjcgVbRqYeuwv/OYt9pytlTxEeiTxVEA6uCtL6PbBJgY2qJ9MlmuLrhRHBwQebnjuTaUupa/BOXUuPXNBffQ4vxXbyGv82UNYhY5MJvTtiIjOCB0xym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055246; c=relaxed/simple;
	bh=Zbrrzvq3FNlZXbFF25qg2w7xZi6cC8Jg7+Oz9Gybs4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wdf0++T5Xzem0VO8P+rjXy8lD6OVuUMLBm2yLIaRyQVCeRksrELOV2/QszfVqJB1x8MX0tIQkJaCwGwGbVfHc9SLyDQWIjO8urvWUdRhBqMtujs3YvFLbiAuzI3zYZE4TXX9//951Ya1kX0hroXau7Wqz7SJiHjXxbQ7B75ic38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPoia08Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B80C4CEFA;
	Sun, 20 Jul 2025 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055246;
	bh=Zbrrzvq3FNlZXbFF25qg2w7xZi6cC8Jg7+Oz9Gybs4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPoia08Z1FHlLU6mgPwlMXPTwnUdVa8IJrLSvYeNaXoA4+MnDmljBx/m+oBUN5pdo
	 qbv472JZ0v5KioZT6vjoY9uTBtnOWnylqwojjKgWDQXTeEUV4sAaIFAVeGHgwoEzbw
	 hhpTVFmNO+uEiK2Okzc5iv26U2GquD0twKu7r71o4TfmTLmWy6GDkzownm1D/hWCEB
	 8sniA8jTjtV2Cd5HxrY/IdnHzrL4s5jtnm4fDKEPzxzsOiGaimZSuGS8PyzjmEFwEx
	 wEwnIed5XBt0BvLYMugoMpBiPnEuAKyAz6esJ+PGMZzmOp6ncQ8TsMaUcJ34rgMYcB
	 S6YmWFxDTE+lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed
Date: Sun, 20 Jul 2025 19:47:05 -0400
Message-Id: <20250720234705.764310-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720234705.764310-1-sashal@kernel.org>
References: <2025070817-quaintly-lend-80a3@gregkh>
 <20250720234705.764310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 964209202ebe1569c858337441e87ef0f9d71416 ]

PL1 cannot be disabled on some platforms. The ENABLE bit is still set
after software clears it. This behavior leads to a scenario where, upon
user request to disable the Power Limit through the powercap sysfs, the
ENABLE bit remains set while the CLAMPING bit is inadvertently cleared.

According to the Intel Software Developer's Manual, the CLAMPING bit,
"When set, allows the processor to go below the OS requested P states in
order to maintain the power below specified Platform Power Limit value."

Thus this means the system may operate at higher power levels than
intended on such platforms.

Enhance the code to check ENABLE bit after writing to it, and stop
further processing if ENABLE bit cannot be changed.

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping driver")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Link: https://patch.msgid.link/20250619071340.384782-1-rui.zhang@intel.com
[ rjw: Use str_enabled_disabled() instead of open-coded equivalent ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index cc51bd508ad15..7550e8be488d0 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -297,12 +297,28 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	u64 val;
 	int ret;
 
 	cpus_read_lock();
 	ret = rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
-	if (!ret && defaults->set_floor_freq)
+	if (ret)
+		goto end;
+
+	ret = rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, false, &val);
+	if (ret)
+		goto end;
+
+	if (mode != val) {
+		pr_debug("%s cannot be %s\n", power_zone->name,
+			 str_enabled_disabled(mode));
+		goto end;
+	}
+
+	if (defaults->set_floor_freq)
 		defaults->set_floor_freq(rd, mode);
+
+end:
 	cpus_read_unlock();
 
 	return ret;
-- 
2.39.5


