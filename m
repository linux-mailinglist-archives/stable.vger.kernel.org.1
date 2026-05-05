Return-Path: <stable+bounces-244015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GthCwSt+Wky+wIAu9opvQ
	(envelope-from <stable+bounces-244015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:40:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D84C8C57
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 10:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31DC53042016
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A282F12B3;
	Tue,  5 May 2026 08:40:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0C30E828
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970423; cv=none; b=IPOnee5bGFvtpe7qPQI3hMHuwy0EGqWQp9OCtPFqDnrXnuhVvm2EhuXrq21g0idv5xTFFoADb9FOUfhuj6jFXIS3V3qD45/pPpInK7Ydjs8imO3nlikhrWJmaGx0oTjoPrc05+WQz7pnSWKU2fPt9wdhX5c8OAIDS2BfggYAZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970423; c=relaxed/simple;
	bh=0CPP07akC6/k5nrlMGh3g5zAgHAolOylhewhEvbOSd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd2ALaGrctkC7ROLuxxLequid1y7F+XUkM3hw3jspr13qDh5D12APUvIAxOeJVcBzFyaw+rX5j9tkDlvHBpg1aEEh7foOSk/5Z2IJlHdZOBi1KKtOTfrgU1qQz4f7hR/J8OI1/QtBn6vGNZzrss4RPAizoqaYvcMJnDaOqv52d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EABC2BCB4;
	Tue,  5 May 2026 08:40:20 +0000 (UTC)
Message-ID: <31002e6e-3983-4e30-aef6-bd2cd51aec40@tuxon.dev>
Date: Tue, 5 May 2026 11:40:18 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
To: pavel@nabladev.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 cip-dev@lists.cip-project.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Sasha Levin <sashal@kernel.org>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
 <afhkX2Ys2BG1gnqy@duo.ucw.cz>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A22D84C8C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cip-project.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nigauri.org:email]

Hi, all,

On 5/4/26 12:18, Pavel Machek via lists.cip-project.org wrote:
> Hi!
> 
>> From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>
>> This fixes an issue caused by the use of msleep during spinlock.
>> In the original commit, msleep was changed to mdelay, but this fix was not
>> carried over during the backport to 5.10.y tree.
> 
> Doing this as a quick fix is probably okay, but this should not be
> final version.
> 
> You are right that msleep inside spinlock will blow up immediately:
> 
>> ```
>> [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
>> [   62.683957] Modules linked in:
> 
> But mdelay for 20 msec inside irqsave spinlock is borderline
> unacceptable, too.
> 
> I believe we'll need Renesas to analyze/fix this properly after the
> CVE emergency is done.
> 
> This fix is good for now, but better fix is needed.
> 
> Claudiu, are you right person for this, or should we cc someone else?

I'm going to investigate and come with a better approach for this.

Thank you and apologies for any inconveniences,
Claudiu


