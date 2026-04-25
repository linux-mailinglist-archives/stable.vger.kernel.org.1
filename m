Return-Path: <stable+bounces-241114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEhWCxKL7GmtZgAAu9opvQ
	(envelope-from <stable+bounces-241114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:36:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048E465B3C
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB5B9300B9E1
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839C389118;
	Sat, 25 Apr 2026 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="VqPABr0T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F235F5F4
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109770; cv=none; b=Rv4K6C0z4isz7t7XUDV69/58oCQs+XLYSLdgHjKcdH93uzKP8OnoVHTiJyn/4FVL8fnBm9tOEfHmh37yx/0pr/GLSQMKvjCIfhPvNGLWRMQTVsbQxsYFJ6kVsgiKws2laPu6EZ4Z08RKxYUOCmC5gKguW0jhTTTiPYFFI1Z/vlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109770; c=relaxed/simple;
	bh=5e6fX3sQdFJdLB1VGGOKAwcO2g4TlKf7rIlNNzyiiLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBciO2ejejATzVGnvBGKjVktTrxwddmjhNrhx2BZqcb5IPb3/JU/SYWIazJ/ZWsHUF+BR9SyEr9qP+96oheSOM34z+JHdkMfQvcsQd7Pkl5r7YU9YkgGp3ryHC/YE3D6nVWu6Gdj2slANxi59FdFpNpTWBuZvhsATtwVZMylps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=VqPABr0T; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so43975985e9.1
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1777109768; x=1777714568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSxxsg0M9lsnfvFXhmfiavy25zETA/dru9Yv7zXBB/8=;
        b=VqPABr0TGjmRPHW80VFyfwkrf1UbdFPHmfRs4WVdvlyQRTjzZCSJ9KTNQHuIqsU+0Z
         CLHBBZvAsLo9pfykIhvL2lIT51MDVetUBBAhRKNcJHM6M8x/Eb61yLMVHphJ6IZa4R6L
         1wsnruiR0u0fGWuukmIUShPR9X5la+xZYsPiZYfZLgzyD9Bx4+F8Cb/LINxHXECOK2Uf
         Rl2XNE1YKQl5Wvu8qE3Z6/gIwU9+vnfndiEQD5TYH4F01gxwg0Yuu/VwZ7f0qBaEsjhx
         ZEREJS+tzwzO7n3HoWW9qUC3yWUns4shw2n/FsAYh6B5NBSNl7g92m+wELDoP+CVnVjm
         RSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109768; x=1777714568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSxxsg0M9lsnfvFXhmfiavy25zETA/dru9Yv7zXBB/8=;
        b=CwnrHSZ3j3zAOdRne6T/J/kTM+n943S0FsQzEyT+uuhSyHkdcojby5j1vWmBeVV+cv
         CCx22yEZLiq6fI4V8L/JWZ9pWlxRTUI/HYix+ti/YgBV5SKZ4k/DQSBat+zNBYE/Jxek
         ikfom/3PBCpg++OMX93QYrXSpa2IU75HigIo1OPr3CNnnLal5pvllD/HGPhwiLdxB/tt
         f+UiuVC9tHbTnfE9a1ZWqx6+a6F4UDMA8/NNs2S3+j/Mglv6gnJzD3R6JKwzEFNqNqKD
         1hEyjKCkoyjkV+c1P6jp6mCPbT7w0VbpRKfw3qtZ2TsftIxoc8B7JtK2wCn17Pdl4KDU
         m71g==
X-Forwarded-Encrypted: i=1; AFNElJ9WmMIMeM6VleJewZOlTPVM6vTulD71Hkfsk99Bf3S7aU6vEiKmYdaZOxFhq67MGlG0xblKHm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMdNPA24xwVm06Cvx75rLQ9EGHGUjBcxMTp1r8PIdimTTH5jM
	pwmUFnT9hpR7UkQEmTrheQvh263ffeGwsbNUh6niw238ptQsWC269AlP+PuvuDwihTo=
X-Gm-Gg: AeBDiesBt0VecUYlCx+BqqhB4IUsO4yqCUmweZfcaXcb1ZUF2G1Qyr/nGiO+rnPiMBm
	vLNLUINXbpCiMwbquNQiIeKZyPJgKK9sCXFAvnnt8svUGVA/2hNv4c7u7CEVKUm5+6io6KVLHGP
	O2p7xjiWOzUR6V/qhEUaZp5Cg8GFnWcCs49/AMU9kZKbzdLspg2SV4s5g8QaMkzT+eD3fctk9pV
	9xeqjaud+P8LCX591sGmznC6kj1zA3TvewqAtR6fNOnFCwzcWH6KG/WmRv4OzpR5aSL33Xg6NL3
	GNWl0346yw25abEOZ/q6UOppRZjgV/B0rHGio8MpU6WzRmRWiigpR0uX56tnaz6FTCsx9QQDlBl
	DA57e58LhH7rJ4UOVSESNG93dIofSRekfXLjoILqypqdwTR1p3XAGyuHFOlaXb99cdi+Imm0JMV
	YxPxMALorkyi501cMKzFdJ
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a5821692dmr228002255e9.4.1777109767130;
        Sat, 25 Apr 2026 02:36:07 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm491347625e9.12.2026.04.25.02.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:36:06 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:36:05 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Corey Minyard <corey@minyard.net>
Cc: Matt Fleming <mfleming@cloudflare.com>, 
	openipmi-developer@lists.sourceforge.net, Tony Camuso <tcamuso@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ipmi: Add limits to event and receive message
 requests
Message-ID: <aeyJ0fClAWI2lBwL@matt-Precision-5490>
References: <20260421132544.2666174-1-corey@minyard.net>
 <20260421132544.2666174-3-corey@minyard.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421132544.2666174-3-corey@minyard.net>
X-Rspamd-Queue-Id: 8048E465B3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241114-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readmodwrite-com.20251104.gappssmtp.com:dkim,minyard.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 07:42:44AM -0500, Corey Minyard wrote:
> The driver would just fetch events and receive messages until the
> BMC said it was done.  To avoid issues with BMCs that never say they are
> done, add a limit of 10 fetches at a time.
> 
> This is a more general fix than the previous fix for the specific bad
> BMC, but should fix the more general issue of a BMC that won't stop
> saying it has data.
> 
> This has been there from the beginning of the driver.
> 
> Reported-by: Matt Fleming <mfleming@cloudflare.com>
> Closes: https://lore.kernel.org/lkml/20260415115930.3428942-1-matt@readmodwrite.com/
> Fixes: <1da177e4c3f4> ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Corey Minyard <corey@minyard.net>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 15 +++++++++++++++
>  drivers/char/ipmi/ipmi_ssif.c    | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
 
[...]

> @@ -410,6 +413,7 @@ static void start_getting_msg_queue(struct smi_info *smi_info)
>  
>  	start_new_msg(smi_info, smi_info->curr_msg->data,
>  		      smi_info->curr_msg->data_size);
> +	smi_info->num_requests_in_a_row = 0;
>  	smi_info->si_state = SI_GETTING_MESSAGES;
>  }
>  
> @@ -421,6 +425,7 @@ static void start_getting_events(struct smi_info *smi_info)
>  
>  	start_new_msg(smi_info, smi_info->curr_msg->data,
>  		      smi_info->curr_msg->data_size);
> +	smi_info->num_requests_in_a_row = 0;
>  	smi_info->si_state = SI_GETTING_EVENTS;
>  }
>  

Would it be better to move this zeroing to handle_transaction_done()?
Otherwise we reset the counter in handle_flags() ->
start_getting_events() and the threshold is never reached.

Thanks,
Matt

