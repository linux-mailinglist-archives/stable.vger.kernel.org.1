Return-Path: <stable+bounces-186314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA5BE869A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E3F1AA4B1F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C363332EC6;
	Fri, 17 Oct 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I375PCkY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB75332EA6
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700825; cv=none; b=Lahv0oKrLZVSn1FRTpC3/QqhOPY8YP5syz+TUQaLhnGiRhPq2Z8P3P03w2veWdjiFDAj7NZdaIXm4CAyg/7PT3uR9W1QHGmKRPb4Jd+UQtWsgKqZiHrf7+loToDGbqaYtcj4JYV3Al+4ZCrLbGKcTbuu8YuTOFIf0d5l9gxh7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700825; c=relaxed/simple;
	bh=UdTwS/dExcvw2xhiAcwl5dXsykAuEk55HCu7Gxo/fHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdmld5EsKQghtudTjutmfn9qp3hvC1UJWmVCN4O6W267we8UFor/EvAtBnQ+eQeA/ttJQGs7rdonaZqpw1pvfoNPmIzpbafZwdfsiGuGBxZjUGS+O91hMUrEYjxj8tktogwPTgpXH26WCXGgovLZADphK1KxcvZw7G8MQXi/fsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I375PCkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760700821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgJNG0+kfyblCxEFNQal2jyX2sK0ET1Tz4uKuV9Ge9k=;
	b=I375PCkYZhnGeHCCaoI3jnoPxOUF39kywQ1m8/YuQ/3f2HkzCjUAJdsnUhkMG7cSgycjv0
	w9xUhAry7VfV0MFNRdG9nSztktnwQOI94x42wXAe3tjtbCePH8WzLjw1Ga9b5fuCHkQw26
	yLlRaEoHV/ood4xKzSoXO+WdB/krPrI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-mYiih6jrOn-FzZqigFdGZg-1; Fri,
 17 Oct 2025 07:33:38 -0400
X-MC-Unique: mYiih6jrOn-FzZqigFdGZg-1
X-Mimecast-MFC-AGG-ID: mYiih6jrOn-FzZqigFdGZg_1760700817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27C511800345;
	Fri, 17 Oct 2025 11:33:37 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 36C1419560AD;
	Fri, 17 Oct 2025 11:33:32 +0000 (UTC)
Date: Fri, 17 Oct 2025 08:33:31 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] rtla/timerlat_bpf: Stop tracing on user latency
Message-ID: <6iu2f3qpxuqsjq4vxygokmmppiuwj32kkxiv57ir524h2xgsxp@wmf5d4vckgvl>
References: <20251006143100.137255-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006143100.137255-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 06, 2025 at 04:31:00PM +0200, Tomas Glozar wrote:
> rtla-timerlat allows a *thread* latency threshold to be set via the
> -T/--thread option. However, the timerlat tracer calls this *total*
> latency (stop_tracing_total_us), and stops tracing also when the
> return-to-user latency is over the threshold.
> 
> Change the behavior of the timerlat BPF program to reflect what the
> timerlat tracer is doing, to avoid discrepancy between stopping
> collecting data in the BPF program and stopping tracing in the timerlat
> tracer.
> 
> Cc: stable@vger.kernel.org
> Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat.bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
> index 084cd10c21fc..e2265b5d6491 100644
> --- a/tools/tracing/rtla/src/timerlat.bpf.c
> +++ b/tools/tracing/rtla/src/timerlat.bpf.c
> @@ -148,6 +148,9 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
>  	} else {
>  		update_main_hist(&hist_user, bucket);
>  		update_summary(&summary_user, latency, bucket);
> +
> +		if (thread_threshold != 0 && latency_us >= thread_threshold)
> +			set_stop_tracing();
>  	}
>  
>  	return 0;
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>


