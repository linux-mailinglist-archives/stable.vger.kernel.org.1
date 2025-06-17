Return-Path: <stable+bounces-153533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A21ADD593
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B2E19E0B46
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454342F2364;
	Tue, 17 Jun 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DOIrsSrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231A2F2371;
	Tue, 17 Jun 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176272; cv=none; b=Nle+R3CW5Ph0FlL82EsFTxYCOc+fh/Q7epy1/f2IuFl/sBC9FRyuvLTWrgDyKm3ucTVhQ6d22qutxN8obr37DymT9TYXQ9yxA5INjXv4hj+itz4AStbDV/0je3I7NdceVM9zNetPBOKzQNif6MWP6qWH16sWS6+dyJfv24IMbUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176272; c=relaxed/simple;
	bh=zuAMXT/BRTEo6xmdT/CG/UXBzuPM9PJKotS0EWJRl0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TToinHrMa6L+4oRag1cCfFxyP+J6OAHy+Cuvl8Soh01F0iqiCF9byWdMKS4pX4mJ3JsJK1d7tkp6qxUIrhCyy5ha+7m3YAQAAZK+WW0GPtvWf04LVrmS/FYZMkCJDVOxXSkdkeaoIkVQOdPbRwsk1M5XEDp5s1cE+n9bPEUeYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DOIrsSrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6532FC4CEE3;
	Tue, 17 Jun 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176271;
	bh=zuAMXT/BRTEo6xmdT/CG/UXBzuPM9PJKotS0EWJRl0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOIrsSrdq6/fpohxaP4s/sR5JnoWCo0rYm4RuuKqidiIJNiE44wBL1pR5jG8DqPBb
	 WPECSFnCsCLHX+aklWZcTr5qa3H6SM417bbKDCKSjSve/CyGjxeQHKN42IeAWCkEC9
	 2XvmdVyY+ybfH52suEUOn87eHjxzfjXsPs/pPFYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH 6.6 261/356] PM: sleep: Fix power.is_suspended cleanup for direct-complete devices
Date: Tue, 17 Jun 2025 17:26:16 +0200
Message-ID: <20250617152348.713019473@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit d46c4c839c20a599a0eb8d73708ce401f9c7d06d ]

Commit 03f1444016b7 ("PM: sleep: Fix handling devices with direct_complete
set on errors") caused power.is_suspended to be set for devices with
power.direct_complete set, but it forgot to ensure the clearing of that
flag for them in device_resume(), so power.is_suspended is still set for
them during the next system suspend-resume cycle.

If that cycle is aborted in dpm_suspend(), the subsequent invocation of
dpm_resume() will trigger a device_resume() call for every device and
because power.is_suspended is set for the devices in question, they will
not be skipped by device_resume() as expected which causes scary error
messages to be logged (as appropriate).

To address this issue, move the clearing of power.is_suspended in
device_resume() immediately after the power.is_suspended check so it
will be always cleared for all devices processed by that function.

Fixes: 03f1444016b7 ("PM: sleep: Fix handling devices with direct_complete set on errors")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4280
Reported-and-tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/4990586.GXAFRqVoOG@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 343d3c966e7a7..baa31194cf20d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -897,6 +897,8 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 	if (!dev->power.is_suspended)
 		goto Complete;
 
+	dev->power.is_suspended = false;
+
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
 		pm_runtime_enable(dev);
@@ -952,7 +954,6 @@ static void __device_resume(struct device *dev, pm_message_t state, bool async)
 
  End:
 	error = dpm_run_callback(callback, dev, state, info);
-	dev->power.is_suspended = false;
 
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
-- 
2.39.5




