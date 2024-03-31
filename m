Return-Path: <stable+bounces-33855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9B892EE3
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 09:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8710E2822F3
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 07:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB58C15;
	Sun, 31 Mar 2024 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="X4UKbK4Z"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B678BE7;
	Sun, 31 Mar 2024 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711871209; cv=none; b=BIhMABHf3My1z1iw8/Y6gxw7APRMyeBuQwk+2OXih/Bp2kW1jPKZqToQxEFPVXHtm2CC9jCeRVFHuV8WPOlvOyf73zffFihtumGQSoa/svJgrs02GZOyVNiO3kQIAI3uUgVPAZRNuCnJqVAesRnVEFHKHOAz+HE2ZxcxMK8MF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711871209; c=relaxed/simple;
	bh=KNn8gendyO5QppVCZPykkXyafEl+PkFRKG8mC2hupUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkADwTEy+jcvgShsfoCPf2DGvJiYBiGj7q5mcGORWvpuWYftik1WJMy+wOb3U5stl6pu5vO8aS+MY84R3IHtr5pDs2FX9LvzYQ49tpZmeJTs1+e4YzILqZxcnS46jL+zO8Kd8trBZnftxMY8Q6LsLIn8Mm57Y1ZoHlVVPYlYKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=X4UKbK4Z; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=J8baHNjWLxAhYjJHaeGkedw4n7wQ2ZSdKhD0Ax69LME=;
	t=1711871207; x=1712303207; b=X4UKbK4ZLEjD05wElK8LF8BZtODVIRS6zuMFWIBCkJS3f2K
	SZfyvTa9viDea8RLkA724xtPOeMzgOlBloDcRVziN7BBz0JpT2avE12xDx4PTV1KijxGMxza51PD8
	WhWaDRgPb3Dl78F707hNVG9VL98r25rp8js6RZ/eatxWQD+++YU/81sEdfocYjS3n25DziPJc2Yy1
	EHpEeycFWRs+LWNVrR5Dh57lrsT5GQEhwlRLar0k5plrZxQemsi9HDC40vl6VA8nFlkmJ3gCpahMX
	RomleRKUFlRHUn8d67pjJDn05ie6ArnK5kXnzyeQsfu+77eqSunQtX1BGxU+ID0Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rqptt-0003aR-0G; Sun, 31 Mar 2024 09:46:45 +0200
Message-ID: <ce448389-bc61-4c71-85ca-e6c445e1a2bb@leemhuis.info>
Date: Sun, 31 Mar 2024 09:46:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] external monitor+Dell dock in 6.8
To: Andrei Gaponenko <beamflash@quaintcat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
References: <22aa3878-62c7-9a2c-cfcc-303f373871f6@quaintcat.com>
 <e9e23151-66b4-4d4f-bf55-4b598515467c@leemhuis.info>
 <7543f75e-6a96-8114-cef9-779594a36460@quaintcat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7543f75e-6a96-8114-cef9-779594a36460@quaintcat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711871207;ced07fac;
X-HE-SMSGID: 1rqptt-0003aR-0G

On 31.03.24 09:15, Andrei Gaponenko wrote:
> 
> On Sun, 31 Mar 2024, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
>> Does you laptop offer a HDMI or DP connector? Have you tried if that
>> that works any better? If it does not, then the DRM developers might be
>> willing to look into this.
> 
> There are only USB-C port on this machine.  However the external
> monitor still works if I use a small (passive?) HDMI-to-USB-C adapter
> instead of the dock.

Yeah, you had mentioned that.

>> Anyway: could you try to bisect the problem as described in
>> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
> Will do.
> 
> Thank you for your reply!

np, but stupid me forgot something (sorry): I had opened your dmesg
file, but not looked into it. :-/

I see that it contains a warning from nouveau that might be hinting at
the problem. Then I'd say: go and file a ticket here:
https://gitlab.freedesktop.org/drm/nouveau/-/issues

Please afterwards drop a link to the ticket here please.

But a bisection might still be needed; if you do not get a reply from a
developer withing two or three days, you definitely want to perform one.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218663
#regzbot title: drm: nouveau: external monitor on Dell dock broke

