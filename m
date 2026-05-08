Return-Path: <stable+bounces-244837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBi5Ovdc/mkWpgAAu9opvQ
	(envelope-from <stable+bounces-244837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:00:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E881B4FC1AD
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797E0301D044
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A75B2DA75C;
	Fri,  8 May 2026 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="aY5zb8qA"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433D2F8E8A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277616; cv=none; b=AKm71wajeawX3yqhj5WKVZSWjntNrEGyYT7eFX6VPx75N76/ETZEb3/jJSZnWSH6szJ32tSUzSs1Fze9ArCnjXHkDgYhic5noMHa4eJnjEdRtCCdxlbKwMCNeGyIT3l2WW//hy+8dcsD1clbOc2y62laCJf92LK8mAETLvg/kRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277616; c=relaxed/simple;
	bh=YvUyJVIIJnigpcUTciBeubD93lBY3xgoK9qBgnLvnzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUdq1h6OQ+jaZVh/vMJ4WQNjvKQl8Q53KgVi09c0ypUtUI0smx6ikGLg7IUpQzfldefLmFQZ8/p5tMdGEPsLiAAkR3hwHq+oQYnyJ9oH0PbfIMjAkAJUZPECYlP2KOhD4qZYs1xfOpJ7xy83SiaQG+WLiqwAlvGTC52VX6m9bVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=aY5zb8qA; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YvUyJVIIJnigpcUTciBeubD93lBY3xgoK9qBgnLvnzk=; t=1778277615; x=1779141615; 
	b=aY5zb8qA5qFjElhbhgSMewZEbSebUEzbQyjRCnt3NDGPsQLxWshtcW/huy/GEOVw3wUYG+5UYYT
	/FSbBu00aa+s8CZMkUCVVoJBERoFBVyU3iqazyuI+OuJBjNqzeUd1LpXruKIzm3OOy074NCMint32
	0Duc3eJ2/his7ZTrL9uUZPG/U7gVCPGvdFkFB3CbQ1jdp/TiUejyqISdltsvnY20GLyMvUr8afBMF
	Achlp9XDfhMuf20FI1HMEypki3Zglm8AvoaIxc9qNOV35OSbAUQst4YdiOyecsDx0VgfHRjGBhDvK
	QeL5U0PI02QOR4RMulseVVMukM9idZqkpZpg==;
Received: from mail-yw1-f169.google.com ([209.85.128.169]:49257)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wLTEt-000587-PZ
	for stable@vger.kernel.org; Fri, 08 May 2026 15:00:09 -0700
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c0dea734bcso1989257b3.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 15:00:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+mEAk9H1vvCeLZSBa0BiOXcny3rag0m6RnjAJH3nGLCUtSFWqqbbKqb+ZQYH4vAOnCNeOKj+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVzsDMIaPRxzJDTlV62udmCKQqvhl6NP46k+nJiOAKr3daeps
	BxtH30kKXp110kbui6ULGfEeG6z0MaFFYtNJ//2yt1+CVo2/PwTD8ViiZhNfZVcT6sBX9cFTGwr
	89EJKmkate9US7yOaZB1RQmHkN26Wh4M=
X-Received: by 2002:a05:690c:f06:b0:7bd:4a12:f08b with SMTP id
 00721157ae682-7c10255cc5fmr3388507b3.3.1778277607075; Fri, 08 May 2026
 15:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507183843.1457-1-ouster@cs.stanford.edu> <379cd3dc-aff5-4fcd-bf9f-4878ae21ee74@intel.com>
 <CAGXJAmzqBQha+XRu12ZpLTDBSMgAEANffD2uGKZ+VVdkMk6OVA@mail.gmail.com> <3de05bb6-2cae-470f-8b8d-8ada1cd0a0f4@intel.com>
In-Reply-To: <3de05bb6-2cae-470f-8b8d-8ada1cd0a0f4@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 8 May 2026 14:59:31 -0700
X-Gmail-Original-Message-ID: <CAGXJAmxKw-85-=0CX=s33CbfUmJA32=oqpDM=SeV5ZLi04fCOg@mail.gmail.com>
X-Gm-Features: AVHnY4JwMwFAqhZa5I5X9osjxt-s62Punjr1W9agb-27xSB4PVgjKpQPNdeAu50
Message-ID: <CAGXJAmxKw-85-=0CX=s33CbfUmJA32=oqpDM=SeV5ZLi04fCOg@mail.gmail.com>
Subject: Re: [PATCH net v2] ice: fix packet corruption due to extraneous page flip
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: anthony.l.nguyen@intel.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	przemyslaw.kitszel@intel.com, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 993826b9125cbf1b907f71dc54053338
X-Rspamd-Queue-Id: E881B4FC1AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244837-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:55=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.c=
om> wrote:
>
> On 5/7/2026 7:37 PM, John Ousterhout wrote:
> > Correct: this patch only applies to the ice driver before its conversio=
n.
> >
> > The patch applies to versions 6.18.27 and 6.12.86. I believe the bug
> > may also be present in 6.6.137, but the code has a slightly different
> > structure there (the function ice_put_rx_mbuf doesn't yet exist in
> > that version) so the patch would need to be reworked a bit.
> >
> > This situation isn't all that rare. It isn't a zero-length packet that
> > triggers it; it seems to happen if a packet uses every available byte
> > in a buffer, ending precisely at the end of the buffer. When this
> > happens, the NIC seems to generate an extra zero-length "buffer". This
> > happens quite frequently (thousands of times per second in some of my
> > workloads).
> >
> > What keeps corruption from happening constantly is that there is only
> > a problem if the "other half" of the buffer page is still active when
> > the 0-length buffer is received from the NIC. I suspect that with TCP
> > this is pretty unlikely: packet buffers get recycled quickly. If the
> > other half is not in use, then it doesn't matter whether the page gets
> > "flipped" while processing the 0-length buffer. I ran into this
> > problem because I was testing Homa under conditions that caused some
> > packet buffers to stay alive for longer periods of time.
> >
> > -John-
> Right. So I think we need to make sure the patch is cc'd to stable.
> Technically it doesn't strictly follow any of the 3 rules, but its
> closest to 3 with a clarification that there is no upstream equivalent
> due to the libeth Rx refactor.

It looks like messages on this chain have been cc-ed to stable since
your first message. Is that sufficient, or do I need to resubmit (e.g.
v3) with stable in the cc list?

-John-

