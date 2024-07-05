Return-Path: <stable+bounces-58155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F8928E98
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 23:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93E52820F4
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6413617C22A;
	Fri,  5 Jul 2024 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoKRB1/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYSDpiBv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AA178CDE;
	Fri,  5 Jul 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213612; cv=none; b=jIXEKhCwzAcfxO053wh5GVqjwugZKm1GzGT7x/m4DYxU2wwc8+NsvRJF9G+KLpu7RtF7TDPYFgY6epPmUWsbXH2Gv1iPhsL6ftVU0kJlm+BCHqgMUeufeA1NbcvfR2ZaYdZp8ROxFqX/P6SqJ38fHI6a7qcTb35oxGyO0oRZR0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213612; c=relaxed/simple;
	bh=i9wxX3ykgal6jT+g69AHfVvMYe+CFAyR4s28qt1e42E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pl1Y2eFp07r3gOA6u9qrRMQlnDN0CsW2SFVX4R40ZmbjgrB2uAfBI5SYjHSnej+/vWuIAZe+R4cwuRTgxXDphNg2hfYaIZpkEXEDy8DZ74jqM2UAUAXYRVKT3QPYzIEXKZOw/A/ojoKGYqENo/I9BB4hReiaaxEO6Hr1nIyhrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoKRB1/H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KYSDpiBv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNwN3vjae4sJmr3lF/uoCdfNZbSUpAVTWMeqdKXBVHM=;
	b=LoKRB1/Hl2ub87KX6gLtEjT0E1i8lfRBaNe/j5tOtkNhdvQRloZKPwG3biqRg8F/jPViF6
	uzAnMx6/veVaLOmCATnVSCaXpdY6SZtn+nPYGnF5K+5eD+gieLtuqhINgejHboip/c2qvx
	9SZzD/9SnwFkP/8aGswD4vWTSl4DFwj+1MVmVgttLTjLveuCtXkx5o90nfo8Umdzhbzd+l
	Oj6nWZ50K+D2OJopZ/BUrLakmnou2GMgs9/aLcMjHTuJiTWYW6tvsOYcRoR1i6J4DatX0E
	Q2x/hGXbn8MhdZVQvFf9OAz7Hg0ma1gIaM1HX3ba/aYHGu8Yb2o6goWBIWK5Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNwN3vjae4sJmr3lF/uoCdfNZbSUpAVTWMeqdKXBVHM=;
	b=KYSDpiBv6iqdBdnhcE/g6ZcIxZ/vHS5qOrLvrSmVmdveCueEUer+7FJtdHI2AyaUltBMGO
	CNdRIckQZZ18vbBA==
From: "tip-bot2 for Marco Cavenati" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Fix topa_entry base length
Cc: Marco Cavenati <cavenati.marco@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240624201101.60186-2-adrian.hunter@intel.com>
References: <20240624201101.60186-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360733.2215.4615279954165973438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5638bd722a44bbe97c1a7b3fae5b9efddb3e70ff
Gitweb:        https://git.kernel.org/tip/5638bd722a44bbe97c1a7b3fae5b9efddb3e70ff
Author:        Marco Cavenati <cavenati.marco@gmail.com>
AuthorDate:    Mon, 24 Jun 2024 23:10:55 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:20 +02:00

perf/x86/intel/pt: Fix topa_entry base length

topa_entry->base needs to store a pfn.  It obviously needs to be
large enough to store the largest possible x86 pfn which is
MAXPHYADDR-PAGE_SIZE (52-12).  So it is 4 bits too small.

Increase the size of topa_entry->base from 36 bits to 40 bits.

Note, systems where physical addresses can be 256TiB or more are affected.

[ Adrian: Amend commit message as suggested by Dave Hansen ]

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Signed-off-by: Marco Cavenati <cavenati.marco@gmail.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240624201101.60186-2-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a6..f5e46c0 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -33,8 +33,8 @@ struct topa_entry {
 	u64	rsvd2	: 1;
 	u64	size	: 4;
 	u64	rsvd3	: 2;
-	u64	base	: 36;
-	u64	rsvd4	: 16;
+	u64	base	: 40;
+	u64	rsvd4	: 12;
 };
 
 /* TSC to Core Crystal Clock Ratio */

