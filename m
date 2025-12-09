Return-Path: <stable+bounces-200458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E847ACAFC17
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 12:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CB73010CCF
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44E306D4A;
	Tue,  9 Dec 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tpuv753l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f98ROZIR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B852800;
	Tue,  9 Dec 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279493; cv=none; b=YHpkHEKfrPop1/RJWjJMgQjx7QfHI5GRwio0J55v+YD9tGD6OWP6C092JIU6L6UUvVJqf9ZC5YK0hkwnkEo6BGEzpl05ftohUj4zECiAyn0Bm027Efnwj+qlCRdN4DthUv9G6YE0REvKuzjeELgOeLk84uZg+vUwLgeLGIAzTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279493; c=relaxed/simple;
	bh=iItUhqkXUDtIfBlc8FKCXi9ZH08tNEr14aUH8zHHsWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y9E3V5AGLRvUDqLoDBOYIL/pnKSPPLtLcFaYsqWeoP7lywX5l5IFIZeNXJEb6ymzxegHtM0OrTVDIHtlDRXynIpNPAWUTZZPFAjeaiomWjs9Vi2ZTJ25slaAede0XWZDIin7lDm+2M7uI/4Fr++Spbk1ANFiMJruh161Qh862rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tpuv753l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f98ROZIR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Dec 2025 11:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765279489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFT2VDPRVMANryn46TKwtBky95aV3GFWee/jIzS71gg=;
	b=tpuv753lhM10XpdLTlts9+upZoFIdhKU4kYdfEQ7BWtfs4Au10YrGx7RbdwtoFkMFFLDiv
	sJxkGLfG6ZhVB/Xf/bE9pCvMV0W2tGdK0yHkdAqpjzfdiVwghHwyO5AjtJi0fc0xou5bLv
	o19GmkoJFgs4BYKnaFJhRQLEpSk66bTqY141gpIpstVHGg1T7Ua8IjVjJQ9ge0CRfS1bta
	e33RwkTcm/rdqZ+42fsDxKYTXkw1fsEfBe8YMf1E4anqBYOa2qG4NkV2YE6WJcQCNVWEeJ
	W6PtCvOXHphu232R75jV9OO1YoUC6eb0xI8YERZCL1h41AjeEimRYxpKKjDFkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765279489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFT2VDPRVMANryn46TKwtBky95aV3GFWee/jIzS71gg=;
	b=f98ROZIRn1KlOir5P1a4/TCzVwPxMmWnqcpZCkttqzoc4AGOFN8OQHIX9VJpzfmHWCL/rh
	eRhNeHkacq38Z6Aw==
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
Message-ID: <176527948852.498.10792756287021428217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     01439286514ce9d13b8123f8ec3717d7135ff1d6
Gitweb:        https://git.kernel.org/tip/01439286514ce9d13b8123f8ec3717d7135=
ff1d6
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Tue, 09 Dec 2025 13:56:38 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Dec 2025 12:21:47 +01:00

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

