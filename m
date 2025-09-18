Return-Path: <stable+bounces-166168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70689B1981B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8BD7A4D35
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425721DE894;
	Mon,  4 Aug 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7qsViun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2A1DE4E5;
	Mon,  4 Aug 2025 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267558; cv=none; b=N4Fu0kaDKz3XMLqPGO28i6QjtI8ci5Q9uChQONoxZCOwD2PNGxIbjc0UwlZ8cXTy3oLxlMmN3h9jmhA24p9hvrSDpt5YwdANrQ0YzuH9Nf6s+2ckDEqpf3FwHMLkxiAO6wEh/HZPpkO/KSATqCh5LRT2+6N5ksNxRKg1Ac9qj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267558; c=relaxed/simple;
	bh=oYzjt0pBPUFIGVDHgd1Ww6Ch3t3p6kCVfPtoExsa0k0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oacDOjjCDb+WynFYjE94dU/GHuD3/W8HgT4iyirgQwNj6Q0f5R05XOOwXYjdPhc2h6Au5pV6WwJf7t8HfhtodpbbxucGCu13BFJStoze+cH9nM7cZ8YHJ5m6iX1WgUSjEo9oE+8b+oH65Tj1sKRfL9qymto58WmlAnqTrTE9JqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7qsViun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26FFC4CEEB;
	Mon,  4 Aug 2025 00:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267557;
	bh=oYzjt0pBPUFIGVDHgd1Ww6Ch3t3p6kCVfPtoExsa0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7qsViunp9RYD0YmCwq0o69pEQS0r76MSD9AbE241mUku9/q7Qy+6yrlYlV1077gi
	 D6jDmtJsWCDyX4RL/6BALCmBLmDhEtC5eE1ke9C5o5FUsNbyjlS2GVI0rsrztW7VIT
	 MdZKXvNBp/HALlSKggKsQ3KJDtExl69MEA0AxHG4WcWyn4YK963VXtfJNjIYv4iCGs
	 myOyYkE2WkSDQNrB2qy7em7oiG8nuapT8Sa0PWU6TFO1+OK/ETt5PhUwmkzhngILI2
	 5YUN30tRIOwPGJyonjv4XH5J91JIorMz+ZU1pRvgofSW8tOkYDRJ0RP3uzm4AcfR97
	 AHnP/jzadFkpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 32/69] firmware: arm_scmi: power_control: Ensure SCMI_SYSPOWER_IDLE is set early during resume
Date: Sun,  3 Aug 2025 20:30:42 -0400
Message-Id: <20250804003119.3620476-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003119.3620476-1-sashal@kernel.org>
References: <20250804003119.3620476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 9a0658d3991e6c82df87584b253454842f22f965 ]

Fix a race condition where a second suspend notification from another
SCMI agent wakes the system before SCMI_SYSPOWER_IDLE is set, leading
to ignored suspend requests. This is due to interrupts triggering early
execution of `scmi_userspace_notifier()` before the SCMI state is updated.

To resolve this, set SCMI_SYSPOWER_IDLE earlier in the device resume
path, prior to `thaw_processes()`. This ensures the SCMI state is
correct when the notifier runs, allowing the system to suspend again
as expected.

On some platforms using SCMI, SCP cannot distinguish between CPU idle
and suspend since both result in cluster power-off. By explicitly setting
the idle state early, the Linux SCMI agent can correctly re-suspend in
response to external notifications.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Message-Id: <20250704-scmi-pm-v2-2-9316cec2f9cc@nxp.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## 1. Bug Fix Nature

The commit fixes a clear race condition bug that affects system
suspend/resume functionality on SCMI-based platforms. Looking at the
code changes:

- **Original bug** (lines 325-333 in original code): The
  `scmi_suspend_work_func` sets `sc->state = SCMI_SYSPOWER_IDLE` AFTER
  `pm_suspend()` returns
- **Race condition**: If another SCMI agent sends a suspend notification
  while the system is resuming (after `pm_suspend()` returns but before
  `SCMI_SYSPOWER_IDLE` is set), the `scmi_userspace_notifier` (line 305)
  will see the state is still `SCMI_SYSPOWER_IN_PROGRESS` and ignore the
  new suspend request
