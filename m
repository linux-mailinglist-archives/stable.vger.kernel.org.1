Return-Path: <stable+bounces-58732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA992B889
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AC282D54
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AF0158873;
	Tue,  9 Jul 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpSSZhSE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WQJVZ+mj"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF8158211;
	Tue,  9 Jul 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525319; cv=none; b=WHNJxqujc3Ev/26WTUVPS3isV86f7hSzX26zsbEKeJflPATB/t4sv0Vt/8Q51geF3Qy5OUw/eShe2u0W4MUIH8aWxzz9HuxCfWvbkD9Zq4cpeLbgE+oTn2I2sevw1o7oLG9cGf040OGq9I3M3sBd/XCyhjopf6jtx6qV2ZEuKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525319; c=relaxed/simple;
	bh=YejHAEyfWwUy7ebTIwYX/yjo1ug4wKVxeyFPHo9Ufi8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LjGvYjr/cxE90LH2z/4PY819ped68tGjCP5Sf+YDgJLNJ+r2nNLR0XAgnMRmuaMjQLxpoBgs1VBQx/dnKxktISbAu/b4zs5Vf0keRQH+bCunpUaFkh+2umALYmrfds89Z+2oJPMcSV+bq61UjOlFsJJcqrvUxmjiYOlDUh4zPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpSSZhSE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WQJVZ+mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTMRAP+SoR+F/a74sYNJVLyTjMu5zts1YDpvjCyCKo8=;
	b=zpSSZhSE/vrm4xa8lArRhCdUxqBFUYhaZ8HB/oggvA3YAWl3gvoThQbf/SJUwgM78QPHlN
	aS7t58h5DuF5WUVVNcZBuYKuP2yaHs8/WB87U+ECDEtr6Z1iV1/8M0phJedpIr+hVXwMJ6
	yZ/7ptKL0Q4OP8FP6Jeq7PywvBffsVflmceDwCFyHEPW7gI7s3DSAf5qn79JoZ826/ty7P
	/634ybQbce2Au4ZeTmuuP4lsV4VMKhqE0iKS9o6744yR8PSijRWBt+yF6//R4QsIKPnavW
	zlblSSl4tq+Q0OyzFzzAjtAT5Nw54RwpY3FsoamsN4XispfoBlGtrcF34jCOcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTMRAP+SoR+F/a74sYNJVLyTjMu5zts1YDpvjCyCKo8=;
	b=WQJVZ+mj4FmwU2zGTfyzOC9+x0EDjk9VImP+gsEGi81puEv2fIZR0dA3mYbvcBEWZ3ytOR
	988929arUwb7j6Cw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake
Cc: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240708193336.1192217-4-kan.liang@linux.intel.com>
References: <20240708193336.1192217-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531604.2215.3507740369226432766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e5f32ad56b22ebe384a6e7ddad6e9520c5495563
Gitweb:        https://git.kernel.org/tip/e5f32ad56b22ebe384a6e7ddad6e9520c54=
95563
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 08 Jul 2024 12:33:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:39 +02:00

perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake

A non-0 retire latency can be observed on a Raptorlake which doesn't
support the retire latency feature.
By design, the retire latency shares the PERF_SAMPLE_WEIGHT_STRUCT
sample type with other types of latency. That could avoid adding too
many different sample types to support all kinds of latency. For the
machine which doesn't support some kind of latency, 0 should be
returned.

Perf doesn=E2=80=99t clear/init all the fields of a sample data for the sake
of performance. It expects the later perf_{prepare,output}_sample() to
update the uninitialized field. However, the current implementation
doesn't touch the field of the retire latency if the feature is not
supported. The memory garbage is dumped into the perf data.

Clear the retire latency if the feature is not supported.

Fixes: c87a31093c70 ("perf/x86: Support Retire Latency")
Reported-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240708193336.1192217-4-kan.liang@linux.inte=
l.com
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b9cc520..fa5ea65 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1944,8 +1944,12 @@ static void setup_pebs_adaptive_sample_data(struct per=
f_event *event,
 	set_linear_ip(regs, basic->ip);
 	regs->flags =3D PERF_EFLAGS_EXACT;
=20
-	if ((sample_type & PERF_SAMPLE_WEIGHT_STRUCT) && (x86_pmu.flags & PMU_FL_RE=
TIRE_LATENCY))
-		data->weight.var3_w =3D format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_L=
ATENCY_MASK;
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
+			data->weight.var3_w =3D format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_=
LATENCY_MASK;
+		else
+			data->weight.var3_w =3D 0;
+	}
=20
 	/*
 	 * The record for MEMINFO is in front of GP

