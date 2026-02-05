Return-Path: <stable+bounces-214474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNETL46phGk14QMAu9opvQ
	(envelope-from <stable+bounces-214474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:30:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 61635F3FA7
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D74523005ABC
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2A3F075A;
	Thu,  5 Feb 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I1Qg4r3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84513F0742
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301836; cv=none; b=DD5Ku3tbuAHxmZAr1Y7Ckjm/dQsVlm/BcQwj4HMmx0iPjjIv1JYP9vyHsXqflC70mnPwnro06us6VzvEZV8SQy1U/N3vvqI2sY5AFgaPUApGdZ2TzyVYJUECmOlHvezHyT9JmR3yTr8+p0M36zbx350TRx74QjEoKFU6CrW+l4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301836; c=relaxed/simple;
	bh=tXtePRpo/gbpziv+pIQx07LvhhOl1DUhHdZWV0RD0Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPMXpk6eXcNyp/4EWWWiRVpv4PBxk/Td2jwZvJLXMzKwtXhWLfWscxnNmkUyRikBf9gwTY7whR3Splyps5YVAVF399nksz8EdK314mLLQG/Qq1gMMLpPK5AYix2WCczXgqp8xFA43PxnRHJow0QbhzzZrCOFBUrCY8HBtkwckgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I1Qg4r3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E03C19425;
	Thu,  5 Feb 2026 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770301836;
	bh=tXtePRpo/gbpziv+pIQx07LvhhOl1DUhHdZWV0RD0Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1Qg4r3y2AUG6lboX4D5lc2kZreI9U9vCQA7yhqWZKop0/GqlIA89LeVgvta2e0XG
	 btnM46Vsh5kdDshwWNPlI7kVxnVy2Vy+y+Try/1heNCcRIZxM5jbJ1/OB/DstYYqCH
	 P5dr/aLW93NOU+93kcdWJMqrSiwT82h4bWDnVEXU=
Date: Thu, 5 Feb 2026 15:30:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn Girgis <pimyn@google.com>
Cc: stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y v2] mm/kfence: randomize the freelist on
 initialization
Message-ID: <2026020521-nugget-grunt-f9cc@gregkh>
References: <2026020339-trickery-vegan-e9c3@gregkh>
 <20260205095323.3149138-1-pimyn@google.com>
 <2026020546-nimble-mower-1202@gregkh>
 <CAJWNTGw42Jx2_oOFm2Hib5DzMJxws1cEUZ8RFUB4cyQyCA7Pnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWNTGw42Jx2_oOFm2Hib5DzMJxws1cEUZ8RFUB4cyQyCA7Pnw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214474-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 61635F3FA7
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:27:13PM +0100, Pimyn Girgis wrote:
> > What changed from v1?
> 
> addr calculation in case of an error is handled in the appropriate loop in v2.
> This ensures that `i` will have the correct value. In v1, multiple `goto err`
> statements risked using an uninitialized or incorrect `i`.
> 
> >  Always put that below the --- line, like any
> > other kernel patch.
> 
> I'll keep that in mind for future patches :)
> 

Please do so for this one, a v3 perhaps?

thanks,

greg k-h

