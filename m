Return-Path: <stable+bounces-74035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E660971CFB
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F214328325A
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD41B86F4;
	Mon,  9 Sep 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j5e8vSYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08CA1EEFC
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893138; cv=none; b=KEx2iR3FWeiIrUVwm7mPOyBd3Iug22iAldm1D4EFAE2Lfrg+e6TqSY+VVo2Tw6l5DwjGXfoB/UnF4GVyNXXK1X0hhBGx3F0npssHnqXXJ+RS9R7eSpvYLF5QLG1uyAbglKWWuBemfpidOV96pJlnOSY2AA246tnokfiYxGDBOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893138; c=relaxed/simple;
	bh=tu1WESvjJz1TxKhL6ZHdnnNfXKaI92CF36oawF8CJUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdvNj+reUk9awsYlH4rtTdel2h4o/nLW+ie12W1LFIIbErF9Q+iS2LICFFaLHGOkxapWyw7lUkR3mvZ+inUFqVg44c5AvtgCH8hpy34WEDzHh3XMsgnlV+q6XdFzYRZXt+qV7H/mcTsloqinBAFEAWFa7/D04HPRR8FT2UM1A18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j5e8vSYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B647DC4CEC7;
	Mon,  9 Sep 2024 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725893138;
	bh=tu1WESvjJz1TxKhL6ZHdnnNfXKaI92CF36oawF8CJUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j5e8vSYkxgbar5HGoO8ZGrjB69d98jtCRDWJpMLFFF462pJaQyrW+VxXDVQEG9Tf/
	 69XEuP+yU/W8onEPYEXtoCele594ZJo93s/6NnIsBgmrC0Zgekrb93CdVegNpwHm0H
	 uBxpeEH29V5AMlKDg4nVgp33LTYClFVZEheEx0BQ=
Date: Mon, 9 Sep 2024 16:45:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Krcka, Tomas" <krckatom@amazon.de>
Cc: Tomas Krcka <tomas.krcka@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <2024090922-crawfish-congenial-33e6@gregkh>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240906154140.70821-1-krckatom@amazon.de>
 <2024090810-jailer-overeater-9253@gregkh>
 <E31564A0-FC73-4807-879F-DB5B3211C327@amazon.de>
 <2024090904-unframed-immerse-6db8@gregkh>
 <139A9542-CECA-4A05-AD88-1C06ED4CB8D9@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139A9542-CECA-4A05-AD88-1C06ED4CB8D9@amazon.de>

On Mon, Sep 09, 2024 at 02:10:24PM +0000, Krcka, Tomas wrote:
> 
> 
> > On 9. Sep 2024, at 16:04, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Mon, Sep 09, 2024 at 01:43:25PM +0000, Krcka, Tomas wrote:
> >> Hi Greg,
> >>  Got it, thanks.
> > 
> > Please do not top-post.
> > 
> >> Submitted
> >> v6.1 - https://lore.kernel.org/stable/20240909134012.11944-1-krckatom@amazon.de/
> >> v5.15 - https://lore.kernel.org/stable/20240909134046.12713-1-krckatom@amazon.de/
> > 
> > No 5.10?
> > 
> 
> 5.10 - is the original one https://lore.kernel.org/stable/20240906154140.70821-1-krckatom@amazon.de/ 
> 
> Or shall I re-post it ?

That's what my original response asked for, right?  :)

