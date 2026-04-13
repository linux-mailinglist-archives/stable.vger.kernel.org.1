Return-Path: <stable+bounces-236496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIZLJ74Z3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BED13EF08C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6DC30A537C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C02B2FFFA4;
	Mon, 13 Apr 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtYNZgEI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53C27280A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097054; cv=none; b=raWGbGjMMZLege6qw1fgpcqr7F1+u+X2OCiaOt9UFoAnNBcKo9YOfq8b2Qgt7Cr74Upup/OmBJ2mbnCi8cYlC7dCucMbFdDEvOZiuRd6r2yB16KWk0u08NkhllSaWbuBTdijgTZHhnJzK+zc/gd98iLhQkOcZk8zKF8zVofXP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097054; c=relaxed/simple;
	bh=/Wy8EUFyEpeEAyYGqty2YpfolfGPZl8bC76hgMD2EBc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nAaBka7mbNgnSj7jhpZjCDTF9Wjec0Jv+dncT3EoIyjxUr8qru+9RXrcj39fh4NAU4IVeFO5GNhlXHPWgpr++1bDFl1UmqfOd1JiMntQaZtdaXWEuRl7qlzZdWRJGGE2jk3NNrjcPXWQ/uCPjNweXyqNrUKkk+dHShLq4wChI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtYNZgEI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35e4617924eso473630a91.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776097052; x=1776701852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjcJ7ExbmXQll1fJ8sfhOKaomR2S+dBnysGQ5TsI/p4=;
        b=ZtYNZgEIfbLWj/Z6HZH4tes2qv+QZynMjYOKMEBxUCy7BeOc0i0hB84oQEV8g9R0wx
         AgEk/8I5Nd7l5IGtsOBg5Sqq2jtFz+rkue+zEdeDfGEz5OMpOdVPfUQgzpGKsaz9NPBT
         pey2ABuJHh2cMuI9hQOLn9rgNHOdtpwWWYgO5E1sLzz9M4K347dVefSvnT0qMpI25djt
         hANmr9xEyybVyj8lSwAHpNOlJibYawiHKmMecmE4R63v2B6z6Pe+FsIS0QMPBVvegs7r
         rXHpv/bvNmgKz/MaKKCF21iOD68m5Xrv/01uT5OAPY4srGB3wDBKl0Sm0hjDPiLF+cd6
         O2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097052; x=1776701852;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KjcJ7ExbmXQll1fJ8sfhOKaomR2S+dBnysGQ5TsI/p4=;
        b=fSlNBx/IrgByG6okSxRxJYrr19BzMGWFGXb94yERUHod05z+0Lj8018CI3KD7Rc0ms
         8xZ+3aDghHAddgneq4s9ZAYH2uZl3fX/CowwDTPIJ63kT+79kvrzZinRa0O91SwDIwWI
         u9vAIp6lLeAzngLPC5Ztu/3AoKvtFy8y+Q3JndfCKYkqh7J+AQPXCT0epx0EbLYj9FS2
         8V53pFqFJ+dhUYm+tdI6duTGRwNdQVdnzJyvyyNz1iB8ovNYYxOFHLDS3FRO0wyyUZKW
         cydh85X+4vCp3MpXiL8U8sdx/5GVfr9doNzEI+0v1ZbBdFLtQIoh6W8xKFywzXrZxf3L
         KHxA==
X-Forwarded-Encrypted: i=1; AFNElJ9eNifSCYY9T5lzSqg51C9tguiZVu7a7ICF4iMQ670am4xBV+92NWxHcuF3h1/SflZLLQu6i98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaoAHXxO2NfsW9Dioi9GXtvu8ECZibXnJLaexHZpY27f9TqOe
	8qLcmRj0JSF5HNmwy7Jymtni3Q8bt3ZUKrCfnB5Vgu1g7iOZqT9nG2yCgEzW6w==
