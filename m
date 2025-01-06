Return-Path: <stable+bounces-106834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05DA024BD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37656165058
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96621DDA3C;
	Mon,  6 Jan 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="O/h8Sy8f"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD51DD9D1
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164995; cv=none; b=GXQqtO8Is07cWKfU8mR/KSZqeiLt6YFjNOuiY2B2q3qMQB1CelPDOGvQYAB06YuFoZ+EhhMtjZkzTPXB55IKm4qDYEHikVg0dxFeaSE6LIyCfUAkPSXOmnPxkmOl2viKrFm3NdiPOFO2kAMqH1mRKWUsbF0zKIo2lmhir9l1x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164995; c=relaxed/simple;
	bh=lJWo+qXmQT2rgTTmfWA1CWcEhhY7uLbUZnDsbQqbxJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEc/r9K5wN8vlbIG9qi6KgFNVmEKGPdyZ0CeIcZApXIZQqeawg6HJSl1CKfWnC/sjDNMyyR6Mj1rGmB6zgACto5MOYWqDKfCcQVumr4Skpj2yr89DgMwp8F92FpCV7zVOIVzSSAMEKvYJtqiNk+J+1slzZ6zvE7qY//JrGa4B48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=O/h8Sy8f; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A0C5C3F480
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 12:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736164983;
	bh=1HyOiAqgWYe2+9mOrcyyWPuIElnKpNHdnTAujYRx+Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=O/h8Sy8fdiuuRDoRgIl6oE+yR5tZKtzxlqcOIu+39B9DgV9uITWV6CJ9hCxQ9kNK5
	 C+QPWWvnK0a/nNSxhJhd97dRHZ8SPkRDBphQDYdi5X+5WRY9unJzRK2sk7PXwXKABz
	 thtQz4ELuLLHpFyaO2i2Dce0Lo7rdPSvJp4OmKITa9VPSjOn+lTDuGrGNfIMPbrBuX
	 xfBk8W6nOj9xUF8UqD+JvkRNtqIpv21+tCEbJ4DTOU3BtcIbgrX6z2xtlMjzWM63a+
	 l83lrWWEu8Iso9lDJYuhpBPz5H79Pu2/3oMLsNrc/5psmC36XtJRHPriEQCjjHKesR
	 xUL+1rncRbHfQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so20587250a91.3
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 04:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736164982; x=1736769782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HyOiAqgWYe2+9mOrcyyWPuIElnKpNHdnTAujYRx+Vk=;
        b=isxqx5FMDcDjVRgrqGLSMsq0eNv0862KoNp7U4536Rzw2ApdDLEW1nKopi114GG6lI
         HV61RtvY5zVGChYd8qZut+zqigM8z5qHJQ3VWy7BjtDVGJNSS4//XrWIvDMgxgZUvFLt
         n62xIAa8+qZVwFOOeAHNvf6IANSpGg2zL3dB5ZLhvSnlp5WFPz7v50xGM2P/WlpWZELz
         nIogHSyXNNo1n/wFCMlpAIl9Usvs2WbnMGrOyuRvd0k+usaDR0S0SL97cSnWNfuthHZv
         ONK1II38LP5iOdhQMQypZP2fWP58Uyuaiq/30DFcuLrwQtmAPSP9KawdO85jdo31dqa2
         xqoQ==
X-Gm-Message-State: AOJu0YyDmWiu6GXiBFVAHmLNYORHhXsU1oGRDDExEJIMX50jS/6rZkKH
	QxsitjjmtZfFE/w5C2eQfd5W3cMgtZ8pwhGer8gyVcPi57bx2X2UxFWvv70jQjpdjtRNVULD1lS
	fAjOfZ4tCRNnJO3XBGlf0sIxTv7qZ1vZaVDLv9R2cW2v8Zx/1zo9XvKV6heS3VVfzM5oKZCzUvi
	WxkA==
X-Gm-Gg: ASbGncvNkt48yeR0aL2ykhmqJT3mLEUi8gVkuO0HM3tRiAHRGFUnhA5TrvBSgvjq9qQ
	AHaCfSKc6Td5i1qpNFZE2EJTCWWrPFPNSOJQIbNUeYxhlGiZRH0Oog3ddqiciYEgiFgwdZazc1o
	124Cm5ADjmvqRJs8IMe1SRRRLtyf7j36v2b/uJKKtdcdVS4MvN+Us0h0B6QEvNwNSmkcUgfXQZ7
	zp3Hv2FbOzbIJvHv0mVgpcISujDw4DpSyy3nA+uB8K9hqAU2UiqUuuN
