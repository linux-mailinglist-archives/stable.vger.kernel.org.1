Return-Path: <stable+bounces-88120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4309AF738
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 04:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA042831FB
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 02:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A4126F1E;
	Fri, 25 Oct 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="sUk+l++E"
X-Original-To: stable@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA560B8A
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729821992; cv=none; b=HbjgxyRbgOyQeH6vKpBRmC6MOHg4ByshDtUxepvWHxA0yEfakZwQdn9GLpjxLQtS3gVbgDnHXGGYRuL1QLcU2LYxVsbMxBgeGR5T1an77FeeCa2GFGkp7LfNRZiN/BUvNbJPPw6CZOrfBrXRUqlXnaMpk1InpQiyRMlEGW0G/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729821992; c=relaxed/simple;
	bh=LunmIuAnPq7QF0SzClujVcqEV/4cCWIZWKfohSopQKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHNDtVxs8HN9NJeWkLStJkIE5cZrdMrBsc15lCtA0dAbBvInUVEyS5Tb4LeQGojfwJLiS0t/CcaGllOzwFyDh/PFZN5wgxVQIqjblC3ojbqntO8lnPKv9UH4B/43j6Mm1Pq9JRgTAGaQ9kPNeWLaJFW1qZ1PuCh3Faw9QUiFlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=sUk+l++E; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1729821991; x=1732413991;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=sG1Yryr+TvaRXkwfHKmKt1Ybr9AWJCFXmYqCUrNs4rM=;
	b=sUk+l++E2IAjfMOrDf8hMm21bH+FpK7B13dMlOsfFUjhAFYx5RF8yCA1YSswafiI9EBYiLHIVrPzqcul4P6MjDtIB1WcILx3BCi2SfWuSjgV8SetjLSF8dyTi8/fxy6dhtVBqbwIZr7uVqUQk32NqtLFDmrbSSxHncH5SIF3Orw=
X-Thread-Info: NDUwNC4xMi42OGZkZjAwMDAyZTM2ZWEuc3RhYmxlPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6bnVsbH0=
Received: from localhost.localdomain (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPS id A3AB02CE03FF;
	Thu, 24 Oct 2024 21:06:00 -0400 (EDT)
From: "Nabil S. Alramli" <dev@nalramli.com>
To: stable@vger.kernel.org
Cc: nalramli@fastly.com,
	jdamato@fastly.com,
	khubert@fastly.com,
	Perry.Yuan@amd.com,
	li.meng@amd.com,
	ray.huang@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nabil S. Alramli" <dev@nalramli.com>
Subject: [RFC PATCH 6.1.y 1/1] cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
Date: Thu, 24 Oct 2024 21:05:27 -0400
Message-Id: <20241025010527.491605-2-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20241025010527.491605-1-dev@nalramli.com>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241025010527.491605-1-dev@nalramli.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The CPU frequency cannot be boosted when using the amd_pstate driver in
passive or guided mode. This is fixed here.

The CPU frequency is dependent on a setting called highest_perf which is
the multiplier used to compute it. The highest_perf value comes from
cppc_init_perf when the driver is built-in and from pstate_init_perf when
it is a loaded module. Both of these calls have the following condition:

	highest_perf =3D amd_get_highest_perf();
	if (highest_perf > __cppc_highest_perf_)
		highest_perf =3D __cppc_highest_perf;

Where again __cppc_highest_perf is either the return from
cppc_get_perf_caps in the built-in case or AMD_CPPC_HIGHEST_PERF in the
module case. Both of these functions actually return the nominal value,
Whereas the call to amd_get_highest_perf returns the correct boost value,
so the condition tests true and highest_perf always ends up being the
nominal value, therefore never having the ability to boost CPU frequency.

Since amd_get_highest_perf already returns the boost value we should just
eliminate this check.

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Fixes: bedadcfb011f ("cpufreq: amd-pstate: Fix initial highest_perf value=
")
See-also: 1ec40a175a48 ("cpufreq: amd-pstate: Enable amd-pstate preferred=
 core support")
Cc: Perry.Yuan@amd.com
Cc: li.meng@amd.com
Cc: stable@vger.kernel.org # 6.1 - v6.6.50
---
 drivers/cpufreq/amd-pstate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 90dcf26f0973..c66086ae624a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -102,9 +102,7 @@ static int pstate_init_perf(struct amd_cpudata *cpuda=
ta)
 	 *
 	 * CPPC entry doesn't indicate the highest performance in some ASICs.
 	 */
-	highest_perf =3D amd_get_highest_perf();
-	if (highest_perf > AMD_CPPC_HIGHEST_PERF(cap1))
-		highest_perf =3D AMD_CPPC_HIGHEST_PERF(cap1);
+	highest_perf =3D max(amd_get_highest_perf(), AMD_CPPC_HIGHEST_PERF(cap1=
));
=20
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
=20
@@ -124,9 +122,7 @@ static int cppc_init_perf(struct amd_cpudata *cpudata=
)
 	if (ret)
 		return ret;
=20
-	highest_perf =3D amd_get_highest_perf();
-	if (highest_perf > cppc_perf.highest_perf)
-		highest_perf =3D cppc_perf.highest_perf;
+	highest_perf =3D max(amd_get_highest_perf(), cppc_perf.highest_perf);
=20
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
=20
--=20
2.35.1


