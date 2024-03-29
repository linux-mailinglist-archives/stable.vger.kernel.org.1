Return-Path: <stable+bounces-33742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A826189215E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 17:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9BF287E16
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F185623;
	Fri, 29 Mar 2024 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PBx+Aqjj"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455085636;
	Fri, 29 Mar 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728854; cv=none; b=d6+zbpi3ss+c4FYYkZnYZ/xRq4gvruVbc8SATyMC1Z9EUpsFgADM1Tj4zYksSBCmb8p8iaO8zj5FwQvgymwTj/hJUuNzeHKglldK1fbjQK2ImoJAyz3XPtWFVDh8bMFUvH4gZCiI42evVFEhhP2CBUafViHmMMuM9XXmw8XFMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728854; c=relaxed/simple;
	bh=i2wZH2CNvVHIqtarxVDuKNJBCbMqzcBWHMfPED1qheE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmT1XQtf4tZXO6ADsWfKSxS154McdkAlOdE6uDycw0BoCPnQOM6T1NjQzkZwCiKslfbyc1oF6BLtw27HP6cw2qiNrb9+vhSBLWiB/Xy/dxfjUrbP753s1UWvvNRBzfR897TAFh23FcO++dYjpLavdR51a8NOZFYU2pjMr3nGsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PBx+Aqjj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=9xsIHYLie0pvh9FebvDoNiQkO3Ms0+BZXLDiPJEuBz0=;
	t=1711728852; x=1712160852; b=PBx+AqjjCIzuGCV8j5fe/CSSJAGJA+6/2bJWDu9vf6k29OT
	yom1KqeM+Nh2WmIzs0bjfj5YX6EoRndBVU4J5XdQDC38xWW9wT7h3CgKzDMy2vQ5BzoRfluS06Ywf
	9/sm890cmEHtkJaVJXcXqoF4+XSsMKZXcOiQl5sVNs9nNUKSYkW3uz1KniwNWiqGGZIN4SLYVF54a
	PGx0oqRgE6GvMwZmw4KJsCkl9Ssv3RiQV9iV6Ct93CMqS/d90WJQa7/3xzv3MeeE9gzJZz61sNJ+4
	zZVY4X4O86d3VsskeS+JEfsDYNK3tAfHAuR9OHYQ/CekviFAC+j6YH3hYiqErIsQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqErk-0005vd-07; Fri, 29 Mar 2024 17:14:04 +0100
Message-ID: <2a4a2d24-2c4d-47cc-bc1b-30c309c173e3@leemhuis.info>
Date: Fri, 29 Mar 2024 17:14:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression : Latitude 5500 do not always go to true sleep mode
To: =?UTF-8?Q?L=C3=A9o_COLISSON?= <leo.colisson@gmail.com>,
 stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <1ee68691-9eb4-404a-adb4-fdaaf12c905d@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1ee68691-9eb4-404a-adb4-fdaaf12c905d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711728852;60f62002;
X-HE-SMSGID: 1rqErk-0005vd-07

On 29.03.24 16:21, Léo COLISSON wrote:
> 
> Since I upgraded my system (from NixOs release
> 2caf4ef5005ecc68141ecb4aac271079f7371c44, running linux 5.15.90, to
> b8697e57f10292a6165a20f03d2f42920dfaf973, running linux 6.6.19), my
> system started to experience a weird behavior : when closing the lid,
> the system does not always go to a true sleep mode : when I restart it,
> the battery is drained. Not sure what I can try here.
> 
> You can find more information on my tries here, with some journalctl logs :
> 
> - https://github.com/NixOS/nixpkgs/issues/299464
> 
> -
> https://discourse.nixos.org/t/since-upgrade-my-laptop-does-not-go-to-sleep-when-closing-the-lid/42243/2

Thx for the report, but the sad reality is: I doubt that any kernel
developer will look into the report unless you perform a bisection to
find the change that causes the problem. That's because the report lacks
details and this kind of problem can be caused by various areas of the
kernels, so none of the developer will feel responsible to take a closer
look. From a quick look into your log it seems you are also using
out-of-tree drivers that taint the kernel, which is another reason why
it's unlikely that anyone will take a closer look.

For further details on reporting issues and mistakes many people make
(and you might want to avoid in case you want to submit a improve
report), see:

https://docs.kernel.org/admin-guide/reporting-issues.html
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

Ciao, Thorsten

