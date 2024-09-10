Return-Path: <stable+bounces-75357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D09D973423
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282D51F25BAD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A094A18C90B;
	Tue, 10 Sep 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G7ahuqns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F800186615;
	Tue, 10 Sep 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964496; cv=none; b=bvxmqAMdGUe+bTjTVEZNsnvH4IlZpboQz06IQQtYn8hyAmFltQJTWuquhEQLuUmUcioM3FpR0jKyhloL7Jy5YCz1Sa8xSv8JHZVYqYyEYiUkuz2QJgHPE28rkG5tOYvxzKD72t/QYCUAFsvXLkOfGQ6BnktGWsANwp/Tilw7uFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964496; c=relaxed/simple;
	bh=gSRjgsCvm8ORDIkSBTVBbzvWqkjKmcK1ImP/amZff+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXYIb0ddIxuz95sSxCDtNZ5Bti1QdQ1A4+qaSwE0kU90b09M09CtGbL7BeniTZrs4cAKoL1ybexAjTmqsGzHhLVC8t9uXKM8N0Sn4Xevn7ujKOMDBn1EclWlOrwzRoZfZSMr5NUFjdSgpBA3yoJzIr/oJ7bxoz5WYxNf1tyCBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G7ahuqns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9C9C4CEC3;
	Tue, 10 Sep 2024 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964496;
	bh=gSRjgsCvm8ORDIkSBTVBbzvWqkjKmcK1ImP/amZff+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7ahuqnsbB9hobfR9dITv1lePt5KZj6UKf+FouuBfQuy5VQKNQJlASXsV08S0ER18
	 BBL8I/734omvFhN94hSgRGG06CFlLcLsiS9xfosMF2crqJ9ovbvDizeJbv6b5xvNXe
	 /BVJGfW7P/mzfIHVaXtlyilSIsszJJE7H/CDJ+bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Gaha Bana <gahabana@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 202/269] cpufreq: amd-pstate: fix the highest frequency issue which limits performance
Date: Tue, 10 Sep 2024 11:33:09 +0200
Message-ID: <20240910092615.277134427@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Perry Yuan <perry.yuan@amd.com>

commit bf202e654bfa57fb8cf9d93d4c6855890b70b9c4 upstream.

To address the performance drop issue, an optimization has been
implemented. The incorrect highest performance value previously set by the
low-level power firmware for AMD CPUs with Family ID 0x19 and Model ID
ranging from 0x70 to 0x7F series has been identified as the cause.

To resolve this, a check has been implemented to accurately determine the
CPU family and model ID. The correct highest performance value is now set
and the performance drop caused by the incorrect highest performance value
are eliminated.

Before the fix, the highest frequency was set to 4200MHz, now it is set
to 4971MHz which is correct.

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ   MINMHZ       MHZ
  0    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  1    0      0    0 0:0:0:0          yes 4971.0000 400.0000  400.0000
  2    0      0    1 1:1:1:0          yes 4971.0000 400.0000 4865.8140
  3    0      0    1 1:1:1:0          yes 4971.0000 400.0000  400.0000

Fixes: f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218759
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Gaha Bana <gahabana@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -50,7 +50,8 @@
 
 #define AMD_PSTATE_TRANSITION_LATENCY	20000
 #define AMD_PSTATE_TRANSITION_DELAY	1000
-#define AMD_PSTATE_PREFCORE_THRESHOLD	166
+#define CPPC_HIGHEST_PERF_PERFORMANCE	196
+#define CPPC_HIGHEST_PERF_DEFAULT	166
 
 /*
  * TODO: We need more time to fine tune processors with shared memory solution
@@ -313,6 +314,21 @@ static inline int amd_pstate_enable(bool
 	return static_call(amd_pstate_enable)(enable);
 }
 
+static u32 amd_pstate_highest_perf_set(struct amd_cpudata *cpudata)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	/*
+	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
+	 * the highest performance level is set to 196.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218759
+	 */
+	if (c->x86 == 0x19 && (c->x86_model >= 0x70 && c->x86_model <= 0x7f))
+		return CPPC_HIGHEST_PERF_PERFORMANCE;
+
+	return CPPC_HIGHEST_PERF_DEFAULT;
+}
+
 static int pstate_init_perf(struct amd_cpudata *cpudata)
 {
 	u64 cap1;
@@ -329,7 +345,7 @@ static int pstate_init_perf(struct amd_c
 	 * the default max perf.
 	 */
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
@@ -352,7 +368,7 @@ static int cppc_init_perf(struct amd_cpu
 		return ret;
 
 	if (cpudata->hw_prefcore)
-		highest_perf = AMD_PSTATE_PREFCORE_THRESHOLD;
+		highest_perf = amd_pstate_highest_perf_set(cpudata);
 	else
 		highest_perf = cppc_perf.highest_perf;
 



