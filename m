Return-Path: <stable+bounces-233108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EMgENTQzmmUqQYAu9opvQ
	(envelope-from <stable+bounces-233108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:25:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D338DF35
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 859FA30214CF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509938B130;
	Thu,  2 Apr 2026 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+sfZfYR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7736C0DC
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161524; cv=none; b=QdQZmUoav4ivnvMjjp6e+dJDn3YJrqDKGXE1gYRHIs4MUw+LMh/RFE2LoeFycHGJh0T7GwKpaII6nAdEXNdOYsuBV+/W+3C1yUDUhBK7gdS6SZspTIB4nmjLKKFAA9Ps2Dhg8LDTw+2mjIzus7esfewAZkM9pagWWVrgymIOsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161524; c=relaxed/simple;
	bh=M+ygnrvbd1t83GBCmH+solpxR3l4QjrCqXbvg1oenBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWEDjKmHrg9AfDgsQKb3d0UKPVW0x9WEb8+tmuX/5jJ50HGLj3A9DKsUBGXfqhG7atmZirtYbvPdIa8hzuoIsUJ9M3l2z/h6AiVgPpkp5W5jVkcTaKxNn7kfKsXDt1AMMmPPRGVLwec0PKhIJ1rHkxSgsZ86MSzsj2HtVH3w8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+sfZfYR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso13829735e9.3
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775161520; x=1775766320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jcc1hZOquhNmlP9pXmTrYcA0fCA/28vP38rmU1pTwc0=;
        b=Y+sfZfYRU/TjPxABK0xcx0Iv5Gfqas27zmnl9HFq5aCJPo0+ET7XuXxu/DWfESeqjp
         phoTe8SBFP4/8LBNRRwuCGjC57y4o/jRF8Moe7sQfZNkwpkEKeBdArmiGnj0dTkZDgf6
         Kl6ULtfefHtggY6/uNG6IARPp84qMN57l5aUDtLX0wcHAjNsNrmzffbhfsCKhQVIuW/h
         qrbn6M6UPWCkYMO/fuECnB4+9qahSqwLc5VAiPZA/76BtSUAoH0FftJB/d5vYjkFWPMB
         JkZp63aJu9oXLook6PzGQkcvzauIQYQA7uSudlNVXdI0yGtr+LQaBre+XQ0u+k9wnCqg
         7+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161520; x=1775766320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcc1hZOquhNmlP9pXmTrYcA0fCA/28vP38rmU1pTwc0=;
        b=lG8W3Xc2qHgYgWJDOnLlBOGVGrENipnw9siK10SO45c7tNAya6qm/Xo2/auXJlWLcp
         y0nAoezkbxpzOMIX4g0KegPC/buhDAa4WPtEdN/VGtGqRh9sP9xxsjTa6OaEd3MRScl0
         Gk9OZWlzlnQiZ0DMor8BAsDMGmAyLtJ/apPktyim0m19l4S+qhhXwfNsLIJD11cz9F9k
         NIM4E/vv8Vny2aC2AzDiq0t7KC7FOFSyUMg2wjXQk3i3KU1J8/hbdrpSBX5VtrO6TScU
         9pXHEuRj2qcsKD2zKGIQvyiC1qCNJ5J3eZyNAyMODD8IHAD/kRH5VTbxtvVONmlkdICX
         WfYg==
X-Forwarded-Encrypted: i=1; AJvYcCUktAr5xVK5MQbvyVTaUxh0XiO1MbjBR9CTLYllW3b7dvF4E0ktzjk34Kj36VQ8FCR/bT9Eq/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlSaekD2SCp3oU2lrZ7r8IY7Fu2VCQ3XRq3Rxp6XucM4Y82nM
	bhFvLDD1+whYN3TkfhqgkDnKm0Y64kJmZm4/e2T7p57VA1yU56Jqbk4a
X-Gm-Gg: ATEYQzyLqwxF9RjHMFRK1M5vKhWY2ey7jc+h3RaFIiUnvCosRlT/TZS2ikbwIk9k3pt
	C0kDpeJGgf/0uMJP218De9Q+R89hGCutdtwz/zmij+6ve8M96Abxe6wtJsjeCjIPbbEydIINTQk
	zTsHiGNC0+6kZFpmRZGIr3ZYE1KVbQchAzRhDdMDwzLt3Yorma7Nd3KB2eg5ZGAIkdzJALPm72b
	/fQ9Xh18qsjKPYuWAgbwc0qdd86PHRu9C3eeUJCwTTT9FS+qGFwhS1N/JCk2HfCymPbgG1t5jHw
	nUx35C6w+BYRJtnxzJm3jikHbudDUCLfj/u50UET9G8FaVu4jtHzVASOcah+YEdSDSH7mp0dxGn
	/SQynuSqXAIVp9761hqfyaTSDpShW7rW5kVZ6HFgSV8kwEf6ISKWbYvS1cqekL86tT4I2xRN3j4
	A/PNN1g9D+VWxa0JLHOZ80DH4ObQlaJ7xa4+qgjrXXupmGNFCK
X-Received: by 2002:a05:600c:8b32:b0:487:1c2:6a56 with SMTP id 5b1f17b1804b1-488996afe1cmr6726265e9.3.1775161519863;
        Thu, 02 Apr 2026 13:25:19 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm10040513f8f.14.2026.04.02.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:25:19 -0700 (PDT)
Date: Thu, 2 Apr 2026 22:25:18 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/landlock: Fix socket file descriptor
 leaks in audit helpers
Message-ID: <20260402.4ce8eba2f199@gnoack.org>
References: <20260402192608.1458252-1-mic@digikod.net>
 <20260402192608.1458252-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402192608.1458252-3-mic@digikod.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233108-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,maowtm.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnoack.org:mid,digikod.net:email]
X-Rspamd-Queue-Id: DB0D338DF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:26:03PM +0200, Mickaël Salaün wrote:
> audit_init() opens a netlink socket and configures it, but leaks the
> file descriptor if audit_set_status() or setsockopt() fails.  Fix this
> by jumping to an error path that closes the socket before returning.
> 
> Apply the same fix to audit_init_with_exe_filter(), which leaks the file
> descriptor from audit_init() if audit_init_filter_exe() or
> audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
> audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
> - New patch (split from the drain fix, extended to
>   audit_init_with_exe_filter() and audit_cleanup()).
> ---
>  tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 1049a0582af5..6422943fc69e 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -379,19 +379,25 @@ static int audit_init(void)
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	/* Sets a timeout for negative tests. */
>  	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
>  			 sizeof(audit_tv_default));
> -	if (err)
> -		return -errno;
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
>  
>  static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> @@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
>  
>  		filter = &new_filter;
>  		err = audit_init_filter_exe(filter, NULL);
> -		if (err)
> +		if (err) {
> +			close(audit_fd);
>  			return err;
> +		}
>  	}
>  
>  	/* Filters might not be in place. */
> @@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
>  
>  	err = audit_init_filter_exe(filter, NULL);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

