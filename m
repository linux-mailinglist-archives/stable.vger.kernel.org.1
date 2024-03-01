Return-Path: <stable+bounces-25750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E186E3B0
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B626CB2393D
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979539AC1;
	Fri,  1 Mar 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="A4IDRX5p"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3763984F;
	Fri,  1 Mar 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709304347; cv=none; b=X6rzcq8RVbG0FmwEaRdP2RPVoNyk+vLou/C+cOsPzjgL33yKwaC3SqMsPFlMFzmJkNlphQsAq8SPBQDzFk+0IoK2maq2kHLl4EZGnIrg8mx0V2LjjsTqsf7wR5o5B6fn9lsQ91FmJnyK6xYeUe2VguSJzSO0Pw9TvEdSCrZAOTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709304347; c=relaxed/simple;
	bh=4QLH3hE2S+z5IGf50KcUJjIxVIczQPhQjmmLNlgPVQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpjYBiRJMYLpOp19Ga9Frn7EJp+H6fCIfUX/xpdHSUqrdRzFSGZh0pDqCHF+EBHIr1jO/Wo6Wo8Ua1qZae4bmRfjpt6HAj57PIlXjjnXsHIjhGzfG9WEceZxNIb5gXMVz7GtG71x1u3x/eiKq+WTyd+Qh/GRrXstFTVex+ISMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=A4IDRX5p; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=K6eQV30rwyI05k/lIeSe0J0bdWqaOHSEWuwMEmSdXho=;
	t=1709304345; x=1709736345; b=A4IDRX5pvC16NXmxWenlSWAJVqMpI40oEAIcB4EDkeq+3ye
	lp9XZyN64S0NUpbZ1+Y18+djWwJotoxDFbESNAZ8aIZnXnJvrHX8cH3fBT4nukLjMxgRiqYxEcA7a
	so1BB5IQrQ34pPbyUMxijLbGimdp9KxC9wOS9IdG21B5jCXRzPQQ+RlkAwDBUd/kbkmEtd9kJsLfO
	41Q2p307Pyj6rnAvQ9tFZ+QxX33zco2xO4TiKnhO7SIXCqC49Pl2C5mK01fK/GKAoOSRc2jE1blai
	YeQsVSbgZZTbONgsJUpR5q9nomkew3knceo3IisClQo/iZqzAWGmPsXvauUVq6sA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rg48t-0006xb-6h; Fri, 01 Mar 2024 15:45:43 +0100
Message-ID: <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
Date: Fri, 1 Mar 2024 15:45:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Language: en-US, de-DE
To: Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709304345;bbd5c064;
X-HE-SMSGID: 1rg48t-0006xb-6h

Hi! Thx for the report.

On 01.03.24 15:10, Pavin Joseph wrote:
> 
> #regzbot introduced v6.7.5..v6.7.6
> 
> I'm experiencing an issue where kexec does a full firmware reboot
> instead of kexec reboot.

Does mainline show the same problem? The answer determines who later
will have to look into this.

> Issue first submitted at OpenSuse bugzilla [0].
> 
> OS details as follows:
> Distributor ID:    openSUSE
> Description:    openSUSE Tumbleweed-Slowroll
> Release:    20240213
> 
> Issue has been reproduced by building kernel from source.
> 
> kexec works as expected in kernel v6.7.5.
> kexec does full firmware reboot in kernel v6.7.6.
> 
> I followed the docs here [1] to perform git bisect and find the culprit,
> hope it's alright as I'm quite out of my depth here.

With a bit of luck somebody might have heard about problems like yours.
But if nobody comes up with an idea up within a few days we almost
certainly need a bisection to get down to the root of the problem.

I'm working on a more detailed guide describing the process, maybe that
works better for you:

https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html

It among other will make you check mainline and also 6.7.7, which was
just released.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

