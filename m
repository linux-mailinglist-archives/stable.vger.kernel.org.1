Return-Path: <stable+bounces-254646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DDDF6AyF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C5C5E8ADA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3129E30046BA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433E4657DB;
	Wed, 27 May 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkeYlKla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB43C583B;
	Wed, 27 May 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905176; cv=none; b=Uu+5hwwgD1kkSV1UYBLT80TS+pVeaOXXjI5sCfWzCX79GAXu1fupy88oW0H0aiCbTYnZH23p4PrzLDl3iNE5RNhbfaUasxv6526HgFrFPJzv1GUr9YO54CjFqL/ULNYKvFEiuMTGUz+FixXxn6OKaZPFKAGLNtln7ul0kchgrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905176; c=relaxed/simple;
	bh=4ynxLGq8Tq6N3l/4qPYz5DvdlYzFN3mdDCXp/vSoefc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PrEUdY/tqXIIF1Q7LblbNCUYQDDYSQYtcmrclMhOz6FmeFRUyv4ULnLvkuyAYfyW2LskS1pH+kDj5/egaAvaUUnKxaERwYkJ0V2hYpPNtrPWWYTT8lDGYjM5t2URAvP2+1rd3maQXUUL6ITGV1IK81NSPmadcVleaWR9p6/2mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkeYlKla; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0F1F000E9;
	Wed, 27 May 2026 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905175;
	bh=jqVJcUgPxUF+veB1WjKysV5XgWlSW8zAy9W8I7TfmWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XkeYlKlaOV4r9NQo+KZZMzid8GXX3wMD5sHbirRqLdS8jU+SLanW28ZcRbd+xhdn7
	 wTibJDx9/45Sx8YCANjmzR0zh8XZIbbjAOpP42FozftfnAshIiQie89gKUw+SrsiFH
	 jA5tUhc2uOcuqZC5Degja4N0s+rTbdoljYBXjirbpS9nFiNofiFU8vKXWpMLOaVnKQ
	 YC2iQJ1z12tVr7OtuVObxrq9ANhhRF2mGBkmt5nuJDnN5UKo9INA0tdxWpcOv6wpUI
	 N2Bo+ncYzaZNjPg5Fv1t9r+CFV/mDiv/VTrRKKTxRumYXyiiqPO3/K+STlX2crDRbY
	 UkUz62cUpcAug==
Message-ID: <b9f08e4e-d706-48fa-b11e-734bb4092b6c@kernel.org>
Date: Thu, 28 May 2026 03:06:12 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error
 path
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Haris Iqbal <haris.iqbal@linux.dev>, Wentao Liang <vulab@iscas.ac.cn>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
 <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
 <90a1581d-9a3c-46db-bc7b-5fd1a9d9c0e1@kernel.org> <ahbZRsqHKKbg9PSB@shinmob>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ahbZRsqHKKbg9PSB@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54C5C5E8ADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/05/27 20:47, Shin'ichiro Kawasaki wrote:
> On May 27, 2026 / 08:15, Damien Le Moal wrote:
> [...]
>> Wentao,
>>
>> You clearly did not test this at all because if you had, you would have seen
>> all the warning splats that your patch triggers.
> 
> FYI, the blktests CI run for the patch caught failures at block/017, zbd/004,
> zbd/009 and zbd/012.

Thanks Shin'ichiro. I did a simple manual test issuing an unaligned write with
dd on a zloop device. That was enough to trigger warnings similar to what the CI
reported.

-- 
Damien Le Moal
Western Digital Research

