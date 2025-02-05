Return-Path: <stable+bounces-112270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CADA28248
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 04:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A8C3A63C1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD7212D9E;
	Wed,  5 Feb 2025 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxEBMQ1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDE2F46;
	Wed,  5 Feb 2025 03:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724593; cv=none; b=NoRbxnZI3lTzXDgl/72WXFqi1zt6dz1ZNarNG4yT5J9m9zbuqb9jtEAG/HUJijNsDjve4yN3fIMtjSnLwhElwlhuRE9KEZ52t+6e7ZvDH6y0UcJjvfCM1k9n7FvCfMKBhUniJGUFAvaMpiur8KRGDIrwkwYqtHUTpaGn+nJ4H7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724593; c=relaxed/simple;
	bh=g6XqJi+3efzE8zFPlaanW3f9Ug9ugh+JBc0KjXvtBU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xvc8yIFggLxjqJboAI/pFQTqLi7dSLZmymtXwSECCRqoEl8wYOaG1DUrLjDOPW0vEogSsVHI24mkzIpSItEEksXAhIa+S2/XUaFNrpRDv7J4zjl+1zlLVE1H/CBlWOvhuWysMPxz5OZBkztd240yEeBOa2iY3Sw7GHBgU1Ba/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxEBMQ1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F6F3C4CEDF;
	Wed,  5 Feb 2025 03:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738724592;
	bh=g6XqJi+3efzE8zFPlaanW3f9Ug9ugh+JBc0KjXvtBU4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nxEBMQ1Otzbfr8Miy8itzaRuIqZcBtTIS5iDE1E6wSKs74Ttx1ATEpl+6dRt+0R8X
	 sm99GN4lVBq3IU7w1Ddn7eNxrshzpZQ1ATHV440zSF2s9ep4NhSzHe39I4MFZEBKm1
	 mEk51fn1ExWrTDE1WbH6RSnopx1/R1/KBf3WHBw0S4lQnhCR8NDLM4LnmQlwMX7L+X
	 gmoQNW5knlpPqZejpRPb8n1sMYs01FfTutAG4nvf+QX41FzgDCx8GdXZ6JhD1DAslB
	 vRD4fadAIjuww39fJ3QFUVRERbo1yUCG3g2UkHi6QtLNoYZn0N8dnLR5259/EH54Fm
	 6oVozAZYZp19g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDFC02193;
	Wed,  5 Feb 2025 03:03:12 +0000 (UTC)
From: Krishanth Jagaduri via B4 Relay <devnull+Krishanth.Jagaduri.sony.com@kernel.org>
Date: Wed, 05 Feb 2025 08:32:14 +0530
Subject: [PATCH] Documentation/no_hz: Remove description that states boot
 CPU cannot be nohz_full
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com>
X-B4-Tracking: v=1; b=H4sIALXUomcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyNL3eLUvBTd/OJiXbiIcbKJUUpymomZcWqSElBfQVFqWmYF2Mzo2Np
 aANx8/qJjAAAA
X-Change-ID: 20250129-send-oss-20250129-3c42dcf463eb
To: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Atsushi Ochiai <Atsushi.Ochiai@sony.com>, 
 Daniel Palmer <Daniel.Palmer@sony.com>, Oleg Nesterov <oleg@redhat.com>, 
 stable@vger.kernel.org, Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738724552; l=2701;
 i=Krishanth.Jagaduri@sony.com; s=20250122; h=from:subject:message-id;
 bh=E835T3tqOhFIcn/Jm6X5qlETpMAWcMeplxvdOyEAeTk=;
 b=arldPplnu5QfSI/nuErJEq7UekxDqNZEtHWhOuNB63444+4wrmK/5cLfNDHZOvmrYyCnN/vOn
 GO55gjfsmhvDDyu1ZDrKcb7qOBtL1+NorXtzZGYZXpdTPdiNYzmlqQ0
X-Developer-Key: i=Krishanth.Jagaduri@sony.com; a=ed25519;
 pk=lx2tvWPqsnFN2XCeuuKdm7G2bXm/Grq1a1KTsSpFZSk=
X-Endpoint-Received: by B4 Relay for Krishanth.Jagaduri@sony.com/20250122
 with auth_id=326
X-Original-From: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
Reply-To: Krishanth.Jagaduri@sony.com

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e ]

Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
include the boot CPU, which is no longer true after:

  commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").

Apply changes only to Documentation/timers/no_hz.rst in stable kernels.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>
---
Hi,

Before kernel 6.9, Documentation/timers/no_hz.rst states that
"nohz_full=" mask must not include the boot CPU, which is no longer
true after commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be
nohz_full").

This was fixed upstream by commit 5097cbcb38e6 ("sched/isolation: Prevent
boot crash when the boot CPU is nohz_full").

While it fixes the document description, it also fixes issue introduced
by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
timers on queue_delayed_work").

It is unlikely that it will be backported to stable kernels which does
not contain the commit that introduced the issue.

Could Documentation/timers/no_hz.rst be fixed in stable kernels 5.4+?
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



