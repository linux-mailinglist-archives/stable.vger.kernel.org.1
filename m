Return-Path: <stable+bounces-139895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5EAAAA1C8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9E11887324
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F3C2D191F;
	Mon,  5 May 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DErtmb5V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AC2D1911;
	Mon,  5 May 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483623; cv=none; b=Fv5N9Dlbdwwt7CQlXhYEFGpZdwmtUz+wiGgdgzvpsGGnPr1CFc8jTfFGEBNtZVGs2xW6V57uNIu7a5gsYEGDBgNsJTF1TKzcjVyGxtGazJL1oL9fSiK2DEgPn14hzhXnck7yXSobK0Dsjs7GvcXpHhksZWhEWNgabXy+YgeHZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483623; c=relaxed/simple;
	bh=WG3l2i6vZdEQKpt0VEXG+sUwnUUt48aVnOtLffB5Qcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxFJ8/zzxr+aSA7GvFKGvGLGkXCPvNbZ/33EuzNrNxW77N3WcQ4iKLcgvO5LRlLQh7uAFKCJXQ1893iRIdmAl11VR0fhqmQGhasGIkz7IQMlJxt9zq9HOqJCKuKmfasjogwvJ3nA0D6ZyPe558dnijpFGkzL2O/EFNgm+L/eoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DErtmb5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EBCC4CEEF;
	Mon,  5 May 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483622;
	bh=WG3l2i6vZdEQKpt0VEXG+sUwnUUt48aVnOtLffB5Qcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DErtmb5VJiOIqRSJLOfjwgrxF3Cpmui64KCJyWk9rSN5gU5+Q6qChhzXVAzZdrK8y
	 nwY0/0dlucFgkWqNErGpoGcf1P8jhczczMiuyRuefIiC3oNc3eAMsv5AruLDU0QEUk
	 y32JlTJ6jUKwUAHta+c1UqIqmSrckYwOqhvhugfSeD38w6U8uZXBVmTAk8bP6sFie4
	 sVkqCD3RWLDqM0wlZ5zVJeA5AQjBTKohagPSMWN0ZW8dmu5tLu5NXTtnSHFdx5/yEI
	 LTwAaFuKsJaqjN83ZAatID80hjx/c/VRwP4p+AuFmumViNzYHe2b54f9LAfoVqMdX9
	 ptelpWxeNS9Ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>,
	Mark Langsdorf <mlangsdo@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 148/642] mfd: syscon: Add check for invalid resource size
Date: Mon,  5 May 2025 18:06:04 -0400
Message-Id: <20250505221419.2672473-148-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eder Zulian <ezulian@redhat.com>

[ Upstream commit ba09916efb29f80e438a54e634970209ce12750f ]

Add a consistency check to avoid assigning an invalid value to
max_register due to a possible DT misconfiguration.

Suggested-by: Mark Langsdorf <mlangsdo@redhat.com>
Signed-off-by: Eder Zulian <ezulian@redhat.com>
Link: https://lore.kernel.org/r/20250212184524.585882-1-ezulian@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/syscon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index aa4a9940b569a..ae71a2710bed8 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -47,6 +47,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct regmap_config syscon_config = syscon_regmap_config;
 	struct resource res;
 	struct reset_control *reset;
+	resource_size_t res_size;
 
 	WARN_ON(!mutex_is_locked(&syscon_list_lock));
 
@@ -96,6 +97,12 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 		}
 	}
 
+	res_size = resource_size(&res);
+	if (res_size < reg_io_width) {
+		ret = -EFAULT;
+		goto err_regmap;
+	}
+
 	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
 	if (!syscon_config.name) {
 		ret = -ENOMEM;
@@ -103,7 +110,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	}
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
-	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	syscon_config.max_register = res_size - reg_io_width;
 	if (!syscon_config.max_register)
 		syscon_config.max_register_is_0 = true;
 
-- 
2.39.5


