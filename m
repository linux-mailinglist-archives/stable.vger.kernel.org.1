Return-Path: <stable+bounces-244017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPcdJiKv+Wky+wIAu9opvQ
	(envelope-from <stable+bounces-244017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:49:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA94C8E2E
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0C8A300C0E8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7703164DF;
	Tue,  5 May 2026 08:49:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236A30E828
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970969; cv=none; b=dyzAskXADyQJ7ib38muCZ6rCuibG0OdZEIR6pOUcFXqoe6T8+gmy6KX7UxMg8j3+riSXbCrUN+A43Zt5pFb/uaUTmMRYjiMUl9+OhRwBWOGtPgPWpsRIYobsFqOL9a3gb7CKAIowGjBJojtMzmx6Kh0HiWHpmBtOHLB71rPEWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970969; c=relaxed/simple;
	bh=kQSMDQsPAEM+eQeOAYOHoND1jwQRPyyGWV07lCVuy1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XWz/BGR5aD/hcEhkqOCbPG6HTZs5NngyP3ShIbypyTYto0E3kpzFTwJKSrVnCf0xVHkyqhhOX0+9Csb/k+nIlctkgmw/6C+GpXhEbEvo8QSBdLw+WFyW48hHQkTHt6O1NfSEAR09aqyTZjZyQ5vQQd0HZCvY25JMDUOECQ1eryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAA4C2BCC7;
	Tue,  5 May 2026 08:49:26 +0000 (UTC)
Message-ID: <f81033c2-3432-4275-b5a7-78c61c31502a@tuxon.dev>
Date: Tue, 5 May 2026 11:49:24 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: pavel@nabladev.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 cip-dev@lists.cip-project.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Sasha Levin <sashal@kernel.org>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
 <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Content-Language: en-US
In-Reply-To: <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51AA94C8E2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244017-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:mid]



On 5/5/26 11:40, Claudiu Beznea wrote:
> Hi, all,
> 
> On 5/4/26 12:18, Pavel Machek via lists.cip-project.org wrote:
>> Hi!
>>
>>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>>
>>> This fixes an issue caused by the use of msleep during spinlock.
>>> In the original commit, msleep was changed to mdelay, but this fix was not
>>> carried over during the backport to 5.10.y tree.
>>
>> Doing this as a quick fix is probably okay, but this should not be
>> final version.
>>
>> You are right that msleep inside spinlock will blow up immediately:
>>
>>> ```
>>> [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
>>> [   62.683957] Modules linked in:
>>
>> But mdelay for 20 msec inside irqsave spinlock is borderline
>> unacceptable, too.
>>
>> I believe we'll need Renesas to analyze/fix this properly after the
>> CVE emergency is done.
>>
>> This fix is good for now, but better fix is needed.
>>
>> Claudiu, are you right person for this, or should we cc someone else?
> 
> I'm going to investigate and come with a better approach for this.

On a second thought, the proper fix would have to go to upstream first. To fix 
the problem currently seen, could we integrate this patch as is?

Thank you,
Claudiu

