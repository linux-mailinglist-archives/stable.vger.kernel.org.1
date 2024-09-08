Return-Path: <stable+bounces-73912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B29707A9
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 15:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189071C20EFE
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C72158207;
	Sun,  8 Sep 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mY0NpVb4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F263224
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725800533; cv=none; b=XOPTOu+4HFHK/JSIzgOE2EAWTFWCXVZrDrbUG6qhy3yxaHDZwIDf+N2Zcj9JvCdlVUr+rwGOwGcmVLqEP2wBUVjDJivPX6ImjFeaPC8krPSbrBTc5s8wUa8Ra4migeCN9tqTrw8n9JE7DAOoaHrfFealQJAbJWn1J6S7tPvqWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725800533; c=relaxed/simple;
	bh=JZ5PZgPuGXaPBgQ+pv06o6vsBzu8ON34vWtFO8FD/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKmOjiWMVdHky71krYk/kj32Gg3Vi0H8LR/dFIpuyE1+I0/tftRHMoD+3Kfs9rDMYQ636IYMvQi2e4euvwaIS464WIFwaHntzZN3sPu/V3Qf9evcr5oaMi2L+lW9TFQYgSAkeM/RYrK7GrPqOU7vYAXflCcN344vtGUjcMsEMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mY0NpVb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C36C4CEC3;
	Sun,  8 Sep 2024 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725800533;
	bh=JZ5PZgPuGXaPBgQ+pv06o6vsBzu8ON34vWtFO8FD/QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mY0NpVb4w5GLxz/XRFA8cq8Iet0CJhOaRV8KLode7K+8l9tYJfN83YCRu/uqj9Pvg
	 Cdumq/XrJSXzDU7tJ22/NzF5TlO/A0X+AvpIUcS95p8FTDG2bgrf1vOn4uhcwzY1tB
	 xz781+RjQOaLMKlkTlB1hWKLuCTDMLfI9H1rCoMQ=
Date: Sun, 8 Sep 2024 15:02:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomas Krcka <tomas.krcka@gmail.com>
Cc: stable@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomas Krcka <krckatom@amazon.de>
Subject: Re: [PATCH 5.10.y] memcg: protect concurrent access to mem_cgroup_idr
Message-ID: <2024090810-jailer-overeater-9253@gregkh>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240906154140.70821-1-krckatom@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906154140.70821-1-krckatom@amazon.de>

On Fri, Sep 06, 2024 at 03:41:40PM +0000, Tomas Krcka wrote:
> From: Shakeel Butt <shakeel.butt@linux.dev>
> 
> commit 9972605a238339b85bd16b084eed5f18414d22db upstream.

To quote the documentation:

	When using option 2 or 3 you can ask for your change to be included in specific
	stable series. When doing so, ensure the fix or an equivalent is applicable,
	submitted, or already present in all newer stable trees still supported. This is
	meant to prevent regressions that users might later encounter on updating, if
	e.g. a fix merged for 5.19-rc1 would be backported to 5.10.y, but not to 5.15.y.

I've dropped this from the review queue and will wait for all of the
needed versions to be submitted.

thanks,

greg k-h

