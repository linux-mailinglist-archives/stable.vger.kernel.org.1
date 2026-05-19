Return-Path: <stable+bounces-249499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEo3LJYqDGqwYAUAu9opvQ
	(envelope-from <stable+bounces-249499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:17:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76557B10D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A48318BE55
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915993F165C;
	Tue, 19 May 2026 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HOAofCau"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6B3F6C3D;
	Tue, 19 May 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181586; cv=none; b=GsWBk8+Wnfw33lDp4ROraqJV/WKkJ+hhZHriFMbPVwEDDNLH7Bw4ciiTt0tkUFjsCdStkuGCUnGyCOmrx9dtpyOhZ8LizZH38B5fT2Wksn3IT7hcHWWNp5lSfjliLFzSopjfhUwU+3c3OvW874d8BkQ5k98qLXIIJdSEQF25Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181586; c=relaxed/simple;
	bh=YZ8qCa5hmacJ+0fwYw5u1WZFYIdWda7ROTjpCvycpWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lznyzOBCnu5z5lxuYVdWFAWAHX5vQ4JgDBYq5xC52cGSAF3/e9sYqVSRekYJ2LbkkUiETe7jEUS2fRKO149bR9FnEAdbpQDDd7h0DMwwKczLjpiEwX1YgJMZkwijhk5K+N1BhLywl1MjbzJVB7Q5OWYleMdHOi/0k0JpqaRDGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HOAofCau; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2EBE34FC;
	Tue, 19 May 2026 02:06:18 -0700 (PDT)
Received: from [10.57.21.217] (unknown [10.57.21.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3CC3F632;
	Tue, 19 May 2026 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779181584; bh=YZ8qCa5hmacJ+0fwYw5u1WZFYIdWda7ROTjpCvycpWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HOAofCaunu9kqKKbshr5Bv9mnrPJFV30N9w+YqVOHhLJs0wXjYRoT/gNbDEzKKw7R
	 42xowttsiloJZMQ5bWdM7yhJbg5wuo0MKQNqqZyg3ZEdjnaqQjJLSMQQ5kr2l1Jsj1
	 v5mjbnxM+YQuQGEBylikY81XL7JLvJD+65PxKLss=
Message-ID: <26091753-3806-4c55-a953-3f3006160239@arm.com>
Date: Tue, 19 May 2026 10:06:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: drop lookup reference in
 coresight_get_sink_by_id()
Content-Language: en-GB
To: Ma Ke <make24@iscas.ac.cn>, mike.leach@arm.com, james.clark@linaro.org,
 leo.yan@arm.com, alexander.shishkin@linux.intel.com,
 mathieu.poirier@linaro.org, peterz@infradead.org, acme@redhat.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 stable@vger.kernel.org
References: <20260519084317.1472444-1-make24@iscas.ac.cn>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260519084317.1472444-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249499-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suzuki.poulose@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B76557B10D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/05/2026 09:43, Ma Ke wrote:
> bus_find_device() returns a device with its reference count
> incremented. coresight_get_sink_by_id() only uses the returned device
> to find the matching CoreSight sink by id and does not need to
> transfer this lookup reference to its callers.
> 
> Keeping the reference forces callers such as etm_setup_aux() to know
> about the internal lookup implementation and to drop the reference
> themselves. This is error-prone and led to a leaked reference when a
> user-selected sink is used for perf AUX tracing.
> 
> Drop the reference inside coresight_get_sink_by_id() after converting
> the device to the corresponding coresight_device. The CoreSight path
> code takes device references it needs when building/using the path.
> 
> Found by code review.

Thanks for the report. But..


> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> Cc: stable@vger.kernel.org
> Fixes: 226443925887 ("coresight: Use event attributes for sink selection")

I would rather drop the reference in the etm_setup_aux, to make sure we
are still dealing with a valid device, that has not been removed under
our feet.

Suzuki



> ---
>   drivers/hwtracing/coresight/coresight-core.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 46f247f73cf6..2cca4ed83e2c 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -624,11 +624,24 @@ static int coresight_sink_by_id(struct device *dev, const void *data)
>   struct coresight_device *coresight_get_sink_by_id(u32 id)
>   {
>   	struct device *dev = NULL;
> +	struct coresight_device *csdev;
>   
>   	dev = bus_find_device(&coresight_bustype, NULL, &id,
>   			      coresight_sink_by_id);
> +	if (!dev)
> +		return NULL;
> +
> +	csdev = to_coresight_device(dev);
> +
> +	/*
> +	 * bus_find_device() returns a device with its reference count
> +	 * incremented. coresight_get_sink_by_id() only performs a lookup;
> +	 * the CoreSight path code takes the references it needs when the
> +	 * path is built, so drop the lookup reference here.
> +	 */
> +	put_device(dev);
>   
> -	return dev ? to_coresight_device(dev) : NULL;
> +	return csdev;
>   }
>   
>   /**


