Return-Path: <stable+bounces-198077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F5C9B50E
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C501A348733
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EDF30FC12;
	Tue,  2 Dec 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3WSzjeK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AA310774
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675013; cv=none; b=GwtCTmdw7issIZbQSUrk1Q+4sWK7Q2PopF49viY6hnw/Ev2dre+ZCduF5i3sKryVy52jkaP6NnM4kSaGA9dQaIx1wzKTIEzk/enwpXeI2gHD3OA8uzth7bRKM2BI8EF7wQpt2OMki+AF9nk8ptilTEvCvwc/FkXNxUzXym1pF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675013; c=relaxed/simple;
	bh=+rQI9VtRlxNH1e2CeyHIz1ukL1Ztc5nmfyKqKY99KGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZQgks4hWmx4Ah+6M+DazrXpaKLnSGoZt0g1Ov8L7AjCpPWjDNux1mNsvqWPJO84uUqlHn3ybIsOZZ4vwsTpZ39mNNPglDkmsFgoXPK6FDLdykLHGpr5O66XaAonAs4+OXBs179lxqDvpnIb3HopjJvlGeZDohTb5h3ELCjdnNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3WSzjeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E1C4CEF1;
	Tue,  2 Dec 2025 11:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764675012;
	bh=+rQI9VtRlxNH1e2CeyHIz1ukL1Ztc5nmfyKqKY99KGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3WSzjeKn/AFl5mIDe7g9LC+7qZeMJcDjeuJC3fYVRspdI5/kFTtdbOwQV2F0W9+5
	 NYZN8gEFz+OK/ZpFJoMzzBIWDYD33hxbWVKozVgjYv3nrvAKvCpoTX1S4IYjAyrvsx
	 0FJ+FM4gyVwhEWMXB9JH3dddd7rnroWt05CopuSg=
Date: Tue, 2 Dec 2025 12:30:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: zyc zyc <zyc199902@zohomail.cn>
Cc: stable <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOjYuMTIuNTAgcmVncmVz?=
 =?utf-8?Q?sion=3A_netem?= =?utf-8?Q?=3A?= cannot mix duplicating netems with
 other netems in tree.
Message-ID: <2025120248-operation-explain-1991@gregkh>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
 <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>

On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote:
> Hello,
> 
> Resend my last email without HTML.
> 
> ---- zyc zyc <zyc199902@zohomail.cn> 在 Sat, 2025-11-29 18:57:01 写到：---
> 
>  > Hello, maintainer
>  > 
>  > I would like to report what appears to be a regression in 6.12.50 kernel release related to netem.
>  > It rejects our configuration with the message:
>  > Error: netem: cannot mix duplicating netems with other netems in tree.
>  > 
>  > This breaks setups that previously worked correctly for many years.
>  > 
>  > 
>  > Our team uses multiple netem qdiscs in the same HTB branch, arranged in a parallel fashion using a prio fan-out. Each branch of the prio qdisc has its own distinct netem instance with different duplication characteristics.
>  > 
>  > This is used to emulate our production conditions where a single logical path fans out into two downstream segments, for example:
>  > 
>  > two ECMP next hops with different misbehaviour characteristics, or
>  > 
>  > 
>  > an HA firewall cluster where only one node is replaying frames, or
>  > 
>  > 
>  > two LAG / ToR paths where one path intermittently duplicates packets.
>  > 
>  > 
>  > In our environments, only a subset of flows are affected, and different downstream devices may cause different styles of duplication.
>  > This regression breaks existing automated tests, training environments, and network simulation pipelines.
>  > 
>  > I would be happy to provide our reproducer if needed.
>  > 
>  > Thank you for your time and for maintaining Linux kernel.

Can you use 'git bisect' to find the offending commit?

thanks,

greg k-h

