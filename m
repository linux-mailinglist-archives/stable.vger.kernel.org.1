Return-Path: <stable+bounces-37998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D869889FCD8
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C651C22141
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92142179955;
	Wed, 10 Apr 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqlhmRVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF0120EB;
	Wed, 10 Apr 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766617; cv=none; b=t/bIE6HfcBGeYGbf9FOYfE7/DInKyHFwLmBOjv5wXb20XPoH4Y+G1HFVW7nRlkPb1CsJIliFrl7SapVuHij8yHITVA5LsiFJFnktIF/IwkyZROh3eOgzA/mdkXD+wbr7cyI8kz/eFkX8LB+NSJnz5B5LAjgOQGTqkIhmpIo1N94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766617; c=relaxed/simple;
	bh=4fwJ6KkDxjO4trdDAwONSY3YMZiL7kj612sMt4+83Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJoEk1UZ4yD3ZY7NtCVh0J0aNz1+FVnWbcwQUswFvm6CbMokJ2QzZMv1U0vIx3f2WSfOakXgxYhTArTGS60Wulh0kOG03Hp2KzDTDe4YDGkwnVZ1XTq/SMSPoGlCkwXd7vclzURwDQN6Qh7m2nDa72aXzMpurw+79G34y1A9NdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqlhmRVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A11EC43390;
	Wed, 10 Apr 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766616;
	bh=4fwJ6KkDxjO4trdDAwONSY3YMZiL7kj612sMt4+83Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqlhmRViXnGlFqUg5NRsS0Kknq1jRbV6Aofmeu5H+J74MXeXGT/7pDeOQrOvmTYfC
	 gTzuVc5XUr509nvQIPv9z+Orv//Xkk2WLgr0dggSmpdTyEXMROFYsGqlu73lOYsMly
	 AG6grUomYHfN2UMjYyDUpVSXDZ/1eBEVejUhWonvt4RqQisT8KRAbXmDy1T5oYXwQD
	 ALDbBBSFAFa8KH/iHtzAqu6kFnpLpzpE93HmMCz0rKdTshypFuwxtjbxYmz6JICCut
	 M/XtmnIHBgaP+uiEJ5OxKlr/mguCn5lsqO84jYJJa++if+n+87w4xfxBo0i+VSrSgT
	 gy387qJJE2zFw==
Date: Wed, 10 Apr 2024 12:30:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, gregkh@linuxfoundation.org,
	xu <xu.xin.sc@gmail.com>, stable@vger.kernel.org,
	vladimir.oltean@nxp.com, LinoSanfilippo@gmx.de, andrew@lunn.ch,
	daniel.klauer@gin.de, davem@davemloft.net, f.fainelli@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, rafael.richter@gin.de,
	vivien.didelot@gmail.com, xu.xin16@zte.com.cn
Subject: Re: Some questions Re: [PATCH net] net: dsa: fix panic when DSA
 master device unbinds on shutdown
Message-ID: <Zha-mMPa1PDnZvOE@sashalap>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
 <20240410090644.130032-1-xu.xin16@zte.com.cn>
 <09f0fc793f5fe808341e034dadc958dbfe21be8c.camel@redhat.com>
 <20240410143419.ptupie3hyivjuzqf@skbuf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240410143419.ptupie3hyivjuzqf@skbuf>

On Wed, Apr 10, 2024 at 05:34:19PM +0300, Vladimir Oltean wrote:
>On Wed, Apr 10, 2024 at 11:14:09AM +0200, Paolo Abeni wrote:
>> On Wed, 2024-04-10 at 09:06 +0000, xu wrote:
>> > Hi! Excuse me, I'm wondering why this patch was not merged into the 5.15 stable branch.
>>
>> Because it lacked the CC: stable tag?
>>
>> You can still ask (or do) an explicit backport, please have a look at:
>>
>> Documentation/process/stable-kernel-rules.rst
>>
>> Cheers,
>>
>> Paolo
>>
>
>My email records say that it was backported to 5.16:
>https://lore.kernel.org/lkml/20220214092515.419944498@linuxfoundation.org/
>On 5.15 I have no idea why not (no email).

Happy to answer why!

It was proposed for 5.15, but dropped due to build failures:

	https://lore.kernel.org/all/202202131427.SK7CctaU-lkp@intel.com/

The missing functions were later brought to the 5.15 tree via:

	https://lore.kernel.org/all/20230601131937.674646135@linuxfoundation.org/

At this point, Greg's current backport of the commit in question was
successful.

-- 
Thanks,
Sasha

