Return-Path: <stable+bounces-216064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMRnAtgIj2ltHQEAu9opvQ
	(envelope-from <stable+bounces-216064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:19:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852F135B00
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C24F3011C41
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CA3570DF;
	Fri, 13 Feb 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ggzI2sp9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878403563DA;
	Fri, 13 Feb 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770981390; cv=none; b=iz2VouO2NWhWpAALld6zb07/ku3GdmoNjsaWKuShyyOpupcHuvIXCqScsB1NiigAe5jY0CW+8p8N5KTPlsxhzGrm7ed6D2UlE/GKyzyvmKWfqTLVTFzyymklu4YlLF7F+NrwyNt1X3Qy4VjbcJ6W/jTrQs6vGbFVTioiWTEG6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770981390; c=relaxed/simple;
	bh=6sr7WkUyaAEppVuqis7b6P9pO0POiZVikgFHSPtfwcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOWaxypaN5cUvCa8geuTXQcvy72OkTyL28Bc8MZ6H3kdlRj7hc6MMiotYzkXCqT7mUuQqQOcoEqp7hLpbqZAXajZ4yJNH6vEcYlLnpRRlgorj5b9vI1dKRsNDXoVUt9ItLFqjkms/3f9mEo5B9iREOSlmlS8Zo9f0fPUyNEruuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ggzI2sp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BAEC116C6;
	Fri, 13 Feb 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770981390;
	bh=6sr7WkUyaAEppVuqis7b6P9pO0POiZVikgFHSPtfwcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggzI2sp9KLKctdYtqkL2MHtJ+HiTGmM4PBbUFvZRWfFkUcxMQxM4lCsislSrZtpzD
	 GP+RcEZB8HaIzJaHwDt0gRvLxC0NhSCqADxA7LyxpfHF9f5OhPdfxgEw5W4YvRlyyc
	 3J78oh4KFkqa5q8f8iRZcYNUeEHkTfgkh5CqFnHg=
Date: Fri, 13 Feb 2026 12:16:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	root <admin@windowsforum.com>, peterz@infradead.org,
	mingo@redhat.com, linux-kernel@vger.kernel.org, mjfara@gmail.com,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [BUG] sched_mm_cid_exit+0xe2: page fault on CID bitmap write
 with nopti on 6.19.0
Message-ID: <2026021318-rubble-mooned-2db9@gregkh>
References: <20260212211213.F1BE52A1C1D@windowsforum.com>
 <31feb490-c9dc-4cb0-80bc-951e9a6cdab6@efficios.com>
 <87seb58s4v.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87seb58s4v.ffs@tglx>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216064-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[efficios.com,windowsforum.com,infradead.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5852F135B00
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:21:52AM +0100, Thomas Gleixner wrote:
> On Thu, Feb 12 2026 at 16:19, Mathieu Desnoyers wrote:
> > On 2026-02-12 16:12, root wrote:
> >> I'm hitting a repeatable page fault in sched_mm_cid_exit() on 6.19.0
> >> when booting with nopti. The crash occurs during process exit
> >> (do_exit -> sched_mm_cid_exit) on an atomic bit-clear (lock btr) of
> >> the CID bitmap. The faulting address is within a 2MB huge page that
> >> returns a permissions violation on supervisor write access.
> >> 
> >> The bug triggered 8 times over ~20 hours on a single boot, hitting
> >> multiple unrelated processes (git, gce_workload_ce). Eventually D-Bus
> >> died and systemd became non-functional, requiring a hard power-off.
> >
> > Can you confirm whether the following fix in Linus' tree fixes your issue ?
> 
> It's exactly that problem:
> 
>   2a:*	f0 48 0f b3 10       	lock btr %rdx,(%rax)		<-- trapping instruction
> 
> RDX: 0000000020000006
> 
> which has the TRANSIT bit set and that's what below fixes:
> 
> > commit 1e83ccd5921a ("sched/mmcid: Don't assume CID is CPU owned on mode switch")
> 

Great, I'll go grab it now.

thanks,

greg k-h

