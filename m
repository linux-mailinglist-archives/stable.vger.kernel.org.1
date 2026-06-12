Return-Path: <stable+bounces-262940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/PLH4ooLGrNMQQAu9opvQ
	(envelope-from <stable+bounces-262940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 17:40:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304567A931
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 17:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=desiato.20200630 header.b=dvXPIKZP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262940-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262940-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F423080F95
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB7384CC1;
	Fri, 12 Jun 2026 15:40:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9494359A6D;
	Fri, 12 Jun 2026 15:40:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278854; cv=none; b=Eqbv0H/KQWAJegMhOOUJQmL3VmSunipmGx93A8gfE4TQRlkS9eSO6FQhDEXgi05MBpMZckbUorzOQBHxd9nij+CZgYjhSewrzNkAV+Wa9TAJVGxtxFYbIPhyoVSLJfXG2kEz8xZgps39r0huMb2rCejjVcrtld765+M7/maZTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278854; c=relaxed/simple;
	bh=ys7fbEWrM3IoWeNbEfQSWHANKrDDlIfPDcdZ1JN0ack=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skwvUCSSXCv1kVz5ZQy8iiqZ46SxukOQ23++sDYjtPTflooo6Jfqz663Kftp/oh+ZdE4ZMKUX8g6z8JqAcFUBoW/CRCUYE0OUuXGEjZlbeoEqigfIeh5shMyOfucNTormU8bi7XgXH21278Pme/vIdsEI3Hqk+NZu+rHFAkrEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dvXPIKZP; arc=none smtp.client-ip=90.155.92.199
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MSuCSDG1sU373sc8ON+XkioeC7GLN1a88jygCwBOnYc=; b=dvXPIKZPaw73Y0JqKWErAvQefP
	Wh6y94usAOWBmmh404EKRSORtrHMVXHhFiJLqzUOOlBqN70mipLzbYT7groNmZ7qylybv2Fp1JCKX
	XZC2RqOYh76rZtw+tWrMlhT/uzikmYWy+g618q4bni3F8CVR2v59H8eba3oFfR/0iUW1I4SvHYcg/
	BsR2n+fLDBy7FGG+iy86oLlOxMEjpuyrkt1ClzrzZTf+tQ41COirrBo6atewj3bdLlyc3Gw8FCMV0
	m828BXBRhFOKUkjrBAHJbb/1Qnmx1x2qfwTae6kIUP9U6Kfxchfr6tOtc9gf+Fa7mnHJL1DTSk3PG
	j9VnrZ9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wY3zc-00000006aqQ-11hs;
	Fri, 12 Jun 2026 15:40:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 561A73005E0; Fri, 12 Jun 2026 17:40:22 +0200 (CEST)
Date: Fri, 12 Jun 2026 17:40:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] block: invalidate cached plug timestamp after task
 switch
Message-ID: <20260612154022.GC42921@noisy.programming.kicks-ass.net>
References: <20260612094042.3350401-1-usama.arif@linux.dev>
 <20260612094520.GA42921@noisy.programming.kicks-ass.net>
 <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262940-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:bsegall@google.com,m:dietmar.eggemann@arm.com,m:juri.lelli@redhat.com,m:kprateek.nayak@amd.com,m:linux-kernel@vger.kernel.org,m:mgorman@suse.de,m:mingo@redhat.com,m:rostedt@goodmis.org,m:vincent.guittot@linaro.org,m:vschneid@redhat.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:riel@surriel.com,m:kernel-team@meta.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,noisy.programming.kicks-ass.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2304567A931

On Fri, Jun 12, 2026 at 11:02:58AM +0100, Usama Arif wrote:
> 
> 
> On 12/06/2026 10:45, Peter Zijlstra wrote:
> > On Fri, Jun 12, 2026 at 02:40:42AM -0700, Usama Arif wrote:
> > 
> >> +static __always_inline void blk_plug_invalidate_ts(void)
> >>  {
> >> +	if (unlikely(current->flags & PF_BLOCK_TS)) {
> >> +		struct blk_plug *plug = current->plug;
> >>  
> >> +		if (plug)
> >> +			plug->cur_ktime = 0;
> >> +		current->flags &= ~PF_BLOCK_TS;
> >> +	}
> >>  }
> > 
> > If you can guarantee PF_BLOCK_TS is only ever set when current->plug,
> > this can be reduced further.
> 
> Thanks for the reviews!
> 
> The invariant holds at set time (the only set in blk_time_get_ns() is
> gated by if (!plug)) and through the only legitimate plug clear in
> blk_finish_plug() (which goes through __blk_flush_plug() that clears
> PF_BLOCK_TS first).
> 
> However, copy_process() sets p->plug = NULL for the child but doesn't
> strip PF_BLOCK_TS from the inherited flags.
> 
> I think the if(plug) is a good defensive check, but can also do the below
> if you prefer?

I think that's worth the extra few lines.

