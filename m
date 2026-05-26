Return-Path: <stable+bounces-254453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIPzGLEpFmqUiQcAu9opvQ
	(envelope-from <stable+bounces-254453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:16:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D245DD7BE
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 218D230480D2
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B093B0AEF;
	Tue, 26 May 2026 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTiUg2eW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E8173;
	Tue, 26 May 2026 23:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837351; cv=none; b=BNte1ZYatBEaB/m1Q1Vf2+lR16XPWjPCf1wHhTpMJnovDIb0t4tYkkkR32KDCN05JCVLr7joBD4zJLjX1u15OHqZG+emxuJnkF2TOA1t/w3PFErB4UPoKVap0RgLmM02aA/XDCyorqyK3cZx0In7xdLBHxB2BwHorsN0GO/Af0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837351; c=relaxed/simple;
	bh=Q09bo9R153WDkMsviQ9L9Hnbnv1FSrIFuB/OuA8Dybw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xt2qAt9eLNJ2Vcwo+lDv90CzshZ+0Ui7kOBdFbyt6fKtWoYsgDBiFRj70ECGeRwUySwaX9vCRcSFVuVSnGY2S1kB7zLz2Fpn1+caTDIaQiAwsQuha5JtVwxsBMXvyCLpCw61EQ8rFqXJVlsSLRDycFM19SfsbqVGuaCWid+wajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTiUg2eW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889C51F000E9;
	Tue, 26 May 2026 23:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837350;
	bh=MCGbQ9PhVibt4D9FhGBq/ohFPhv1Vpv/Vj2vmoVb5Co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NTiUg2eW3fqQ8rprBKXjx73F6AFiaW09Ogz6/LshOk+1FSyiIwy1JTkkmuZgqddsa
	 cWSs/A+T0ZnWaek8ZzJofggsGG0OWKd/yyB4CvGMCIqL7rSETu2jOcz7hyw8E1583q
	 Yh+JvBtKLF0JDgcW+d+aL4OrytyDy9K7x964blssxNwmJLmCuXVDQi3EHMPgvFHPP5
	 wLxXXzGC6VoioT/PWygYjv9PDmngp47KIczYwZG+FYjDCLx+S0mEbRAOhcotzCO3F+
	 kzMDbCAbll3+YMuXeG6D/die5ika0be1z2wVXClV265YwsxBThqP6BCqDPRhS2NoXi
	 tu87xaI+827Pg==
Message-ID: <90a1581d-9a3c-46db-bc7b-5fd1a9d9c0e1@kernel.org>
Date: Wed, 27 May 2026 08:15:38 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error
 path
To: Haris Iqbal <haris.iqbal@linux.dev>, Wentao Liang <vulab@iscas.ac.cn>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
 <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254453-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 00D245DD7BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 3:54 AM, Haris Iqbal wrote:
> 
> 
> On 5/26/26 16:18, Wentao Liang wrote:
>> blk_zone_wplug_handle_write() increments zwplug->ref via kref_get()
>> when preparing to handle a zone write. On the error path where
>> blk_zone_wplug_handle_write_noalloc() fails, the function returns
>> without calling kref_put() on zwplug->ref, leaking the reference.
>>
>> Add kref_put(&zwplug->ref, ...) on the error path to properly release
>> the reference.
>>
>> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   block/blk-zoned.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 42ef830054dc..24b899663a48 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -1503,6 +1503,7 @@ static bool blk_zone_wplug_handle_write(struct bio
>> *bio, unsigned int nr_segs)
>>         if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>>           spin_unlock_irqrestore(&zwplug->lock, flags);
>> +        disk_put_zone_wplug(zwplug);
> 
> I am not sure if this is needed. The code above adds the
> BIO_ZONE_WRITE_PLUGGING flag to the bio, which means the
> blk_zone_write_plug_bio_endio would be called which should then call
> disk_put_zone_wplug.

Correct. This patch is not correct at all. The write plug reference is dropped
in the BIO completion path.

Wentao,

You clearly did not test this at all because if you had, you would have seen
all the warning splats that your patch triggers.

-- 
Damien Le Moal
Western Digital Research

