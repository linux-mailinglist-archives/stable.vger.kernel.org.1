Return-Path: <stable+bounces-64560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AA941E6D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8661F25630
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B0183CD5;
	Tue, 30 Jul 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmNnhWkx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0021A76D4;
	Tue, 30 Jul 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360524; cv=none; b=k3ERRw9Og592l0zAh72Eu4FKF+jpZzGlNZsfMgCxn3qruEwNGrib2SX0eyPMeRp0aCjBXIJ4VPFQJPCAN7bP0Db6SoR6HEqNFx4f8fRK9UAZv//8X0L/VaO5DA4250Kiav0rPMEFpEcBIRKUFSI1GuJgNnBcYN/fgGppWm7FKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360524; c=relaxed/simple;
	bh=eABcc7yxUxdgDALPKXJxwCIhIBps6btS4zPWfZCgVWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kf+L77EhNGawtThuq8mPIahJYk1ynvPTA1hIS0i1WqtvEcry3EncAhqlwmLRh3s8WvVUJj3FsI1JjFvP2lOezUlQqf5xkxkUYOY5fLg3Fl4UbRzKY8VMqyht/3N/u/c5oNwUzDp05YOHGhaslQ6ItWAytHVQ7uAd3rzQejfV21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmNnhWkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCCBC4AF0C;
	Tue, 30 Jul 2024 17:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360524;
	bh=eABcc7yxUxdgDALPKXJxwCIhIBps6btS4zPWfZCgVWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SmNnhWkxjw6TcFA8OB4apZSuNqxcgoHPbgHFBq5LUxYIGsgvs/PB4G3YHYqLxH/d4
	 ZpM5ujxe0hLkutFlfUZS8cfKA/yR47yI1FZJcvc4poQG+/SA19z2JPsGHsZE6T8l73
	 kpd5RuNBsVQOkRSwHGC2pGtEYlcjj1oWAmiez0Y0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.10 695/809] perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake
Date: Tue, 30 Jul 2024 17:49:31 +0200
Message-ID: <20240730151752.367638512@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit e5f32ad56b22ebe384a6e7ddad6e9520c5495563 upstream.

A non-0 retire latency can be observed on a Raptorlake which doesn't
support the retire latency feature.
By design, the retire latency shares the PERF_SAMPLE_WEIGHT_STRUCT
sample type with other types of latency. That could avoid adding too
many different sample types to support all kinds of latency. For the
machine which doesn't support some kind of latency, 0 should be
returned.

Perf doesn’t clear/init all the fields of a sample data for the sake
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
Link: https://lkml.kernel.org/r/20240708193336.1192217-4-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/ds.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1831,8 +1831,12 @@ static void setup_pebs_adaptive_sample_d
 	set_linear_ip(regs, basic->ip);
 	regs->flags = PERF_EFLAGS_EXACT;
 
-	if ((sample_type & PERF_SAMPLE_WEIGHT_STRUCT) && (x86_pmu.flags & PMU_FL_RETIRE_LATENCY))
-		data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
+			data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+		else
+			data->weight.var3_w = 0;
+	}
 
 	/*
 	 * The record for MEMINFO is in front of GP



