Return-Path: <stable+bounces-271683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dG+hHAd0R2rIYQAAu9opvQ
	(envelope-from <stable+bounces-271683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4897001CA
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 10:34:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=CfCOuV93;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271683-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271683-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 156323090136
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC5F33A9DA;
	Fri,  3 Jul 2026 08:20:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF9314B76;
	Fri,  3 Jul 2026 08:20:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066826; cv=none; b=rFsLwACQsPEA5TifLsWjkYASprKnP4RwlW/0Wlw4po+u6eND+/MKXSi0P9UV2gSF9NRApWcczHU8Q9v01vd/lxcHHlHjKmqH9oT9ItBJpV2K6XXTDXel4z9J2zp+8v2nKOZR5WpI64WS1t2RTtEBmvyEXXCngIq+Q2i8GSjrJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066826; c=relaxed/simple;
	bh=mH+0U5CZG2uR3UNPft08fjj6UpzpUG2Lm/YTnpNEi0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faY95+3ZNRmJvyaZqeznYoWlpAfNPS3HYLAZi+NaeJWmRM9WvAzLJCr9+7mkn97ajyAQWFlhYUlVcmtkbWIRmwj1+RtBUjv4lNzDgiZX2ll/uPNPaK+EbGMM8wcJ4jPh9JBAoKAno41J30t7AHiJt59Y24ddxXbOzxTikVi6svE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CfCOuV93; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304851F000E9;
	Fri,  3 Jul 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783066825;
	bh=u0+KdUCekwh9hkMd/0K08RoqTPEWE9HPi7sqIARest4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CfCOuV93GwDsJuzVHGfNRZ+QLCxrEAartV0qPMCVhfPzJJ3WbaiBb4edi4XjpVE3B
	 Gev+/tzc0WuLchG5/Kd2sIAVVMv8s1ooJdHeOvBxd6HkGV7U5qOi30mf21R7pFXhPS
	 b9V8wlNrjZhcp20AbPwOV7ZqxiwTzA7xeMgxvN7Y=
Date: Fri, 3 Jul 2026 10:20:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Wang Jun <1742789905@qq.com>,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	libaokun1@huawei.com, 25125332@bjtu.edu.cn, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
Message-ID: <2026070315-crescent-factoid-616d@gregkh>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
 <2026070210-catty-grape-2568@gregkh>
 <b93095c6-0717-4616-9702-570b2927429b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93095c6-0717-4616-9702-570b2927429b@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-271683-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:libaokun@linux.alibaba.com,m:jiayuan.chen@linux.dev,m:1742789905@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,qq.com,mit.edu,dilger.ca,vger.kernel.org,huawei.com,bjtu.edu.cn,suse.cz,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF4897001CA

On Fri, Jul 03, 2026 at 03:57:09PM +0800, Baokun Li wrote:
> On 2026/7/2 13:47, Greg KH wrote:
> > On Thu, Jul 02, 2026 at 09:48:33AM +0800, Jiayuan Chen wrote:
> >> Hi Greg,
> >>
> >> Any update here ?
> > What is "here"?  There is no context in this email :(
> >
> >> We rebased the 6.6 stable one week ago and also found the same regression.
> > What regression?  Again, no context :(
> >
> > confused,
> >
> > greg k-h
> 
> For some reason, LTS only merged a subset of my patchset, causing
> some commits to lack their prerequisite patches. This leads to error
> numbers being interpreted as valid pointers.
> 
> For details, see the fix patchset that Erkun submitted to 6.6.y
> (it fell through the cracks for some reason):
> 
> https://lore.kernel.org/all/20260421113416.4040274-1-yangerkun@huawei.com/
> 
> Either applying this fix patchset or reverting the incorrectly merged
> commit should resolve the issue.

How about submitting a revert so that we can start fresh and work from
there?

thanks,

greg k-h

