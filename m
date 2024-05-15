Return-Path: <stable+bounces-45152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA878C6376
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCB61C21ED9
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2657333;
	Wed, 15 May 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="auXRJCkc"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7C56458;
	Wed, 15 May 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764376; cv=none; b=i9PEq4IyCdalv4NAO35Zx/BRq+t5JR2lWLdhgvqSaQgcG3TbHj8PQaSG2//pKn8j+50+bHw8PLFPSI8Ll72tfz0NRUnU4bGF8AI6u/fVUMJ6P/zxYa83UQpiGgY7+g4O0ursunY+UrgmyeRzT1K/Laaa2wodxaVRKnSkenwqHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764376; c=relaxed/simple;
	bh=TTsEtprCxdUfO5ikvCApgameQ9WCVeqzkrls7BtfyBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KSPNzpSiZ1Yp0/u/9lL+2nFGBkBs6QMX1o7KysY46CCxUkueOeBHnZ/r1vC0mtSmAqF/uj6YhvVr7eQoPRd0tt6+TnJyQ/NdklHuxu/Z2oM27UCW08o4zudTZoe0qPP8vZiRccuOwDHDi7JdpP/PqFNqMxw+mm4XqrnV3zgDW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=auXRJCkc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ExKMvvECnZB5Wg1PzyuTiY6o/G3+BSWWytYUhdKnSSY=; t=1715764374;
	x=1716196374; b=auXRJCkcrBfTu1xRI/Gzp4ayso1IYH3mbqUxzGIaTFiDfa2qD9kWzxMasd3jx
	hfAtJhKviumwyJQj/F4zbCFZ48vgsRcjzhcQAPH1W+LI0R7zLrhKjEQPPzsq0UXaGLYrAjknESxH2
	s7AN44ZRNnT1xHZSSwh8ZN6/Fvv21Z2r6OFdIftJlXTYitvv8EDHgLnxHsNeRDhSyJzjk43xgjjCq
	wiWZdECtTj/gtSt5m7UaJba86woIClBkbHgQ5q8Nxxw85bjwid8sO3R1aiFLt2o9vubI94BhxeMG7
	KgXyFy3sIl1ZfwIGF29ZR05xcyIictiRHCvNcoTWZy6mjDvnQA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7Agt-00018z-Mw; Wed, 15 May 2024 11:12:51 +0200
Message-ID: <e4967bdf-f600-4791-b522-7f308ef9bd99@leemhuis.info>
Date: Wed, 15 May 2024 11:12:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix e100e: change usleep_range to udelay in PHY mdic
To: James Dutton <james.dutton@gmail.com>, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715764374;a400e4a3;
X-HE-SMSGID: 1s7Agt-00018z-Mw

On 15.05.24 10:36, James Dutton wrote:
> 
> Please can you add this regression fix to kernel 6.9.1.
> Feel free to add a:
> Tested-by: James Courtier-Dutton <james.dutton@gmail.com>
> 
> It has been tested by many others also, as listed in the commit, so
> don't feel the need to add my name if it delays adding it to kernel 6.9.1.
> Without this fix, the network card in my HP laptop does not work.
> 
> Here is the summary with links:
>   - [net] e1000e: change usleep_range to udelay in PHY mdic access
>     https://git.kernel.org/netdev/net/c/387f295cb215

That change is already in 6.9. Did you mix up the versions? In case you
did: it's scheduled to be included in the next 6.8.y and 6.6.y releases,
too.

Or am I missing something/mixed something up?

Ciao, Thorsten

