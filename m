Return-Path: <stable+bounces-66417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9398094E9BA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484BC1F21265
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479E16D4DE;
	Mon, 12 Aug 2024 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DCCC95wy"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF320323;
	Mon, 12 Aug 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454820; cv=none; b=fE8XfaV61Yb5tJVkeTJI+PIt+UaiUi33X/WvW334jVDuxxzH9eTyY6HqWi2+dsEQXXGk3SD3UNr2W3U5Ji8TtZPR1XWa1PO3zGkVdK8BiupLLVT+rglpnjHHIOzO5bh8A0kAgAQ7BJ+d9YB0QS1E/PFW/jJosrX2/EtqL9NG+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454820; c=relaxed/simple;
	bh=+TOpnq771vnp9m+jll3UhJCsuI4wccY6bIz5U2rAqKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncNqzPTOzIFNsdRiwlZ3PqgZH/YeDqDH1Wga6xqusRy9wELKSXkt5/9f5XbB3uQD6J7L9LrqriS62ciAigq0RFiELD0lutNJgna7g1+f7WHd8JrCajA6SO+Gba5Fzjyl2FmyOxoa0O+sFC0yOcf//Lr/7Xmyu4n+1h6yfyR3FwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DCCC95wy; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=wPeLYjeMosSUb2DOdkipv7FiyTkLh//sOcA6BT4w+PI=;
	t=1723454818; x=1723886818; b=DCCC95wyD3wohOCatXIGuNIgO4di3eRT/PWhoq168DSlhrL
	XdTPPjpfOllj5addbIlFJAqtplblb0I5MwPZsIPO83AVldBONVjMR308ImHbXeRXQDFy87UBCIgWC
	kbJp2q59xe96G23CvJzrb/saYPhfPFy5dtWSZTRQm1GEobQrq0Ca841JwNXeROk00bntOYrfp1BNe
	Pz90b/LwKIjHlV3GflAS+PE49/wdC8tiwEEnPkVvkzr8k5KtJWd4exGITWyzcGAzIoZmHCz8r+Nm8
	oN32EOMxUORMT+7rxslg3/RS6GrLoEYO53/zevcGWQDqgam3lcLFIZhAxPokUesA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sdRKJ-00078r-NH; Mon, 12 Aug 2024 11:26:55 +0200
Message-ID: <d224b165-14dd-4131-b923-1ef5bdf3fb7f@leemhuis.info>
Date: Mon, 12 Aug 2024 11:26:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED][STABLE] hdparm errors since 28ab9769117c
To: Christian Heusel <christian@heusel.eu>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>,
 linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu>
 <45cdf1c2-9056-4ac2-8e4d-4f07996a9267@kernel.org>
 <ZrPw5m9LwMH5NQYy@x1-carbon.lan>
 <1376f541-bc8a-4162-a814-a9146ebaf4eb@kernel.org>
 <df43ed14-9762-4193-990a-daec1a320288@heusel.eu>
 <e206181e-d9d7-421b-af14-2a70a7f83006@heusel.eu>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <e206181e-d9d7-421b-af14-2a70a7f83006@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1723454818;d05a56c1;
X-HE-SMSGID: 1sdRKJ-00078r-NH

On 09.08.24 22:13, Christian Heusel wrote:
> On 24/08/09 08:42PM, Christian Heusel wrote:
>> On 24/08/09 08:34AM, Damien Le Moal wrote:
>>> On 2024/08/07 15:10, Niklas Cassel wrote:
>>>> On Wed, Aug 07, 2024 at 11:26:46AM -0700, Damien Le Moal wrote:
>>>>> On 2024/08/07 10:23, Christian Heusel wrote:
>>>>>>
>>>>>> on my NAS I am encountering the following issue since v6.6.44 (LTS),
>>>>>> when executing the hdparm command for my WD-WCC7K4NLX884 drives to get
>>>>>> the active or standby state:
>>> [...]
>>> Yes, indeed. I do not want to revert any of these recent patches, because as you
>>> rightly summarize here, these fix something that has been broken for a long
>>> time. We were just lucky that we did not see more application failures until
>>> now, or rather unlucky that we did not as that would have revealed these
>>> problems earlier.
>>
>> It seems like this does not only break hdparm but also hddtemp, which
>> does not use hdparm as dep as far as I can tell:
> 
> As someone on the same thread has pointed out, this also seems to affect
> udiskd:
> 
> https://github.com/storaged-project/udisks/issues/732

For the record, three more people reported similar symptoms in the past
few days:

https://lore.kernel.org/all/e620f887-a674-f007-c17b-dc16f9a0a588@web.de/
https://bugzilla.kernel.org/show_bug.cgi?id=219144

Ciao, Thorsten

P.S.: I for the tracking for now assume those are indeed the same problem:

#regzbot dup:
https://lore.kernel.org/all/e620f887-a674-f007-c17b-dc16f9a0a588@web.de/
#regzbot dup: https://bugzilla.kernel.org/show_bug.cgi?id=219144

