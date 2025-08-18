Return-Path: <stable+bounces-170154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB956B2A28E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48233A9E91
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B731B129;
	Mon, 18 Aug 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLGtgr/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EA1E51FE;
	Mon, 18 Aug 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521702; cv=none; b=VLRQEvuyc6WpCKrRhxiixBv2ZxDBzeBYR1vemRM5/CzPxHqQMvtAmPbLNjDRFJfxNk80VuBO18GbLx+O9JdCZKX3veYbo2jLb+IVSmEOGj9ZoQvBtWMNjs8/oOwtKF0CNPZYyEoqLcmqmHuqioE3ICVD27SV7pdbRNqurmfMnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521702; c=relaxed/simple;
	bh=PnWdPjZR76sYsuBedlmCJjRCTkk50Emb+GyARMF3kdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMhpubNMtpgQDse5l4WfMbfahrFWm8ALrE8LswlTL7B2G1bkrEJLyPxyF7hnsSc5dNaHbsylrRXZmJbQ6dlBB8en/AJvwuEgMJIO0AXDCmrBcl2YOWyadK/XfMjpSGYC1+lZLokypQxU+2centepWjf4g/RfbzEfsZw4H3BDi8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLGtgr/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C39C4CEEB;
	Mon, 18 Aug 2025 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521702;
	bh=PnWdPjZR76sYsuBedlmCJjRCTkk50Emb+GyARMF3kdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xLGtgr/6DsHYrmaWkwbthqsY0omIfZV/Oo8VWd9exySgFszPq7unUMxYehB1rXVBq
	 C4NKYw5jSIqQAoYE8Dk7ROSBOI1MxzcQ+Qw5UZNNFYjZtGKuBGLTl7DV5I3GfuwdDU
	 +GDdKCIAW1oNOKgLIdt+xC4pQZlRo97DJjk/UhWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Prashant Malani <pmalani@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 097/444] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
Date: Mon, 18 Aug 2025 14:42:03 +0200
Message-ID: <20250818124452.580267014@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashant Malani <pmalani@google.com>

[ Upstream commit 0a1416a49e63c320f6e6c1c8d07e1b58c0d4a3f3 ]

AMU counters on certain CPPC-based platforms tend to yield inaccurate
delivered performance measurements on systems that are idle/mostly idle.
This results in an inaccurate frequency being stored by cpufreq in its
policy structure when the CPU is brought online. [1]

Consequently, if the userspace governor tries to set the frequency to a
new value, there is a possibility that it would be the erroneous value
stored earlier. In such a scenario, cpufreq would assume that the
requested frequency has already been set and return early, resulting in
the correct/new frequency request never making it to the hardware.

Since the operating frequency is liable to this sort of inconsistency,
mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
invoked when a target frequency update is requested.

Link: https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/ [1]
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://patch.msgid.link/20250722055611.130574-2-pmalani@google.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 36ea181260c7..8d5279c21e6c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -841,7 +841,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.39.5




