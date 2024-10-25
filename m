Return-Path: <stable+bounces-88119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564429AF736
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 04:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BCF2833C7
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F474879B;
	Fri, 25 Oct 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b="ViYL6C34"
X-Original-To: stable@vger.kernel.org
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0C136E37
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.0.186.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729821988; cv=none; b=PzLIQjTs7iV9mUFeWpfHz1Yivd/586oqxR74CeeA7LRrj7Qhk1MaWiEpWz9x7ioJrOIt6AAmakGPl6FARCB9fAz3/7aWZILrqNY0gsT8zM20/rdtHsJv+ZEaNVJGVwN6FTdgjO3cOKvaLikLkklGjgdTaGo8D9k+KU4JbPAEQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729821988; c=relaxed/simple;
	bh=NO9fmOs1GXCCcZ74pAbl6f5r+b/635OX5p3kSN9dM+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URlcvPQHfCJzreQOdo1cdlEgrxL6LZDNm1/paQXLjF6g0wVwQ0s4EEosf15IZqTc5AaKz9+729yq64JaNaNQmJm6uJofQtm3CIb68w42EkIx4xlhWPqeo6Pu7knbo3FCDlHq2Uv9PMX/g/2fJjvkIVrbwAznBWaHX297P3Zk2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com; spf=pass smtp.mailfrom=email-od.com; dkim=pass (1024-bit key) header.d=email-od.com header.i=@email-od.com header.b=ViYL6C34; arc=none smtp.client-ip=142.0.186.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nalramli.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email-od.com
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
	c=relaxed/relaxed; q=dns/txt; t=1729821986; x=1732413986;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
	bh=e/0/6KmLP8IDOZiXwbbz4hIq8Tt4TKaYWZ5giDxZMgs=;
	b=ViYL6C345GwqqMWu4tX0WwPdti+xNX9ONBiZqR2YDEncX9TqCZIf2OCnl3yRGN/97z+hVVRo21xit8JjriATJTlafMSJQUQUi64ObIeaqoEZC3zKQdsoBSOfnPbEpo6tG+43wMiOpPu01r4gpEaiM6csVzZkMgU5MxnRkE5gbyQ=
X-Thread-Info: NDUwNC4xMi42YjZkZDAwMDAyZWEyZjYuc3RhYmxlPXZnZXIua2VybmVsLm9yZw==
x-xsSpam: eyJTY29yZSI6MCwiRGV0YWlscyI6IltdIn0=
Received: from localhost.localdomain (d4-50-191-215.clv.wideopenwest.com [50.4.215.191])
	by nalramli.com (Postfix) with ESMTPS id F3BE82CE016E;
	Thu, 24 Oct 2024 21:05:58 -0400 (EDT)
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
Subject: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
Date: Thu, 24 Oct 2024 21:05:26 -0400
Message-Id: <20241025010527.491605-1-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Greetings,

This is a RFC for a maintenance patch to an issue in the amd_pstate drive=
r
where CPU frequency cannot be boosted in passive or guided modes. Without
this patch, AMD machines using stable kernels are unable to get their CPU
frequency boosted, which is a significant performance issue.

For example, on a host that has AMD EPYC 7662 64-Core processor without
this patch running at full CPU load:

$ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
  do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
  sort | uniq -c

    128 2.0 GHz

And with this patch:

$ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); =
\
  do ni=3D$(echo "scale=3D1; $i/1000000" | bc -l); echo "$ni GHz"; done |=
 \
  sort | uniq -c

    128 3.3 GHz

I am not sure what the correct process is for submitting patches which
affect only stable trees but not the current code base, and do not apply =
to
the current tree. As such, I am submitting this directly to stable@, but
please let me know if I should be submitting this elsewhere.

The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
amd-pstate: Fix initial highest_perf value"), and exists in stable kernel=
s
up until v6.6.51.

In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
Enable amd-pstate preferred core support"), was introduced which
significantly refactored the code. This commit cannot be ported back on i=
ts
own, and would require reviewing and cherry picking at least a few dozen =
of
commits in cpufreq, amd-pstate, ACPI, CPPC.

This means kernels v6.1 up until v6.6.51 are affected by this significant
performance issue, and cannot be easily remediated.

Thank you for your attention and I look forward to your response in regar=
ds
to what the best way to proceed is for getting this important performance
fix merged.

Best Regards,

Nabil S. Alramli (1):
  cpufreq: amd-pstate: Enable CPU boost in passive and guided modes

 drivers/cpufreq/amd-pstate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--=20
2.35.1


