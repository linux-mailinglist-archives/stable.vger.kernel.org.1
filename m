Return-Path: <stable+bounces-252325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDy2BSb8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF5595FE8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E84431498A3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC13FB7FC;
	Wed, 20 May 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l9FnK+mE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85F3A6B6D;
	Wed, 20 May 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300381; cv=none; b=Cbbt8YeS2q/v44kffhrXdjRuuYfecevD9TUktg+BjECgcYbHzuzxXo2aGHrDOPtoQk1yaniWOQvHMaOQVqwLLaBsHZ/wSveiDSMePO/3AHaFaLihe8F5cvT0VAi2w9FZ6i6sH6OLoJQmCdcwb3WKK6Ay3xwUq5/SvdVljCZdyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300381; c=relaxed/simple;
	bh=vwE5Tu3I9JOjf3+32tHSA47GKYs60r6dqRlKoBrdoMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jesu2/DduBhFZD4tUTLAhT8r6cMzbZB2T75OjJjtHoRbdvFlqlOlP2xFl+/i69jCw9Zch7UBrqAe9+4/L126qzsOJt6YJXsFlX1RyRdTL6/fDVv8/A1dzU5gjl0p7XIwqS5WcLMpg2CtiunbEa/P8UUv/7iKXhowi/P3fzMC+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l9FnK+mE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5AB1F000E9;
	Wed, 20 May 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300380;
	bh=Uq2EYbrdmHxAYMD6NTXFFIdQX4Ve34MU1Y/e5Ku2Z/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9FnK+mEUPcS8N+fF1VsiND7dgMq90/4/SxfnXGSvDvgVkJlqEYUPx1X14NqMuriz
	 ozds46MQSeoVrz8VdF2hIddJhUFxh/3gZKEEN9BIovSH8CMryLW0US9S2mtT08EQqA
	 5q0NwKIPadlkwTTmMY6O81yHNIAf4KPmHFgCOMbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Yan <yanaijie@huawei.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 152/666] fbdev: matroxfb: Mark variable with __maybe_unused to avoid W=1 build break
Date: Wed, 20 May 2026 18:16:03 +0200
Message-ID: <20260520162114.503284816@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,huawei.com,gmx.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-252325-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,gmx.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email]
X-Rspamd-Queue-Id: D5FF5595FE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit caf6144053b4e1c815aa56afb54745a176f999df ]

Clang is not happy about set but unused variable:

drivers/video/fbdev/matrox/g450_pll.c:412:18: error: variable 'mnp' set but not used
   412 |         unsigned int mnp;
       |                      ^
1 error generated.

Since the commit 7b987887f97b ("video: fbdev: matroxfb: remove dead code
and set but not used variable") the 'mnp' became unused, but eliminating
that code might have side-effects. The question here is what should we do
with 'mnp'? The easiest way out is just mark it with __maybe_unused which
will shut the compiler up and won't change any possible IO flow. So does
this change.

A dive into the history of the driver:

The problem was revealed when the #if 0 guarded code along with unused
pixel_vco variable was removed. That code was introduced in the original
commit 213d22146d1f ("[PATCH] (1/3) matroxfb for 2.5.3"). And then guarded
in the commit 705e41f82988 ("matroxfb DVI updates: Handle DVI output on
G450/G550. Powerdown unused portions of G450/G550 DAC. Split G450/G550 DAC
from older DAC1064 handling. Modify PLL setting when both CRTCs use same
pixel clocks.").

NOTE: The two commits mentioned above pre-date Git era and available in
history.git repository for archaeological purposes.

Even without that guard the modern compilers may see that the pixel_vco
wasn't ever used and seems a leftover after some debug or review made
25 years ago.

The g450_mnp2vco() doesn't have any IO and as Jason said doesn't seem
to have any side effects either than some unneeded CPU processing during
runtime. I agree that's unlikely that timeout (or heating up the CPU) has
any effect on the HW (GPU/display) functionality.

Fixes: 7b987887f97b ("video: fbdev: matroxfb: remove dead code and set but not used variable")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/matrox/g450_pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/g450_pll.c b/drivers/video/fbdev/matrox/g450_pll.c
index ff8e321a22cef..b2d3f7328ea83 100644
--- a/drivers/video/fbdev/matrox/g450_pll.c
+++ b/drivers/video/fbdev/matrox/g450_pll.c
@@ -407,7 +407,7 @@ static int __g450_setclk(struct matrox_fb_info *minfo, unsigned int fout,
 		case M_VIDEO_PLL:
 			{
 				u_int8_t tmp;
-				unsigned int mnp;
+				unsigned int mnp __maybe_unused;
 				unsigned long flags;
 				
 				matroxfb_DAC_lock_irqsave(flags);
-- 
2.53.0




