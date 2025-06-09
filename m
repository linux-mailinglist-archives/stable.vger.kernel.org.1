Return-Path: <stable+bounces-152100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA255AD1F98
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BD316DA76
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862D25B677;
	Mon,  9 Jun 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3E4w9Es"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62642258CF5;
	Mon,  9 Jun 2025 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476793; cv=none; b=sNP8RkOfpCE2BkXh/75gHrs2Yj+tbEDziLv301avZRdUIK/UtFiuZs4MULeOxQvq6yY+zluXKxg6BwQs7jOQwmV7tkzJRCbmXZqvnAk5/RgJI44Zl75lPNYC5kAcnd6GScfCHXeUiAltONKfg8JjIxYLKXpHNmBiRugxQxFw/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476793; c=relaxed/simple;
	bh=nrqqEGo6jaJwQGs6JIAmZhKgMNrOYuEAvZ+Ai/B8Nko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRHneDH0CbvQICn0LHrfjv5zMpHsPMcHp/qf01RdkFgtGQ7mdGHejZ1SBTu/NJjDX9GcI6LuHuaxu7dPkabcNgZ7y/IcojiKH03KEaa75d098B/JrO9Anb+TFay4TUlRncHZtd+5NAs8vv1UHG6YC30oce7TReeB7jM/U6iVwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3E4w9Es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B714C4CEF2;
	Mon,  9 Jun 2025 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476793;
	bh=nrqqEGo6jaJwQGs6JIAmZhKgMNrOYuEAvZ+Ai/B8Nko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3E4w9EsY6VhkmuX1RMqpSjvP8ERPUSjmeIGospVo+6kyBjR1R03EpTOI02XZLSKf
	 WGQ4/c3ZVAWpmbe4/GFweojhq/sLe0Q4V8dxuXOyh1l4pQ8Eqlu/LaAYmGVO+8AeBv
	 e2lqprMPagtglax86NfQEW5oohNG7PrC1kR0VWlL4Y020dYgrD8qxr0e2XcUfNKKxP
	 +93wMYTGsVKDkjjp9EA1X13qGLDkTjUn0YSECte5Q34vMPy26VeKVrG9erXrCdszPq
	 FOj82gSwRvLQ0ZJnSVjlwShr23uzBjbOVfPCm7gd44rhSExmmnZreIiGZgA3vALSdm
	 VAYlM+/vvKWVg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 13/23] usb: dwc2: also exit clock_gating when stopping udc while suspended
Date: Mon,  9 Jun 2025 09:46:00 -0400
Message-Id: <20250609134610.1343777-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134610.1343777-1-sashal@kernel.org>
References: <20250609134610.1343777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit af076a41f8a28faf9ceb9dd2d88aef2c202ef39a ]

It is possible that the gadget will be disabled, while the udc is
suspended. When enabling the udc in that case, the clock gating
will not be enabled again. Leaving the phy unclocked. Even when the
udc is not enabled, connecting this powered but not clocked phy leads
to enumeration errors on the host side.

To ensure that the clock gating will be in an valid state, we ensure
that the clock gating will be enabled before stopping the udc.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Link: https://lore.kernel.org/r/20250417-dwc2_clock_gating-v1-1-8ea7c4d53d73@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the code, similar commits, and the context, here
is my assessment:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Code Analysis

The commit adds clock gating exit logic to the `dwc2_hsotg_udc_stop()`
function in drivers/usb/dwc2/gadget.c. Specifically, it adds these lines
before shutting down endpoints:

```c
/* Exit clock gating when driver is stopped. */
if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
    dwc2_gadget_exit_clock_gating(hsotg, 0);
}
```

## Rationale for Backporting

1. **Follows Established Pattern**: The code change exactly matches the
   pattern used throughout the dwc2 driver in other similar contexts. I
   found identical condition checks and dwc2_gadget_exit_clock_gating()
   calls in:
   - `drivers/usb/dwc2/platform.c:333-336` (driver removal)
   - `drivers/usb/dwc2/core_intr.c:314-317` (session request interrupt)
   - `drivers/usb/dwc2/core_intr.c:447-450` (wakeup detected interrupt)
   - `drivers/usb/dwc2/gadget.c:3738-3741` (USB reset detect interrupt)

2. **Fixes a Real Bug**: The commit message describes a specific
   hardware state issue: "Even when the udc is not enabled, connecting
   this powered but not clocked phy leads to enumeration errors on the
   host side." This indicates a functional problem that affects users.

3. **Low Risk, High Consistency**: The fix simply adds the same clock
   gating exit pattern that already exists in 4+ other locations in the
   same driver. This demonstrates it's a well-tested, safe pattern.

4. **Critical Hardware State Management**: Clock gating is a fundamental
   power management feature, and incorrect state handling can cause
   system hangs or hardware enumeration failures, as evidenced by the
   related fix in commit 2c6b6afa59e7 which had to be marked for stable.

5. **Matches Historical Precedent**: Looking at the reference commits:
   - Similar Commit #2 (YES): "usb: dwc2: gadget: Fix exiting from clock
     gating" - This shows clock gating exit fixes are considered
     backport-worthy
   - Similar Commit #3 (YES): "usb: dwc2: do not gate off the hardware
     if it does not support clock gating" - This reinforces that clock
     gating correctness is critical

6. **Stable Tree Criteria Met**:
   - ✅ Fixes important bug (PHY enumeration errors)
   - ✅ Small and contained change (6 lines)
   - ✅ No architectural changes
   - ✅ Minimal regression risk (uses existing, proven pattern)
   - ✅ Confined to dwc2 subsystem

7. **Recent Historical Context**: The git history shows multiple recent
   clock gating fixes that were marked for stable (31f42da31417,
   2c6b6afa59e7), indicating this subsystem area is actively maintained
   and these types of fixes are important for stable trees.

The commit addresses a state consistency issue where the clock gating
state becomes invalid when the UDC is stopped while suspended, leading
to hardware enumeration problems. This is exactly the type of subtle but
important hardware state management bug that stable trees are designed
to fix.

 drivers/usb/dwc2/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index bd4c788f03bc1..d3d0d75ab1f59 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4604,6 +4604,12 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	if (!hsotg)
 		return -ENODEV;
 
+	/* Exit clock gating when driver is stopped. */
+	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
+		dwc2_gadget_exit_clock_gating(hsotg, 0);
+	}
+
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
-- 
2.39.5