X-Gm-Gg: AeBDieuJFUuha6HJTZ70J5WGf9DoDBd1zcXXktvp4bUiKvoPCLPomyky6pevk8TuvNB
	fT/opOfgvBZiB+xHxNeDMGl4mzuxYWjDY++bznG+a0XD1qByd2bD7dDjIV5Weu6sK5JuuwE1jJp
	gxdPToJ41mJX6lkmblGVuJdQy3zhB62/cH997xuKqw8o/aY7dUfCb2dkX9Ee2mOeoOmok8+30Ll
	xKcQ8XpCt0fvEmd+/atHyBVyLagfD2VyN0wEfaFtV9wF9jcod36VCgEWpu1NO5UQiCKx927ZVBJ
	TU7/Rayj7BCNwRRHNzlle9NoGrKrG7VRygyNy1naT+ofRhItcfpdEjfY3U1iWfKIGBMAoID8qdQ
	7z2Q0eZBMFU0VSTlGWansRQ4IUaJc9pyq8ROAO3zD1qe/548lMb9kd8gqU3aggAROGVZz84OQ3H
	G8g+jcORr0CMteLJjj83xnKw6d+JQQARoPP7I/E16rG4zvyjbD5Ps=
X-Received: by 2002:a17:90b:35cf:b0:35e:576c:7c1e with SMTP id 98e67ed59e1d1-35e576c7d9cmr4245897a91.4.1776097051938;
        Mon, 13 Apr 2026 09:17:31 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.228.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4131d3f2sm12560433a91.12.2026.04.13.09.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 09:17:31 -0700 (PDT)
Message-ID: <86770cef-bf30-45f6-8d33-e7b74b3bb834@gmail.com>
Date: Tue, 14 Apr 2026 00:17:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yangyccccc@gmail.com,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 Sanman Pradhan <psanman@juniper.net>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, shenyang39@huawei.com,
 prime.zeng@hisilicon.com
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout in
 trace_start()
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260409010704.383882-1-sanman.pradhan@hpe.com>
 <20260409010704.383882-2-sanman.pradhan@hpe.com>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20260409010704.383882-2-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236496-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,linux.intel.com,juniper.net,vger.kernel.org,hisilicon.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangyccccc@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BED13EF08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/4/9 09:07, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
>
> hisi_ptt_wait_dma_reset_done() discards the return value of
> readl_poll_timeout_atomic(). If the DMA engine does not complete its
> reset within the timeout, hisi_ptt_trace_start() proceeds to start
> tracing regardless.
>
> Return the poll result from hisi_ptt_wait_dma_reset_done() and
> propagate it from hisi_ptt_trace_start(). Deassert the reset bit
> before returning on timeout, preserving the existing reset cleanup
> sequence. Move ctrl->started to the successful path so a failed start
> does not leave the trace marked as active.
>
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 94c371c491357..73b93df8504c4 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -171,13 +171,13 @@ static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>  					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
>  }
>  
> -static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
> +static int hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)

the other status wait functions in this driver return a boolean, it's better to keep consistence.

>  {
>  	u32 val;
>  
> -	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> -				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> -				  HISI_PTT_RESET_TIMEOUT_US);
> +	return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> +					 val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> +					 HISI_PTT_RESET_TIMEOUT_US);
>  }
>  
>  static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
> @@ -194,6 +194,7 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>  {
>  	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>  	u32 val;
> +	int ret;
>  	int i;
>  
>  	/* Check device idle before start trace */
> @@ -202,19 +203,21 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>  		return -EBUSY;
>  	}
>  
> -	ctrl->started = true;
> -
>  	/* Reset the DMA before start tracing */
>  	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>  	val |= HISI_PTT_TRACE_CTRL_RST;
>  	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>  
> -	hisi_ptt_wait_dma_reset_done(hisi_ptt);
> +	ret = hisi_ptt_wait_dma_reset_done(hisi_ptt);
>  
> +	/* De-assert reset regardless of whether the wait timed out */
>  	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>  	val &= ~HISI_PTT_TRACE_CTRL_RST;
>  	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>  
> +	if (ret)
> +		return ret;
> +

could add some error log here for better debug. otherwise looks good to me.

the timeout wasn't checked since the hardware reset will be finished in the limited time normally,
which is less than the HISI_PTT_RESET_TIMEOUT_US. It'll be better to add this check in case
there's something wrong with the device.

Thanks.

>  	/* Reset the index of current buffer */
>  	hisi_ptt->trace_ctrl.buf_index = 0;
>  
> @@ -234,6 +237,8 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>  	if (!hisi_ptt->trace_ctrl.is_port)
>  		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>  
> +	ctrl->started = true;
> +
>  	/* Start the Trace */
>  	val |= HISI_PTT_TRACE_CTRL_EN;
>  	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);


