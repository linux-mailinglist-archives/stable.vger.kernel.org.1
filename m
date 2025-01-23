Return-Path: <stable+bounces-110251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB5A19F5E
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 08:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F2718898AD
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49920B20C;
	Thu, 23 Jan 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="Q2+H56GR"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D11C5D5F
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618563; cv=none; b=gS2VNImyrMPdvcACcQ09YJJKnre/bopf/189WxQcU+Pgqt8ojY/DEh0VcdjFJbHAxjl7sjsTohcrB4E3VxTq4uc1d8cp1V1YMLnY9qYsrkarbuTbcEfZ3mcifFLD02+hOxkWRYh1QTdSqz3nW8yMomJAdgWtTJMNXTNz7tXg2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618563; c=relaxed/simple;
	bh=6CG/TKEr2oDmFKaIdYlqeQFBmB7uUXar0oDK9aaugA4=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=LjIb/AsyOL3DOYs93QpTUtAejgNIOaBkodePUtVdEMxboHM+RGg/UvVqAUyKS3drXDYhYw0ic2nNIgb4D6T3WXRK3VuywfL9xH2kBjFHAiTd3PRdsTy/ODPd/r2f3XWEmuU2oFTc+Cs1zJcf/pSK0twyztX3sJlPD2/B6C0yLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=Q2+H56GR; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737618559; x=1738223359;
	i=rajanikantha@engineer.com;
	bh=4d1V1vy+pXeaTeoztbWCDGutAzhTHQydkSTL1xY4Vxs=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q2+H56GRvgtCTQaiKJWNsmQqjGIlEbGhaPne/1B9OjtSHH8c6PxYemIFTe1iCmtL
	 ZtAt4KMMk3k1VivLZNj15ZQ8muau5Fp0QUmI9fOHHP2MhOvdcXrMjLCaw+PEfD8+y
	 ivoImg5dcn2/yDvoDCM4K1zzKXKPfI5g/nFBXI7w8yUdFNEkWamqUAUg9Ezn3ih6n
	 sAX4+7f5SjjbwKcjB7a9zdmZYWiKzF1MyLhVaAuiayXwqZRHOIf/wmI4PKmDsJsK7
	 hvpXZcJYBh9UjuzYQd3Nbjsxi/ioN6kg3AbNa89pHiE81o327fw8NLv7TUW6rwOMi
	 vP2DFsUVMQGQHTbAcw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa14.server.lan [10.76.45.15]) (via HTTP); Thu, 23 Jan
 2025 08:49:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-4ae0c36c-d1ea-4a58-b4f1-1758e1ef242f-1737618558957@3c-app-mailcom-lxa14>
From: Rajani kantha <rajanikantha@engineer.com>
To: abelova@astralinux.ru, perry.yuan@amd.com, viresh.kumar@linaro.org,
 stable@vger.kernel.org
Subject: [PATCH 6.6.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's
 return value
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jan 2025 08:49:18 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:op1QPqt0UL9HZB3QdIGVSTyC1ghd5Rgi9FDOqtKSlSKjPuv3H2o+K5Bgzm5k1KcN7jyaY
 +RtWDrnVXeTwb9pti5mD8Aug4umUCzkGOzAfsGsn2TGAAICWKeydXyok8xQn4+xu28Jwr0Duj5Rb
 Z1vceBEuxt1J1QXbGzSYKCcSDpAb6B5wqkMTmH7z5JUqxEnBjSDkg++viYoxH0LQv7ZasH4oB+Cy
 2FupaRkRlW4FDZrVtBZDb/gz5pPjbuUSRSbm86S8AMn18+XsPlqKgml9fDJ1T5J6KySsjyBbQLvJ
 8c=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5sT6c0DSLjA=;qeIjU8RcUsE+rXzny24RtD5DLpA
 IknPIZHfBrubj/QljvUjjgMs0g+aWu/0MqxTJ31IWvWxSfJfTjwNhlo8+TvfBMdk/i3oxAHmx
 GfaiOpCqd96Ngkto+dfYLO11dEuELG3GLjok16N9gAw69Gg//3xh0w1Wn2WZp15SCm5r++Mia
 x3tn4NdzWj9/B58QWJOGDXUujFc80G82+eb8wAWQjC0NB7pJBe0ox7ALe0tcIhnMT+CfP2hs0
 Yih9x3dvkcGd5KFJysTLVTDEr7eWcliLu2rZuoio1y+X/T04L8S8A1CCtlxyPoV+oJbJtQP9A
 B3+0KiGa4LuAo1xOy5HBBhnbaw4mV1U4MgGc06JM0JxItxZ3JoUr3MQrJmg32PC52duEBOr8G
 ZQ9K+xDUoUWXWRa1eS+5VE+UrfqzGtX07EjMf+M27hLxk5i0XNkf1kJgsH5YIAzjUApYE8EjW
 kFq7eBJX9p2SMMyyBPjpS/YY6vxD1rYjbpgnaZoOu8oFgRvZyg5VMILlrWng8tMKht32K30TA
 1dvaBQGa7XLpebKmnHkCLkdq9BIs169bMwat+0tsW8gAKISJPcFcAxxtVCMSoVe/50miSaOtR
 NPdoR4NVNcdtY1Ttsl3GfGq8rhbq/NRVnhUA0T39J3wkOisG82/ahabbFiYnC5a/lh+9RrC82
 Q1j7W2DQ6XcmYa+G18eJwYhK5RefwrMJKlc7K4RNpuu82u/1zR41qSG2c3nqgqI7o1yyJugaJ
 k0Qz1HzzxFvR5nLiTAtFTvYNTGWZRnZOFUFv1T0cm96Uf8ILmAzjPdeArhly3VT1Nmp9aUtJv
 ebiD5Q0T6nMwqKaJcD412+jb2EMSrn8HDQtgGUwmG6vx97U/9ki3H2sM2Z1gxswll0OroD0VU
 YtTNefz6BCmL/vzz/dbTe13h00L0rSE/15Um4WmaV8sxXC8iA7cOYeRWQTl9vRsigdZb6Q0ZA
 +gcFoPLMqgmW9JEctZMg93kvdGrQfrRAKRKwvJKvzz3oqfZzOTtpDDJbdR3EuvOjnCyVvQcJ1
 ChHUO1L20gEkVeq/l4=
Content-Transfer-Encoding: quoted-printable

From: Anastasia Belova <abelova@astralinux.ru>

[ upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
<Raj: on 6.6, there don't have function amd_pstate_update_limits()
so applied the NULL checking in amd_pstate_adjust_perf() only>
Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
=2D--
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cdead37d0823..a64baa97e358 100644
=2D-- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -579,8 +579,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata =3D policy->driver_data;
 	unsigned int target_freq;
+	struct amd_cpudata *cpudata;
+
+	if (!policy)
+		return;
+
+	cpudata =3D policy->driver_data;

 	if (policy->min !=3D cpudata->min_limit_freq || policy->max !=3D cpudata=
->max_limit_freq)
 		amd_pstate_update_min_max_limit(policy);
=2D-
2.35.3


