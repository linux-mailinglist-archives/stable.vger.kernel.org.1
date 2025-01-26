Return-Path: <stable+bounces-110751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F70A1CC4F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D427F3A3266
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA43A231A42;
	Sun, 26 Jan 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCvfB9oK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5A231A38;
	Sun, 26 Jan 2025 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904081; cv=none; b=Ux/Vjlry8q49e9pp7gdZLrxTBF0mTRJUeHIPVzR0t36oTIDMGydPhfKrglI32atx0UKpd11EizCoDrthyo4Tft0nxStEuvND7pKo1hzK8SKdmoKtwYPd73Ym3MHjra0uplGJwxkib+Z9ZeRaMVgQmEDe04xhWLh0jqPit+9sZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904081; c=relaxed/simple;
	bh=ai6//92DJVJVQTxJRiBgC+6XeDepn/lhKFEPryjrBFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWFR22ZTABDUnAKmhzlKobiFtg0Byb7QCMjOzjjlP3jJDmTErFJ3gCqG7vCcLzBSD5gNJfu+YL+jfvSPCaJVTanUX7aLDsiD+5Xr7shjp2vgfI9PHY576icP/IrA8lNFRQsUaqAJQcCjJ4ihtoE1O34nLgttSQGzTRG0E73WoUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCvfB9oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3988EC4CEE2;
	Sun, 26 Jan 2025 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904081;
	bh=ai6//92DJVJVQTxJRiBgC+6XeDepn/lhKFEPryjrBFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCvfB9oKSZ6dOvOtmEp1B5kFkDXVxauj1MA4ANVW90nCE5Ha13MB3LwxTwEzYqL3l
	 hQZUdTMWu8LjjKqesXmdM4OyXxIBuxMoD3C4oE73Y7BbMiW8p0gRAQjBtiGemzpE4L
	 6dt2bTl0EQ7hDEBRhaqqHIRs951S4VgBP/htMaA3VJ/yqt6clWHyjsQar2yriQ75MP
	 2E6YmvjAtwvVQuZpIYiUg0h1gM6Rn8WPbhTPIuW4cS5mFhWWiJZEN88mWg5aBhDm4u
	 M2TTI0sWMdywgqpCFDoA0gGrAeHs8/cjSOrdgOafd/eOUV/2PxdDB9nnREuoctRQ1x
	 jcArWJhOEGkEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Farhan Anwar <farhan.anwar8@gmail.com>,
	Rayan Margham <rayanmargham4@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 16/16] platform/x86: acer-wmi: Ignore AC events
Date: Sun, 26 Jan 2025 10:07:18 -0500
Message-Id: <20250126150720.961959-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150720.961959-1-sashal@kernel.org>
References: <20250126150720.961959-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6bfa25c6665f8721421ea94fe506cc22f1d4b43 ]

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-120c8e7afec8@gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250119201723.11102-2-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 1b966b75cb979..ac4f8ab45bdc0 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -95,6 +95,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
+	WMID_AC_EVENT = 0x8,
 };
 
 enum acer_wmi_predator_v4_sys_info_command {
@@ -2321,6 +2322,9 @@ static void acer_wmi_notify(union acpi_object *obj, void *context)
 		if (return_value.key_num == 0x5 && has_cap(ACER_CAP_PLATFORM_PROFILE))
 			acer_thermal_profile_change();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
-- 
2.39.5


