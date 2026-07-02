Return-Path: <stable+bounces-270336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mdg8DJv7RWqgHQsAu9opvQ
	(envelope-from <stable+bounces-270336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 07:48:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B36F39E2
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 07:48:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="sWZ5/4fd";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270336-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270336-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 679FB3038A95
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 05:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48C35E1AA;
	Thu,  2 Jul 2026 05:47:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399834CFC6;
	Thu,  2 Jul 2026 05:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782971245; cv=none; b=KnFBs2LfwThgjQ9kGyiJP9qwiu934xCG+/QYaYQ5BmI57swZSZKPgMY557Wh6T+h8mmu3Gx1MZnzaVSl5KuW5lzmSUs4YIuz12Oyav0HhRfZ+XiCM8SaMsIsd95t96RxcG0FAwcVh1/YrBtPASDnHk4ZcApZAX50hYZAVX8FNQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782971245; c=relaxed/simple;
	bh=u58r3CefMbAywJbaVku/oZhOab/Wjy2zxF+O+Ztw3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqKg+n6BFrTcDdUST/gYMcxIQYAovH+UwnFwgwRbt+IIcWakTKA12L2esXWxinoIFQA2+Ug78a6U42CmmEFmZOs30S2wwCESon5QgBQFvmQtJ/ThbeeNY2CmivG8LThmZ6DvPTh2bUKYP4bMl1FXDh1zjUUU9iJZW/7gCgJE7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sWZ5/4fd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7C21F000E9;
	Thu,  2 Jul 2026 05:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782971244;
	bh=sXso+4GBnuKXjYgPtf84y9cD9NZXvUOFXFxPwbxDSJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sWZ5/4fda5pFsq8jQYD188mc73tARPLECCMdEd4amk+BG4YwjPUCtaJRdvTp+Afz7
	 e9Ek8a/aQ2Qfm6wZoL6Nn78DawaCZzQhjPIQUcJ8rc4uLzd66/5f5/jHjzCk7DfzCo
	 TNMx3FUBxOd7RfRNU9AR94cNC9qo8fs8rkaSuGik=
Date: Thu, 2 Jul 2026 07:47:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Wang Jun <1742789905@qq.com>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, libaokun1@huawei.com, 25125332@bjtu.edu.cn,
	Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: get rid of ppath in get_ext_path()
Message-ID: <2026070210-catty-grape-2568@gregkh>
References: <tencent_C982B0201FE8F041BD5B4FC1ED7D646A740A@qq.com>
 <2026062643-tamer-limes-a320@gregkh>
 <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rrsgndgpxyrmu6okb43u6wkdaibbidlbyqgugeeijd2b44sf4y@6lzmm4v4xvdp>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270336-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[qq.com,mit.edu,dilger.ca,vger.kernel.org,huawei.com,bjtu.edu.cn,suse.cz,linux.ibm.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:1742789905@qq.com,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:libaokun1@huawei.com,m:25125332@bjtu.edu.cn,m:jack@suse.cz,m:ojaswin@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B47B36F39E2

On Thu, Jul 02, 2026 at 09:48:33AM +0800, Jiayuan Chen wrote:
> Hi Greg,
> 
> Any update here ?

What is "here"?  There is no context in this email :(

> We rebased the 6.6 stable one week ago and also found the same regression.

What regression?  Again, no context :(

confused,

greg k-h

