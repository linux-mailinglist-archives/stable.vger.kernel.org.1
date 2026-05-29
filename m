Return-Path: <stable+bounces-256741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCzCI7rpGWqFzwgAu9opvQ
	(envelope-from <stable+bounces-256741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:32:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12F8607E6F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC087301AA45
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03853B388A;
	Fri, 29 May 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjMYfz6w"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0033AD528
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083077; cv=none; b=lXX3s/JHhTCj0ejg7AD1YSWmU0fYuRgaqQiJFmw0FDDpCxYFgDz4f9m+yylYvXm3D65BSz055oTvaMeBl4SOWKOc4xlj38Cc5abz3AKCV5YmtsM4iHK6hCV3ac3dlp+rpDQjeLmYlGmG1M1IDuriCNwTM8gWrUypWaYuWiu4QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083077; c=relaxed/simple;
	bh=zSJ4kB4tDIOBKRki3ZLehnLNadR+84J/X2etwho5jMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeQypZLPZJpG3NJ9fRoJVk7I3W3RH0bQYYBPitIYFa7eLZeM1Dno2wr1Gwz4bb+c558NzeJ9nBzcz22JAkdQlI+0OTLK8v47MDL/h0RFqYqBPzrWke9l+x9PNcg/wlr3/M0pTnn3AGBk0fP0ymTiQTVRlu8VTJnX8kbCQl3WmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjMYfz6w; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304e6c6464dso2913211eec.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083074; x=1780687874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YZwbJmOdj/CzDOJRzvaxizYubzK8nMz96rk/mNhROM=;
        b=mjMYfz6wGEPLh7wkt52IxKisSFcuB9mEu76Jck4vDbmAOZEo+1NemqRNVfwAkvEEe1
         Ns9jLKmtUiVNOLMZ35dA8RqP7KqgzU5olzzh7IeLnRjdxh5EDUAT10UENKOYOeKIknEK
         07q2jKz/yGNHUhXrQHwTbBey3DPgxJviEmRXMRzE8DpK4E8/+PQ0Tf2LtuoWw5Ed7Ul5
         01RNE/99w2eVOgtw3yPwcRotMkgqAeodclzNac1AiNsGJnJVqhHIpigUxnlb3DZQdRR5
         ciFDvVL7++9YeTaBnt/W70ecwp74xYw4oiER03Xlvm+wtia4KzQA0sVJcEjPoKg0V6UT
         npwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083074; x=1780687874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YZwbJmOdj/CzDOJRzvaxizYubzK8nMz96rk/mNhROM=;
        b=Cx7d/T93qvqy5HfVNQrGBcD6sTV+U+T1SVnjlBNkPives+g2KH2GFd+aFeeB6jE0JM
         cHcaTTLwLbkbqYefPjvq+moaVJXw92xhNrOrMq6ahUPaFEOMj1NwZq4XFEIEBtf7Rexp
         j381cZohnqfRlyFgcYmp8sA4dmWkAH1BgchoPR+69jTTtGhayegvW8yVW34HU5MgOpvs
         iWMMtx/CEpTfQZeoiqQ/QxsecvsMUzQRycdAoFyOMESM6MjIxXAOnNMvliMEf2Q+VLib
         XAwanBCFAvfPTO3WCy54/E3X1QTbO92jeJrpa08pRCNkxs8qjr5wa7f1dfmZ5wU13ef9
         POWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Bhdp2YLPFo+Srj//NEoBalGSqVtZ6PMviy7Iq5/GkIKJds/sGZ2cYmsnhpJlE6an7nOTYWgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4miJ+RQoRukRwxMhg48t1VsuVbH+dwQQpRWdZsHoFXtD3YFM
	dmEN+JTZYGP956ozPvHMaguKvq/zMFOI6e0OFsVrM+CT+Af22Zr4q+meba7uxw==
X-Gm-Gg: Acq92OHmR730VbC7hgxQ2rjInljVLyOIJzQzhRqc9Pe2odSJWvjdDqxeB0L6CLNpB1S
	CuJou5q+te0MDjZyDdewjsNmCxn+GTlj2BgXt8NQFVMNyb4DRz94TuqdElwPeeDeAgYwIbq44PB
	KxZrVsLD3nsmAB/qX1svUynFf6VXX1WLwWLt58bOhepXwZfOS3N64Qh0zvLjUsrMg0+kdqXOhJG
	FTyARcjqOiStXRVa2CEnYsuk/zUR+52hfYnFYIQlms2CqoB7yrukFmT8Jb39grTZHPqUyAh7Cj3
	idRZIdb3kd7bLd4c7vA3eZRZ6hiMn+q5tWwUkv3OXFAtZTlIuQEmpe5pTbj4T6zbmW6RtvhhtAI
	+nvUjxMU8YcQFWlVhl76PRqYpQil9KH1LaatcWAEWuPzRZn2pGfa4bq3IRLl1FRgdeljz78tvLn
	LiHUcvafvTopJVqK2IXlfUihBc1d67JFeyrd2yt00uqnpy+X/HZGivNJnn93OrxurPZ/YB1RJaE
	jE=
X-Received: by 2002:a05:7300:5726:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-304fa523d3amr696259eec.3.1780083073492;
        Fri, 29 May 2026 12:31:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2efb4esm2188760eec.8.2026.05.29.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:31:12 -0700 (PDT)
Date: Fri, 29 May 2026 12:31:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-goodix-spi: validate report size to prevent
 stack buffer overflow
Message-ID: <ahnn8iPJP5nbN2rS@google.com>
References: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E12F8607E6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 01:42:47PM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> goodix_hid_set_raw_report() builds a protocol frame in a 128-byte stack
> buffer (tmp_buf), writing an 11-12 byte header followed by the
> caller-supplied report data.  The HID core caps report size at
> HID_MAX_BUFFER_SIZE (16384) by default, while the driver does not set
> hid_ll_driver.max_buffer_size and performs no bounds checking before
> copying the payload:
> 
>     memcpy(tmp_buf + tx_len, buf, len);
> 
> A hidraw SET_REPORT ioctl with a report larger than ~116 bytes
> overflows the stack buffer.
> 
> Add a size check after constructing the header, rejecting reports that
> would exceed the buffer capacity.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> ---
>  drivers/hid/hid-goodix-spi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
> index 80c0288a3..288cb827e 100644
> --- a/drivers/hid/hid-goodix-spi.c
> +++ b/drivers/hid/hid-goodix-spi.c
> @@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_device *hid,
>  	memcpy(tmp_buf + tx_len, args, args_len);
>  	tx_len += args_len;
>  
> +	if (tx_len + len > sizeof(tmp_buf))
> +		return -EINVAL;
> +

We can also consider returning -E2BIG here.

>  	memcpy(tmp_buf + tx_len, buf, len);
>  	tx_len += len;
>  

In any case:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I think we can ignore Sashiko's ramblings on this patch, it needs some
instructions detailing order of operations/timing of callbacks in HID
subsystem.

Thanks.

-- 
Dmitry

