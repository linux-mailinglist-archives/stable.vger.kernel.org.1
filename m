Return-Path: <stable+bounces-25724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A257B86DB44
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 06:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2E21C2129D
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F9451C2C;
	Fri,  1 Mar 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fg9cY+vd"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51C3FE23;
	Fri,  1 Mar 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709272403; cv=none; b=DClwS/FvRRKvhMLT9glWZ6G+BwY1NerM2fR6dhMRb/4Rui91FuMGMSqMHEvQf7lBY0LIKLlBb2kRtWu/hEc0FtNBJotZ9QTG2vtmySjTsuRPc9QuW30qOdf8b0ssf0UZu9WvM9oSCEQLBovriTIKywam80Ezn4i88jVqUHrcBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709272403; c=relaxed/simple;
	bh=5TgWZb4/KOE0mCOVJEt0Xmql79Rk7IHFG+Z2FeL2hOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWrJcjFe16zWiftiXDWMEjBeJkOggDyowiwFA3Fjxdfos9kWxKsiuhdu4Ropx33AX3lkwuNPIMvi4ll/Bug8K1E/hvB5mjC00TeLBTb6Vd+wKpF/aVUzdeI/OAPWVxnvOF7rMY+hGTq5lefssUNcwe9gv+WQOt33Zu96nFOY7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fg9cY+vd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ncXBQX+kSqn2nKAzLMBhXZ/NTpGfNX4QeH2wgUJQDLU=;
	t=1709272401; x=1709704401; b=fg9cY+vdRQ/5I1wx0xTsG4qDZg1EbxfVpZh9frGXqmf4pOa
	fYvJSOqMLW4UxAasulNfqeSkEwrtUYob0CLjYXE8m+sOotSN8n9Tlgz2onrfheEh5vsUDkv+PZkGB
	VUYonlLGxcsf6yWwUiS274ztj18gvzPIoGE8mq1QGJbDw9Pl07PK0is2FRv+ip2hi0h61I1sldYiI
	WkRaKPoic0lv8ZchRhgfCDUWsxPrPwBqOV5lGTERizWI7UiksEeGDTeTA/JBh2IuuatI+EWnIAFd8
	6Esvk+tgvpjiiSZa/h7NFIza2/dIqvjdM61zakYY21m2e41Hd/A7/g92g/nwcy2w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfvpd-00044Z-Up; Fri, 01 Mar 2024 06:53:18 +0100
Message-ID: <7639639c-7c63-44a9-81bc-f9093b70559f@leemhuis.info>
Date: Fri, 1 Mar 2024 06:53:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
Content-Language: en-US, de-DE
To: linux-bluetooth@vger.kernel.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
References: <20240226213855.GB3202@hostway.ca>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240226213855.GB3202@hostway.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709272401;a6bacc60;
X-HE-SMSGID: 1rfvpd-00044Z-Up

On 26.02.24 22:38, Simon Kirby wrote:
> 
> I bisected a regression where reading from a Bluetooth device gets stuck
> in recvfrom() calls. The device here is a Wii Balance Board, using
> https://github.com/initialstate/beerfridge/blob/master/wiiboard_test.py;
> this worked fine in v6.6.1 and v6.6.8, but when I tried on a v6.6.14
> build, the script no longer outputs any readings.
> 
> 1d576c3a5af850bf11fbd103f9ba11aa6d6061fb is the first bad commit
> 
> which maps to upstream commit 2e07e8348ea454615e268222ae3fc240421be768:
> 
> Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg
> 
> With this commit in place, as also in v6.7 and v6.7.6, the script does
> not output anything _unless_ I strace the process, in which case a bunch
> of recvmsg() syscalls are shown, and then it hangs again. If I ^C the
> strace and run it a few times, eventually the script will get enough data
> and output a reading.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 2e07e8348ea454
#regzbot title af_bluetooth: reading from a device gets stuck in
recvfrom() calls
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

