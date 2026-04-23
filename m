Return-Path: <stable+bounces-240450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGqwInDq6Wm2nAIAu9opvQ
	(envelope-from <stable+bounces-240450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:46:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACAF44FF50
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0A1B3012A93
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EBE3E4C6F;
	Thu, 23 Apr 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CsOjvdS0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA361F1932
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936873; cv=none; b=dKGqniiXcOCsJn492q7kOkLVHY7htcgJI0tWd1WH6GYAMUA3E9MtTmat6aQ2HTpyRu+V2rccbLVNudJ73zR8B5HhYfH7Nvu5oFetrpMN+P7BAQIznwtSawQUclBGRI3o9BMiO3UAVhzXUycmDUgSgQYV8OSawRVZOp+zzjWMoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936873; c=relaxed/simple;
	bh=uNBIefZDxhBdTplR4Rutsfb3Br0hvsb2IXlHcCoomHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDyUP3I+83RElnmMDg8SMjQPKbVDgToPYLtIudWWgEI3nfx7ctj0+w/uOsZ9pe3hSsBdRfYnBTSue8U2eaWXGEfildSMOigSJQjr3D2t9BO/rwtXDekxdcGlhuGWFqNaEE+m44pJ9farGk/h85X4sY6Xl+WERwiTW26u1DHnTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CsOjvdS0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so28713735e9.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776936870; x=1777541670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlLH7AnUkh/yIK3b4miCcJ1QsnDeuZTPALrNv48Gw7Y=;
        b=CsOjvdS0AK08aup7D6oTiLrYCaIW9py4QiBhmjyyYmdeKpieHQ/4+fqI4rQ3Bs6UtO
         2+gnaWyTZ3p8OZSiYMiz+c3c9FM31vY8myBzcO1zdqjssrzBN4dbJFY60h59l6gT/USo
         iCEWeaDEH0puJMDhzRJY5SRVmI5Pd1iO65R4TtcvgYiOIh2J37a/YuKVyeYLGneOVDT6
         ni9OIDoLgkECVIW3HDVNllRC7TyAeIwPI2CncNOdKXs35LJBpzejSKgqlzjvFIpuYxqJ
         TLUqD+Hbb7I6yAV29wsXfERRaOjhrBNuIH2BGTkelbrKt7NJrfk5Ebc604TfVZlZSXin
         HOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776936870; x=1777541670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nlLH7AnUkh/yIK3b4miCcJ1QsnDeuZTPALrNv48Gw7Y=;
        b=NQCQCfh81jr3rjTCi4+ZxBQOjMl3uCJUNkizQBft/zIs6UiBE/m9JwrziyTynC25gB
         xRGlgxNyppWltexezdTgD6OQD8k/twhlygpzA8ag+/gkXRLODALLwqubxtDaz/3cPuWE
         jD3B0/tvuvlGhlf5L0x4JPmF07V0hVpApm9c4irhwBH1KCQYZbhRcH7gCKQN6vyTrJMv
         vALqhFxE+3vZfBGZZ+MOEmAxGRhUG+nlPDEYj+U0heOHvClnZkazsGr9Bsv1zJIn1YTt
         xQ8k3ZSowU2zdWX5TWbCPl7mLDiPznWEdmrSQiWin4+Kh5WEUvvGmr/mVO7+d6AFTftH
         RbIg==
X-Forwarded-Encrypted: i=1; AFNElJ8eUuKN2hRSLigjTR3DqGY8OfC89pWkXR3QQJ9S5m00W9pFPuv1RcAhTD2PLbZ0oV2mq0xZJ1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlS7M3cDbK2XtX2HdStXwmPq+qzMfEUTqaxpmzQu91sEl5yUbK
	EN2lH/CqnB/DsRPK2RKCDakmrxvIfPTN+Py4dDXAlfXKENkJHs1m1v4dY1pUiq4LdXQ=
X-Gm-Gg: AeBDieuaUde+9XSvQsSIRQSbQ8lK6XwL4oBwX1CwZF0Oyu44Pnc0U5Wr7Eh2gR4Sz4j
	phmeCwXjLRWZ/dh6uvSUH0AskIq6w0mOWs08UDIpQ20dWR9sMZGSJRv6lCvRm8PWPAmN2mLz9ke
	X4y8EPl425TRhJdtpFjtoy4EC762i5SU+ftQLWc6LwrUNspqUQ+aFJPNHI29QlA7hEoGlp/9TkU
	Oaj9TZvh22gRDLoQO6N3u2KwC+ogbbk3Pv2tawWCOaSdyZ3kPMIdKHgq27gjJhUov8tlJpUXj0h
	gPabvyPpvU5LmZqR6L8fBsFgecxLH1iOaAuJKy+7PajIJW/E6LH0r9tuL9tm8zQJRhnjPxAbigV
	a/x9hYxcQpLxTX/T9jlLj8QxmEggKsG84VGY8Q65PnUY5wCoH0eBLD4jhxYk1a1icOHJdQgpbbC
	blP8yGXU2hhmGBHr+5Jj35Yx8cDgDu1Ilsl3RRfKEtBlvDekrZYlmX3/A=
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr224085135e9.11.1776936870253;
        Thu, 23 Apr 2026 02:34:30 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm237232245e9.11.2026.04.23.02.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 02:34:29 -0700 (PDT)
Message-ID: <3df70252-1a11-4360-8803-8a093c12ac75@suse.com>
Date: Thu, 23 Apr 2026 11:34:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] params: bound array element output to the caller's page
 buffer
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Daniel Gomez <da.gomez@samsung.com>,
 Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
 Aaron Tomlin <atomlin@atomlin.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260417075042.26632-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[samsung.com,google.com,kernel.org,atomlin.com,yandex.ru,linux.dev,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 8ACAF44FF50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 9:50 AM, Pengpeng Hou wrote:
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

The underlying issue is that the kernel_param_ops::get() callback only
takes a pointer to a buffer where the result should be stored, with the
implicit knowledge that it is at least PAGE_SIZE in size. The params
code apparently borrows this from the sysfs code, which is
understandable because only sysfs can currently print module parameters.

Nonetheless, the question is whether it would be better to rework the
kernel_param_ops::get() callback to also include a size argument. This
modification would prevent the copying in param_array_get() and having
an explicit size is generally a better interface. It could also be
useful for Rust integration, even though the current code doesn't
support reading module parameters via sysfs. However, this change would
require more work to update all current implementations of this
callback.

-- 
Thanks,
Petr

> 
> Fixes: 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than get and set fns directly")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  kernel/params.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..8910daa12816 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -475,22 +475,34 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  static int param_array_get(char *buffer, const struct kernel_param *kp)
>  {
>  	int i, off, ret;
> +	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
>  
> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
>  		/* Replace \n with comma */
>  		if (i)
>  			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;
>  }
>  
>  static void param_array_free(void *arg)


