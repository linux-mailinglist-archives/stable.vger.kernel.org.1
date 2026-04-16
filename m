Return-Path: <stable+bounces-238257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IW3pE4x/4GkKiQAAu9opvQ
	(envelope-from <stable+bounces-238257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1740A987
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 833A03079F32
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB335F5E4;
	Thu, 16 Apr 2026 06:18:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2E21A95D;
	Thu, 16 Apr 2026 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320308; cv=none; b=n2ie6NXpYX4m/iOSMPOW6t9wZYNdKy/c2a0mBY19teZvQwG1KbIiUpEjuXiEK1i1VJNiXoULiknsDdQiVYkIni/PK8aJs6mIRe+LU7VeOmXFkyHCyJyhXxyqyXDmVf9C1rnzgdkeyUyubifc9mIeM0txeFhTE0rtMSnA9VHAfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320308; c=relaxed/simple;
	bh=eCsKDa/p7lPGZvq1JXc4GFSpPGg9liwsR+o57QW8Tus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFUcl0A3wzWPRQfn1OXldHuqLExYDvXklADNRxadOdL6q1ZGEqtxdN7GJS7wIKJqAZ903guOyykjvydn5LkyOPg7MvsoVzXYqfQw5d6m1BWBDmijUc6jNJct77fpdzc5ue4/QpPrRj1/cfXX26U7zuHqjPwS/12Ekc5q0SJ/LfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5b13a2d1.dip0.t-ipconnect.de [91.19.162.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9C5CD4C2C37F01;
	Thu, 16 Apr 2026 08:17:28 +0200 (CEST)
Message-ID: <803b6b1c-6aef-43e0-89e2-3d0f1308e892@molgen.mpg.de>
Date: Thu, 16 Apr 2026 08:17:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] md/raid10: fix divide-by-zero in setup_geo() with zero
 far_copies
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, NeilBrown <neil@brown.name>,
 Jonathan Brassow <jbrassow@redhat.com>, linux-raid@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SYBPR01MB7881A5E2556806CC1D318582AF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238257-lists,stable=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fnnas.com,huawei.com,brown.name,redhat.com,vger.kernel.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,molgen.mpg.de:mid]
X-Rspamd-Queue-Id: F0F1740A987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Junrui,


Thank you for the patch.

Am 16.04.26 um 05:39 schrieb Junrui Luo:
> setup_geo() extracts near_copies (nc) and far_copies (fc) from the
> user-provided layout parameter without checking for zero. When fc=0
> with the "improved" far set layout selected, 'geo->far_set_size =
> disks / fc' triggers a divide-by-zero.
> 
> Validate nc and fc immediately after extraction, returning -1 if
> either is zero.

Why also `nc` and not just `fc`?

It’d be great, if you documented the command how to create such a layout.

> Fixes: 475901aff158 ("MD RAID10: Improve redundancy for 'far' and 'offset' algorithms (part 1)")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>   drivers/md/raid10.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 0653b5d8545a..811ea3d23b80 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3791,6 +3791,8 @@ static int setup_geo(struct geom *geo, struct mddev *mddev, enum geo_type new)
>   	nc = layout & 255;
>   	fc = (layout >> 8) & 255;
>   	fo = layout & (1<<16);
> +	if (!nc || !fc)
> +		return -1;

I’d also print a warning, so the user knows, what was wrong:

     pr_warn(md/raid10:%s: near and far copies need to be greater than 
0, mdname(mddev));

>   	geo->raid_disks = disks;
>   	geo->near_copies = nc;
>   	geo->far_copies = fc;


Kind regards,

Paul

