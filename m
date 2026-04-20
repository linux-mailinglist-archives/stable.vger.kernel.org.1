Return-Path: <stable+bounces-238742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFMsF4UZ5mkprgEAu9opvQ
	(envelope-from <stable+bounces-238742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:18:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC642A92B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27DAF303E49C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD0387363;
	Mon, 20 Apr 2026 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8I5zClr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9FD288C08
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687433; cv=none; b=MKO1Xa2xuPinsMU8h43lboIb5Z2IOGCtBODmEppiV7T86tHnMikY+Six5fglqgilE0DzmPc8y/Hbl1wkyUTLC8HCJ06JYClEhWXBCtg/3kUfup2rKhhwGuB4uwkS4YEMlaNWKIGiulSCv6GVak12Tx/FsTCFnS2NaPDvZZ2lXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687433; c=relaxed/simple;
	bh=4VuMnrHpW+Ys9pSu9mAz1veXiKY9spgI1R+SpeNWJA0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwjDKtdNhgCJ/1teLGMxhLfp6JAWFpIQa55+nIaykxM8wF3JZ0tNvkEluxJuA33fahjq+WDmeQ+6A6dQtNfSrXrUYR9zw3a+wd/Z2FX2DP2aiF8v7yiEnIDfk2SNlg6xFHE1pqgFsDwaiQ+KtMx3DCYRCpGw4Hm0kh1VYxo/KKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8I5zClr; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dcdf60427so2624949e87.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776687430; x=1777292230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drkslkYKwh8bl2BohU7oUu2nJDGY7lLZqg96VgbKXeA=;
        b=D8I5zClrpfFMhcy4xFrJ6qq3L4Dcha9lvOuhYN5RjvqAxR7VFScLsoyF0YfL2NsfAR
         ORtHF5jjv/sOQMCIQhuguf/amEQPC7MgEbZOXTDwX8+yYraJong0LK5M+wfflQmiTAVG
         chJI/Sd6aTGhOIUZXQygD4nLaOqNNhjmn8rnOUHZ9SHfuCfrd37EkpiLXwHJ3G0PsiEY
         5b7zN1YckwydtbiD3OusAzmfXrrZh8FuVUwSVScqvug5IPkc5ACkZsT2T5oiiCtjS92S
         ti07BOIy2qM5d/Y+hD+chlgHTh0OGiSkZEEFaI8obwtiTBHJLIsDqkGVLoONPDtGfd75
         dwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776687430; x=1777292230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drkslkYKwh8bl2BohU7oUu2nJDGY7lLZqg96VgbKXeA=;
        b=P0VEI+BD0tigpG1/7Fy+eBJVMYnsf5zGeiIwXWmJmsRM8qopNnx67p6odJhSmnmJ6H
         Wmza1gmYqsgTn0aYNkB+C/dNyOuWPNKErr1VsnqGH1GwvQFWgAh4i0ZEyLltiiIoZfbY
         S52oG0Lv/vlMsNTxH782FU9paYcuHOrMdHHx0IHb/Gt8M8IpxZ4a8Xw3Yc8NLMwYNe1Q
         z84/GLMS8eI5JiS7mAoadAWieRxIyzo7e3UdqmQVWu3vO1xdqfI5F1RQCGwaORV+UzsD
         pKaAtTLJ2PdtAAwHes0sG4LbTj6AlFu02daLHlgLl47Onu4ZjSWZqD6VvgNw6TFDf0ND
         bAZA==
X-Forwarded-Encrypted: i=1; AFNElJ/rnAjeJzbBus9aUX+dEc8pN1jbdjfAN6aQnvD3+8GXNPCrHjEqdPyAGTeENcvsZHHVZ/ymHyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOVW4Nvcadg984J8uCa08okcA+i2onqrMUl10Nst9y1Fxudi0E
	tXt20gf8sbeEoHDjbzeKOY/PtEf2ZiZ32QRO8QHNX76upxH+vnGmB5Rj
X-Gm-Gg: AeBDievpqTqUcEk3AC0Jtzk/VSfqMlcIo8Ec+g1Kg4GVAj7yai4muAYsaXAB4wuMea2
	sDCUeXTISo7LVbPkbl2bunO2qEjjVpTSOc0vJB43h8NM/P0NHtCk3GbPkxOvNyHWNybKlGXtdI5
	02Kl8r+N2HJ/cVQI/IaHZ/0gka9OUh+5ucS4FHUUSjjibIWUcpGdnt95oqMre782090xBo9xV4N
	KJ7DptbSjVtABQ5gdC/J4v+Jgp5HBiJ7tcgZpaII2gnBsQvuSr9cTl5D+E/u05Cn7eFyhyXD8m0
	us/S57w9yAtqxQ7f+5rmvuXKyh3LkvEUlObgZ1Qrw8Q8FmvdV6r8R0vteST+vkEyF4nfEjbcU/b
	+q1Yhz1dtDgVVGrTL8A7Lv9JqeEX9MHxn1AU2rfUY29zR1lSm+88JVVm9vRP3qHf0De44Z1hv8g
	Y=
X-Received: by 2002:a05:6512:a8b:b0:5a2:c289:3337 with SMTP id 2adb3069b0e04-5a4172fabccmr4256296e87.42.1776687429463;
        Mon, 20 Apr 2026 05:17:09 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad2f4sm2965771e87.17.2026.04.20.05.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:17:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 20 Apr 2026 14:17:07 +0200
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Vitaly Wool <vitaly.wool@konsulko.se>, stable@vger.kernel.org,
	"Harry Yoo (Oracle)" <harry@kernel.org>
Subject: Re: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
Message-ID: <aeYZQ501gs_OLR8H@milan>
References: <20260420114805.3572606-2-elver@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420114805.3572606-2-elver@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238742-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEDC642A92B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 01:47:26PM +0200, Marco Elver wrote:
> Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
> vrealloc") added the ability to force a new allocation if the current
> pointer is on the wrong NUMA node, or if an alignment constraint is not
> met, even if the user is shrinking the allocation.
> 
> On this path (need_realloc), the code allocates a new object of 'size'
> bytes and then memcpy()s 'old_size' bytes into it. If the request is to
> shrink the object (size < old_size), this results in an out-of-bounds
> write on the new buffer.
> 
> Fix this by bounding the copy length by the new allocation size.
> 
> Fixes: 4c5d3365882d ("mm/vmalloc: allow to set node and align in vrealloc")
> Cc: <stable@vger.kernel.org>
> Reported-by: Harry Yoo (Oracle) <harry@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 61caa55a4402..8b1124158f54 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4361,7 +4361,7 @@ void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned long align
>  		return NULL;
>  
>  	if (p) {
> -		memcpy(n, p, old_size);
> +		memcpy(n, p, min(size, old_size));
>  		vfree(p);
>  	}
>  
> -- 
> 2.54.0.rc1.513.gad8abe7a5a-goog
>
Agree with a problem described in commit message:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thank you for fixing it!

--
Uladzislau Rezki

