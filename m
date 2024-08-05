Return-Path: <stable+bounces-65385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E73B947CBB
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7572B21E95
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1213A3F7;
	Mon,  5 Aug 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrVeLoky";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/CZzLjNR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E7139CFF;
	Mon,  5 Aug 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867732; cv=none; b=HxvBuQgoS5OvfFUUQCT+jcCPO4ztFNCoaXIELiyR4pwqdPwFJU0eIWFs9KbQt3qxVaB4KO0jnDjaXBKs2KrPz5oeit9fK6fUhlNLA7jYC52tLYyzggJl2Go8VswYg3+B3b6XcGkJtlE+QelfDg3Sxmk06xM7csjRfGunwzuZS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867732; c=relaxed/simple;
	bh=rcSZaK3AMezdlxdI6KTngjtbD2JcqXkWz3boLhTr2Eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iC08iE4ow1jx05Y6FaYv8NpfAZeIeXLN11UaH+pbq8NUbeHw3kU5+6eRk8+9oETufLQv4ZmPxV3babYhaKIMu1kdWX3n6yzcTRL0dN1MkIKmMnIXOytHt4dgSHdP3Ai7iC9qV8HNGoLMhqQZFNY3RbHnKzoU4bkH8O9980IYTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrVeLoky; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/CZzLjNR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 14:22:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722867729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiwUNDIRGXOU0CEVX+x2YoQYhfoznRr2E2OpXnfBd8I=;
	b=YrVeLokylrOL3kIr0YJbxnbv2rAwGAj8bDqtofCCJxTmPR2hPLAFIuAkH4QH9SOKyvW2pa
	k3vS3sOYCi5mGipI8l9cOZi/eJRMHIYK7JnzLDvLbG7r9436ga28qRyV+0bxXpQEgotu/1
	Q/qWBoRyQX27APefZHpvH1mGiVzxxpXFXNK3e3y0Ll3E/5ZO34wbsdlXDPG6guo0iiUKdr
	yF2xQg1rxtValBwZtzIHnyqFpxrptoHisIG7r7CZwYcyzA63DapveIYkQ6rYOlkITnXeoX
	PLcYhxZACKsvAU8PVkfSAK7e/VYVNVDZFszeRlts7GAOSzpRtPcKr/yFha9lyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722867729;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiwUNDIRGXOU0CEVX+x2YoQYhfoznRr2E2OpXnfBd8I=;
	b=/CZzLjNRGNjvOTfvxNAgesM6LxXzbRKCUtUCQOlGXA+1/3v/tpUzCEvsMbSlhOgHihM0bM
	eW8euBcbxY54CcBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix bogus clock_was_set()
 invocation in do_adjtimex()
Cc: Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <877ccx7igo.ffs@tglx>
References: <877ccx7igo.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172286772893.2215.12693341202200297923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     5916be8a53de6401871bdd953f6c60237b47d6d3
Gitweb:        https://git.kernel.org/tip/5916be8a53de6401871bdd953f6c60237b47d6d3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 03 Aug 2024 17:07:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Aug 2024 16:14:14 +02:00

timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()

The addition of the bases argument to clock_was_set() fixed up all call
sites correctly except for do_adjtimex(). This uses CLOCK_REALTIME
instead of CLOCK_SET_WALL as argument. CLOCK_REALTIME is 0.

As a result the effect of that clock_was_set() notification is incomplete
and might result in timers expiring late because the hrtimer code does
not re-evaluate the affected clock bases.

Use CLOCK_SET_WALL instead of CLOCK_REALTIME to tell the hrtimers code
which clock bases need to be re-evaluated.

Fixes: 17a1b8826b45 ("hrtimer: Add bases argument to clock_was_set()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/877ccx7igo.ffs@tglx

---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2fa87dc..5391e41 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2606,7 +2606,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set(CLOCK_REALTIME);
+		clock_was_set(CLOCK_SET_WALL);
 
 	ntp_notify_cmos_timer();
 

