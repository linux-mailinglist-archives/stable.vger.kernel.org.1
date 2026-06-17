Return-Path: <stable+bounces-266641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H3JFLjkmMmrZvgUAu9opvQ
	(envelope-from <stable+bounces-266641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:44:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3AB69679A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:44:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=cf3eZ3iF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266641-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266641-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE08C30A6F62
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 04:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25631619C;
	Wed, 17 Jun 2026 04:40:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD484314D26;
	Wed, 17 Jun 2026 04:40:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671257; cv=none; b=O/ltXQwOk0DLTc2cha1/doJ+N5nWQUtWi/RjzG9qnfLAPL0HhmIDMlj/+lbuMx5zxQFmr+UWTDzoX1cqu7RBBYNugJSalyWTVhcVMBLUz5Y7XXx3LeWZ6AE4AQwPvVAhOobHkUyGLZGX2fAnJhcJLNPEqIzetaxJRnbru7aH7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671257; c=relaxed/simple;
	bh=jeMLXWMjkZOSCKidB9Ig3lqfbAWzmmdRXitq37KdODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrkUGOBzbWgjF4J9gOYz77UsX04t/wvYPuqUzyy5J3Mtg/QgubhFLoczjMCiM6/4riwpd/9xea4xzxL9P5xo8R0vcWh7K/K2qH2kiVXYu/JDBuue5bYOdm0gIvpiiJkfmzl/COxAeBe5z/CSBL4As91wPVra9b/L3kcbBuid5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cf3eZ3iF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332E1F000E9;
	Wed, 17 Jun 2026 04:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781671256;
	bh=YYGOyRobgw3DiFGGT2nTs5eAzw/evHI536sRpxtam2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cf3eZ3iFYQqGLVnWWZ3FpRZctSEoshPRxvi6EHh3esdOyV2+NbU9UJVQLfco/2910
	 C5RE9C9kO69gJhVc9n+Q2oQD/wsRL9U9ibMdo+ygHt9CpHxe2RLtc4d++lM29dFfdG
	 UvMov+80YQe3DaubTAsSbdLZ6gp0RycMz7PW53WI=
Date: Wed, 17 Jun 2026 10:09:51 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Zhenzhong Wu <jt26wzz@gmail.com>, Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH 6.6 343/452] bpf: Track equal scalars history on
 per-instruction level
Message-ID: <2026061744-lagged-president-6397@gregkh>
References: <20260616145117.796205997@linuxfoundation.org>
 <20260616145135.289901493@linuxfoundation.org>
 <ajHLK93Cbr5WdYqB@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajHLK93Cbr5WdYqB@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266641-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:paul.chaignon@gmail.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:sunhao.th@gmail.com,m:andrii@kernel.org,m:eddyz87@gmail.com,m:jt26wzz@gmail.com,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,m:paulchaignon@gmail.com,m:sunhaoth@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,kernel.org,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A3AB69679A

On Wed, Jun 17, 2026 at 12:16:11AM +0200, Paul Chaignon wrote:
> On Tue, Jun 16, 2026 at 08:29:30PM +0530, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> As discussed in [1] and its reply, this patch is currently breaking the
> BPF selftests on 6.6.y. I think it would be best to drop this series
> and wait for a v4 of the backport.
> 
> 1: https://lore.kernel.org/stable/ajCB9jXBzPyaDNSQ@mail.gmail.com/

Now dropped, thanks.

greg k-h

