Return-Path: <stable+bounces-20175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84737854B31
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E301F275DB
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D81C54FB8;
	Wed, 14 Feb 2024 14:14:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751654F83;
	Wed, 14 Feb 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920093; cv=none; b=JdlnixCoD9i4yjHvNRFqgEyPZqGFTR1T7J4j7dlVlEMSmO2S11JO/Xdi+fFSMgI8xiXAJDlOHjmncp3sumULT/aVpDp0TUQfnfUgmNMWQUN944xGvf3m/9T3k7KkJzMXr81HHwZ3jKXrAbiTgF9OLAY8yfC3gHQkkQVtbAqCI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920093; c=relaxed/simple;
	bh=WU5ye4sqffY/jrxVREVpJxv9BvbepfNs+ZpzUGDfugI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Klpnyjov039l7179VafVAvjJjCI5DZtIpvERys2FxmCPHQFTFJzB1sVHs2kmBPn5Zw7MFZxmSzmgGPoChRXFbG4HZGmBY1JIgWsN9anju3+0kLxbY/nDZWwppycrztmpPjyMDR6Fza/hdsrg7WE5XGmWVj5NnhRKmPJHaLYskI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1raG2D-0003d5-0J; Wed, 14 Feb 2024 15:14:49 +0100
Message-ID: <1c36c706-a2ae-4b9a-979d-2b75e8bb0440@leemhuis.info>
Date: Wed, 14 Feb 2024 15:14:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Acp5x probing regression introduced between kernel
 6.7.2 -> 6.7.4
Content-Language: en-US, de-DE
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <CAD_nV8BG0t7US=+C28kQOR==712MPfZ9m-fuKksgoZCgrEByCw@mail.gmail.com>
 <CAD_nV8B=KSyOrASsbth=RmDV9ZUCipxhdJY3jY02C2jQ6Y34iA@mail.gmail.com>
 <87bk8kkcbg.wl-tiwai@suse.de> <2024021342-overshoot-percent-a329@gregkh>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024021342-overshoot-percent-a329@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707920091;d4548704;
X-HE-SMSGID: 1raG2D-0003d5-0J

On 13.02.24 15:46, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 09:17:39AM +0100, Takashi Iwai wrote:
>> On Mon, 12 Feb 2024 15:32:45 +0100,
>> Ted Chang wrote:

>>> So the culprit was the stable commit 4b6986b170f2f23e390bbd2d50784caa9cb67093, which is the upstream commit c3ab23a10771bbe06300e5374efa809789c65455
>>>     ASoC: amd: Add new dmi entries for acp5x platform
>>
>> Greg, could you revert the commit
>> 4b6986b170f2f23e390bbd2d50784caa9cb67093 on 6.7.y?
>>
>> Apparently it caused the regression on Steam Deck, the driver probe
>> failed with that backport alone.
> 
> Now reverted, as well as on 6.6.y and 6.1.y.

#regzbot introduced: 4b6986b170f2f23e390bbd2d50784caa9cb67093
#regzbot fix: Revert "ASoC: amd: Add new dmi entries for acp5x platform"
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

