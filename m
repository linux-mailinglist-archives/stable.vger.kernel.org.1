Return-Path: <stable+bounces-242617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF3XBGwx9mnKSwIAu9opvQ
	(envelope-from <stable+bounces-242617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 19:16:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3124B3043
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 19:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD03F30103B2
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 17:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4D38236C;
	Sat,  2 May 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRbYRLOV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4516347512
	for <stable@vger.kernel.org>; Sat,  2 May 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742166; cv=none; b=WZiXmQMx8wdhr/dYjMS7uy0cPVHWhMU/v9kMRMrnvBE/oLaVqMQLJGPwmwLEu2EBpTm/8FsYJfFdVbl1JlxpRqNHdBNYF0XxwuAHEDIBVjZLCV7yo4Wn1Xo6CAZ4/nLEBGHHTJG9XzmGCpM7fVoFYc6gKm53cwZVaveszjN0hOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742166; c=relaxed/simple;
	bh=+0CFC5A4Evy+9GJG+IpKuen6s5CfemtvpTuS9J4rTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFNiSII7Z+ueE5ZNE3FUwU72XhREQhx9A87bUGkK7T7zWzsoSA2u4hG7/f9v8BanJ/jEPOc/3QF34pbJQwf1hMkW+3hhy2JJUFTqWdcP467RSHaexNtoyLteu+QJR4s/X6XP0x3RCE/96Y4ZJ56udMbY89zpnsDUdOn4I6vvIUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRbYRLOV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef5776530bso326350585a.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777742164; x=1778346964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z11f/Vv9GkY9KDFoxqPMfht6srzp4mP7hxNzZazS6AM=;
        b=cRbYRLOVKst7BuzUoW9x9PfVHQfmL2YlfabBCjvzLaBds447t3EK6MCJzd3DqXwIfQ
         lvpNpWCNQDCnIQSKh2ptijz7xitnR0IImy+NSTgZ6mhVFgYK7PxShnzLXo8zH+08cLzH
         vYl22IIlfNCfFxikKKph8jaKGUSKEhJKM5FqrLOGo25qcDRroLB6HfIZDxKyzuik2Klz
         L2hub35AXL9d5C5lARHkR57Zis2n9oV+eQq63c1g9wKOxY4/n5be5pZCOWdSNQlu0d0n
         4GxtcUhqxs7tl00if0iUhBAxc/jo3wqR5w3p+DZY0RUtEhoDDAvi9KoQsUmS8IRkOp0Y
         IPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777742164; x=1778346964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z11f/Vv9GkY9KDFoxqPMfht6srzp4mP7hxNzZazS6AM=;
        b=nSmrFMuAW+1sfH7Tr61VZH+xSJOPQok81nGt3USapbh5BWiVXOWVRJ5OsgkU5haWP2
         S3L1E9pUVExGuNkNpYJq6fp7CyQFgyDWocMv4oss4PRJJvxbhuw0suyVNhizVi9MVVqN
         1Pe3s/IiZH0YVaDj+72tJKzQkk2DfZ1AOCDXWmqz9nIcAxvKTiwWgkxsLpD/pRRrrHFJ
         nzL54S97DnUg6IfkxntxtfCgnfvVt/Wh4BddKIybQ57N3Ap9TI1MeS6i3LSIbIvAWlPy
         pdE0aa38R5WeFnZDjfF2vYH1kAE5v4lcPXErtESzmx5aaTAC507TNr0bzxSNSmVM9pHd
         2sjg==
X-Forwarded-Encrypted: i=1; AFNElJ9vdG24fB408KuRiH5eSHBw6b9f08yeAlx/j+YASnQRZfg63Kgbad6argNGYo+fExBLtTtuR44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz796dqZ8iQVy8WkOgLVytzpW57VfGbHc1E88s7tSZpodLxXuyg
	HjQCKrnMA11JfqaNhlUld4w5p96z6nlmUgx4B80DmvbV4OUJXsM0a7sZgUu8hgjP
X-Gm-Gg: AeBDieuuWaO+FAQLBqigbYeNZpadA7BOV718EPnvbTpg56/l/lzCAQ7HJGKnKRhBNX6
	AsLY4/4i8yhVvgVrnOMvtzmTywUL90gVVia6J9wusaPNiBWB0vxsNvMTI+SiuKXYnhMR7L96b3P
	fhZ4irWEV43j0kFZI92FrIC8EVnVuOWYV2HtcszVs4CBFVWSGsCOk5CvK+1IjdgL3n6usJKVszU
	xlaYDZ5JFr+Q3kzbD236n0gbKTCNCN6oNPWdrRS7EPj1TZb4rtXnEtKLWd3fQGDtgItTQC2v/Td
	BdM0Lc+kX12qXX1iPjwktE91nAw7tSzNomKjIc5x52W+FVaFMsUmIwczFIfvzy9ZBVTuGa6Eb8A
	igqhvDT6jM957rqdOjIkBsxGlYOZxdsql7ETIuEce3pNg4GKvysuir0hnqIxDdBx9ROkZSfRZuY
	1wisl3O+zxy9uElRRH80CO+vnkOrwRFI0WOyBd/nxf2A5liHYHJ7A91okmsKzti0ukVzU=
X-Received: by 2002:a05:620a:40c9:b0:8f4:e8ce:8e3 with SMTP id af79cd13be357-8fd17e45b75mr609597585a.41.1777742164457;
        Sat, 02 May 2026 10:16:04 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm572920185a.36.2026.05.02.10.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 10:16:03 -0700 (PDT)
Date: Sat, 2 May 2026 13:16:00 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <afYxULoCOaL3pQkm@PF5YBGDS.localdomain>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
 <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
 <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
X-Rspamd-Queue-Id: 7D3124B3043
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 04:02:04PM +0200, Andrew Lunn wrote:
> On Sat, May 02, 2026 at 05:45:08AM -0400, Mike Marciniszyn wrote:
> > On Fri, May 01, 2026 at 02:46:36PM +0100, Simon Horman wrote:
> > > On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> > > > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> > > >
> > > > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> > >
> > > Hi Mike,
> > >
> > > I think this warrants a bit more explanation: Why should addr 2 be
> > > accepted? What happens from a user-perspective when it is not?
> > >
> >
> > The DW IP part has two distinct PCS address ranges cooresponding
> > to the C45 PCS registers.
> >
> > The shim translates the PCS mmd/addr/regno into specific CSR writes
> > to one of two zero-relative addr values into one of those two
> > ranges.
> >
> > This patch fixes a one off in the test that could allow an invalid
> > CSR write if an addr == 2 was called.
>
> Stable runs say:
>
> It must either fix a real bug that bothers people, ...
>
> Can this bug be triggered with the current driver? Are there any
> noticeable effects? How would somebody inside Meta know they need this
> fix? This should be included in the commit message.
>
>     Andrew

Thanks Andrew!

I am working inside Meta with Alex and Kuba.   I noticed the one off when
doing the patch that reworks the shim.

As to a real impact, that depends on the part2 series, but before that
series no one would care, which is why I had in as part of
the patch 1 series.

Without the follow on work, I suspect that no one cares or would
see any issue as I have yet to present the xpcs changes in part2.

Perhaps the best thing to do is beef up the commit and remove the
stable Cc, leaving the Fixes linkage?

Mike

