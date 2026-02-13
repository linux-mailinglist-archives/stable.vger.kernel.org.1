Return-Path: <stable+bounces-216255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDj0FthJj2moPQEAu9opvQ
	(envelope-from <stable+bounces-216255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:57:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B474E137BC9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0708304A5BB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5993570C9;
	Fri, 13 Feb 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eK6qroBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA633D4F3;
	Fri, 13 Feb 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998225; cv=none; b=ofMLD8qQQoI3XTuDHTL5hyrWANxOT99Zf4tXq93ZTFci3p9+U4SFDsSe0KKs0u8QTBGxr+bPyPVgPSiQ3+iFGaBy7h9wlDmpy+G+SXkxDNMhojoKCOCWWCKZw5igSPPhcH6zuuy2tsCH/o0T1Jdvi4iGZ0AdzPYOYtYEMPmlppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998225; c=relaxed/simple;
	bh=TN8QHY8npDjavfEwCNcBB5l1VozdGJICS/ynSKF0Qz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWwXFINoRtuTZOeC0Pn6nPsDImQW8hRdOtsr8ZymBsnp2TcnrMY1Er9whygnkiz5HOeGxgQRz1jfQaCvbqQIZeMyXcaDK3bsLU1p9g7zKg5iwiTsy12w4uZxlz50nYyo+0E6I+l3Pu+U3w4w+Um4XZc0K354NhaTnrnvBnYaTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eK6qroBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD9C116C6;
	Fri, 13 Feb 2026 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770998225;
	bh=TN8QHY8npDjavfEwCNcBB5l1VozdGJICS/ynSKF0Qz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eK6qroBD0jF3Uu9GUCbpV9wEJUHX7cWDKbwbhwGVhX15DxINmIZOy87LA9eA9Z01e
	 ArJwVh7b4GNUkNcSQZSWQkiuIdhEj3NcEIFNui+6YExZAgRVBDhCxggrLx9e/DLDvB
	 6xJ7j7JD9ue2zFP9+uNbU4j+vbowEFhHlm2sus2Q=
Date: Fri, 13 Feb 2026 16:57:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Achill Gilgenast <achill@achill.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
Message-ID: <2026021353-perfume-drum-3776@gregkh>
References: <20260213134708.713126210@linuxfoundation.org>
 <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
 <2026021312-magma-dormitory-53af@gregkh>
 <2026021325-repacking-crumpet-5861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026021325-repacking-crumpet-5861@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B474E137BC9
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 04:36:39PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 13, 2026 at 04:35:27PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Feb 13, 2026 at 03:48:19PM +0100, Achill Gilgenast wrote:
> > > On Fri Feb 13, 2026 at 2:47 PM CET, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.19.1 release.
> > > > There are 49 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
> > > 
> > > Hey, the link to this patch (and all other stable-review patches from
> > > today) seem to be not uploaded yet. Is this expected?
> > 
> > Nope, not at all. let me see if something went wrong on my side...
> 
> Ok, pushed again from my side, let's see if it propagates properly
> now...
> 

It's a kernel.org mirror issue, it's being worked on right now...

