Return-Path: <stable+bounces-254379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM3fG/O5FWroYwcAu9opvQ
	(envelope-from <stable+bounces-254379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:19:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A339A5D8873
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63FEC33ED208
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8E1401A3A;
	Tue, 26 May 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWeBpD1H"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C40400E17;
	Tue, 26 May 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807586; cv=none; b=dvd0BCCKncl10qiVV1ZeyRN7IINR8+6RqhJTrRi9ggELQ0AAI51lQlQlqlNw1TAGgL5a3jCCDyN7zmrM06/LIPFeUna7E/ghX5hGRbzyGpQw2vCanRT6Tku3FAqRbCHinpjIR/PaPY+unWWlFMtW/XodX7SYQxQ4onkMc9Yz2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807586; c=relaxed/simple;
	bh=lY5sYqBKb+AtZ4XOmflhgYPgxcRPHPReYfjft5d3W34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Waf7/dB+oC/zopyLnUQkuxblMplGWyGb1gb+mzqGbxY9jBumBYydoa/JD1v242QlTlleTIdsUDXwGYW3eSM3JymJzgIb0uVly1uxNc+873g/kAo7OkPmqc47mCXzSKGt8Gl7DVT8CYyLoCmNYnCvGIM2Nh5ebdgY6t3P0MRD4T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWeBpD1H; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbb8c50d-6478-466e-baff-20a6aeaca940@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779807581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gw2ho1TBqL0+84U+DbNJSQtrZkTGKWZZmLYfkdK9KKo=;
	b=iWeBpD1HTTjsY/2K5waOx5evkbXYYP64kHhAPU4tOPvs2q0USHj7Lm5tHSxZHVibQoNPoD
	FyPKmNlBUXzU/cRzTp6wS97YMcr5dhwvX1c85qzRg9VWcyxEH3bGIA/I7g2hOwAwIN6KfB
	EOTg6o5En732i7ZWiXoAAxpMILu9op0=
Date: Tue, 26 May 2026 16:59:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] block: partitions: fix of_node refcount leak in
 of_partition()
To: Wentao Liang <vulab@iscas.ac.cn>, Jens Axboe <axboe@kernel.dk>,
 stable@vger.kernel.org
Cc: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254379-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A339A5D8873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 12:21, Wentao Liang wrote:
> of_partition() calls of_node_get() on the parent device node at the
> beginning of the function, storing the reference in 'partitions_np'.
> This reference is leaked in two paths:
> 
> 1. The compatibility check at the top of the function returns 0
>     without releasing partitions_np when the node exists but is not
>     "fixed-partitions" compatible.
> 
> 2. The function returns 1 at the end after successfully processing
>     all partitions without releasing partitions_np.
> 
> Fix both leaks by adding of_node_put(partitions_np) on each path.
> 
> Fixes: 2e3a191e89f9 ("block: add support for partition table defined in OF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Looks good:

Reviewed-by: Md Haris Iqbal <haris.iqbal@linux.dev>

> ---
>   block/partitions/of.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/partitions/of.c b/block/partitions/of.c
> index c22b60661098..53664ea06b65 100644
> --- a/block/partitions/of.c
> +++ b/block/partitions/of.c
> @@ -74,8 +74,10 @@ int of_partition(struct parsed_partitions *state)
>   	struct device_node *partitions_np = of_node_get(ddev->of_node);
>   
>   	if (!partitions_np ||
> -	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
> +	    !of_device_is_compatible(partitions_np, "fixed-partitions")) {
> +		of_node_put(partitions_np);
>   		return 0;
> +	}
>   
>   	slot = 1;
>   	/* Validate parition offset and size */
> @@ -104,5 +106,6 @@ int of_partition(struct parsed_partitions *state)
>   
>   	seq_buf_puts(&state->pp_buf, "\n");
>   
> +	of_node_put(partitions_np);
>   	return 1;
>   }


