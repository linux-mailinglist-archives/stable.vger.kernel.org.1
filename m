Return-Path: <stable+bounces-151044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DCACD374
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504D41899C9F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BDE1DE2CD;
	Wed,  4 Jun 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htz26NEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420F1624C5;
	Wed,  4 Jun 2025 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998848; cv=none; b=VjBVvlXQ6Zp6LBPRcJLpO2oI8SqLokkrCxDHCBw7hrtlPUcdcqmOaws4VLQFVq7ou47/NKDzz3HtVVunFh0z/FogoXcnIUyCc3YVENtoTplCSre4IisDamoUptYB2KlHJxZHzBzk6oI8I3mEwTq4yGsCNHpboVIhjFzjEbc+awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998848; c=relaxed/simple;
	bh=k0ttt0hVvxOERBZO40tXZZIloJLaohvYvr5/0BqFVHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvwpDXdxBSCmqoiKJ3Tm2BLka6tol/c/lWRfCsS0hdtoUsSuBQI52/IYm/p0z6xUcGrwCuydK3HB5uc6EIfrkeORfuCVLNo0YVDHaTTPTyLunMh1OK/nf7hqPs+rcrhKI56zwgHHe6OX4MUfHrQChRiMllDHkICqmP49y3IHgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htz26NEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298EEC4CEED;
	Wed,  4 Jun 2025 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998848;
	bh=k0ttt0hVvxOERBZO40tXZZIloJLaohvYvr5/0BqFVHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htz26NEm0l7NrcB5g3C+zMnAZAI3aqUxk+fDsnF5MSnWN/qEYNv08S6ZruRvgwNmU
	 G69G5ba+pC0m3hxxKnGPWQISzEswhVFa9Y5MznbHeklfay4oPvb5hpIVbQ9AJZT94T
	 rgPidmDX9+8U0Bn030obzWrR2vjJRxejuBwzABelxjWFX7XtvBJiWzfIiV7C3fMBIc
	 g9HBXYSt8KZU1zC2+jUAHfyFg8AfZwZTWVfq9Q+VEqDYYQiseNpHOj8GD70eS8lVaa
	 bwxZxBi9Q3FXjTmAFJz/kf96/TyTP7XFgYa3rot9h13n27IVLK612nNh+9qrjFsm13
	 JvZEwBu80Viig==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@kernel.org,
	emmanuel.grumbach@intel.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH AUTOSEL 6.12 47/93] wireless: purelifi: plfxlc: fix memory leak in plfxlc_usb_wreq_asyn()
Date: Tue,  3 Jun 2025 20:58:33 -0400
Message-Id: <20250604005919.4191884-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005919.4191884-1-sashal@kernel.org>
References: <20250604005919.4191884-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Salah Triki <salah.triki@gmail.com>

[ Upstream commit 63a9a727d373fa5b8ce509eef50dbc45e0f745b9 ]

Add usb_free_urb() in the error path to prevent memory leak.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Link: https://patch.msgid.link/aA3_maPlEJzO7wrL@pc
[fix subject]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Code Analysis The commit fixes a clear memory
leak in the `plfxlc_usb_wreq_async()` function in the pureLiFi wireless
driver. Specifically: **The Bug:** - The function calls
`usb_alloc_urb(0, GFP_ATOMIC)` to allocate a USB URB (USB Request Block)
- If `usb_submit_urb()` fails, the function returns the error code but
never frees the allocated URB - This creates a memory leak every time
USB submission fails **The Fix:** The fix adds a simple but crucial
cleanup path: ```c r = usb_submit_urb(urb, GFP_ATOMIC); -if (r) +if (r)
{ + usb_free_urb(urb); dev_err(&udev->dev, "Async write submit failed
(%d)\n", r); +} ``` ## Timeline and Impact From examining the git
history: 1. **Bug Introduction:** The bug was introduced in commit
`68d57a07bfe5` when the driver was first added 2. **Bug Duration:** This
memory leak has existed since the driver's introduction 3. **Impact:**
Every failed USB submission would leak memory, potentially causing
system instability over time ## Comparison with Similar Commits This
commit matches the pattern of all 5 similar commits marked as "Backport
Status: YES": 1. **Similar Commit #2** - Also fixes missing allocation
failure check in the same function (`plfxlc_usb_wreq_async`) 2.
**Similar Commit #1** - Fixes memory leak in the same driver
(`__lf_x_usb_enable_rx`) 3. **Similar Commits #3-5** - All fix memory
leaks in wireless drivers with small, contained changes ## Backport
Criteria Met ✅ **Fixes important bug:** Memory leaks can cause system
instability ✅ **Small and contained:** Only adds 2 lines of code in
error path ✅ **No architectural changes:** Simple cleanup fix ✅
**Minimal regression risk:** Standard USB cleanup pattern ✅ **Clear
scope:** Limited to specific function in wireless driver ✅ **Follows
stable rules:** Important bugfix with minimal impact ## Additional
Considerations - The fix follows standard kernel patterns for USB URB
cleanup - The same driver has had multiple similar memory leak fixes
(commit `895b3b06efc2`) - The change is identical in nature to Similar
Commit #2, which was also in this exact function and marked YES for
backporting - No side effects beyond fixing the memory leak - The
function is called from transmit path, so failures could be relatively
common under stress This is a textbook example of a stable tree
candidate: a clear, important bug fix with minimal code changes and no
risk of regression.

 drivers/net/wireless/purelifi/plfxlc/usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/usb.c b/drivers/net/wireless/purelifi/plfxlc/usb.c
index 56d1139ba8bcc..7e7bfa532ed25 100644
--- a/drivers/net/wireless/purelifi/plfxlc/usb.c
+++ b/drivers/net/wireless/purelifi/plfxlc/usb.c
@@ -503,8 +503,10 @@ int plfxlc_usb_wreq_async(struct plfxlc_usb *usb, const u8 *buffer,
 			  (void *)buffer, buffer_len, complete_fn, context);
 
 	r = usb_submit_urb(urb, GFP_ATOMIC);
-	if (r)
+	if (r) {
+		usb_free_urb(urb);
 		dev_err(&udev->dev, "Async write submit failed (%d)\n", r);
+	}
 
 	return r;
 }
-- 
2.39.5


