Return-Path: <stable+bounces-114047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA9A2A4A1
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789103A3B95
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E7E226196;
	Thu,  6 Feb 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKVZf0n4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEBF225760;
	Thu,  6 Feb 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834263; cv=none; b=EOj3vnbAhUgte0VNamDIyajvzk9+v8ucJar2WGymwFiDj23nLDfaTsVAa7P7wJ39MCCeWD6KlYMm9v5krCmeVs8gOaLdcQa9s+MWx6SkRk2t2BxSHXHxoxuRCaN7m6VUs+QFXtGfDtcE6LiG40Hug44QSy3wRTDU82cw4C1AI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834263; c=relaxed/simple;
	bh=SOrWPcSoquNWpMyZy27wi/Q8SEueF+uvyv+XLXRcMtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=goJ/v2c7tzrRbBcu/lwqWHkD5ZomrP7MS5zshrql+w73Lv8IKdXRVDe+ktWBe93NpnJWXsVpj95qH/6JwlvBBhFbIJdN3g8VhUb7uR24tmXr2DdM5st/VBYxUArEJlXv5qOQi+PMJo9XnGCUTKQ199KFCZiYaMBadD1HbJkaVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKVZf0n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7610C4CEDD;
	Thu,  6 Feb 2025 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738834263;
	bh=SOrWPcSoquNWpMyZy27wi/Q8SEueF+uvyv+XLXRcMtI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=dKVZf0n4e4dRMTQWnrkqyy3uilErXdJ0QaK3TdzfR8z6J6eaJuHOfV5Otk3J3aIqD
	 d/YdC5i0d4JCBhnPOfvyBlxTI1s7YbDrpiPb6Acl5BmOYUTalO9mbzF8Rw9T+H63Y+
	 ZR9HH+JkBmk4wBcNNKH6f+PMVphuch6wvZPmO0vUntMHKxZeC3PP0nM2sNzhjpE89Z
	 H6OjLO/bjRaUFK5fkeKjjhgpYlsIXQ4R2i0NHhCZBtBDQekNrpHrB+z53U2B52OKa3
	 1Fa+z/Qd22copyEQq+8HyQGbG0nJz6ToUd8rSJ9Pz+wjavIqmF6nEFPwHu32XpnL2o
	 LEMWeR2VLULAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93A0C02194;
	Thu,  6 Feb 2025 09:31:02 +0000 (UTC)
From: Krishanth Jagaduri via B4 Relay <devnull+Krishanth.Jagaduri.sony.com@kernel.org>
Date: Thu, 06 Feb 2025 14:59:59 +0530
Subject: [PATCH v2] Documentation/no_hz: Remove description that states
 boot CPU cannot be nohz_full
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-send-oss-20250129-v2-1-453755f58ae0@sony.com>
X-B4-Tracking: v=1; b=H4sIABaBpGcC/22NQQrCMBBFr1Jm7UgyTSt15T2kC02mNgsTyUiwl
 NzdWMGVy/fgv7+CcPIscGxWSJy9+Bgq0K4BO1/CjdG7ykCKOqVpQOHgMIrgz7TWkLOT6Vu+Qt0
 9Ek/+tTXPY+XZyzOmZbvI+mO/NVLdn1rWqNEZZQbS3LsDnySGZW/jHcZSyhu4p96TsQAAAA==
X-Change-ID: 20250129-send-oss-20250129-3c42dcf463eb
To: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Atsushi Ochiai <Atsushi.Ochiai@sony.com>, 
 Daniel Palmer <Daniel.Palmer@sony.com>, Oleg Nesterov <oleg@redhat.com>, 
 Chris von Recklinghausen <crecklin@redhat.com>, 
 Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>, 
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org, 
 Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738834214; l=4586;
 i=Krishanth.Jagaduri@sony.com; s=20250122; h=from:subject:message-id;
 bh=0sAqiurAdX4WtqSixtXBXrO6eSAPmKIpbmQxC16fIUQ=;
 b=hDy7sRE95Qphd9khrwPu6zkaHUaLc4tX4GPlhxcIbo1nJb0329SLQF28B1dY2SW2yulWnmT/+
 8/xP9DJuCLLC72BGybpDoZaSCYsUvTiTnOr6bLexjE7YL/2fSlhMpJu
X-Developer-Key: i=Krishanth.Jagaduri@sony.com; a=ed25519;
 pk=lx2tvWPqsnFN2XCeuuKdm7G2bXm/Grq1a1KTsSpFZSk=
X-Endpoint-Received: by B4 Relay for Krishanth.Jagaduri@sony.com/20250122
 with auth_id=326
X-Original-From: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
Reply-To: Krishanth.Jagaduri@sony.com

From: Oleg Nesterov <oleg@redhat.com>

sched/isolation: Prevent boot crash when the boot CPU is nohz_full

[ Upstream commit 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e ]

Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
include the boot CPU, which is no longer true after:

  commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").

However after:

  aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")

the kernel will crash at boot time in this case; housekeeping_any_cpu()
returns an invalid CPU number until smp_init() brings the first
housekeeping CPU up.

Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
return smp_processor_id() in this case.

This is just the simple and backportable workaround which fixes the
symptom, but smp_processor_id() at boot time should be safe at least for
type == HK_TYPE_TIMER, this more or less matches the tick_do_timer_boot_cpu
logic.

There is no worry about cpu_down(); tick_nohz_cpu_down() will not allow to
offline tick_do_timer_cpu (the 1st online housekeeping CPU).

[ Apply only documentation changes as commit which causes boot
  crash when boot CPU is nohz_full is not backported to stable
  kernels - Krishanth ]

Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
---
Hi,

Before kernel 6.9, Documentation/timers/no_hz.rst states that
"nohz_full=" mask must not include the boot CPU, which is no longer
true after commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be
nohz_full").

When trying LTS kernels between 5.4 and 6.6, we noticed we could use
boot CPU as nohz_full but the information in the document was misleading. 

This was fixed upstream by commit 5097cbcb38e6 ("sched/isolation: Prevent
boot crash when the boot CPU is nohz_full").

While it fixes the document description, it also fixes issue introduced
by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
timers on queue_delayed_work").

It is unlikely that upstream commit as a whole will be backported to
stable kernels which does not contain the commit that introduced the
issue of boot crash when boot CPU is nohz_full.

Could we fix only the document portion in stable kernels 5.4+ that
mentions boot CPU cannot be nohz_full?
---
Changes in v2:
- Add original changelog and trailers to commit message.
- Add backport note for why only document portion is modified.
- Link to v1: https://lore.kernel.org/r/20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com
---
 Documentation/timers/no_hz.rst | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index 065db217cb04fc252bbf6a05991296e7f1d3a4c5..16bda468423e88090c0dc467ca7a5c7f3fd2bf02 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.

---
base-commit: 219d54332a09e8d8741c1e1982f5eae56099de85
change-id: 20250129-send-oss-20250129-3c42dcf463eb

Best regards,
-- 
Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>



