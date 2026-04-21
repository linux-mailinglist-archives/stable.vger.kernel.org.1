Return-Path: <stable+bounces-240037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIBPKXsI52lP3AEAu9opvQ
	(envelope-from <stable+bounces-240037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:17:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712143663B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A453014671
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 05:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6032C316;
	Tue, 21 Apr 2026 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uoh2EUB8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157228851C;
	Tue, 21 Apr 2026 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776748630; cv=none; b=Q4+hrqoe+mDy0+9tt7bmXFmCa+6saXwKM9IQTgFxdPj3GHnVDew+4kwnAnns2g6tF66p+FvVwE5tim0buBgVsleWAiycmhOUqxvivbOnTWqrhIeFPYn5NnT3BfdSdWp7yMtleUVeiqoflzYpiwSSiTfDmqXZL+dMapzJe77wOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776748630; c=relaxed/simple;
	bh=T6BDRmHTOU3X94CvZXEg2AiRhZ3yOz0XmWWh7XAKhi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/ZZBV9q1eQMge0BXNbt/BPhxJUpVHT9WXhLO/CTiUsP8B7obEh1l9GigaleeHtWBWKem9/JcEOAFTT4p897cVoC32s2iMrQtPDYjd31pn3WuWeD1na1yXT9OF/1/fhRP16+VsDoGi12C+S8zTxXUyUToG75Wr+aSmNsNatr4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uoh2EUB8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776748629; x=1808284629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T6BDRmHTOU3X94CvZXEg2AiRhZ3yOz0XmWWh7XAKhi8=;
  b=Uoh2EUB8iAh11TLPtsjjkHNaYPJ+eZw+sWK7v8yFIywo/jM+6J0c0jwU
   n4QeW2OaycwI6IP+lmOxSvPNZblq+lQR5TOD1JMB9pybVxDxYvdN2fsU0
   rTumivXEEtKenyomoYDKqO8/WeHGg4Ngfo3IaMw2SIgPNdGCLT93c17ub
   uIM8inBoqWmba5kmBlXMmV2jHXZh5ZSIGxZ8a+tRdtuL9MPNvUyPeAdOV
   HLXWhT8Ic8RXbadjNra7ZYLc/sM0soXM3S7MW1f8FKdppoxKzwqOgN05x
   2OlCmtUEDjPgTmZY15Bv4ryAb9kuwn65P7BTcPdZ8U2kWZ+nhYXyNQfi3
   w==;
X-CSE-ConnectionGUID: PUjZTcmnT+qUB6GsFnWyJA==
X-CSE-MsgGUID: DXBoSQgqTPmrfNFLiQQgaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81543204"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="81543204"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:17:08 -0700
X-CSE-ConnectionGUID: OV1zeRSRQ5y+J1lBqhszGQ==
X-CSE-MsgGUID: 0g4IRji0TL6+HZ77tnlG/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="236909264"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:17:05 -0700
From: Sonam Sanju <sonam.sanju@intel.com>
To: kunwu.chan@linux.dev
Cc: dmaluka@chromium.org,
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
Date: Tue, 21 Apr 2026 10:42:19 +0530
Message-Id: <20260421051219.3409921-1-sonam.sanju@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev>
References: <87add1dc9bb95dc50bc20ce5c8fbfe2999185dd3@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240037-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 1712143663B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Could you provide a time-aligned dump that includes:=0D
>   - pwq state (active/pending/in-flight)=0D
>   - pending and in-flight work items with their queue/start times=0D
>   - worker task states=0D
=0D
Below are time-aligned extracts from both instances.  Full logs are=0D
included further down in this email.=0D
=0D
=3D=3D=3D Instance 1: kernel 6.18.8, pool 14 (cpus=3D3) =3D=3D=3D=0D
=0D
--- t=3D62s: First workqueue lockup dump (pool stuck 49s, since ~t=3D13s) -=
--=0D
=0D
  kvm-irqfd-cleanup: pwq 14: active=3D4 refcnt=3D5=0D
    in-flight: 157:irqfd_shutdown ,4044:irqfd_shutdown ,=0D
               102:irqfd_shutdown ,39:irqfd_shutdown=0D
=0D
  rcu_gp: pwq 14: active=3D2 refcnt=3D3=0D
    pending: 2*process_srcu=0D
=0D
  events: pwq 14: active=3D43 refcnt=3D44=0D
    pending: binder_deferred_func, kernfs_notify_workfn,=0D
             delayed_vfree_work, 5*destroy_super_work,=0D
             3*bpf_prog_free_deferred, 10*destroy_super_work, ...=0D
=0D
  mm_percpu_wq: pwq 14: active=3D2 refcnt=3D4=0D
    pending: vmstat_update, lru_add_drain_per_cpu=0D
=0D
  pm: pwq 14: active=3D1 refcnt=3D2=0D
    pending: pm_runtime_work=0D
=0D
  pool 14: cpus=3D3 flags=3D0x0 hung=3D49s workers=3D11=0D
    idle: 4046 4038 4045 4039 4043 156 77  (7 idle)=0D
=0D
  Active busy worker backtrace (pid 102):=0D
    __schedule =E2=86=92 schedule =E2=86=92 schedule_preempt_disabled =E2=
=86=92=0D
    __mutex_lock =E2=86=92 irqfd_resampler_shutdown+0x23 =E2=86=92=0D
    irqfd_shutdown =E2=86=92 process_scheduled_works =E2=86=92 worker_threa=
d=0D
=0D
--- t=3D312s: Last workqueue lockup dump (pool stuck 298s) ---=0D
=0D
  kvm-irqfd-cleanup: pwq 14: active=3D4 (same 4 in-flight)=0D
  rcu_gp: pwq 14: pending: 2*process_srcu  (still pending, 250s later)=0D
  events: pwq 14: active=3D43  (same, no progress)=0D
  pool 14: hung=3D298s workers=3D11 idle: 4046 4038 4045 4039 4043 156 77=0D
=0D
--- t=3D314s: Hung task dump ---=0D
=0D
  Worker 4044 (MUTEX HOLDER):=0D
    task:kworker/3:8   state:D  pid:4044=0D
    Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
      __synchronize_srcu+0x100/0x130=0D
      irqfd_resampler_shutdown+0xf0/0x150  =E2=86=90 synchronize_srcu call=
=0D
=0D
  Worker 157 (MUTEX WAITER):=0D
    task:kworker/3:4   state:D  pid:157=0D
      __mutex_lock+0x409/0xd90=0D
      irqfd_resampler_shutdown+0x23/0x150  =E2=86=90 mutex_lock call=0D
=0D
  (Workers 39 and 102 show identical mutex_lock stacks)=0D
=0D
=3D=3D=3D Instance 2: kernel 6.18.2, pool 22 (cpus=3D5) =3D=3D=3D=0D
=0D
--- t=3D93s: First workqueue lockup dump (pool stuck 79s, since ~t=3D14s) -=
--=0D
=0D
  kvm-irqfd-cleanup: pwq 22: active=3D4 refcnt=3D5=0D
    in-flight: 151:irqfd_shutdown ,4246:irqfd_shutdown ,=0D
               4241:irqfd_shutdown ,4243:irqfd_shutdown=0D
=0D
  rcu_gp: pwq 22: active=3D1 refcnt=3D2=0D
    pending: process_srcu=0D
=0D
  events: pwq 22: active=3D56 refcnt=3D57=0D
    pending: kernfs_notify_workfn, delayed_vfree_work,=0D
             binder_deferred_func, 47*destroy_super_work, ...=0D
=0D
  pool 22: cpus=3D5 flags=3D0x0 hung=3D79s workers=3D12=0D
    idle: 4242 51 4248 4247 4245 435 4244 4239  (8 idle)=0D
=0D
--- t=3D341s: Last workqueue lockup dump (pool stuck 327s) ---=0D
=0D
  kvm-irqfd-cleanup: pwq 22: active=3D4 (same)=0D
  rcu_gp: pwq 22: pending: process_srcu  (still pending, 248s later)=0D
  events: pwq 22: active=3D56  (56 pending items, zero progress)=0D
  pool 22: hung=3D327s workers=3D12 idle: same 8 workers=0D
=0D
--- t=3D343s: Hung task dump ---=0D
=0D
  Worker 4241 (MUTEX HOLDER):=0D
    task:kworker/5:4   state:D  pid:4241=0D
    Workqueue: kvm-irqfd-cleanup irqfd_shutdown=0D
      __synchronize_srcu+0x100/0x130=0D
      irqfd_resampler_shutdown+0xf0/0x150=0D
=0D
  Worker 4243 (MUTEX WAITER):=0D
    task:kworker/5:6   state:D  pid:4243=0D
      __mutex_lock+0x37d/0xbb0=0D
      irqfd_resampler_shutdown+0x23/0x150=0D
=0D
  (Workers 151 and 4246 show identical mutex_lock stacks)=0D
=0D
> Please post sanitized ramoops/dmesg logs on-list so others can=0D
> validate.=0D
=0D
Full logs: https://gist.github.com/sonam-sanju/773855aa2cbe156ca19f3a87bbeb=
c15e=0D
=0D
Thanks,=0D
Sonam=0D

