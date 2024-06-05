Return-Path: <stable+bounces-48149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A848FCCFB
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E51F237B7
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD561A1863;
	Wed,  5 Jun 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua+EkKi8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFDB199397;
	Wed,  5 Jun 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588984; cv=none; b=GjA00wjM9353QaCBgA4mzAU4Sdy7RorAW9zIWKT7DQ9iUYoZpl0Kr1BahITI5FmPjlYpGY9qnKmAe+TXsfHFvTS3J6cllBzCunqL0gFOOg61wP501D+YbScVPMWAiVgdE/YczZfZ6OGXzNt1B43TQTJpLJhyeyDmK9IEfIg6iNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588984; c=relaxed/simple;
	bh=Hws0J5mHqGJewzd/hkx+aFlBWndwx/W+Wq0F05xqxQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOWH8DTyK9LhqnMpAh2saY95j+2gbjubAar9w6YTvHMfop/ea4z760CPGvDJlD6LoQJnTi0CDjotF8CXgyJER4dM9jJjkI8+qCZBiTx31by36F/IUJIB7grXW70ggylpSi75Il3XlZDAGJhUfyJ4iXKgjn0EExkoIUk4iVFcwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua+EkKi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD75C3277B;
	Wed,  5 Jun 2024 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588984;
	bh=Hws0J5mHqGJewzd/hkx+aFlBWndwx/W+Wq0F05xqxQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ua+EkKi8nTxmGXZkJNrIORN0Wij3aEZCw8uJ5yjkTrfkM1up7sdqU7wixzrBuvfTG
	 ngyLUMP7x4UMMVtmb0razepeC/NYrr8mmsYZxj88UwiUgx6GngDfAMwuQ8tZbfQETr
	 lkziisJ1/8IPIWr+9UBeHSQK/w6a4BF9MNmQz4CKFsTEzsB6lp1v+BHL9hRX6hF6ci
	 Bk30jsk5w4OKUFgufqinYO1vT+End7fhj/xQyP4JUbt1OwCwYEZ3wHK41LV9XMI2ZM
	 /wfucOCqMUjNRSWyJ/L9CWiNiEYSwLxzKu4q9ouSIXgsnczS8lq0AxqSGs1yBa1+H2
	 iYwK1O2lI84QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 22/23] hwmon: (dell-smm) Add Dell G15 5511 to fan control whitelist
Date: Wed,  5 Jun 2024 08:02:05 -0400
Message-ID: <20240605120220.2966127-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit fa0bc8f297b29126b5ae983406e9bc76d48a9a8e ]

A user reported that he needs to disable BIOS fan control on his
Dell G15 5511 in order to be able to control the fans.

Closes: https://github.com/Wer-Wolf/i8kutils/issues/5
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20240522210809.294488-1-W_Armin@gmx.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index efcf78673e747..b6a995c852ab4 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1530,6 +1530,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
 		},
 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
 	},
+	{
+		.ident = "Dell G15 5511",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
+	},
 	{ }
 };
 
-- 
2.43.0


