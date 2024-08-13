Return-Path: <stable+bounces-67491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E061950656
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF855281DE8
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE019AD6E;
	Tue, 13 Aug 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMskW5VP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1f+zuZx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13418953E;
	Tue, 13 Aug 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555315; cv=none; b=Q5Xu4XCsb6PaAx3h88NTJPS07k5jcNreEOyP9yVDYQ9iVAFZ48yETelTwMppkiKkNZ5wYq19p9VPmskJHkvl6gxh3m4f2IlSun8PFsONO8AcfZQ7piufRmRBmm103Sm++8YhoXSZ0Y7jzaPbKnMT3qTLZJNJU8myXPr9/5ZQkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555315; c=relaxed/simple;
	bh=qjciSgQ2Z2/btL6BUOx5r0H3tDQdvYHDVFVLweiVy1s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H60/dic0clGSRtLl3pysVfCXh71/o3LvuEyruHqtFPmyxFBTkdLg9MgK/YT/GkEAyvUIZCtutJVGs7vih7udzwGtyOwPpxOsPg+aqSGZwaSMFQpAeifwPel4GuYwjp3QMOMmz9ACdoJoqlQFf/AGGJIOSznwniOdyTDAGSFxdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMskW5VP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1f+zuZx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 13:21:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723555312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diMymUXX9xUr86i3YOydYUTNUH8eprm2HE7Tgl/c2Hk=;
	b=VMskW5VPPfvYUf4HH54t4DZVdyxlP9HCHG28Fptb16wIFxzTnaYruL54UM4cZncUvWmMoX
	63KbNizQ4jD0TJQbxFNX0TijZrXtfX05Bc/xGRqlu1JIUdxzx3WFmZxb2TLrp6fig3JgRT
	J5We4YiTrqWGptv1YCelzIVh9Yya9drC4r/+fsDSalYnP9ncwcOHwMbL7JuQLUS5c02s/h
	qM2v2cF/1+agu5mP0Xk6Xaps0HVt6d+Uwa2gBmgOC4gM2Oo/zEebqdwXwX3QOARWjvZYF7
	ks1HR0tuxrz59bjfpMX2CEPt9M7u85A3LOGY/ZR8nGHcQ0nov936A+UwlPSm4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723555312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diMymUXX9xUr86i3YOydYUTNUH8eprm2HE7Tgl/c2Hk=;
	b=Q1f+zuZxUPlQyJ4x1ubnPLQ5yVDF1lBc7el9GYu8iyewR9ZxvXYgc3+i8QdOadjdrhXCcA
	vwhcsWWPpXDoQRAw==
From: "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Make x2apic_disable() work correctly
Cc: Yuntao Wang <yuntao.wang@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813014827.895381-1-yuntao.wang@linux.dev>
References: <20240813014827.895381-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172355531145.2215.1265281947968550641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0ecc5be200c84e67114f3640064ba2bae3ba2f5a
Gitweb:        https://git.kernel.org/tip/0ecc5be200c84e67114f3640064ba2bae3ba2f5a
Author:        Yuntao Wang <yuntao.wang@linux.dev>
AuthorDate:    Tue, 13 Aug 2024 09:48:27 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 15:15:19 +02:00

x86/apic: Make x2apic_disable() work correctly

x2apic_disable() clears x2apic_state and x2apic_mode unconditionally, even
when the state is X2APIC_ON_LOCKED, which prevents the kernel to disable
it thereby creating inconsistent state.

Due to the early state check for X2APIC_ON, the code path which warns about
a locked X2APIC cannot be reached.

Test for state < X2APIC_ON instead and move the clearing of the state and
mode variables to the place which actually disables X2APIC.

[ tglx: Massaged change log. Added Fixes tag. Moved clearing so it's at the
  	right place for back ports ]

Fixes: a57e456a7b28 ("x86/apic: Fix fallout from x2apic cleanup")
Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240813014827.895381-1-yuntao.wang@linux.dev

---
 arch/x86/kernel/apic/apic.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2..3736386 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1775,12 +1775,9 @@ static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
-	u32 x2apic_id, state = x2apic_state;
+	u32 x2apic_id;
 
-	x2apic_mode = 0;
-	x2apic_state = X2APIC_DISABLED;
-
-	if (state != X2APIC_ON)
+	if (x2apic_state < X2APIC_ON)
 		return;
 
 	x2apic_id = read_apic_id();
@@ -1793,6 +1790,10 @@ static __init void x2apic_disable(void)
 	}
 
 	__x2apic_disable();
+
+	x2apic_mode = 0;
+	x2apic_state = X2APIC_DISABLED;
+
 	/*
 	 * Don't reread the APIC ID as it was already done from
 	 * check_x2apic() and the APIC driver still is a x2APIC variant,

