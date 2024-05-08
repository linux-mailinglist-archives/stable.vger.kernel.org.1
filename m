Return-Path: <stable+bounces-43445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83D8BF66F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 08:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A01C2117E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E61EB3F;
	Wed,  8 May 2024 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YZlV4hOC"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EF17C72;
	Wed,  8 May 2024 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150559; cv=none; b=YQ3mevV23QfgmdAg9f7kJ2EpBQVQY31yAmIg7/uv4y0GAFgB98s+PZphNcoeUHQqOVhbDda786ZIx7SXmtvJALhR1x3sNlXaJZ8qc/XW6C20ThQzVvfkvhVYqj3AyWhCHPZ9RyZXMcptEtW0kRGdiZtcWuBh83/N0WYv0LZl3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150559; c=relaxed/simple;
	bh=W5+RjvQrupUOshzo05DQOeCYGN1gl2cnaHf1ncfmML0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YXL2Rk2qPPxp46G7Bsy9NW6p+Z6sNklaTWNBQ+iKBsZtF7YtBAjEzJ5dMoXjKoKGW8JmQutoZ2hzHMFN8gKmHcoaWZXUuIFPFCDuZi0sWpABI9xBjgODLv7Czs1WQVrjEotP70dClV/8a16Ww6w3S2oDdE/i7A234FjPooJzIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YZlV4hOC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=3+lk1i0Pfak7ZUTq9+6fHflYwuqG8pna7IWBla3+L6c=; t=1715150557;
	x=1715582557; b=YZlV4hOCq16H/QThAduqKCZm2T3WZDx/oOegXPyijmIv3iywTXOiqfWYXZekx
	azPopif4b3sw38+lG09vXZVAF055A3zROywayUUVr8wEFWrkFr9I90zX4x4fsfl3tYdGI1qYyzdDr
	1kP9t0U4JPFkiIEQ8cfOdMlzPKI2wVOnW6TOosImhsYjlxsjqP98dd4I8TXcDWa0sOhU/kYbkwE5n
	AF6OaPhU55mJGY/DUkhlEgV9bT0byLMFLNyhPyeJPSi7G916q9LfiaYOv7udLG0GQtMv25ALbeBLE
	7zDRJoBDvEA2WAkLAtL2+3B+y4fU/5xVVBi1RqRPlAkKOkC2WA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4b0X-0008EH-FZ; Wed, 08 May 2024 08:42:29 +0200
Message-ID: <b93c9141-b749-4dd3-b448-17c1f30e74b9@leemhuis.info>
Date: Wed, 8 May 2024 08:42:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with Ubuntu 22.04 Kernel Update
To: Mandar Deshpande <mdman2257@gmail.com>, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <CAOi43pJoOvhMaYh-ArfDAVv+bOA+yMQXGxZmiL9xEwxtJPRzkw@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAOi43pJoOvhMaYh-ArfDAVv+bOA+yMQXGxZmiL9xEwxtJPRzkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715150557;35118d01;
X-HE-SMSGID: 1s4b0X-0008EH-FZ

On 07.05.24 19:47, Mandar Deshpande wrote:
> 
> I hope this message finds you well. I'm reaching out regarding an issue
> I've encountered with my Ubuntu 22.04 installation.
> 
> Up until kernel version linux-image-5.15.0-84-generic, my laptop has
> been running smoothly. However, after updating to subsequent kernels,
> including the latest one, linux-image-5.15.0-106-generic, I've been
> experiencing a significant problem.
> [...]

Hi, thx for your report. But the thing is: you need to report this to
the Ubuntu developers, as your problem might be caused by a change they
made between those versions (which are ubuntu specific numbers, so it's
not even obvious which upstream 5.15.y versions they are based on). If
you want to find help here by the upstream developers, you have to check
if the problem happens with vanilla kernels.

Ciao, Thorsten

