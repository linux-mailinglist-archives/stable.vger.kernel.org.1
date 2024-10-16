Return-Path: <stable+bounces-86429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814569A00FA
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 07:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4A71C24250
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFB18C033;
	Wed, 16 Oct 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fH1rs0sR"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC85221;
	Wed, 16 Oct 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058175; cv=none; b=hNaEQaDhaz22ONolobV2aUYNTtiqbZPdCp859osqvbikImES47UtlCW9y1+2L2yg65/2m6A1bZqeOK3pK8qCc4I9bt2m6VLqqFraQzZBWf7Y/EFO3P5KA8ncRwi8LzUPwb2QhFcEIUSsto3SZ5KOGB/1W6ilEtk0ODtjUJxjfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058175; c=relaxed/simple;
	bh=EVsQY8fPxvadPhWsnGUGb2WaQ0g3ANREtDe2FCLO9I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrwWTR5XpZQVqbtBMWqvl9y4AkekUax2LjspE4/JbgNs9KdTBn7j4qvruVSX95AhB5MxxgufaixuvQChoU7/O1yK7lUtD/dkWiZJGtcZNGaGLV/OOWAL7grXC8Ttn/R7fsz1kWbyCQm5DAuWyIExhT/2sRYDlgNdixHhgnIWlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fH1rs0sR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=OfDEy5CvavV94PaefN8qX3Rl0Kvh6OaxMiKj2+nKExg=;
	t=1729058173; x=1729490173; b=fH1rs0sRN0zjeP5Oln5pZ0TgLmeW/MOqlhhu1Z0GqFzLHZh
	qlMaabGc7B/F8ai4rClQv/ACtxepuZvDJF21GAPUl3pSkasB5VafPglfdJxrgeLguviFvPHjVS3W7
	LmQ7c2WZizEaEOQONSwL6g0HI8248P+cv9BAUzzf+bFnhJSbX1k+Z8ngnZjSBDAsMfi9eI62gn5lu
	qg2OErdrn1bgczRmutS67HlR2WHK7cBsKl/lf8jqS+VbXApx4rOrM3u5p8i+YSGuW/Fyh9/nLn7/R
	De9xuwPhOQXyEObBH2AifA1yHanFOU8UAjWJz495ouVIYxZWme1rasznNvIbFdfQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t0x10-0000xh-EW; Wed, 16 Oct 2024 07:56:10 +0200
Message-ID: <433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
Date: Wed, 16 Oct 2024 07:56:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No sound on speakers X1 Carbon Gen 12
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Linux Sound System <linux-sound@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
 <2024101613-giggling-ceremony-aae7@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024101613-giggling-ceremony-aae7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1729058173;7a816f2a;
X-HE-SMSGID: 1t0x10-0000xh-EW

On 16.10.24 07:42, Greg KH wrote:
> On Tue, Oct 15, 2024 at 07:47:22PM -0500, Dean Matthew Menezes wrote:
>> I am not getting sound on the speakers on my Thinkpad X1 Carbon Gen 12
>> with kernel 6.11.2  The sound is working in kernel 6.8
> 
> Can you use 'git bisect' to track down the offending change?

Yeah, that would help a lot.

But FWIW, I CCed the audio maintainers and the sound mailing list, with
a bit of luck they might have an idea.

You might also want to publish your dmesg files from the latest working
and the first broken kernel, that gives people a chance to spot obvious
problems. Ohh, and runing alsa-info.sh and publishing the output could
help, too.

Ciao, Thorsten

