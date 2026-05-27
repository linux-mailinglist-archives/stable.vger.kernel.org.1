Return-Path: <stable+bounces-254591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP3ZKQj6FmqEzwcAu9opvQ
	(envelope-from <stable+bounces-254591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:04:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 512455E58BD
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFE330C2098
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F4402442;
	Wed, 27 May 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKnaPh/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A493C2B84;
	Wed, 27 May 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890242; cv=none; b=ct+iuLafehlVT0gnV7IhtGojrudBxXTl3jy2XvPfxKYIwnFmRaqv95S2RAzESkM0AsJND1yL5NRFRCNtQvsbP6NUZN6l1dqBOi0gEkv4cHDY2XmZKt8IZk5T1UujqbAxcLvpEcZunoISO9OmG39c+cebSBHB6kLzoWNuDoKi+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890242; c=relaxed/simple;
	bh=L1UY8u0vuV9JSPqrZ5lO4PXAKPfjSEOXsCY3A7TCLHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+ze6V8pUQi/vxxA69CB2b2yhjOa5LxBC1A+8tV7k1UF/tdVcfY2IW6nl6QWtNvjF1cna/4nR4nIVNG6ZKs+53rN+tswYMB1sZh+f3A9Q+dju9H5yec2L7m52HS8tnfOU0wdHnlW6jzMK1pTbXCUQO3+4yrNsglui3bOOm55TN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKnaPh/8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5B1F000E9;
	Wed, 27 May 2026 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890241;
	bh=MdlUzT9Bn5pbr3y0d3ZaQ4v8JcH+Pr3NoB3O0svvOc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CKnaPh/8WyoPgIAaoEcx7FNedo2YAxzAcZt9T8lFcM4lBbylUtdRsJ6UtgWrODzRk
	 nq73f499wXbSQCbTDxyBGyi5BLoNWCLfLr7janUl96guR9w9s/8+iaTzBkkGHYiGap
	 oTNofQte8yJzitVTKpFKZjpJu5kCWbxP6p7FqC7LMw62A/AqmH/bLA+tJrWEduZDx0
	 ZgKsb+WBf1Kq24PeRf4e0CWiG/Pe8XJETmzE21uhAJcUCbgUrAnzaX7Ui7W2NVCqQJ
	 4zZaugwhRtbCDgVXLjVpSpNw1XDBpxJmv1DF2tdePj6xlQ9ZpPYFH4uzs+OzmJ2C6o
	 LAKKZ021nMZmw==
Date: Wed, 27 May 2026 15:57:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, Jake Edge <jake@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
Message-ID: <20260527-holzplatten-woran-wettkampf-9ee073dd8891@brauner>
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
 <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
 <CAG48ez2pmuoTCZh_AVKDDLeQEYmm=gLMgThnqFhRMFfZvABpdw@mail.gmail.com>
 <20260527-kuchen-fassbar-hauer-4b6fc31e3395@brauner>
 <CAG48ez1OfP4umNSeGzw4YhZi3dcb1jsy-vrKUwMc9+SLpt3isA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1OfP4umNSeGzw4YhZi3dcb1jsy-vrKUwMc9+SLpt3isA@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254591-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xmission.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 512455E58BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:44:17PM +0200, Jann Horn wrote:
> On Wed, May 27, 2026 at 2:01 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, May 26, 2026 at 08:22:38PM +0200, Jann Horn wrote:
> > > On Mon, May 25, 2026 at 9:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > > Question 4.
> > > > Is it possible to use a seq_lock instead of reader writer semaphore?
> > > > Or is that only for non-sleeping readers?
> > >
> > > Linux seqcounts are 32-bit, which means they are always kind of dodgy,
> > > but they are particularly dodgy if a reader can be forced to sleep for
> > > an extended amount of time. I don't see a reason why we couldn't, in
> > > general, use a 64-bit sequence count for readers that may need to
> > > sleep while reading.
> >
> > I have a patch series for this that I started working after merging your
> > series for precisely this reason: performance. It's a few days old now.
> > I've tried various approaches and I started with a simple 32-bit counter
> > as the POC. See appended (untested) patches.
> 
> It looks like there is a missing patch at the start of the series,
> patch 1 uses exec_update_seq_begin without defining it.

Yes. I was mainly worried about changing performance characteristics if
we start using the lock in more cases.