- **Impact**: The system fails to re-suspend when it should, breaking
  power management functionality

## 2. Fix is Small and Contained

The fix is minimal and well-contained:
- Adds PM ops structure with only a resume callback
- Moves the state reset from work function to PM resume callback
- Total change is about 20 lines of code
- No API changes or architectural modifications

## 3. Clear User Impact

The commit message explicitly states this affects real platforms: "On
some platforms using SCMI, SCP cannot distinguish between CPU idle and
suspend since both result in cluster power-off." This indicates actual
hardware is affected by this bug.

## 4. Low Risk of Regression

The changes are:
- Limited to the SCMI power control driver
- Only modifies the timing of when `SCMI_SYSPOWER_IDLE` is set
- Uses standard PM callbacks (`dev_pm_ops`)
- No changes to core logic or protocol handling

## 5. Follows Stable Criteria

The fix meets stable kernel criteria:
- Fixes a real bug (race condition in suspend/resume)
- Small, focused change (~20 lines)
- Already tested and merged upstream
- Clear explanation of the problem and solution
- No new features added

## 6. Technical Correctness

The fix is technically sound:
- Setting `SCMI_SYSPOWER_IDLE` in the PM resume callback ensures it
  happens before `thaw_processes()` completes
- This guarantees the state is correct when interrupts are re-enabled
  and the notifier can run
- The use of `dev_set_drvdata()` and `dev_get_drvdata()` properly passes
  the context to the PM callback

This is a textbook example of a stable-worthy commit: it fixes a
specific race condition bug with minimal code changes and clear impact
on affected systems.

 .../firmware/arm_scmi/scmi_power_control.c    | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/scmi_power_control.c b/drivers/firmware/arm_scmi/scmi_power_control.c
index 21f467a92942..ab0cee0d4bec 100644
--- a/drivers/firmware/arm_scmi/scmi_power_control.c
+++ b/drivers/firmware/arm_scmi/scmi_power_control.c
@@ -46,6 +46,7 @@
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/printk.h>
 #include <linux/reboot.h>
 #include <linux/scmi_protocol.h>
@@ -324,12 +325,7 @@ static int scmi_userspace_notifier(struct notifier_block *nb,
 
 static void scmi_suspend_work_func(struct work_struct *work)
 {
-	struct scmi_syspower_conf *sc =
-		container_of(work, struct scmi_syspower_conf, suspend_work);
-
 	pm_suspend(PM_SUSPEND_MEM);
-
-	sc->state = SCMI_SYSPOWER_IDLE;
 }
 
 static int scmi_syspower_probe(struct scmi_device *sdev)
@@ -354,6 +350,7 @@ static int scmi_syspower_probe(struct scmi_device *sdev)
 	sc->required_transition = SCMI_SYSTEM_MAX;
 	sc->userspace_nb.notifier_call = &scmi_userspace_notifier;
 	sc->dev = &sdev->dev;
+	dev_set_drvdata(&sdev->dev, sc);
 
 	INIT_WORK(&sc->suspend_work, scmi_suspend_work_func);
 
@@ -363,6 +360,18 @@ static int scmi_syspower_probe(struct scmi_device *sdev)
 						       NULL, &sc->userspace_nb);
 }
 
+static int scmi_system_power_resume(struct device *dev)
+{
+	struct scmi_syspower_conf *sc = dev_get_drvdata(dev);
+
+	sc->state = SCMI_SYSPOWER_IDLE;
+	return 0;
+}
+
+static const struct dev_pm_ops scmi_system_power_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, scmi_system_power_resume)
+};
+
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_SYSTEM, "syspower" },
 	{ },
@@ -370,6 +379,9 @@ static const struct scmi_device_id scmi_id_table[] = {
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
 
 static struct scmi_driver scmi_system_power_driver = {
+	.driver	= {
+		.pm = &scmi_system_power_pmops,
+	},
 	.name = "scmi-system-power",
 	.probe = scmi_syspower_probe,
 	.id_table = scmi_id_table,
-- 
2.39.5


