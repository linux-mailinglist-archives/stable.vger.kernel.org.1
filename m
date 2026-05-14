Return-Path: <stable+bounces-247106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDp5JjpUBWpPVAIAu9opvQ
	(envelope-from <stable+bounces-247106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:48:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8853DC1E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 06:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEF83032CFD
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD773A7F6E;
	Thu, 14 May 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HClYxTwL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43F2F8E81;
	Thu, 14 May 2026 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778734112; cv=none; b=XzYqrV3UgfYwGEn8Bf1fhdtu8M2eqgJ46kJNowHa1HUq0xP9iD8yvW/lh59WeaWVHGLCz/hHgh10SdHAyIcSWHX0rpMkspEpVt4QDgVipfeUv1coAd01F0Kqb7gvpRgwxm/37gbw5Grd80U+xlMNvWxt7mCWHWrXzJCxO/sjCrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778734112; c=relaxed/simple;
	bh=77OhJcmWcVYCdR6+BjbtMuX6789Ua3m10DtUXbH1vP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeuEalMziOJNdPkk7tfWfyuG45ntgDj+25jgJict24OkBfW1sbzoWmmTwt3Yz8MFl0NUALqro4JjclDuHGqvu/U1UtXL30rf/gT930FLtx6byPBVJonUnllduZ5ipZ51ehR4ZtlbD4KhPfrV8jtjXoNBumGBiG8J4k+o44xVajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HClYxTwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E27C2BCB7;
	Thu, 14 May 2026 04:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778734112;
	bh=77OhJcmWcVYCdR6+BjbtMuX6789Ua3m10DtUXbH1vP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HClYxTwLySkTuDtqtV+KD94LQ60TGm6hgyRCr27ExCYxxee1FXMZRqg21twvrl52Y
	 mtRiGLtj+DbIqAiuLyr1dozSFu6XsjH0EAVHjuYAUhK/+n3USr0j2pSjwS8zAyRU1c
	 ejzO7lKqd2CmTW7B11p1XmyXRNmasHEA3XpmL+q2CA7x+OVg9f06V0egLVZwMUKbeX
	 F19fu4+AQOMOhG/1Ljk25mIRGqxZR6QbUKjilsiPqfYSEym2DsjMp/vVP9atZ1EhEg
	 zUVsPolexA1k7FVtP6AR+zt3sGbwazFKJD2o3TG0/nd1Ppw2BOPomMQKfbUhzVUItZ
	 7GJF9t0bgQ/Sg==
Date: Wed, 13 May 2026 18:48:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kyle McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Linux RT Development <linux-rt-devel@lists.linux.dev>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
Message-ID: <agVUH-L503DwAiSW@slm.duckdns.org>
References: <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
 <056f95bc5805f7e161458984fff4b3cb@kernel.org>
 <20260512172847.5024e5e8@gandalf.local.home>
 <20260513193914.1593369-1-tj@kernel.org>
 <20260513202432.18dd7b9f@gandalf.local.home>
 <agUdAatmlqQc1NS_@slm.duckdns.org>
 <20260513213108.2870a1e7@fedora>
 <agUodtxEi24HQ1Oo@slm.duckdns.org>
 <20260513220136.5a11c740@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513220136.5a11c740@fedora>
X-Rspamd-Queue-Id: EFE8853DC1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247106-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On Wed, May 13, 2026 at 10:01:36PM -0400, Steven Rostedt wrote:
> I could try, but there are still some things that I don't understand.
> One is that to send more IPIs due to the RT pull request, there needs
> to be RT tasks constantly sleeping. Is that happening in this use case?
> Are the softirqs waking up RT tasks that run for a short time and go
> back to sleep, causing the pull IPI to trigger again?

Ah, yes, that makes sense. That's why the repro is using FIFO threads too.
In prod, there's mpi3mr threaded irq handlers that are FIFO. These are
storage machines so they're also constantly active.

Thanks.

-- 
tejun

