Return-Path: <stable+bounces-148554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB03AACA443
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18A6B7A65B9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F76266B5D;
	Sun,  1 Jun 2025 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4eK3ky3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0684266B5E;
	Sun,  1 Jun 2025 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820792; cv=none; b=ah4Td+QHtVwAzylI2AjqpQqtZfS8YLPI5qJmN4OreIqlHlXn5iTehHxyjC+oY2uoiUQgVciSFDdzQTX9LZAt88Zzozq58LnKFCmAkVJabuZD57sf5B0BLEpj3/mxSu8cOVgwicguaCHlYk7SSBlAEmhbU3d/Koc/jZfHQDixiGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820792; c=relaxed/simple;
	bh=YPX6Slv9N2YVAS4WV/RS4fwpOikGHDThdyUX07TaSQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKcEAa9LGhO3qttCD279Pi4oSvhEjGHsEPPr7em8+juG3H0YFvYJ+ftZnibQxsW9UiO2JhE7kt5OWBrxxQ8PdMpXc2aFUtxV8TDtATRklM213VLI37CDrwRqRAiFgk1wqUGlMDoht0Byn3X7YV4lwKSYsYfmG0bxt6hgAN+HSwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4eK3ky3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D004FC4CEF1;
	Sun,  1 Jun 2025 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820792;
	bh=YPX6Slv9N2YVAS4WV/RS4fwpOikGHDThdyUX07TaSQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4eK3ky3GUjnJHh3qZGjkUN6/Umv5UbqqNHtf1yrVsGlEjU9rama0dCfhm3v2yruI
	 7NGMkFkwHVpteGrqDcclbjJdSbo6rP+2dGp0FqIIdWfLAwt3+SP3Iao1L5+K+hiZkx
	 LmVhPkn3Ey3L0m7SV/LMZwzSYSz/2Blmb3hjaKEYfg6KvmkHwdG24rRLgM7gENkolQ
	 cAej/Hy0fJOu9g1w+a3mA1MXaccFmOqnH8qiHKDzZHlV8oDFmNBDGOY/e1IdgT98IH
	 bifUYQu32MRsZWFB1gONK/mVkg0f477pX7+sMliCmPypL4EoBfiIOHraaLGWdhtkX2
	 HSKKbHRHEVt3g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Charan Teja Kalla <quic_charante@quicinc.com>,
	Patrick Daly <quic_pdaly@quicinc.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 078/102] PM: runtime: fix denying of auto suspend in pm_suspend_timer_fn()
Date: Sun,  1 Jun 2025 19:29:10 -0400
Message-Id: <20250601232937.3510379-78-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232937.3510379-1-sashal@kernel.org>
References: <20250601232937.3510379-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Charan Teja Kalla <quic_charante@quicinc.com>

[ Upstream commit 40d3b40dce375d6f1c1dbf08d79eed3aed6c691d ]

pm_runtime_put_autosuspend() schedules a hrtimer to expire
at "dev->power.timer_expires". If the hrtimer's callback,
pm_suspend_timer_fn(), observes that the current time equals
"dev->power.timer_expires", it unexpectedly bails out instead of
proceeding with runtime suspend.

pm_suspend_timer_fn():

 if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
 	dev->power.timer_expires = 0;
 	rpm_suspend(..)
 }

Additionally, as ->timer_expires is not cleared, all the future auto
suspend requests will not schedule hrtimer to perform auto suspend.

rpm_suspend():

 if ((rpmflags & RPM_AUTO) &&...) {
 	if (!(dev->power.timer_expires && ...) { <-- this will fail.
 		hrtimer_start_range_ns(&dev->power.suspend_timer,...);
 	}
 }

Fix this by as well checking if current time reaches the set expiration.

Co-developed-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Patrick Daly <quic_pdaly@quicinc.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
Link: https://patch.msgid.link/20250515064125.1211561-1-quic_charante@quicinc.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the code context, here is my
assessment: **YES** This commit should be backported to stable kernel
trees. Here's my extensive analysis: ## Code Analysis The commit fixes a
critical bug in the PM runtime autosuspend logic where
`pm_suspend_timer_fn()` uses a strict inequality (`<`) instead of less-
than-or-equal (`<=`) when comparing the timer expiration time with the
current time. **The Bug:** ```c // BEFORE (buggy): if (expires > 0 &&
expires < ktime_get_mono_fast_ns()) { dev->power.timer_expires = 0;
rpm_suspend(dev, dev->power.timer_autosuspends ? (RPM_ASYNC | RPM_AUTO)
: RPM_ASYNC); } // AFTER (fixed): if (expires > 0 && expires <=
ktime_get_mono_fast_ns()) { dev->power.timer_expires = 0;
rpm_suspend(dev, dev->power.timer_autosuspends ? (RPM_ASYNC | RPM_AUTO)
: RPM_ASYNC); } ``` ## Why This Bug is Critical 1. **Race Condition:**
When the timer fires exactly at the scheduled expiration time (`expires
== ktime_get_mono_fast_ns()`), the current logic bails out without
performing the suspend operation. 2. **Persistent State Corruption:**
The bug has a cascading effect - when `timer_expires` is not cleared,
future autosuspend requests fail. Looking at the `rpm_suspend()`
function at lines 596-597: ```c if (!(dev->power.timer_expires &&
dev->power.timer_expires <= expires)) { ``` If `timer_expires` remains
set from the failed timer callback, this condition will evaluate
incorrectly, preventing future hrtimer scheduling. 3. **System-wide
Impact:** This affects the PM runtime subsystem, which is fundamental to
power management across the entire kernel. Devices that rely on
autosuspend will get stuck in active state, leading to increased power
consumption. ## Backport Suitability Assessment **✅ Fixes Important
Bug:** This fixes a functional bug that can cause devices to not
autosuspend, leading to power regression. **✅ Small and Contained:** The
change is a single character modification (`<` to `<=`) - extremely
minimal risk. **✅ No Architectural Changes:** This doesn't change any
interfaces or architecture, just fixes the logic. **✅ Affects Critical
Subsystem:** PM runtime is used extensively across the kernel for power
management. **✅ Clear Side Effects:** The fix has clear, positive side
effects - devices will now properly autosuspend when scheduled. **✅
Follows Stable Rules:** This is exactly the type of important bugfix
with minimal risk that stable trees are designed for. ## Comparison with
Historical Commits Looking at the similar commits provided: - Similar
Commit #5 (Status: YES) was backported for fixing a data type issue in
the same subsystem that could cause timer truncation on 32-bit
architectures - This current fix is similar in scope - it's fixing
timer-related logic in the same PM runtime subsystem - The risk profile
is even lower than Similar Commit #5 since it's just a comparison
operator change ## Conclusion This commit meets all criteria for stable
backporting: - It fixes a real functional bug affecting power management
- The change is minimal and surgical - It has no risk of introducing
regressions - It affects a critical kernel subsystem used system-wide -
The fix is straightforward and well-understood The timing issue fixed
here could affect any device using PM runtime autosuspend, making this a
candidate for immediate stable backporting to prevent power regressions
in production systems.

 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 04113adb092b5..99f25d6b2027a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1003,7 +1003,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires <= ktime_get_mono_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
-- 
2.39.5


