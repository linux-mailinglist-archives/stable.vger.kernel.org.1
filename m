Return-Path: <stable+bounces-238919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEQSKQIw5mliswEAu9opvQ
	(envelope-from <stable+bounces-238919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75642C672
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A16F30552F1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887133DC4CA;
	Mon, 20 Apr 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="PjP0vfLU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3C3DBD5C
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691450; cv=none; b=GC4nehk9aCtfhjOsSh1MgbOa+Zfc1GQl6XfKdGui0tRehOt8L4i1sbdhD0cHJjZDK2fwhMNh7Ztiwu01dc3iypnAr4pcU/P+zZsIZD0CwGWvyCb5Tr5PF9LWczaUSzpvgK65Rfi4TpjFcErh2HIru075+b/ggGlMAavYe3R3f9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691450; c=relaxed/simple;
	bh=/FPvrro+0Yn8nbeo9fnCoGNzx5aAMZeIRKRWnVSWBNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrNOUtGSMOxnFtTDXW16VEW9ot9RuDvCSyTltVOfOWpxmQDznvnQatjpprCAXLPRaaVGJR+lJ+Y/BjlpnA1FvxPEty3k/dE7nVCCMg3tJxL73AsTNrmu3IgU6kmJ+pa0LfQYviZAWBohhKqMPIV/S7ZZYbIsuGABWcpXWEB8dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=PjP0vfLU; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so44706505e9.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1776691446; x=1777296246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWgOpHK1V0mcahhXRBLeTBDr92JJ8SRycnjCV/1/+JU=;
        b=PjP0vfLUPJO79WFbk/e9N6lk0jLsL4G4XK3QbneVNvZfsyZcfO75qj0utuPXVmDFP3
         0aED85AWAAsPWUdZ9FLQaWMJcs2LrrNLqyBU0i5NfW1tQy3qX4FSb8Pe94EpZnzKrCHQ
         2jMsVg4U2TFuByxope83SJ3tEfufo91EPV9VsRYEY1zEq+402IwH+QCnboM1GwxlHLT5
         nO+HrJ5LwcyYIXNq5C3cD6u39sZOjHbk0ohTKHiEPztIOuXINf2FT81QPkQQPA7Urw2+
         3FZ5KrkCyLaF9oHmjYuj77TUSSZ6AU+C6oDCCykTg5XWBk1VHmBB1LoJWtWF40Um9Cqt
         Tbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691446; x=1777296246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWgOpHK1V0mcahhXRBLeTBDr92JJ8SRycnjCV/1/+JU=;
        b=N8jVr6xM9JfSG72NCSiZp9byZJDmBu6WYiVaLWNJB7USa9XkM3U69ZT75Llcw7rQwx
         BYghbgy7WAwSuXHy29EINpLWGP+J71xiTtWNIGEjTNd/bvH/6Yuht7wbzf1IKQrMOVE5
         4mJVAKXaZ0egaujdXhXpvlJNGib8BQr9dlwdEJQxi0451MR4VAu2/AlGpvLkMt5nxM1/
         aynBuTEBEhPyj5GFwHRlwKdM/6MJBcwIwSdFsg11jM7lex3EUaZZBZQA/cf9zmEh/RlS
         iqx0MXsvC4QDQe6iOPOaQqw9t1+umRd7bbimc8aspYOwBtP7W9k4aZxP/25iAlLPX7u3
         BaoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yLn85O8WJYUgkdddFMA8OOf7f9iEMHTPYRQcb5BZj7adPW7+dNLi3NbMhYsd1zBdwZNbTRcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpNRkmEFmz/ZjXGLfkua3n9gZDqWJiH4H9JobjLLjVS+i9OWz
	qZGHiL4yboCER0XNFL8KWqrkZpchmo68twxpNheuyDyTSxWqWXrmAcTBBrRAOKzFo6w=
X-Gm-Gg: AeBDietd+/O112asnBTWWOB+kEqN1Td+NZ9zdrQ16WLyG4G5Qr4sOLyZEYzMBlAZwQ8
	tZ2LBxBN+jjwfnTr7Aco1cD4JrbXhw4r+1MRKkXAFR8LPyNZWJHjJvcTts0IawfCnG/Tia73hNJ
	bFOaLEwhNfRHdZAUWkCFPMDGC1wt81qMIsGc9ILsNp43Z+Xkv3wvRBJeaUai6WWPf7s3o1hSMav
	ZLFlJuu+6zUhxu622PmMdcHh/AaozL7s7+X9lM3sOG4yHWBG7IlXpImjtuQNuh7ylw9rQ6tcztv
	Co9UmdzWlIDj3YslArZOn1BWFXoWXVZ65wvkBFtZm16f0BRXfRdTeZR7xIKh/ukOuDhY+ObFXJD
	ydiMO/Be4r4wdIrWhrrLfJ8rmrdFP4eFVDqJMxx41cAzPvEYogZ/EmDG2jbyBiW6enUHGLjUWkk
	lqRhePgS8Uz+rzmEgZKX+r/e4wQZx89Gku1fFA23fCdS6TGt8zx6PCgq8=
X-Received: by 2002:a05:600c:1549:b0:48a:761:5808 with SMTP id 5b1f17b1804b1-48a07615c09mr25066825e9.0.1776691446240;
        Mon, 20 Apr 2026 06:24:06 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm305785195e9.2.2026.04.20.06.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:24:05 -0700 (PDT)
Message-ID: <384adac7-2aa4-4568-b7a5-987e914fbaf2@ursulin.net>
Date: Mon, 20 Apr 2026 14:24:05 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/xelp: Fix Wa_18022495364
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, intel-xe@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Matt Roper <matthew.d.roper@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, stable@vger.kernel.org
References: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260420131603.70357-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ursulin.net:+];
	TAGGED_FROM(0.00)[bounces-238919-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ursulin.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tursulin@ursulin.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,igalia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE75642C672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 20/04/2026 14:16, Tvrtko Ursulin wrote:
> Command parser relative MMIO addressing needs to be enabled when writing
> to the register.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: <stable@vger.kernel.org> # v6.18+
> ---
>   drivers/gpu/drm/xe/xe_lrc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 9d12a0d2f0b5..c725cde4508d 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1214,7 +1214,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
>   	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
>   		return -ENOSPC;
>   
> -	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
> +	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);

Or if this register exists only for RCS would it be better to define 
CS_DEBUG_MODE2 as the absolute 0x20d8 (as in i915)? Unfortunately the 
public TGL PRM does not list neither the register or the workaround so I 
am not sure.

Regards,

Tvrtko

>   	*cmd++ = CS_DEBUG_MODE2(0).addr;
>   	*cmd++ = REG_MASKED_FIELD_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
>   


