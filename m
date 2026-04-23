Return-Path: <stable+bounces-240446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD3qLtfh6WmTmQIAu9opvQ
	(envelope-from <stable+bounces-240446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:09:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6689944F0EE
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC9A306A83C
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8E3E1D1A;
	Thu, 23 Apr 2026 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gy9/2w/B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E33E123F;
	Thu, 23 Apr 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776935155; cv=none; b=We/A7f5X+8jKmD5UFeOG5tkZV62laO+swO1bUh2VJiLdiUTdet/jJKX68rfp3tpHKEva3ZQXpTR+ECScG0mV/8UhO2LwcByR/TKk+77OgcLwkR+UGtn36+AOT5D7TlVwb6DXEKc8DzLhaVlHIR4y5jyUETPvnN/YSCutlpndIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776935155; c=relaxed/simple;
	bh=2bAtGdzn7v+8fXbEOVa1SYsIckCBQdDDets3ZG2mSSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1kWdh6Ld439XOdRt7qAzaJ4ljLhJiPXTytaQSFN29hYGzR14J0Jwaeo9aPok9sZhNXivoZzPbFGixuZx8eKiO9kX0G67O/0qIWiapc7l08WZmDsLtsyynaZ1XuLEbtSbv7hcPTCjmTXAxv8sGJnrRtuWk8CSQI6UYoEyx+ByP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gy9/2w/B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776935153; x=1808471153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2bAtGdzn7v+8fXbEOVa1SYsIckCBQdDDets3ZG2mSSA=;
  b=Gy9/2w/BpNn/mayiKzD5Db6duhRikJ+ldnjEORQlkiJ0aG/hxNAlf9YY
   yy1/Y6IQGpjbnoL1iqWzFINS5/JNBmZ+rt8yzGiSi2MmUmgjQnVMHmZ2A
   QUz7pjSskXwQvWwuXNJEeggF6VrgUv2xDi3oSUqF9fI3oftA3pAz0z/R2
   M5XVgAytYYNLy4pN9XS4TG+/VDbvdlqNXZB7e4k1dUjxe0rl/fhtTB7dP
   A7SFQbjAEHqe1m61fSrDjWit+toQ6l2VVW+wYfLx+wKxVSj4Loa1GkQHl
   B1+F8rPsfIDP6aZaputjnalveiE+VElMs6Nxh6qX2At6zcXqAazrSXVS1
   w==;
X-CSE-ConnectionGUID: +vGoT5eGRlq4GPMXHBFUNg==
X-CSE-MsgGUID: SbbgZWAXRqyJ+Y69ifuDtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77065306"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77065306"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 02:05:51 -0700
X-CSE-ConnectionGUID: 0ISce5F6Q0+zZoUlNsqZ+Q==
X-CSE-MsgGUID: w5bLXO5ASv2WHP2wswNxRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="232445980"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 02:05:44 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: tj@kernel.org
Cc: dmaluka@chromium.org,
	kunwu.chan@linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	rcu@vger.kernel.org,
	seanjc@google.com,
	sonam.sanju@intel.com,
	stable@vger.kernel.org,
	vineeth@bitbyteword.org
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu out of resampler_lock
Date: Thu, 23 Apr 2026 14:31:00 +0530
Message-Id: <20260423090100.3231633-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aefAWGcAQHeRYbs8@slm.duckdns.org>
References: <aefAWGcAQHeRYbs8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 6689944F0EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Tejun,=0D
=0D
Thank you for the detailed analysis.=0D
=0D
On Wed, Apr 23, 2026, Tejun Heo wrote:=0D
> The problem with this theory is that this kworker, while preempted, is st=
ill=0D
> runnable and should be dispatched to its CPU once it becomes available=0D
> again. Workqueue doesn't care whether the task gets preempted or when it=
=0D
> gets the CPU back. It only cares about whether the task enters blocking=0D
> state (!runnable). A task which is preempted, even on the way to blocking=
,=0D
> still is runnable and should get put back on the CPU by the scheduler.=0D
>=0D
> If you can take a crashdump of the deadlocked state, can you see whether =
the=0D
> task is still on the scheduler's runqueue?=0D
=0D
I instrumented show_one_worker_pool() to dump scheduler state for each busy=
 worker =0D
when the pool has been hung for >30 seconds.=0D
=0D
All workers show on_rq=3D0.=0D
=0D
=3D=3D Pool state =3D=3D=0D
=0D
  pool 2: cpus=3D0 node=3D0 flags=3D0x0 nice=3D0 hung=3D47s=0D
  workers=3D13 nr_running=3D1 nr_idle=3D7=0D
=0D
=3D=3D Per-worker scheduler state (first dump at t=3D62.5s) =3D=3D=0D
=0D
  PID  | state | on_rq | se.on_rq | sched_delayed | sleeping | blocked_on=0D
  -----|-------|-------|----------|---------------|----------|-------------=
------=0D
  4819 | 0x2   | 0     | 0        | 0             | 1        | ffff95360820=
5210 type=3D1=0D
  4823 | 0x2   | 0     | 0        | 0             | 1        | ffff95360820=
5210 type=3D1=0D
  4818 | 0x2   | 0     | 0        | 0             | 0        | ffff95360820=
5210 type=3D1=0D
  11   | 0x2   | 0     | 0        | 0             | 1        | ffff95360820=
5210 type=3D1=0D
  9    | 0x2   | 0     | 0        | 0             | 1        | ffff95360820=
5210 type=3D1=0D
  4814 | 0x2   | 0     | 0        | 0             | 1        | (mutex holde=
r)=0D
=0D
=0D
All 6 workers are in kvm-irqfd-cleanup, calling irqfd_shutdown =E2=86=92=0D
irqfd_resampler_shutdown. They contend on the same resampler->lock=0D
mutex (ffff953608205210).=0D
=0D
Full logs: https://gist.github.com/sonam-sanju/08042878542b7a58d2818e607655=
4211=0D
=0D
Thanks,=0D
Sonam=0D

