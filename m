Return-Path: <stable+bounces-232748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDTZIqbuzGknYAYAu9opvQ
	(envelope-from <stable+bounces-232748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:08:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7C3783B2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56145305C8CB
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9963B19B7;
	Wed,  1 Apr 2026 09:51:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3B3382F7;
	Wed,  1 Apr 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037115; cv=none; b=V5jqNJmNLvjFp+2vSfooxTpuqkucCw28s41etVIW5M304uAaaE1DwSlw+Mn1yeJe7yBaMqAfNiVBtwBlvMak0ies+AO2aFK49eIREhDuI5rEyxYt27H7lS+XKQQlTOGPP3THn5gamGdUkD+NaZBb581oxXApuk1KIl5mCD4Fhjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037115; c=relaxed/simple;
	bh=U97ebIvudxTv88YtYZfzy5ZrlchjEOPs2mSLzLQmu6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IV6uAds9llZUTb+//22S/ah4+eJe4KnqD5dVSZi26xrgZf6k5/0ygUBN7r9rrGS56EwYwXq1H9mZnhB76zTR5b7PyXi5n9pitvH5S9bmVsMDJdVX+T71DnupAQ+qYYOKOwdhgMkz08AL+e1jyEnOPaYpKLZl7zBTlI0AFYXO5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com; spf=fail smtp.mailfrom=intel.corp-partner.google.com; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.corp-partner.google.com
X-CSE-ConnectionGUID: LKJLZTZ+QM2+ozNZRH+TsQ==
X-CSE-MsgGUID: HrWPrAQ3Sv6Zg9p864WfiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76083234"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76083234"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:51:53 -0700
X-CSE-ConnectionGUID: IoCaRfFXTbiEaY64u7Hknw==
X-CSE-MsgGUID: 3y5qohERTs2JU2HsZyHR+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="226497065"
Received: from intel-fishhawkfalls.iind.intel.com ([10.99.116.107])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 02:51:49 -0700
From: Sonam Sanju <sonam.sanju@intel.corp-partner.google.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmitry Maluka <dmaluka@chromium.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	rcu@vger.kernel.org,
	Sonam Sanju <sonam.sanju@intel.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu out of resampler_lock
Date: Wed,  1 Apr 2026 15:17:14 +0530
Message-Id: <20260401094714.2533621-1-sonam.sanju@intel.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2d080c02-9602-4b22-94ce-1f7a71cc19a4@paulmck-laptop>
References: <2d080c02-9602-4b22-94ce-1f7a71cc19a4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[google.com : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,bitbyteword.org,chromium.org,gmail.com,joshtriplett.org,goodmis.org,efficios.com,vger.kernel.org,intel.com];
	TAGGED_FROM(0.00)[bounces-232748-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sonam.sanju@intel.corp-partner.google.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFD7C3783B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sonam Sanju <sonam.sanju@intel.com>=0D

On Tue, Mar 31, 2026 at 01:51:00PM -0700, Paul E. McKenney wrote:=0D
> On Tue, Mar 31, 2026 at 11:17:19AM -0700, Sean Christopherson wrote:=0D
> > Please don't post subsequent versions In-Reply-To previous versions, it=
 tends to=0D
> > muck up tooling.=0D
=0D
Noted, will send future versions as new top-level threads. Sorry about=0D
that.=0D
=0D
> > Unless I'm misunderstanding the bug, "fixing" in this in KVM is paperin=
g over an=0D
> > underlying flaw.  Essentially, this would be establishing a rule that=0D
> > synchronize_srcu_expedited() can *never* be called while holding a mute=
x.  That's=0D
> > not viable.=0D
>=0D
> First, it is OK to invoke synchronize_srcu_expedited() while holding=0D
> a mutex.  Second, the synchronize_srcu_expedited() function's use of=0D
> workqueues is the same as that of synchronize_srcu(), so in an alternate=
=0D
> universe where it was not OK to invoke synchronize_srcu_expedited() while=
=0D
> holding a mutex, it would also not be OK to invoke synchronize_srcu()=0D
> while holding that same mutex.  Third, it is also OK to acquire that=0D
> same mutex within a workqueue handler.  Fourth, SRCU and RCU use their=0D
> own workqueue, which no one else should be using (and that prohibition=0D
> most definitely includes the irqfd workers).=0D
=0D
Thank you for clarifying this. =0D
=0D
> As a result, I do have to ask...  When you say "multiple irqfd workers",=
=0D
> exactly how many such workers are you running?=0D
=0D
While running cold reboot/ warm reboot cycling in our Android platforms =0D
with 6.18 kernel, the hung_task traces consistently show 8-15 =0D
kvm-irqfd-cleanup workers in D state.  These are crosvm instances with =0D
roughly 10-16 irqfd lines per VM (virtio-blk, virtio-net, virtio-input,=0D
virtio-snd, etc., each with a resampler).=0D
=0D
Vineeth Pillai (Google) reproduced a related scenario under a VM=0D
create/destroy stress test where the workqueue reached active=3D1024=0D
refcnt=3D2062, though that is a much more extreme case than what we see=0D
during normal shutdown.=0D
=0D
The first part of the deadlock is genuinely there. One worker holds =0D
resampler_lock and blocks in synchronize_srcu_expedited() while the=0D
remaining 8-15 workers block on __mutex_lock at =0D
irqfd_resampler_shutdown.  =0D
=0D
Thanks,=0D
Sonam=0D

