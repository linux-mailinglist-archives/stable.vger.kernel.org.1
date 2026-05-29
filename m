Return-Path: <stable+bounces-256785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA0wG9oGGmoY0wgAu9opvQ
	(envelope-from <stable+bounces-256785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:36:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FC9608F24
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DC1305A73A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC0347FC4;
	Fri, 29 May 2026 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scr584Dc"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989D1E9919
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090489; cv=none; b=HG+MqtFiWtLHf6rWbIDERzlbgDAIt+KpVAlU4zzO0/XDt5zPMsZQz1h4UexOzo0PKhy6rD8KwPez3S/SRPYDgKiLdvNd41o21bNjijK+dftWuZcPsWa3iqKNTodRiSL5D8xnR4gCieB2c90SkWE0PbwLdovzX+SzDeZG5phfTrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090489; c=relaxed/simple;
	bh=0lVNYjLEUNOylrDmCmQrYmtZ2GlOw+1H9dVCcihGSPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBqmXkiIe4bhztHZRN+gIsLKEt17STLbezzSHpOtKJhkXJIgwa/ImoV8Naz8sjF9QIRxmbtXJwpFSfUOPNCmC/2m+eMaDBwYqTyRPZaUW3c4GhJSDwUIaamLaJPklW0tVBQ8PnbS1k71eYGU7Vs5oEB1YqxUYApLy+z8xnw7/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scr584Dc; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1331e851faaso8042459c88.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780090487; x=1780695287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PHJD+WGMvI6ScOAGyvVweNtpM7wQC4AEbQ6AWYBlBPM=;
        b=scr584DcLKI0SBNmQ9BPbZyhebgYT9ZaHWDCubBX+MRbwhXRHP2Dwh5yFqNeUc81tx
         y17RzR4kxtrZlhWiI7+9O2TWSLxRQsgn4/F5oxlc/sScv8AFUGM5fqUYY+zWgLjN6mYi
         5Wv+BCRyU4I0N630z0WWgLlihk6RkWu6PPiwe1BxO8uwoKTH3MOqRmMB5Vs1y5HA+ddE
         EdH2MZ5PLNO0dkKzu6cvBdIwQiLXwwQ/RYhtSXq5DCrFDcYPXqfULH6KP9mAERDmM8Ol
         yIXIMou5MMqhzpya8+4kprLseclceiwRTGqVGc3ZCU/swXjwoD1rS6LHkydkrR/w9zr4
         omeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090487; x=1780695287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHJD+WGMvI6ScOAGyvVweNtpM7wQC4AEbQ6AWYBlBPM=;
        b=GpheBKCeJEibwFUcum+7DdJJUL+Gcivwbeb4k3egFYFkb76actfRmZchX9L5DWYhHz
         X4f7obDzDOXjeqtKCLbMBCnIqmF/GfwRpEQTJRnhMY5Q7SN2yasrTaY34RtKP0f1jNjj
         XKjkj903xRpoxcHW9/DqPmr63zpGpkSrGKlqvpn0p+cQqzBnWetkideJJ6eEBiD82alQ
         bmvIf3asajEGI8QkekzPCt0FOwHboJhSsqlpIDJmefYeji0yp8qp7qDJYGqiFuksqOzl
         8Nwk4IfxDfN3RayAPa1JCQGIK9X/nDnf0+/9RczGIo7w0PHQ6/fyKrPJMPQKcPTkS6Ko
         mWPA==
X-Forwarded-Encrypted: i=1; AFNElJ8KC5hemFgphLX0/aFiFBBZHlalxxoXE5keQka9pJ/JSe+lUQaWA+LRf5hrdKapWMeO/VqbVkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZ5BP9WzDAsET892eXwIOe4HGrPHfOS0KrRXE0ssFGcK16E05
	UUjhJs1Ah4wbyiS7xjm8xLuKQpO13uOL9c6a2lomq2jIZSESV40zGXAD
X-Gm-Gg: Acq92OGroOdNX5YJs1sGua3fLuvqYYCucJCZ/3xG+P9Nt1ebzpwhyTjQfduqD1h9dOo
	vkli+KueVHC6dlAIAgzPKad1h6qQ3p7PvDgZQvr6M3op2yLc3B6gMTrt2o51kh6rxrAEvnqkHxA
	hGZD7Mk8LubER7r/WeDhz17n1q9pTz0WHxdtnCgHG3Cf2kt+kC20shESEbR0txNurMmnZeMmr+X
	aiMe04xs83N9UMvD7s3Zp4mktyAUcLt/NN1v7ypZVOnHID8qweg4qwgbln81Wb6/2aUfgGK1fvo
	RwTvqpdLyKP7J4RvYAr1hO0aKNLxe7mVlG9PM4hEq0jzgq4JiHfkRdYF4K0n7VIY86lOtXzkOy5
	ApC9nivvUbtsr2DhSfFuSILs0RxdhGxL7C5+OSVGoaJ9v8zDuMBQP86Kjr6RRGeWlmZlqiFVnud
	ew0D9PP023nc4MClBwFXClTddc48DGqVURS/X0avjuObqic6OvCLinJMLTPsbJAA59xSwixb1zm
	ZU=
X-Received: by 2002:a05:7022:ebc9:b0:134:d3bc:b4b4 with SMTP id a92af1059eb24-137d43bc909mr444225c88.4.1780090486836;
        Fri, 29 May 2026 14:34:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bcfsm1970283c88.10.2026.05.29.14.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:34:46 -0700 (PDT)
Date: Fri, 29 May 2026 14:34:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
Message-ID: <ahoGOBmkc7i5ttxS@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256785-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C2FC9608F24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 02:59:45AM +0900, Jinmo Yang wrote:
> wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
> doesn't have enough space for the incoming report. If the kfifo is
> empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
> via __kfifo_peek_n() and interprets it as a record length, advancing
> fifo->out by that garbage value. This corrupts the internal kfifo
> state, causing kfifo_unused() to return a value much larger than the
> actual buffer size, which bypasses __kfifo_in_r()'s guard:
> 
>   if (len + recsize > kfifo_unused(fifo))
>       return 0;
> 
> kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
> 3842 bytes past the 256-byte buffer.
> 
> Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
> is never called on an empty fifo, and check the return value of
> kfifo_in() to reject reports that are too large for the fifo.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
> Changes in v2:
> - Instead of a size check at the top, add !kfifo_is_empty() to the
>   while loop condition to prevent kfifo_skip() on an empty fifo
>   (Suggested by Dmitry Torokhov)
> - Check kfifo_in() return value to reject oversized reports instead
>   of a separate guard
> 
>  drivers/hid/wacom_sys.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b35..489ca68f1 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -54,7 +54,7 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  {
>  	bool warned = false;
>  
> -	while (kfifo_avail(fifo) < size) {
> +	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
>  		if (!warned)
>  			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
>  		warned = true;
> @@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
>  		kfifo_skip(fifo);
>  	}
>  
> -	kfifo_in(fifo, raw_data, size);
> +	if (!kfifo_in(fifo, raw_data, size))
> +		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
> +				     __func__, size);
>  }
>  
>  static void wacom_wac_queue_flush(struct hid_device *hdev,

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

