Return-Path: <stable+bounces-166390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB073B1996D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FC7A8637
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFD81E3762;
	Mon,  4 Aug 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvgRszH0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A181FDD;
	Mon,  4 Aug 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268122; cv=none; b=YgrCKLWHT/4DXNyaJmF/4UonU/fW9w2pou06K7SpVlGB0G5N60cjy6k11ZzMYIa8Inmt5bRmj4ibEfyQbAm4bkgcl8OwhsGRtK6drWV9g+7C3OX6pA73dOezqD7R2kuS7QgB9dUrPZ85y6SasX0qnV6lseNR1+2V22w5fwM2Rw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268122; c=relaxed/simple;
	bh=wMHBNBeeHHUWPqurqWKHMSiNhDpOnJuB4LXOrrMLExI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icBK23zNfBo5p1H2RPqsE/IC1QtpsBlmT04BYrpJ7LivOKCzcJbr+5JaAuX8vnEhCWX7NU1a6o6J6lPxAnKFjOwyD3o9wgZwR60hduki6ItvH+4IrxOUmShUgofJJaQZ+XKNBufUKJoPvx6kDXt41mE4wYVNT836e05mWjvb9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvgRszH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9574FC4CEEB;
	Mon,  4 Aug 2025 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268122;
	bh=wMHBNBeeHHUWPqurqWKHMSiNhDpOnJuB4LXOrrMLExI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvgRszH0WcgC47jc1Xb/pfECNHr4+0R/wyzpLgus5Wif804Jovb9UnfSI5Ghn8XEK
	 POVAeQemkMNaHVO5Uiv3CZ9xm7HpmE4y4mKJENTVGwZ6dUJTKFq279mNya0QqZgD2e
	 bxWw1mjrk4ZuLhAF7GeL2XGnZE/zj+02EOYXnodZjUhLrH2JZ6CxlQMkayj6apIY+c
	 7lakdwnYOQxvNCIBdU9p2EWOtJTSePTm8WZ/V1vBF03wc+fQ2oRNLeu75DmxRO39P0
	 AXG6x6ZBKHUg6Z9MxdeRdgSgb/nEyOAqa+dhIEPT+I55Mb+x0GidNmMd9LqIi8KdLf
	 HpZp6DDovtLDw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	thomas.weissschuh@linutronix.de,
	rdunlap@infradead.org,
	linux@treblig.org
Subject: [PATCH AUTOSEL 5.10 30/39] usb: core: usb_submit_urb: downgrade type check
Date: Sun,  3 Aug 2025 20:40:32 -0400
Message-Id: <20250804004041.3628812-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 503bbde34cc3dd2acd231f277ba70c3f9ed22e59 ]

Checking for the endpoint type is no reason for a WARN, as that can
cause a reboot. A driver not checking the endpoint type must not cause a
reboot, as there is just no point in this.  We cannot prevent a device
from doing something incorrect as a reaction to a transfer. Hence
warning for a mere assumption being wrong is not sensible.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250612122149.2559724-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of this commit, here is my determination:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real issue that affects users**: The commit addresses a
   problem where a `dev_WARN()` can cause system reboots when
   `panic_on_warn` is enabled. This is a serious issue because a driver
   bug (not checking endpoint types properly) should not be able to
   crash the entire system.

2. **Small and contained fix**: The change is minimal - it only replaces
   `dev_WARN()` with `dev_warn_once()` on line 503 of
   drivers/usb/core/urb.c. This is a one-line change that doesn't affect
   any other functionality.

3. **Clear side effects**: The only behavioral change is that:
   - The warning will no longer trigger a kernel panic when
     `panic_on_warn` is set
   - The warning will only be printed once instead of potentially
     multiple times
   - No backtrace will be generated

4. **No architectural changes**: This is a simple logging level change
   that doesn't modify any USB subsystem architecture or functionality.

5. **Affects critical kernel subsystem**: While USB is a critical
   subsystem, this change actually makes it more stable by preventing
   potential system crashes.

6. **Follows stable tree rules**: This is clearly a bugfix that improves
   system stability. The commit message explicitly states that "A driver
   not checking the endpoint type must not cause a reboot" - this is a
   stability improvement that prevents denial-of-service scenarios.

7. **Similar fixes in the kernel**: There's precedent for this type of
   fix, as shown by commit 281cb9d65a95 ("bnxt_en: Make PTP timestamp
   HWRM more silent") which made a similar conversion from
   `netdev_WARN_ONCE()` to `netdev_warn_once()` for the same reason.

The key insight from the code is that `dev_WARN()` calls `WARN()` which
can trigger a kernel panic if `panic_on_warn` is set. This means a
malicious or buggy USB device could potentially crash the system just by
triggering this warning. Converting to `dev_warn_once()` maintains the
diagnostic value while removing the crash risk.

 drivers/usb/core/urb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 9c285026f827..c41b25bc585c 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -490,7 +490,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_pipe_type_check(urb->dev, urb->pipe))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
+		dev_warn_once(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
-- 
2.39.5


