Return-Path: <stable+bounces-195429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2361EC76986
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 00:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B160A2BB51
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0283093C6;
	Thu, 20 Nov 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOz75Qbf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7A30146D;
	Thu, 20 Nov 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763681195; cv=none; b=EvEoXcXd1/0Bp7mlX/JWWaPrOJF+RjYOv35GwAJXCEaTwswA/kOau8Iid8Twi+XtcTcYZEcbscWbgVqKwFmJh9ebiP/VBvRRTBbVSxbuHHKkfNmNyAcxl5NiYDEDTIonxc9iWWLHkkij60faFZsqOcydoo7lug1JF2IdYy7Vhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763681195; c=relaxed/simple;
	bh=IzzXrKpnxD77S92ynC5y2Koa1yDERlcqMfRIHt5aWrc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hHuC+x5fNUD4ujWpoovLVICiHieL55Z8y0MLLsUgWpDK5kipP2IkmZ3aEppHDzzX8dINzaAZu8gBHtuKyNwpi/0iTzS5Dn33U5oEVO1iv3WGOtLL31E48xkjH2Fmzsl/SJ+dyNuDkau5bFrUO8NCW0562RApAg6NTVgP0JslzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOz75Qbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D30C19421;
	Thu, 20 Nov 2025 23:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763681195;
	bh=IzzXrKpnxD77S92ynC5y2Koa1yDERlcqMfRIHt5aWrc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=JOz75QbfYPf1lLjECkzgIr3HvHniReLyUTIUP5He64TV2YGPX9xIRFTHZBzxGLY0p
	 CcIdrx2aYZXNwyH/qYTBBSkIUYrG1yEa47m4nP7Hohgz5jWIrQi1glDbicRL6bFaYo
	 3Nr2fpyc54YfZcECsJwBteFbbupy5Lhg2MqGSd+4nBL+Qm3F0eJkAebG1XB482dVNu
	 uUl3Kj6lUw0DyeRpkqJYs1yjXO2CiDmBf90bPhivcEClB4yIU6mIABXBq88DJZuM2E
	 LUO8zc8QC63730pkf30oSUE78gJe7NhYCPgHRvQKExXvav7ysn+zDqpWqIqJmQIuVt
	 bQEgQsCnwFOqA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vME3Q-000000041sC-0NxX;
	Thu, 20 Nov 2025 18:27:08 -0500
Message-ID: <20251120232707.946976394@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 20 Nov 2025 18:23:27 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Wander Lairson Costa <wander@redhat.com>
Subject: [for-next][PATCH 04/16] rtla/timerlat_bpf: Stop tracing on user latency
References: <20251120232323.271532418@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

rtla-timerlat allows a *thread* latency threshold to be set via the
-T/--thread option. However, the timerlat tracer calls this *total*
latency (stop_tracing_total_us), and stops tracing also when the
return-to-user latency is over the threshold.

Change the behavior of the timerlat BPF program to reflect what the
timerlat tracer is doing, to avoid discrepancy between stopping
collecting data in the BPF program and stopping tracing in the timerlat
tracer.

Cc: stable@vger.kernel.org
Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/r/20251006143100.137255-1-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index 084cd10c21fc..e2265b5d6491 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -148,6 +148,9 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 	} else {
 		update_main_hist(&hist_user, bucket);
 		update_summary(&summary_user, latency, bucket);
+
+		if (thread_threshold != 0 && latency_us >= thread_threshold)
+			set_stop_tracing();
 	}
 
 	return 0;
-- 
2.51.0



