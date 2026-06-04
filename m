Return-Path: <stable+bounces-260291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P2xBCWs1IWoUBAEAu9opvQ
	(envelope-from <stable+bounces-260291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:20:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D763DF53
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=HBXd5CG+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260291-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260291-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B00A300CB27
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0FE3DFC7D;
	Thu,  4 Jun 2026 08:20:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7B3DF018;
	Thu,  4 Jun 2026 08:20:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561255; cv=none; b=Q4Ykkk1xyLeIWopnWgIt5OIRiqiEGiFjWYLbzgiMWTRXXzPUEuFVlmgQihQmzFrH9Fva/5bNnhU0wbaMuAtITBFv4MixRR7vr3qv0cyFo7dxVE4k+ZJVxAv1AFOmJxFdNNyd2OF2KP6YwHqFVwWypm1XSv+zAwaYnJ9dF3eRcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561255; c=relaxed/simple;
	bh=xx4q8zA0SDvN+Zn0mJt/nZF2yaNi8H3ZSogpxfNtLDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxmrrBWyt13HEk2ybD/bqePQ/X8JGkUnUiZoJOrxyGt+gTdF1L8WYexop23KXSK3IAL81cAhHhIlx1fVHWJrDBoWDM4n1z4c2cJqsFZSmtPsEhlMKW98WHI8I/AkS1L5JlbEbytW6aAjPIA/KSnH9VcVJmGtHP63RAhrz4QpU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HBXd5CG+; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3D013297;
	Thu,  4 Jun 2026 01:20:45 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7FD3F7D8;
	Thu,  4 Jun 2026 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780561250; bh=xx4q8zA0SDvN+Zn0mJt/nZF2yaNi8H3ZSogpxfNtLDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBXd5CG+Kw6LL3Z4p7LfEbspjPtluKqFtPwlqSvB7gMo+FkOMRXEUzIzw8YIkodTH
	 5cfr6vGu5hfm2waGS4loALDrp8AsIwkxiZPthmIUwEjoK01BV2uy+NuQT4FHx7Zp2C
	 2NcAeygFzCwWLdxy4tNOTyHo+5qDb5CzLEAqoEHA=
Date: Thu, 4 Jun 2026 09:20:47 +0100
From: Leo Yan <leo.yan@arm.com>
To: Amir Ayupov <aaupov@meta.com>
Cc: James Clark <james.clark@linaro.org>, stable@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: stamp pid/tid/EL on each buffered packet to
 fix cross-pid attribution
Message-ID: <20260604082047.GL101133@e132581.arm.com>
References: <20260515021135.1729028-1-aaupov@meta.com>
 <f767dc3b-9796-4b12-a776-1de6a9ff3f99@linaro.org>
 <CAMOD+7+_HE3E+FFg6GPfG31GzVBzF1qhcQ=i-eiEgiGcn3WRvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOD+7+_HE3E+FFg6GPfG31GzVBzF1qhcQ=i-eiEgiGcn3WRvw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260291-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aaupov@meta.com,m:james.clark@linaro.org,m:stable@vger.kernel.org,m:suzuki.poulose@arm.com,m:mike.leach@arm.com,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:john.g.garry@oracle.com,m:will@kernel.org,m:coresight@lists.linaro.org,m:linux-arm-kernel@lists.infradead.org,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[arm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:from_mime,arm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 905D763DF53

Hi Amir,

On Wed, Jun 03, 2026 at 01:10:17PM -0700, Amir Ayupov wrote:
> Hi James,
> 
> Thank you for picking it up.
> 
> I tested the v2 patch series and it looks good. There was a minor
> difference in 2/39 tested perf data files: the number of brstack samples
> differs by one, however, there was no loss of binary profile. The resulting
> BOLT profile converted from the perf script output was identical, so I'm OK
> with v2 patch as-is.

Sorry jumping in as brstack is mentioned.

Now branch stack is maintained per-CPU wise, it mixes up branch stack
cross threads. The patch 03 in the series [1] refactors branch stack
per-thread by using common code.

Hope this can benefit a bit the profiling data quality and in case
you are interested in.

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20260526-b4-arm_cs_callchain_support_v1-v6-3-f9f49f53c9dd@arm.com/

