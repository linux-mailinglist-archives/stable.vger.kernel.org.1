Return-Path: <stable+bounces-106061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E09FBB7B
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42EE166D81
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608A1B4F1F;
	Tue, 24 Dec 2024 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfnJC6FE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQ3XPKs4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16B1B4128;
	Tue, 24 Dec 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033614; cv=none; b=LTlTodYtmzDJkNZmW53TrqXcjzGKM7G5dCP2F8EFcjfHFjedQFD6LkTDu24QO87QcF1G8fTsfukvEMWZ1IybdNy9lg1j4UZVJlhTTpMc51igJypTTD/wxjP6/Brmn98Ata7/eTabjTlc8jcakFFO2QRvJ+JwKir5sIhWyD55/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033614; c=relaxed/simple;
	bh=+IBW+5AjRgu5sn/HOoAyLQ8kBrZHpZcjp1T7ivQ6O4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xd+XEVYhU7CrY2kZc1xzPfx+cdIP7UVcCDfgt6FFruwFCdPxq+XP5hG/sQbgxQRm4Vk43lH+kH067JPUPqPsnJdc5ooi/f3BzpDOIhn0B9F3LMc0TJ5n5hUao+t5thgIsh/pc0AGd3ddZxdkUq0bI6ZJxA7EaIHdzKQ9N4JhlAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfnJC6FE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQ3XPKs4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo0eWLy4lbgJyrHAz+mVU4+OZCOrBWvnB0jrRPaVlM8=;
	b=pfnJC6FEq4Owezi05CfV0VX4nrq/0KdivXtuS0f8Tck7YMBatYnrDjeozLRH6Rm/C4ol0j
	3WNI45GitveFRJVV4gyZoLuNNA04hYI76Embk5+QIVRLkOT36Wmf82ZFmpKS3lCYGXknnc
	z0gbHts6dNI5jXKdgX988BisgzRRsw4voQKxRDesb0uXY7eZ8+fKfiS/ROsXvaOt0Z86ap
	ou1q9ER7wOJt+c4bkic/88c8r+Ot6jjmjoAJmMx4p2S1IpPgcZWREXZCrSct5nr2dB7m7f
	KPuPI1H9rEeZIP7sp0qfzg0YOEttduC2pZrrVJZV4207+67wS5z8XsxSlApVGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oo0eWLy4lbgJyrHAz+mVU4+OZCOrBWvnB0jrRPaVlM8=;
	b=BQ3XPKs4pNVZe3eSTQQWtcJn7hew+565yEjOX55IgCItDucM0kKJcNIKcZ7mXbLPXPySB2
	LE2RmbK+CU61txAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/ds: Add PEBS format 6
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241216204505.748363-1-kan.liang@linux.intel.com>
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503360436.399.14871621667134693686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b8c3a2502a205321fe66c356f4b70cabd8e1a5fc
Gitweb:        https://git.kernel.org/tip/b8c3a2502a205321fe66c356f4b70cabd8e1a5fc
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 16 Dec 2024 12:45:02 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:23 +01:00

perf/x86/intel/ds: Add PEBS format 6

The only difference between 5 and 6 is the new counters snapshotting
group, without the following counters snapshotting enabling patches,
it's impossible to utilize the feature in a PEBS record. It's safe to
share the same code path with format 5.

Add format 6, so the end user can at least utilize the legacy PEBS
features.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241216204505.748363-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1a4b326..6ba6549 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2517,6 +2517,7 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 6:
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;

