Return-Path: <stable+bounces-200449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C704CAF6EF
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 10:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1873F305935D
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9902D94B7;
	Tue,  9 Dec 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPTJy2fY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dr8odZGO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BA1991CB;
	Tue,  9 Dec 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272218; cv=none; b=rfAFPRpoPIbIrZkQoYyYX6oA0haD8S3kM5y3g53QvrcghOa8iWujXq9TB3oaX7/19AM2xgfLHGes8M7/QstyqPdlsGm3HVOODOuJH6gFjZsrcz4khD35uyVj6eVDlgmFJaIb4z+AkjxxYaUvwJ7aSpt1LZsTmSWnYgSqlZEYPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272218; c=relaxed/simple;
	bh=fvOMNXln6sh95au/jnm99zy56lkTv+1tRPphobcPaus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UK8ltzIS553FIcgNSm0xhUDAzGmRXllywA9Xmu9FToKLYg7C+O8xy0UPEFnKnnQMfT+3W898A75IOHX/wMTgLWCKsjXHtJuxiChaAvJ1vK8XtzCti2Btu1xRNm9mOy46sXAijjX3QkdQDW3rqo3EUrv8M37sBjJ+/XkJaJR8OdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPTJy2fY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dr8odZGO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Dec 2025 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765272214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Fn01UKZi0QD9EeBSCONAPyyxraw4sfRQXaoZXC5g24=;
	b=pPTJy2fYceIVjy+RaK2hw9Eolwk4t2VtCfBCA1/zmn9kg/Dpe1sGp0iKxEBdQbrZVSacNV
	50dqnQjPGq85BAcv42zzKqsVpU0gtsZM5MM/q15tjRWkCMYnaOwzRRvV0kjSkKwVWpE1zs
	EooGbeyqJbEHFiIBlc8uJvzmrZEBqWKrPV4moRoX7hv9WcVHNDJIFlPJfzTq6f1MwdLzm4
	1T1O6I5mRDzJ0JW8BY8nYYxy0JuSqF/GOnLco7NIceOSOEomCIX1rEjH4Ywn1k8QpgJeBA
	g539nlcUmEgHGPbwM3mLjgWmiQCnQwwNm6cu1oPBxUXwlKjjfeGHiTTq2oy/Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765272214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Fn01UKZi0QD9EeBSCONAPyyxraw4sfRQXaoZXC5g24=;
	b=Dr8odZGOULxvkKSrP+r9tAEskXxEHj8rrwOi12ndC+tFBid7cyYfvKmOrNV6DenzSfMZwD
	GVCpl6lEcLYMLEDg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/uncore: Fix the return value of
 amd_uncore_df_event_init() on error
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C076935e23a70335d33bd6e23308b75ae0ad35ba2=2E1765268?=
 =?utf-8?q?667=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C076935e23a70335d33bd6e23308b75ae0ad35ba2=2E17652686?=
 =?utf-8?q?67=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176527221342.498.2501811009995506184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3ce7078debf267e12aab93528b40ba6c373bfa52
Gitweb:        https://git.kernel.org/tip/3ce7078debf267e12aab93528b40ba6c373=
bfa52
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Tue, 09 Dec 2025 13:56:38 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Dec 2025 09:59:14 +01:00

perf/x86/amd/uncore: Fix the return value of amd_uncore_df_event_init() on er=
ror

If amd_uncore_event_init() fails, return an error irrespective of the
pmu_version. Setting hwc->config should be safe even if there is an
error so use this opportunity to simplify the code.

Closes: https://lore.kernel.org/all/aTaI0ci3vZ44lmBn@stanley.mountain/

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/076935e23a70335d33bd6e23308b75ae0ad35ba2.17652=
68667.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e8b6af1..9293ce5 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -656,14 +656,11 @@ static int amd_uncore_df_event_init(struct perf_event *=
event)
 	struct hw_perf_event *hwc =3D &event->hw;
 	int ret =3D amd_uncore_event_init(event);
=20
-	if (ret || pmu_version < 2)
-		return ret;
-
 	hwc->config =3D event->attr.config &
 		      (pmu_version >=3D 2 ? AMD64_PERFMON_V2_RAW_EVENT_MASK_NB :
 					  AMD64_RAW_EVENT_MASK_NB);
=20
-	return 0;
+	return ret;
 }
=20
 static int amd_uncore_df_add(struct perf_event *event, int flags)