X-Received: by 2002:a05:6a00:a27:b0:727:d55e:4be3 with SMTP id d2e1a72fcca58-72abdd7bad8mr75663947b3a.7.1736164982034;
        Mon, 06 Jan 2025 04:03:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKh3NHoPj8VwDMPRC/1Voy7fzBWRCAHxZwWkn+AXbkZzRxZACjU4zbbLCT/n8lGUe3Seh5Cg==
X-Received: by 2002:a05:6a00:a27:b0:727:d55e:4be3 with SMTP id d2e1a72fcca58-72abdd7bad8mr75663924b3a.7.1736164981653;
        Mon, 06 Jan 2025 04:03:01 -0800 (PST)
Received: from localhost ([240f:74:7be:1:de1c:d045:9b:980c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb941sm31249062b3a.160.2025.01.06.04.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 04:03:01 -0800 (PST)
Date: Mon, 6 Jan 2025 21:02:59 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, bigeasy@linutronix.de, 
	stable-commits@vger.kernel.org
Subject: Re: Patch "vmstat: disable vmstat_work on vmstat_cpu_down_prep()"
 has been added to the 6.12-stable tree
Message-ID: <x4sqfvmoj2d42ovg5ebn2ytoi3w54sxgrbn5mes3wz3nzenyk7@3eabarxtsiht>
References: <2025010620-glazing-parakeet-e197@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010620-glazing-parakeet-e197@gregkh>

On Mon, Jan 06, 2025 at 11:41:20AM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     vmstat: disable vmstat_work on vmstat_cpu_down_prep()
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi, could you hold off on adding this for now? It's broken [1] and needs to
be fixed. Once a follow-up fix is ready, I'll make sure to notify you.

[1] https://lore.kernel.org/linux-mm/7ed97096-859e-46d0-8f27-16a2298a8914@lucifer.local/T/#m758eb53a012a4348c256ee8a723a6a29f86906df

Thanks.

-Koichiro Den

> 
> 
> From adcfb264c3ed51fbbf5068ddf10d309a63683868 Mon Sep 17 00:00:00 2001
> From: Koichiro Den <koichiro.den@canonical.com>
> Date: Sat, 21 Dec 2024 12:33:20 +0900
> Subject: vmstat: disable vmstat_work on vmstat_cpu_down_prep()
> 
> From: Koichiro Den <koichiro.den@canonical.com>
> 
> commit adcfb264c3ed51fbbf5068ddf10d309a63683868 upstream.
> 
> Even after mm/vmstat:online teardown, shepherd may still queue work for
> the dying cpu until the cpu is removed from online mask.  While it's quite
> rare, this means that after unbind_workers() unbinds a per-cpu kworker, it
> potentially runs vmstat_update for the dying CPU on an irrelevant cpu
> before entering atomic AP states.  When CONFIG_DEBUG_PREEMPT=y, it results
> in the following error with the backtrace.
> 
>   BUG: using smp_processor_id() in preemptible [00000000] code: \
>                                                kworker/7:3/1702
>   caller is refresh_cpu_vm_stats+0x235/0x5f0
>   CPU: 0 UID: 0 PID: 1702 Comm: kworker/7:3 Tainted: G
>   Tainted: [N]=TEST
>   Workqueue: mm_percpu_wq vmstat_update
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x8d/0xb0
>    check_preemption_disabled+0xce/0xe0
>    refresh_cpu_vm_stats+0x235/0x5f0
>    vmstat_update+0x17/0xa0
>    process_one_work+0x869/0x1aa0
>    worker_thread+0x5e5/0x1100
>    kthread+0x29e/0x380
>    ret_from_fork+0x2d/0x70
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> So, for mm/vmstat:online, disable vmstat_work reliably on teardown and
> symmetrically enable it on startup.
> 
> Link: https://lkml.kernel.org/r/20241221033321.4154409-1-koichiro.den@canonical.com
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/vmstat.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2139,13 +2139,14 @@ static int vmstat_cpu_online(unsigned in
>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>  		node_set_state(cpu_to_node(cpu), N_CPU);
>  	}
> +	enable_delayed_work(&per_cpu(vmstat_work, cpu));
>  
>  	return 0;
>  }
>  
>  static int vmstat_cpu_down_prep(unsigned int cpu)
>  {
> -	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
> +	disable_delayed_work_sync(&per_cpu(vmstat_work, cpu));
>  	return 0;
>  }
>  
> 
> 
> Patches currently in stable-queue which might be from koichiro.den@canonical.com are
> 
> queue-6.12/vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep.patch

