Return-Path: <stable+bounces-35596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A79D8951EE
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7691C22A43
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15265BAA;
	Tue,  2 Apr 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jYZE6pOL"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAAB657AD;
	Tue,  2 Apr 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057740; cv=none; b=jwT+sjhJrSdx3TQa2qmvx4c5vYIayAXx1xxbW6jHxCoYNx22Og80HXXvq/5PW7PSN4ib90AGZgChMjUO65LB6yyGNomilHQ3rfwmjQePr/NikGuqQ3wAW7ok2iwDyb6DcK1QfphOP1242FTYS4qVPFiOZr5o/inl0pPlsTEkcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057740; c=relaxed/simple;
	bh=q/eZjUWAugq5q/OxFoUEqB9Q/iPA9gpO4VsEYccFMtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6TmSkpW5v4CI2JRQrp+DAUJeEuc/UfmUwihrx5ChP4TIZtWDbCtv9AGHMjivQzWVeKYV/z2f/SXk/RJTJVUE80Pk1NPNatmNYX09YUw2DG3KgoPjRZorc/nHI84qvZ5LnpBrJCwi05I/zQOb9eQ2Wj+nEmG12PoZ7+jiMs6Wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jYZE6pOL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=7awxh5qbtdWbV+znG2uCAsRKZ70Rg1TLE8l9FPivOcg=;
	t=1712057738; x=1712489738; b=jYZE6pOL9CTNxFy4o4qhSgDd2FmLrrY+yPzf/48v7XwBj1S
	D90bq63kbNxBTCVvx1D7gZNNTTHPuBywceRMUnGYGIW/+68Ja9Q8Pc1pyGLl5AVn55vW8b+wesrK0
	bZ+xncx12TBBrlKzzqqucITicUDqne2loh/ZWObTAeiK4J3g31aHMXgu5hTNUrn08WB7s44KMvofg
	iyUtBVAbV4R+RXHkiscK/TpFpnhqLK9fX4/n/RfONiZjgljkiQc0GcX/q8LKHrev3xZWuAycDs9Ap
	a5kydLVIlW352hCwe2wvfFxOOGddagAOUTTYwN6FiZ3ssGYy84j7/ATZDrh4EWQA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrcQR-0002IY-3Q; Tue, 02 Apr 2024 13:35:35 +0200
Message-ID: <1c698f8e-c7ca-4909-8872-057d6ae149ff@leemhuis.info>
Date: Tue, 2 Apr 2024 13:35:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
To: Norbert Preining <norbert@preining.info>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <ZgvkIZFN23rkYhtS@burischnitzel>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZgvkIZFN23rkYhtS@burischnitzel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712057738;d6f7ad17;
X-HE-SMSGID: 1rrcQR-0002IY-3Q

On 02.04.24 12:55, Norbert Preining wrote:
> 
> I am running Arch Linux on a Lenovo X1 Carbon Gen 10.
> Tests are made with uptodate system, and besides the kernel no
> difference.
> The kernels are as distributed by Arch, but if necessary I can compile
> locally.

Thx for your reports. Nitpicking: next time, please report each issue in
separate mails, as mentioned by
https://docs.kernel.org/admin-guide/reporting-issues.html

 > Arch Linux kernel 6.8.1 works without any problems.
> Upgrading to 6.8.2 breaks a lot of things:
> 
> * Plugging in my Yubikey C does not trigger any reaction
>   (as a consequence scdaemon hangs)

Have not heard about a problem like this yet.

Could you bisect?
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html

> * sending of bluetooth firmware data fails with Oops (see below)

A changes that hopefully fixes this is in 6.8.3-rc1:
https://lore.kernel.org/all/bf267566-c18c-4ad9-9263-8642ecfdef1f@leemhuis.info/
But from other reports there might be more problems. Could you check?

> * shutdown hangs and does not turn off the computer

That might or might not be a follow-up problem due to one of the other
two problems. :-/

Ciao, Thorsten

