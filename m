Return-Path: <stable+bounces-240643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBKwLvBX62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:45:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07F45DF6D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB8243003493
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A233BED2B;
	Fri, 24 Apr 2026 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mDRfROvr"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE7E846F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031145; cv=none; b=XLHzOkwP0bq3VKnw3MSQQFdpLTObGRvoEcIkF32t26Pkw/ntO9Zvg57BCIAIvHXRFmNg60dvouoeSAHl/8labT8bwOaKpu7gFRrXW23NyQmGk9ZG78O0/ViLzgCYAZemlwxGxb5TYKDNghEju6v6Yhlvem6Hzr0Oeye15qwzMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031145; c=relaxed/simple;
	bh=jjjn4yQ01mGYuh+5NCHlPuPC01E7l4Ga5g6y4UjX9Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyXo+Cbk9nPzpsRHHXOwyZJKP+x5LQQap87IKDZ/BuaSfglip3hEoDfo+gl4O/NUiMaMgOTk/igKV4eq/+GswTMyXarn5p5a3GANH7YIdjfDOSqWva0/TIOZv2m+pXDx2mwoAHbF0AyIaisioOWJlSuOLv47uPzEZQCWjVTIhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mDRfROvr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A807220B7165; Fri, 24 Apr 2026 04:45:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A807220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777031144;
	bh=MMY5phplFfduMHmrYnCexVNSPpju0sSJXn0XHXbP6qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDRfROvri/p70pJRj6siAUgTDuBi+hEzGSZ3LMBTMdLstrIGdSjfdb0H3S4ljewJP
	 4KUVgQSyfHo820XjmGW641stP+YZOcCT90VSgQ+5RdzuGga2ITI4GPRF0pH4Qj8FsP
	 RMJskHbLfeF7R0K8advuAEiS+vkN4fr/XwAVJ3ZE=
Date: Fri, 24 Apr 2026 04:45:44 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>
Subject: Re: [REQUEST] crypto backport for 6.6
Message-ID: <aetX6JwQ72GEv80e@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aetVcb8pSITaiGg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2026042442-absinthe-reversing-8376@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042442-absinthe-reversing-8376@gregkh>
X-Rspamd-Queue-Id: 0A07F45DF6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]

On Fri, Apr 24, 2026 at 01:42:42PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 24, 2026 at 04:35:13AM -0700, Hamza Mahfooz wrote:
> > Hi,
> > 
> > Please include commit 35e13e0eacf4 ("crypto: testmgr - Hide ENOENT
> > errors better") in kernel 6.6, as it resolves a kernel panic.
> 
> I see no such commit in Linus's tree, are you sure that is correct?
> 
> > (you will also need commit fc0f08317135 ("crypto: testmgr - Hide ENOENT
> > errors") to have it apply cleanly).
> 
> I don't see that commit id either anywhere.
> 
> What tree are you looking at?
> 
> confused,

Whoops, I was looking at my local tree, the correct commits are:

6318fbe26e67 ("crypto: testmgr - Hide ENOENT errors better")
4eded6d14f5b ("crypto: testmgr - Hide ENOENT errors")

> 
> greg k-h

