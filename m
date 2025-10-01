Return-Path: <stable+bounces-182894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA5BAF362
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 08:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B83178459
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 06:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A82D7D27;
	Wed,  1 Oct 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlqlWdUp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337F23C8AA
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299380; cv=none; b=GvAXvAHoClPq99RbcflcakchUp1yufBwmB8VxWli1wNQywyUohJ+AsZRcqEeC72mfBq80B/k5AMD6r6LXg2J/RrRczbIijteJB5/Pilb2Urx2fytk4mgRint6kazLMitvnwUIfR3OZdPMGIGY4K8qNIbEntpFOX12JeZkWN7xG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299380; c=relaxed/simple;
	bh=EsZHnwMiJYPfidoSqF4cLJPZLMaFXC7b5B5xbjHh7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTIRxQWllGx90kttpnm7+rolyRROvHnkbvX6sMau5aS52mz2/LyqVOd+1b/mJ60TR2naCQBrWaXpC1K7A4kthXbXh+Qnq4p59rGVUyHPpqpjfMEZV6aJ1w9YnY9WJBkwEKzN9Ebyle1uvLYuvzVZQfantVQTwteCdj8xppjepV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlqlWdUp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fe4a1d872so1348946a12.0
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299377; x=1759904177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=BlqlWdUpTt1i0e9rEdsqx42INF5MhP5s32JHeZBPn6O2TJQTkHG1QQwSpKNP8ZBzbM
         XvA5dOAmKjlx+nHD7PEGcimFsFDZOxMeYd8aXo3QT+yDtkIJGzY9TXlyji5fk6pGvN2q
         ZZ00vkxuVnJj/T62MYTED9aONJZ2cwLJa+jrmqxE4BNWbuDAVXErOQ29JklFE+3l47/4
         pkGKVHqEDEMo+dNC4MWkp2nqD07mq1+jB1av7ypGYAF6qUNwvF4RiHgzpoHSANOduaPx
         1CF8TlkZ8HRke9SfL2zw+Yobr/YHl1X5eq5GlPsqegdTNNF6/MLgqKY8kwYEeH9SwLLw
         FzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299377; x=1759904177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=QCNFb5I/AQst7sgAo3PBRMDTddbQImpd9h9XhC3y4QwIrvYQqxv+0bl5OMkKU+UiCQ
         R28QizCxrtDvsk0XmxWuh3CV3jhWt2F5jdKr8EC5pZ6MncA1leb0vyGS6IhbrrLa42Rc
         AskcKAlhimzLBPQj2NNg4NobQwz8+8K1G1411VhLsSBwKFCWgb9cLimGYGwV3JXvSPFq
         rFU7GAxtwz0WAQFfuhNy+Nly7nV9Xc1VsfowADXIHhhqyl61MVdTT3gEfRXoIfH3pGQt
         rvTUXiNldoMiVYGEc50/y6OE4XkRAOk59WS/94QD8bxr7QMrmWUts3Kzdrn3A+5kPbyE
         6n0w==
X-Forwarded-Encrypted: i=1; AJvYcCWfIKLZHUyrmTqpaqm4l88kYNL0qy1E/EFj5mRdIopV1Xl1gkAGcX3Qr7ai4iPYtdNqyMGzJ2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxttzFMP9TqTLLycSHBUbqUJAsUnLMNKAG6AVawbbO0LJec9YH3
	KAGCA1pyzzLxEksn8ycCrkS0FyQAm9OvHRrhDf5h4YGZkSp6sLwmkLtv8TDpe3tOMak=
X-Gm-Gg: ASbGncuAH4K/1o68wawhc7xFzDfGRCNg9iHYVpguS4yroWTvS8Qku+CrbAq8cbMXfgj
	jbNZHP0vOSl/vtYV0M6DX6cE7NzcZxWTn86XyFSiir7L1VgkrrWy46Yvn+/DmgzwnuXfp6OZqQG
	aW4W+4ZCAIFEksN0vXpL0rmVqx9F0Cnv+0dMgKYAjFTN+ve1ktpcXmO2EIC1M279IwW8OeM2iSz
	zk2g/ANlAWx9EEg7hInLptFzEY8Ex/Euxn92DdrpuNzH7iegedGN1wpLXeMOAA43RAlYX25KCJ9
	AQT7K1p5SzZovLsdoSj4pSZHReaLSUlVjcdHRMWcJsV2dM3Q81HeG5WdSoyKsgJeZS8pde0nowj
	NHud91mnCYkSOyOUVCm9B4jJgeQILq6qx+6WSwm50nL5kakHut9wss6lFXZ8DCE4CrOmYn5DZUI
	P7ABYdMKxjuFNm4uumiqPtHgXuPv5SXxaw5EvyShVdqjBuDBhJDobq
X-Google-Smtp-Source: AGHT+IFQWcwToJXtlmVcxmZdWqb+p7usl4TzaktlGgv885VDmhxQ95bwd+azkuh9E8Say4Z2rE5kaw==
X-Received: by 2002:a05:6402:348a:b0:634:cc8a:5428 with SMTP id 4fb4d7f45d1cf-63678c4357dmr1386965a12.2.1759299376749;
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c4b96ff6sm8623357a12.46.2025.09.30.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:16:05 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251001081605.4f86a6cf@mordecai.tesarici.cz>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
References: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Cc: stable@vger.kernel.org

(One day, I'll finally remember, I promise.)

Petr T

On Wed,  1 Oct 2025 08:10:28 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
> ---
>  include/trace/events/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  		__entry->dma_addr = dma_addr;
>  		__entry->size = size;
>  		__entry->flags = flags;
> +		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
>  


