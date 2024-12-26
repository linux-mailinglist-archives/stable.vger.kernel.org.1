Return-Path: <stable+bounces-106169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2C9FCE19
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 22:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D6F3A02A9
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BC145FE0;
	Thu, 26 Dec 2024 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maeUfYg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323B13C80D
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249543; cv=none; b=lw5XL2jdp6I8relxEF0cTzGWOU3ojtoevKMUFtlMnLSStJ+UNhr41EhyolKc/oBFHxxJQcXHSdrhxQck6MyoDXuHgn0Nd3vwA5thgwB+5zOXVZ0Le+IkpxODUqNLdNSBAmQCzruX9pDsadMSzp54n7zg1VrNu767nN7ea4Wn2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249543; c=relaxed/simple;
	bh=7hdQ+Biv3Hy5U8TlsndUOfujbh4MSSo9pFjuAP58twY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyYG0Np6Dc3qimF7Mepyq5L3F3vVJ3erQo1KnRwjO/fPZS+H9lIfjbMmCyYIDwO4jaQYPBeTaaJ4aj6Wzia/tR1wYdJ3tOOfSYL3YwCLjvSTHX9y9XIuEpjtvwFNYwiKBLb78+h1MwDBKqKeYgriDuwMypHqopfW+napk+qhOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maeUfYg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04C3C4CED1;
	Thu, 26 Dec 2024 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735249540;
	bh=7hdQ+Biv3Hy5U8TlsndUOfujbh4MSSo9pFjuAP58twY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maeUfYg9yFkPxFmh+fhRvHjIWN+e+5ALUQy4yk8yU7LEPyWwXvG3H2BEHZEOmVWik
	 TyNwrVpDtFK7Oa8Xu/jXW4+k6Jva7vZ6VvwC0vm1I0Cp1+yJf4wBE3sz/H3t4/HAn1
	 YwjrDcmPZbYJPHOq0XHC17SquDUCv8N7PjwM8/fjMNq8+2uq7fKvxq9OHYaxbuXFDV
	 tLmnZYnkqVCC/68vMKUowIAz6b8q+t/L015Yt66HNAyR19uSCYO/8Di9CkI265617o
	 a4k2FKEdtXWfcMpkmH9aOjuIHISkEvpWnjcobhGxp6NXFdKjvwCyQrqIUlZZX8qqYU
	 fNRi4KdEPkfhw==
Date: Thu, 26 Dec 2024 16:45:39 -0500
From: Sasha Levin <sashal@kernel.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y 5.10.y 1/4] skbuff: introduce skb_expand_head()
Message-ID: <Z23Og6nGf-rJJ0cq@lappy>
References: <20241225192848-210522801797f885@stable.kernel.org>
 <ebabf38b-23bd-4903-b4fc-b2a12bd5c166@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ebabf38b-23bd-4903-b4fc-b2a12bd5c166@oracle.com>

On Thu, Dec 26, 2024 at 06:14:10PM +0530, Harshvardhan Jha wrote:
>Hi,
>
>On 26/12/24 6:51 AM, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> The upstream commit SHA1 provided is correct: f1260ff15a71b8fc122b2c9abd8a7abffb6e0168
>>
>> WARNING: Author mismatch between patch and upstream commit:
>> Backport author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
>> Commit author: Vasily Averin <vvs@virtuozzo.com>
>The only difference I see is that this patch has my signed off by?
>As seen below, the tests also pass. Can you please tell me what is
>needed to rectify this warning?

Nothing to do in this case, this will just make our review easier.

Thanks!

-- 
Thanks,
Sasha

