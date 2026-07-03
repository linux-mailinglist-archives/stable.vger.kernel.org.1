Return-Path: <stable+bounces-271742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PhiwK0qiR2qkcgAAu9opvQ
	(envelope-from <stable+bounces-271742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 13:51:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE67020B0
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 13:51:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=mit.edu (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271742-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271742-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D491730A031F
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE873CBE7A;
	Fri,  3 Jul 2026 11:48:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA33CAE9B
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 11:48:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079327; cv=none; b=uHUbQP69IMDBsa10JD+EhZ+PxypoQyi5LYHmbyznBKKB+Yaqmgto/vyHDZWPY1FdNu6SDqjJDBotksDjRDRaTcmO0iznAHKn4yH5A1jkLjgMTDsIKd376U25UYvcgMWyyIYu3q9S4AIZ4dUtTzqb16zK5RGTPfmntbo/BN2C3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079327; c=relaxed/simple;
	bh=5JqLuEiREk8klCaoqV+K5aWMLAGYc2iXBg4rGhZbat4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdOeBeneVm3vjj0XamdJaJ/3yNoTZNNl6BnPfVbpxhFgGyaRso8QweIGgmQuYQUTsYYZUqJH49SWzvifZXwC3g0PK8r/gyFLKiVDACgNq8ztDtbHpbumPyXVLrrdqIGQmHHxg/+N+K87nsJXYqYeRt7+NxietGK0h5Pqqls6t1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Received: from macsyma.thunk.org (syn-072-043-125-131.biz.spectrum.com [72.43.125.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 663Bm81Q002631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jul 2026 07:48:10 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id CD31589CE68; Fri,  3 Jul 2026 07:48:08 -0400 (EDT)
Date: Fri, 3 Jul 2026 07:48:08 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Jiayuan Chen <jiayuan.chen@linux.dev>, Wang Jun <1742789905@qq.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        25125332@bjtu.edu.cn, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
Message-ID: <akehR1wEgK23wFp4@mit.edu>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
 <2026070210-catty-grape-2568@gregkh>
 <b93095c6-0717-4616-9702-570b2927429b@linux.alibaba.com>
 <2026070315-crescent-factoid-616d@gregkh>
 <2904d1db-11fa-450a-89ea-20fe133fa268@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2904d1db-11fa-450a-89ea-20fe133fa268@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[mit.edu : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linux.dev,qq.com,dilger.ca,vger.kernel.org,bjtu.edu.cn,suse.cz,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-271742-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:libaokun@linux.alibaba.com,m:gregkh@linuxfoundation.org,m:jiayuan.chen@linux.dev,m:1742789905@qq.com,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EFE67020B0

On Fri, Jul 03, 2026 at 04:44:32PM -0500, Baokun Li wrote:
> >> Either applying this fix patchset or reverting the incorrectly merged
> >> commit should resolve the issue.
> > How about submitting a revert so that we can start fresh and work from
> > there?
> 
> Alright, I can help review the patches.

Can you also double check whether your patchset actually fixes a bug
in 6.6?  As near as I can tell, it wasn't needed for 6.1 at all.

Thanks,

						- Ted

