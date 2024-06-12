Return-Path: <stable+bounces-50198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5581904B0B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8521F23F85
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4938DF2;
	Wed, 12 Jun 2024 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QdgDiqZO"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A239AF9;
	Wed, 12 Jun 2024 05:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171472; cv=none; b=DmUDjHrRzsbwJFGa+fypBmoaUqlEeZeALMTnAboKzRWRgJNGdpLyUd7p/eA4+V67OvLZufdKPWvRxO3TCnt9xvgLz3BWHE4E16Bnl7M1Y6FkIJXnaFjaw8ln4SIxgN/W0gEWRTfXoR+Q2kXdKzf3P8+Z3pIXmR7mPxcn/Pdi2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171472; c=relaxed/simple;
	bh=tcIe6lAwAoUmTJhobYIwK/ldOlcBBXDJTOmm8Z2AyKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYYdXxV3t6yD5GtEmynJgbMZKtnU3ntuFlkX2Qih24MMg0O6e6RrU08aJuIchXQX1KNULWNdQz/8SfD53wtDN4vpsEJCJV3Qgmkcy8psrtwqhGTE1dUbBgMQmNcU6gZ+Mkg88cZOEz9KPaB7trFQ2KJuv1/Qw03OrikF7SUEvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QdgDiqZO; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Cuiizet8ko146AQpF7HtdLDcA9QnFdSYLTJpg+Pci3Q=;
	t=1718171470; x=1718603470; b=QdgDiqZObqW4L1X5wykhaoT69DNodcsoO+rnxGZoU4dhF0E
	Rs+mJYO9SYEfTlX0dVnRAFLCDQawWtaw2nK/R/2IlhRMriUK8seZ5J1bPnZr9UoBCJ3POQ9s6vouq
	a5sU9vl8UNqjkkQxH4roE7PvrTxEF5JV9o33gpqM/fBMWG6c1PmLHkuEbKfIWs8pkyvv6S/VB4UE4
	c/FLGlsEK5AdFGOa/4i1+0wmV30GAfEbEdId73wwsUFmM/ae4aYv2Kgjnus1HEoVnG/ROVJYlWZAf
	Mgg70e9+VFhZiF3MA4BjL3IOmUxc7Q9lrCyMxSCYJXnVCNKTcGdyItQ0kZ9/ctmQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHGt2-0004qm-4S; Wed, 12 Jun 2024 07:51:08 +0200
Message-ID: <08a9551a-e368-4eaf-91b3-f5f716e1fda3@leemhuis.info>
Date: Wed, 12 Jun 2024 07:51:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential regression on Kernel 5.15.0-112.122
To: Xavier Boudet <xboudet@gmail.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <CAJ_Ywo+kJcgkPxgncrc33Rqy7Sn04j3g=euvCtYS8oFhH_wXEQ@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAJ_Ywo+kJcgkPxgncrc33Rqy7Sn04j3g=euvCtYS8oFhH_wXEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718171470;94350ba8;
X-HE-SMSGID: 1sHGt2-0004qm-4S

On 12.06.24 07:19, Xavier Boudet wrote:
> 
> I'm using Ubuntu Ubuntu 22.04.4 LTS.
> I upgraded my kernel last week and obviously there is something
> wrong with it.
> When I come back on 5.15.0-107.117, everything is fine.

Thx for trying to report it upstream, but sorry, you came to the wrong
place. That is a modified vendor kernel, so you have to report any
problems with it to said vendor.

See also the first few point in:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

Ciao, Thorsten

