Return-Path: <stable+bounces-59832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A4D932C00
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F367AB20FE7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704127733;
	Tue, 16 Jul 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+ztBJ1h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FB19DF53
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145046; cv=none; b=a5s3ffEDZXPfUtgzj1pZcM6EyTIjQlrJbKsW843eQ6q39dnyotlNKy0Mux0v4fuVPGwOZT26bdzUQ600TA7DWXPImryKWJwWMLN9yOo7l7a6kKTvuhCofgxW3FLNwmXZCEQhw6PGgHOAjE5OHbOWlJdz3FqNs3TKwU1ISjmJpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145046; c=relaxed/simple;
	bh=yLge87BNhYF8/8lBN8RkKJC+YhB97bGkr0FtFgOLENk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psP0ngMR4JEV675Qq8qFOZjo/PJjiPWAAoOlNJadeBk2i1VAwd2+My6RRE/Tw3LB6GQp7d98+vikOjUxx3Gy255UsQSPfay+vziVQjVbcQkxww0AEZgWM50zAEhBTjWUEAF2Q4lUt/hfWqu3J5VnUOSx0vJ+TuPEB4c8KkFF9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+ztBJ1h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc0f82e4f5so4681395ad.1
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721145044; x=1721749844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvZaY7m1dVS6FlWDuiFTl9UrA1M+EIhBuq8DkOECW1s=;
        b=U+ztBJ1hHK3qBjD9g+wPmVxjfzR8td3EC8DXP3+63SSsKEhz3CQ06sdmoF7r+J+R1M
         Ufvh9QKdF8uIVnVytyjZwH3sc4loHfNunqB2Sh80/yFY8HfDsHUZahfSh/a4mQ1YpC5r
         Pgd4jLkLV565CHiWQADwRfx22X1LKCH+6CkvUs8GRHJ7jIEf61r910SJd+5VnQ+W1cER
         yjnW27E9O77Kg+oVQy7Nz+yVNNvemCGRT6ExammECyjcUBqmP3H/GzCG3jDphRpbqqIZ
         qZSV8u2seYsoSY2PXPOywHvkdR0chTa80006bScsdve2JRQe+OPRMg2UvF6yK5pquD0v
         XvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721145044; x=1721749844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvZaY7m1dVS6FlWDuiFTl9UrA1M+EIhBuq8DkOECW1s=;
        b=ssFwzxHJQb3VRB9UKxQvRpm1OWES/FisKauq8Y2T8KclHjIyr/+a7WKDcEllXycqv4
         o5gnL5uv+o/tTzXavOR+Ii1/QOyuvbVTUdNCnFpld5afsMUuQCiadE3bjMpFINK+icAl
         RD6A7sO9q+wdqAplepQs67PVrewsZ2DmQpsJJkQ7y41gvAn4v4qm2QzWTuus27nyte5l
         2TMbWe77kRfMGHuQFapy4C9CF9HFeKqstEr1MY/joJRwfGPpyhe9ytXOhHQKK8yr9YPg
         hWz24bbPENT/8zJd/QWxt+HU57fJWF3DJz2noHJtoD2CGQAjyENwJrfVetYqx1enY6iZ
         IpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCViH+XVL7Js1sdvEku4GyO1m/UCRXjZlbYJCl27ojAWthkOfdI839YQBdeiPoEh/ym2X0zNl38Q9xKDIt6fW7vEJ2Alc//b
X-Gm-Message-State: AOJu0YwAPNHwsUIE1O6ncolAjQeLpWnWo1GKQjF+l/OgsDbT28xAQcCD
	YxE8jRFeG3E+BSivgU9KpkwnSYgbhVc0VIa2DLBA+lzw+Ka5ROR+
X-Google-Smtp-Source: AGHT+IG8iepnm92Ob6MRHl+fnexFN1ixhdatDwodWAUnL9y3ukguEar/boG8xG7dKPoQlHlon+Z/XA==
X-Received: by 2002:a17:903:2344:b0:1fb:5f82:6a48 with SMTP id d9443c01a7336-1fc3b909358mr24276795ad.1.1721145044256;
        Tue, 16 Jul 2024 08:50:44 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb73ea1sm59829345ad.34.2024.07.16.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:50:43 -0700 (PDT)
Date: Tue, 16 Jul 2024 23:50:41 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: 2001wayne@gmail.com
Cc: Julian Sikorski <belegdol@gmail.com>,
	All applicable <stable@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5.15.y] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
Message-ID: <ZpaW0W9QsxMGZDLX@visitorckw-System-Product-Name>
References: <20240716152941.159841-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716152941.159841-1-visitorckw@gmail.com>

On Tue, Jul 16, 2024 at 11:29:41PM +0800, Kuan-Wei Chiu wrote:
> The acpi_cst_latency_cmp() comparison function currently used for
> sorting C-state latencies does not satisfy transitivity, causing
> incorrect sorting results.
> 
> Specifically, if there are two valid acpi_processor_cx elements A and B
> and one invalid element C, it may occur that A < B, A = C, and B = C.
> Sorting algorithms assume that if A < B and A = C, then C < B, leading
> to incorrect ordering.
> 
> Given the small size of the array (<=8), we replace the library sort
> function with a simple insertion sort that properly ignores invalid
> elements and sorts valid ones based on latency. This change ensures
> correct ordering of the C-state latencies.
> 
> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Julian Sikorski <belegdol@gmail.com>
> Cc: All applicable <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20240701205639.117194-1-visitorckw@gmail.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> (cherry picked from commit 233323f9b9f828cd7cd5145ad811c1990b692542)
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Please ignore this patch. I accidentally sent it to the wrong email.
Sorry for any noise.

Resent to:
https://lore.kernel.org/all/20240716153031.159989-1-visitorckw@gmail.com/

Thanks,
Kuan-Wei

> ---
>  drivers/acpi/processor_idle.c | 40 ++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 4cb44d80bf52..5289c344de90 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -16,7 +16,6 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/sched.h>       /* need_resched() */
> -#include <linux/sort.h>
>  #include <linux/tick.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
> @@ -385,28 +384,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>  	return;
>  }
>  
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
>  {
> -	const struct acpi_processor_cx *x = a, *y = b;
> +	int i, j, k;
>  
> -	if (!(x->valid && y->valid))
> -		return 0;
> -	if (x->latency > y->latency)
> -		return 1;
> -	if (x->latency < y->latency)
> -		return -1;
> -	return 0;
> -}
> -static void acpi_cst_latency_swap(void *a, void *b, int n)
> -{
> -	struct acpi_processor_cx *x = a, *y = b;
> -	u32 tmp;
> +	for (i = 1; i < length; i++) {
> +		if (!states[i].valid)
> +			continue;
>  
> -	if (!(x->valid && y->valid))
> -		return;
> -	tmp = x->latency;
> -	x->latency = y->latency;
> -	y->latency = tmp;
> +		for (j = i - 1, k = i; j >= 0; j--) {
> +			if (!states[j].valid)
> +				continue;
> +
> +			if (states[j].latency > states[k].latency)
> +				swap(states[j].latency, states[k].latency);
> +
> +			k = j;
> +		}
> +	}
>  }
>  
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -451,10 +446,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  
>  	if (buggy_latency) {
>  		pr_notice("FW issue: working around C-state latencies out of order\n");
> -		sort(&pr->power.states[1], max_cstate,
> -		     sizeof(struct acpi_processor_cx),
> -		     acpi_cst_latency_cmp,
> -		     acpi_cst_latency_swap);
> +		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>  	}
>  
>  	lapic_timer_propagate_broadcast(pr);
> -- 
> 2.34.1
> 

