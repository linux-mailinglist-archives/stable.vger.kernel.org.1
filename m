Return-Path: <stable+bounces-67544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430AA950D6C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 21:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7DC3B25D0F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3C1A4F2B;
	Tue, 13 Aug 2024 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b="S5WcwaWY"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BD1A4F1A
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578878; cv=none; b=MLeMNMbmdYqJIf3G4mfMngZ6OzIwOEac4Vk28nZardEDdwZJ1yAi7vrQPkl/uQPLzYJxETXxIllqS6nF5Eead/C93JRhLFkIdEU0yWWkFAsDwkYooDg7heN4tv+/rLa+UxCB+sw3c+fPdGyc0YAfYKkmj5vGvFEgnkIXI1hsbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578878; c=relaxed/simple;
	bh=gS67BgDPmV3smXCjYLNBei7PnUTvpUtKbgZkKyolsfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZakmaPwrEZNPlHGuMu2N1/I4iA1Rx5nz/DszLibYdjg9+XPYUy+uWZT4HxrTfPLPfK3cLGD02qrEqpdaRFgawIXr073oCgbE9dtNdZ3LwoisnsMCFa8yUC3V8P5201ZlYKzjsixzKlhVOTZ+cvCBKVKewZmhPgXHNtYw3gtPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev; spf=pass smtp.mailfrom=holm.dev; dkim=pass (2048-bit key) header.d=holm.dev header.i=@holm.dev header.b=S5WcwaWY; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=holm.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holm.dev
Message-ID: <12516acf-bee6-4371-a745-8f9e221bc657@holm.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holm.dev; s=key1;
	t=1723578873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybU5fZuGvqXMvEmK5ZQDsI/cL+5fGncOiEXqBYtLv9o=;
	b=S5WcwaWYef998RxsEapBTEXWJ9/BIxvWohuGtm8z1cbw+Mgm0wKLvQqStaPjGs0mIOXAPD
	LJLcpm63/ZXNi/FZ350MWDK12+yPZrjk9EtI9F+D6VCeIrUhvn0P1fMRIPAj+amPT3exU6
	FFMYG+HdX+mzDbeBBSj7L7kR4zMHjaRvHXWdix6raredDRo7f5SQuTRWNZuAMrxKbOP/rC
	O8pbWtG7+h1A7uVpBgAYi2JXE6koRRS5Mg7JtMk06wFrb8jFCnxt00KjqffwNMag4mFTDj
	ThH9iJKptvAgcvVuqyBjcXtWjTYvmPBbF7cTKFgorgvBIbpThtGfUuDGgveghg==
Date: Tue, 13 Aug 2024 21:54:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.10 257/263] drm/amd/display: Defer handling mst up
 request in resume
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Wheeler, Daniel"
 <Daniel.Wheeler@amd.com>
References: <20240812160146.517184156@linuxfoundation.org>
 <20240812160156.489958533@linuxfoundation.org>
 <235aa62e-271e-4e2b-b308-e29b561d6419@holm.dev>
 <2024081345-eggnog-unease-7b3c@gregkh>
 <CO6PR12MB5489A767C7E0B1CFAEB069A0FC862@CO6PR12MB5489.namprd12.prod.outlook.com>
 <2024081317-penniless-gondola-2c07@gregkh>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kevin Holm <kevin@holm.dev>
Content-Language: en-US
In-Reply-To: <2024081317-penniless-gondola-2c07@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13.08.24 17:26, Greg Kroah-Hartman wrote:
 > On Tue, Aug 13, 2024 at 02:41:34PM +0000, Lin, Wayne wrote:
 >> [AMD Official Use Only - AMD Internal Distribution Only]
 >>
 >> Hi Greg and Kevin,
 >>
 >> Sorry for inconvenience, but this one should be reverted by another 
backport patch:
 >> "drm/amd/display: Solve mst monitors blank out problem after resume"
 >
 > What commit id in Linus's tree is that?

 From what I can tell it's:
e33697141bac18 ("drm/amd/display: Solve mst monitors blank out problem 
after resume")

You've send out a message that it failed to apply to a few of the stable 
trees:
- 6.10: https://lore.kernel.org/stable/2024081212-vitally-baked-7f93@gregkh/
- 6.6 : 
https://lore.kernel.org/stable/2024081213-roast-humorless-fd20@gregkh/
- 6.1 : https://lore.kernel.org/stable/2024081213-sweep-hungry-2d10@gregkh/

To apply it on top of 6.10.5-rc1 these two patches need to be applied first:
f63f86b5affcc2 ("drm/amd/display: Separate setting and programming of 
cursor")
1ff6631baeb1f5 ("drm/amd/display: Prevent IPX From Link Detect and Set 
Mode")

I don't know if that solves the problem I initially described as I'm 
currently
on a different setup. What I can say is that it applying those three 
patches on
top of 6.10.5-rc1 works without conflicts and compiles without errors.

~kevin

 > thanks,
 >
 > greg k-h

