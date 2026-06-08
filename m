Return-Path: <stable+bounces-262101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hv4GM/IRJ2rBrAIAu9opvQ
	(envelope-from <stable+bounces-262101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:03:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D3659FAC
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:03:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nRSH22uK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262101-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262101-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58F26303698B
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 18:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7193E51FC;
	Mon,  8 Jun 2026 18:58:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A632B11F;
	Mon,  8 Jun 2026 18:58:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945087; cv=none; b=NlQIhN6RPagmyfA2J1W0v+X8p1Eb9VaVDmG6OyhrfhQ205f1XpfVqHATuktYdadv8Fw60woHCuFx7pAM+745xYxhtQChHsE9qJc902dseFMZP2Kk0vp1DAbDLSq+qQR/cd39L6AobloQO64StHH4ez09WylOPU129ysOWfd9fmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945087; c=relaxed/simple;
	bh=GM2jj6R7dGpHaVSx10PY2i9Q65YNez7xdNwNBy4w4TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJsLBrygHRsPyQjNS3vgu99c/Jn5rbfpjug6nBnadmXa908KDfR4o1+jfxkFpSKA5eI15PMaDAg/JQO5qGpVv39HmmQwdcZvEVAupNIN7g+KSGP5AkZU2LuwTLnv18l9WF6CUwMwOGk7cF8985La/0pl9uKm8TRteAtTwj/RVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRSH22uK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A381F00893;
	Mon,  8 Jun 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780945086;
	bh=lJ697wuTa5/76WpGI5kWSrt7Q6BzPPxhvcCh7DE3bRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRSH22uKswRDdqfA7o0x/dXJbEQqCA2o3y1W29hSiATYxOIgYZV3OOWFTz5zmMz6p
	 TcaGr7cJxqVom7AxDJAdC/1wmXA/AakUEjehPoRt1S1TQMYdMJYcJdlqG3hHwEpNM+
	 5Dm7kCQGgYeu10QITjiMj9LKiHUWPq4oaymzXEzilQ04vWksWifa/YhRaLnVvN3dRQ
	 er3sEooMQYAD4Sc2aJc15ujfH/+2sRf2xFxM9uHRsmBOg+bbRxSyE5BXHVxGmzaJju
	 cthmIl2akCXOeE/mghrggqBVoil55vqdtTKiQlvn4FY9GhnAytWNipATBqKYc9USWq
	 xBCh3tQAR1Z7w==
Date: Mon, 8 Jun 2026 21:57:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, David Carlier <devnexen@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Heechan Kang <gganji11@naver.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 1/3] userfaultfd: verify VMA state across UFFDIO_COPY
 retry
Message-ID: <aicQtr1tbnhhqmtw@kernel.org>
References: <20260527184751.4147364-1-rppt@kernel.org>
 <20260527184751.4147364-2-rppt@kernel.org>
 <ahhAHNSZOeW49ms2@lucifer>
 <ahhUM0A8-q0UqFv1@kernel.org>
 <aia8nKXtShnhQpVY@lucifer>
 <20260608093918.68ce9d7d5694380e3055e293@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608093918.68ce9d7d5694380e3055e293@linux-foundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262101-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:ljs@kernel.org,m:devnexen@gmail.com,m:david@kernel.org,m:gganji11@naver.com,m:liam@infradead.org,m:michael.bommarito@gmail.com,m:peterx@redhat.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,naver.com,infradead.org,redhat.com,kvack.org,vger.kernel.org,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D94D3659FAC

On Mon, Jun 08, 2026 at 09:39:18AM -0700, Andrew Morton wrote:
> On Mon, 8 Jun 2026 14:03:11 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:
> 
> > > > > Fixes: 292411fda25b ("mm/userfaultfd: detect VMA type change after copy retry in mfill_copy_folio_retry()")
> > > > > Fixes: 6ab703034f14 ("userfaultfd: mfill_atomic(): remove retry logic")
> > > >
> > > > Did we want a Cc: Stable?
> > >
> > > Andrew adds it when applying.
> > 
> > Hmm, I didn't think this always happened by default? :)
> 
> Nope, adding cc:stable is manual, case-by-case and the -stable
> maintainers have been asked not to automatically backport MM patches
> which contain Fixes:.
> 
> So this one snuck into mainline without the cc:stable tag.
> 
> Thanks for noticing.  Greg, Sasha: can we please add mainline's
> 85668fda932a ("userfaultfd: verify VMA state across UFFDIO_COPY retry")
> to the backporting pile?

There is no need to backport, both commits that 85668fda932a fixes are in
7.1.

-- 
Sincerely yours,
Mike.

