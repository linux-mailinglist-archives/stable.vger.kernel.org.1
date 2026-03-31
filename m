Return-Path: <stable+bounces-231382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIx4KKGhy2kUJwYAu9opvQ
	(envelope-from <stable+bounces-231382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:27:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50C367EED
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D09993052445
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDD3E0C66;
	Tue, 31 Mar 2026 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cewqqc70"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84C3A9D87;
	Tue, 31 Mar 2026 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952348; cv=none; b=IqffiSwBC4T7IT6Os5wwHdzvSWicF2XYbQfFfApXaBQnc5kn3gYBz0m5ps/bFtVPtN+jU5tePz4D7RySEXmCsh/X9Mbp8M4LiSDa8xYbVeavLO7hY8qUmNdHPLiPS4QlnXQyrnTj2OI0Bn/hk8QMwgB0U5Jy1gELHaiEs0wXj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952348; c=relaxed/simple;
	bh=C63rki2LoaCtMMcuFy7+wQ/l3D0PT2ixs9u9g+JVSpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsVs7kAwHRNKfByYd/UADC4g3P4KG+Ual6kSp7MD39AOygwWVjbvwxiRbif+bF1CXSBq+QMNqvxVj4A+l01YSfs9w8vmHyYLdERzceMfUDWnG2vljlyS4KYgS51ajua9tzELiqEY5nAFAnWa9fMzAj11Wb97R8aJd6kR9RHuyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cewqqc70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3055DC2BCB0;
	Tue, 31 Mar 2026 10:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952347;
	bh=C63rki2LoaCtMMcuFy7+wQ/l3D0PT2ixs9u9g+JVSpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cewqqc705/lCYbeJKP8sJfsgy3UQsbAl5dtWjwj3Bqq+5JvJtxZdEaQ/i2U4fdZbn
	 EGLOPzUKotyLfHU3UZi+ZT6PW0LYRLXpLWZtqeaGQjEs5aCyXiBX5oOqVN2TiF7lN0
	 5vLl2faf8FxFSFLPHTYdDQ54JeRMfCP1PoYesFRg=
Date: Tue, 31 Mar 2026 12:19:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, achill@achill.org,
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org,
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
	shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
Message-ID: <2026033158-choking-confined-75be@gregkh>
References: <20260323134503.770111826@linuxfoundation.org>
 <20260325010401.62938-1-ojeda@kernel.org>
 <fed7d83d-ace7-47b2-acbb-d469c6189722@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed7d83d-ace7-47b2-acbb-d469c6189722@leemhuis.info>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231382-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[kernel.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,infradead.org,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: DE50C367EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:48:50PM +0200, Thorsten Leemhuis wrote:
> On 3/25/26 02:04, Miguel Ojeda wrote:
> > On Mon, 23 Mar 2026 14:43:41 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > For UML, I am seeing:
> 
> Guenter (now CCed) just reported something similar down in the thread.
> And I got a similar bug report about it as well, which bisected it to
> 49cf34c0815f93 ("unwind_user/x86: Enable frame pointer unwinding on
> x86") [v6.19-rc1, v6.18.17 (b9537a51b65af0)]:
> https://bugzilla.kernel.org/show_bug.cgi?id=221283
> 
> > [...]
> > 
> >   aa7387e79a5c ("unwind_user/x86: Fix arch=um build")
> 
> The users in that bug reported confirmed that this fixed things:
> https://bugzilla.kernel.org/show_bug.cgi?id=221283#c12
> 
> Greg, Sasha, could you pick this up please for 6.18.y?

Now added, thanks.

greg k-h

