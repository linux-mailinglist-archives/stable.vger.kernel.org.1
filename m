Return-Path: <stable+bounces-83166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB0F9963F0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D97287CAB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB2E18EFED;
	Wed,  9 Oct 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RmoK8kmG"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF33218EFDC;
	Wed,  9 Oct 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463852; cv=none; b=EVswpFV1FBIoJ2CGTFCuQ+X0qAqqVVjNWLuQ8vFPL7ipT3GTv6BYqfyN1dLJsM0sMT/P3NSUlYSgmYTsxpdmxxFbwJnO6Br/UZY7zSRWT0LQvZw9dUCs7UqgvB7Q2TJI0I7fDOdsw4rOFYy/FtNsGyoJJHBUuyTX6BImqcsJOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463852; c=relaxed/simple;
	bh=FT2/Rf313385n2kDJ/fzhd3vYkbTbyyjBfPJKTF0mZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3YBkipLMOleX4lJwoyFKs1RvPLm+KSIS7MYt7tmhNXHUDRC4XJuLz6INojSfBW/ZR0KxxNshmHBfzrFNw798Fi7mzkLagfzmlP+WKuJ6Htx+4WvlFZNwlAs5J3BgpFzUqVVN6Q6a12vEOCfgVSr7L4jQvenos+dc46gQBOaO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RmoK8kmG; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=zceBOdFm7KRw5bjLOwysbg1+K5HqCb/PBKPvRDULxow=;
	t=1728463849; x=1728895849; b=RmoK8kmG3vZgDqaWQNm7Z/HPoZjwXkpdv34Uz/74yL4/yaD
	u9FYGsICnkhUxwWlGIm7dKL8y4hgNyuRrIQHGlbh0bt9ZhQiqO4VsXIhualoKtFPINataofLyL4tc
	9PVsFGsZ3ObEj5zLIOItNGTLST0mgP5EO7YrtSXpYdK+mVkVCjXGNH6Obm12VFNOUvYsQuSxQs8Mt
	ipQ21f/F0QdRUQVYaRUf+gUwdUDQLtUcWS95aqebqFJ8xJ+M2eikblHFuWEKHMpatQ5EP791iC3SF
	8TNFL701TKbO3OuYbDKZ3e1ayZ4gxxcLrr+3U0U+tHhJlIP3dfY/s+UmWSdmIDpw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sySP5-0000RH-RF; Wed, 09 Oct 2024 10:50:43 +0200
Message-ID: <f4f697fb-35d8-48a0-8299-c7020c4a0900@leemhuis.info>
Date: Wed, 9 Oct 2024 10:50:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Fix dosemu vm86() fault
To: Dave Hansen <dave.hansen@intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Robert Gill <rtgill82@gmail.com>, Jari Ruusu <jariruusu@protonmail.com>,
 Brian Gerst <brgerst@gmail.com>, antonio.gomez.iglesias@linux.intel.com,
 daniel.sneddon@linux.intel.com, stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
 <bd933e11-7836-462f-9b6b-5172301f188b@leemhuis.info>
 <212478a0-ab8a-4ed7-8dfb-600f9d81e7ba@intel.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <212478a0-ab8a-4ed7-8dfb-600f9d81e7ba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1728463849;5e2ecabb;
X-HE-SMSGID: 1sySP5-0000RH-RF

On 09.10.24 00:48, Dave Hansen wrote:
> On 10/8/24 06:52, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Is there hope that patches like these makes it to mainline any time
>> soon?
> 
> Unless it breaks something again:
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=785bf1ab58aa1f89a5dfcb17b682b7089d69c34f
> 
> ;)

:-D

Great, thx!

>> This yet again makes me wonder if some "[regression fix]" in the subject
>> or "CC: regressions@lists.linux.dev" in the patches would help to make
>> the regression aspect obvious to everyone involved. But it would create
>> yet another small bit of overhead
> 
> In this case, not really.  This was a typical email screwup where I
> didn't pick up that there was an updated patch that got appended to a
> reply among the normal email noise.
> 
> We've been poking at this pretty regularly since getting back from Plumbers.

Many thx!

Ciao, Thorsten

