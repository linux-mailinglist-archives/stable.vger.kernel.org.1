Return-Path: <stable+bounces-177610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EF2B41F01
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA12E1A815A1
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634226E173;
	Wed,  3 Sep 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UOAM5t6c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VJLAYF3z"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C41E4AE
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902694; cv=none; b=CwKPETWyAJsUUDQZYWPWVSm03SW54zzU7S8MzPUy0rryC+aHyONDZ4ydY0++fx8IX5qWZItB+KBW8ww1yiG56D/5LYOOKZu69UHKc/ZXihORUaZNh8k+nlzsTuQu/lszwv73I8Bh8CFVLX6/24oY+/ZnFnxtDg6Q/PvgPszAYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902694; c=relaxed/simple;
	bh=HrUpVFtZR34C/OjzdyyKk7pu4bdufLulfSAe5JKADuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXXcuJ2JTTX8nDelq0Z21+aejQpAQGfnRBnkjpFprxdmI/uG2Dl6M1Gf0VIPQr+80E0qQNJOI17gH/F3cX8OD93dw2Z9DESqrgSkHSulacCtvq2DJenPygX7Ed1YdGg6JULx+lYbNeKerbOFHAWJ9ZY5XuW+fVv0k+T5RJXMVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=UOAM5t6c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VJLAYF3z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B34061D0026F;
	Wed,  3 Sep 2025 08:31:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 08:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756902690;
	 x=1756989090; bh=57X4OsnQsPF6M5+eY26JM0wi0c64Lqd+UNhWZSqiybk=; b=
	UOAM5t6csnWSzDqwEPvF73ry6GwAxQWZeWWRgeGmVUVa327XwwAx0FeKnqr4Gx56
	eP50UlQpTu0+p/JWf3ZenWDRJ6B5D0dvwDebsA9OQ62eUalm8nt8DyR8nTNEFAay
	PMoZU+VT399ij8zAZO2SrrCwmJLwLtszg8ivlCTi8funojyiIkJgUkTLk/iwmsQv
	t/t8X44GvMF9EP9YmnQHLRqBoEns1chwsF3NoVWS4uuthm1OczKs337hova6zM1P
	yA6qmI9ytz7EM4VmOfszBtUYYeQ/dt3r+UJ+nTLqJWHOs/EdIAvamTP9InUyrR9r
	LgLIJDbC/HBhiTz9xQ6Wdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756902690; x=
	1756989090; bh=57X4OsnQsPF6M5+eY26JM0wi0c64Lqd+UNhWZSqiybk=; b=V
	JLAYF3z0mSwl4GEAte8DpSbxzuHELJxM5Bp3Ffw0wfrK5iTCW25/VvwOVYeC59e7
	h7dbp3haIt5vaWsOh/FVx6sdctDotObLDXkOxOqM9Hh0LuAvKvHj9sJhMjAKcisj
	ybeVFRderue5AB2EXd5BjwBr38wNyowp6zEM8o/VfPuUVxQN8JFLfstlIOo1fytl
	nwwZ/p2xLlntJa3zGGyo/h/5+Pq+OnTyfLaG/Ikjt9Arv1aPmLb7aC8cNdg0EgtH
	2u36kmM+1Q21bP6JH32iZjHkcPfnw/OqFzZiIGQ656BXUothxz9Qa5JVhJ239DA+
	ZqDKyXRgbBfIDDqM1148g==
X-ME-Sender: <xms:IjW4aDPQpqJXHzbguPECO1Hv2Q-fyeM6Ck_IjwT1_-UHkiTfPp9UFQ>
    <xme:IjW4aPcT-gtZqXH4KoC_dpChj6Xrw7KiwPSv_kvSod4zb2EpWCh38pelpZ9xSfTO0
    8TpWEAfeG7DfA>
X-ME-Received: <xmr:IjW4aP5CxIO9otmtKVAYS8d2BU1-wNj8cU_GPIpMX8VOGu7fD5Qz3kV3sfSIfEsfbuxZ1ggxu6w3jRuxGnasEX0rGmzFixihw1qmIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehkeduvdeuge
    eiueeigfdtvdehveevueffgfdvieevteehfedtgfeutddvkeeijeenucffohhmrghinhep
    fihikhhiphgvughirgdrohhrghdpuggrrhhinhhgfhhirhgvsggrlhhlrdhnvghtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehk
    rhhorghhrdgtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheprghkvghnughosegrkhgvnhguohdrvghupdhrtghpthhtohepshhujhgr
    nhgrrdhsuhgsrhgrmhgrnhhirghmsehsrghprdgtohhmpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhlihhtvgihnhesnhhv
    ihguihgrrdgtohhmpdhrtghpthhtohepihhgohiilhgrnhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepmhgslhhotghhsehnvhhiughirgdrtghomhdprhgtphhtthhopehtrghr
    ihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IjW4aPJsqIEvyMnIrjYLMV_k0SKcCYNmdCypLMp8NH8LzcE9ny7Fpw>
    <xmx:IjW4aL5q2G5QtTxzSlzLDVhjAckhZzppRi57Qf-Lmu6_Jfe92ev3wg>
    <xmx:IjW4aGZG0xeHyPw72O3sG11jaPZARy2rHTTNkMtU0WONhteTVd61BQ>
    <xmx:IjW4aKw0V7LbhE_A9mfxYB-st3dEQJjP5mikHctpm9M1JEbxQb5_jA>
    <xmx:IjW4aLMoS0lxcju1rQZRobDgWWSI7kKRgG25IAtwdIn9itNHAzeh_NbK>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:31:29 -0400 (EDT)
Date: Wed, 3 Sep 2025 14:31:26 +0200
From: Greg KH <greg@kroah.com>
To: akendo <akendo@akendo.eu>
Cc: "Subramaniam, Sujana" <sujana.subramaniam@sap.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net/mlx5: HWS, change error flow on matcher disconnect
Message-ID: <2025090307-exposure-demeanor-c016@gregkh>
References: <20250903083947.41213-1-sujana.subramaniam@sap.com>
 <2025090322-nervy-excuse-289e@gregkh>
 <6c5efc80-9dcc-4943-9840-5e1046182101@akendo.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c5efc80-9dcc-4943-9840-5e1046182101@akendo.eu>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Sep 03, 2025 at 02:21:29PM +0200, akendo wrote:
> Hello Greg,
> 
> Thank you for your responses. We’re in the process of learning the process
> and figuring out how to get the git send-mail out.
> 
> This patch aims for the kernel 6.12 and backports the changes for the mlx5
> from 6.13 to it. We use the 1ce840c7a659aa53a31ef49f0271b4fd0dc10296 commit
> from upsteam to do it. We had to update the path within the patch to make
> the patch apply that’s the only change we made. We roll this out in our
> kernel and test it already.
> 
> I forgot to add my full name to it, we will fix Sujana's Name is correct.
> Please, I apologize for the puzzlement we might have caused.

Great, please fix up and resend.

thanks,

greg k-h

