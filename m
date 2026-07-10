Return-Path: <stable+bounces-273207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Um52HV7eUGpW6gIAu9opvQ
	(envelope-from <stable+bounces-273207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:58:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E973A78B
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=EKqurUcQ;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273207-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273207-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A864230C1A40
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB63CF1F6;
	Fri, 10 Jul 2026 11:50:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6863B14D0;
	Fri, 10 Jul 2026 11:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684205; cv=none; b=QpH3zHQF43tiejAhDGGZUtiX+sDbDyQO944Zxt5i4M8W3qRJOnaDofA9bk+QkKFt9IyfH3MS3AxAEKv5r4oI30bhy79qKjdXV5E7bxP0VUSjNf/zzpgq2JzV7Wa60aMgT2To2G5TUkbL/HatsESv4bPy5iwTrbvuEcg9jV05cS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684205; c=relaxed/simple;
	bh=0zdUmkAYIu7TQbO2qzGSlCDJ1NiHeK0hsVM5PwrAi6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2vZNe9h+t2KDbQgf9wZZfkzcXo7fdNbEv+eeZr0GwWFd5xT5ADwqz4VdEiWagjGJ7tbQw9797fXYXLdw4yvgWZ3gLy32cuAnbtr0f02Wj7ol/x4sPwNUGknu/3SKRolTy5yMOdY9M52oN3ph6q7IA2eyO1GSHOuvpGHa89OVy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKqurUcQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4241F000E9;
	Fri, 10 Jul 2026 11:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783684198;
	bh=2ECyTCPkkExKTnkYMGZphcdxdGDUw94pbpd/km7z2oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKqurUcQTSjci0lkPk6+JLcBJkSr7HjUNiblOcgJuoTh2XO5ODX0QrhqfC2slDQHn
	 cZhN4lB8D+283fL3m8CQL+d+6bxMU+iebQxBN5TAwgPKdP70ybiqd/nDMn3yfyAE8Z
	 I/PDCEw03rgzlN2zVeCsSBOQC+HmeR1ZtWGMAexM=
Date: Fri, 10 Jul 2026 13:49:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Dominik =?utf-8?Q?Wo=C5=BAniak?= <stalion@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.12 187/204] nfsd: check get_user() return when reading
 princhashlen
Message-ID: <2026071043-dicing-arousal-ae51@gregkh>
References: <20260702155118.667618796@linuxfoundation.org>
 <20260702155122.580017616@linuxfoundation.org>
 <17cce379-76ca-49fd-91e7-1a486de62d2a@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17cce379-76ca-49fd-91e7-1a486de62d2a@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:stalion@gmail.com,m:jlayton@kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,kernel.org,oracle.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,name.data:url,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D72E973A78B

On Fri, Jul 10, 2026 at 04:58:41PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> 
> Sorry, I couldn't send this in 48 hrs of testing timeline.
> 
> On 02/07/26 9:50 pm, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Dominik Woźniak <stalion@gmail.com>
> > 
> > commit e186fa1c057f5eccb22afb1e83e34c0627085868 upstream.
> > 
> > In __cld_pipe_inprogress_downcall(), the get_user() that reads
> > princhashlen from the userspace cld_msg_v2 buffer does not check its
> > return value. A failing copy leaves princhashlen with uninitialised
> > stack contents, which are then used to drive memdup_user() and stored
> > as princhash.len on the resulting reclaim record. The other get_user()
> > calls in this function all check the return; only this one is missed,
> > which is most likely a copy-paste oversight from when v2 upcalls were
> > introduced.
> > 
> 
> I ran an AI-assisted backport review and verified a leak in the released
> 6.12.95 equivalent of this patch, 0ec4aaa488ff (“nfsd: check get_user()
> return when reading princhashlen”), this is only in 6.19-rc1+
> 
> Upstream e186fa1c057f uses an automatically cleaned-up temporary:
> 
>   	char *namecopy __free(kfree) = NULL;
>   	...
>   	namecopy = memdup_user(...);
>   	...
>   	if (get_user(princhashlen, ...))
>   		return -EFAULT;
> 
>   But 6.12 retains the older manual ownership model:
> 
>   	name.data = memdup_user(...);
>   	...
>   	if (get_user(princhashlen, ...))
>   		return -EFAULT;
> 
> Thus a fault while reading cp_len after the name copy succeeds leaks
> name.data. The upstream early return relies on 4552f4e3f2c9 ("nfsd:
> change nfs4_client_to_reclaim() to allocate data"), which introduced the
> scoped cleanup, but that commit is not present in 6.12.y.
> 
> Maybe we should fix this up with a downstream backport ? That looks like a
> simple approach to me.

Yes, that would be good, can you send a fix for it?

thanks,

greg k-h

