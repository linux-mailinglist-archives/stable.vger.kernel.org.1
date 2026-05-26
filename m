Return-Path: <stable+bounces-254427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDwZHFXsFWogfAcAu9opvQ
	(envelope-from <stable+bounces-254427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:54:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6B5DB996
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69E2B30344C4
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1433C0639;
	Tue, 26 May 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oqsssk50"
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A733BBD7
	for <stable@vger.kernel.org>; Tue, 26 May 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821650; cv=none; b=ZoVkp4YeqFu0I2DVmOlIyNdO+Bx/+/SltMCiq/bsa/IOWcIuqkI/PK080vAASOWDs17dOJvjycsF1+bhdU4Nq1BYG0xXyTVyYmbn2GZFibi3LPThRMaE+qgXmnqtKOGveulGMkJvUfd46UkA9FGBxz5I51rHCNKwvXAZJj3QJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821650; c=relaxed/simple;
	bh=FGzY0YZgR8w2b7dguwl2gBPZNAvUDtOzbOTH4ScfDGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryD5hEXmPmqVJ7MgE8BdTPXpcfqzL1wR0mIPp094CmlvrmBuhXit7xrJb6GG5kQ5dlOHRcevyU2/AHoIfHGvGpWwGDamjaYsbPtfdYQk0meIiXmbpkNAfjZudqt38UNNXwL7EUqq5wn3vhmIDjkJnmwio7qUjmWR4yw93Ya6ytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oqsssk50; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8be2a57-c950-46c2-b9d8-120b6e53da91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779821645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3Yznr35imLD78iltYGodRDSkRLN1y+2M8xTF22MycQ=;
	b=oqsssk50FituQxco+7g6Pay5nenbdkws/tioe59bGvqYH3CpgNFF7mxxyVB9myqiIHjfQj
	1VwHS93IJPStk2MRBix+/PazEeLyM6rfx9ArxiX68Rzm4pJifqwTAqKbIIgVLG8z+uPvWn
	xLpXd2s1XaQvsvv2xZ+mTu8K7ruOGE0=
Date: Tue, 26 May 2026 20:54:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: blk-zoned: fix zwplug refcount leak on write error
 path
To: Wentao Liang <vulab@iscas.ac.cn>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526141824.2293025-1-vulab@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260526141824.2293025-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254427-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 67B6B5DB996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 16:18, Wentao Liang wrote:
> blk_zone_wplug_handle_write() increments zwplug->ref via kref_get()
> when preparing to handle a zone write. On the error path where
> blk_zone_wplug_handle_write_noalloc() fails, the function returns
> without calling kref_put() on zwplug->ref, leaking the reference.
> 
> Add kref_put(&zwplug->ref, ...) on the error path to properly release
> the reference.
> 
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   block/blk-zoned.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 42ef830054dc..24b899663a48 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -1503,6 +1503,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>   
>   	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
>   		spin_unlock_irqrestore(&zwplug->lock, flags);
> +		disk_put_zone_wplug(zwplug);

I am not sure if this is needed. The code above adds the 
BIO_ZONE_WRITE_PLUGGING flag to the bio, which means the 
blk_zone_write_plug_bio_endio would be called which should then call 
disk_put_zone_wplug.

I do wonder if there are special cases when blk_zone_bio_endio is not 
called.

>   		bio_io_error(bio);
>   		return true;
>   	}
> @@ -1511,6 +1512,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
>   	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
>   
>   	spin_unlock_irqrestore(&zwplug->lock, flags);
> +	disk_put_zone_wplug(zwplug);
>   
>   	return false;
>   


