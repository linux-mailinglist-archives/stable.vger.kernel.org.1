Return-Path: <stable+bounces-238341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNZLCa8b4WmmpAAAu9opvQ
	(envelope-from <stable+bounces-238341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:26:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A84412A9B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D0153032DEA
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB2C3264DF;
	Thu, 16 Apr 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+gvUDm2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245D319851
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360363; cv=none; b=MAJBOVl7vnuaRy9b+jCq+GD18Efob4a5L2rZ/cp0s++nqdbyKblI7NKkhnvPF2JJL6E/D5PxuT9p2VLoHcl9EgfaTGDbMi7+1aGPYODf2nEAKW6ZFhGs+ZgZmshpKgxAKDePmAp4z8OzT5YHXzkn5oPpT/IXeS+dScmPpoL79tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360363; c=relaxed/simple;
	bh=8TutVFT0hECdtwHYPD7KRgv2J2Fan8VcWdgBQxNgxhM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bgV1LzfjbjLaD9j55OeiGJ7X57uIqT20P5Z8DsbuKEqJGEAjSfAoU+scyDTP4XYAt9fY2grAaJCCsgYPZhxRJJ6iDShSfyy98dlM2rUjwBt3t63lKZZVbge8q0tmkr8JIw5xYBb0wRu/vNjzPIIx50SnKxwg0DFaNbwJbX16aAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+gvUDm2; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d9472c97dbso197155eec.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776360361; x=1776965161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+oSOpmEaL2AL0jPocX9orqw+4TcJ8hn5aq7jtSVezk=;
        b=P+gvUDm2uOvDRPh9BglHdTSlMraj0q0MQr4v2JWmdqTLLauXtZSg7Ju7r/sZ6Ifwwo
         mAN8YHornl8pYMYb3F2S8C5tnU9boO8Kx3oYAvdkxNvxNCvQQEDKU/Tt2eYTNIwbqITx
         9lqsExKRnAo/IgeBLIrFdyfLT8AwerXEwaisEJnroC877YVLnk9ukH3EVAYcKgxwVmaW
         0H4P++GlfGznoCrsPIiARpcvCiqLDnhqrnsQIHSnKQpKzUt1+IEj2Vbdpvg/pxBf7t2F
         eIN+2lXnjgzpEniZdue7z27iM7UONAH1yf6+KrBf8UhrCIrJzXbkMpUnFf4WolpXa7RM
         kGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776360361; x=1776965161;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+oSOpmEaL2AL0jPocX9orqw+4TcJ8hn5aq7jtSVezk=;
        b=rfROppEVODMkUWhYN8qLByKBLddni4EFk/KKzWCazCsHthRkCQYfoEP+O51ju0tQLw
         jSfwKNV9iaw792hsbiCyT5g5iKupgj4PxbCcqhRo8a2CMCSveeO1qNcijt1kmEDWNWe6
         4IXJ8cHZKEyuHkH4yh5tfrANKP4imZ0murf2hQsGFlts+jCiIeGbHRXaDU45A8gF1B1N
         onc/QtsW0EbZxB719QvSL6s9nKBDtK1GVNA12U1DvOH7KnX/3/rLl4GGmf3a32U0gd0j
         EmjbtzwdTfk4dHF0I8Js7XJVJ4b5VmMuDhpINAKJXczVnw5UvIyDNqmg7ka0Uwz3143n
         CkIg==
X-Forwarded-Encrypted: i=1; AFNElJ9Tw7plmq+ypAPCvyeklMNGBgSeqbKl6kxzjhue9OVJKJrJvQFiDKaeV/sJ/nuu/9q9yI3coO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytwwRTeFs4iyadONM/KCyxySAXTgKbvWpmAdstINWWXhLJMT8K
	x9Vynl2sDvFmei6EThxx35WS//aJMGzFmveY6H+SHrr30oaSz6iqMIRt
X-Gm-Gg: AeBDieseCA/FsSxEU5fI3d5GXGmuFdbfUqFSopaMnZgenSabjrJUxAO1KiOGSCUiX0Q
	bYLsnrOKyQ7uzTezuqDxGQypTM1wVBDl+ISsex3UchAWlJx89XH6U77MwQYwBoEMcfnrgceIBaJ
	vb+qSZ3gBDc0iwlaSmNxodLHHy47mrNyXk9oMRDaNExuiVVro5/i03d4G1cKqT+sqDLKAkzdAup
	9TBHqKubBH+RohzG2ZV1fqvIR/FEYY9sadM16lnXoKa9pVgXB/YrKGwRgWPF0GL33xPBLrALii7
	o805+xKqbOybVNzuTgv+8NZmxd8AtJFFSmOf01qbEzpV3F+Uub6QRME0mnosVgtYcjOPrWi0Nxr
	kdhFdRk6FSdeNjKuh6HMAcL+fyfrWxRWu4FG6aCmTCmLK6GyPI/h5fR99mGfESFa4+602Beh6Pp
	vQJ/Z/tdzdX7RNELF9+yZdjnG9ltX0HE+V8ntyFvuS8KD6stfi18HdBXINunabw6O2Gfs=
X-Received: by 2002:a05:7301:168e:b0:2da:b53f:8c9f with SMTP id 5a478bee46e88-2e2e09350f6mr35840eec.0.1776360361060;
        Thu, 16 Apr 2026 10:26:01 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.228.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb848b8sm8199551eec.16.2026.04.16.10.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 10:26:00 -0700 (PDT)
Message-ID: <166964d1-2d16-43e8-b4d7-27b4a5e6286d@gmail.com>
Date: Fri, 17 Apr 2026 01:25:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yangyccccc@gmail.com,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sanman Pradhan <psanman@juniper.net>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jie Zhan
 <zhanjie9@hisilicon.com>, liusizhe5@huawei.com
Subject: Re: [PATCH v2 1/2] hwtracing: hisi_ptt: Propagate DMA reset timeout
 in trace_start()
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
References: <20260414172451.14331-1-sanman.pradhan@hpe.com>
 <20260414172451.14331-2-sanman.pradhan@hpe.com>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <20260414172451.14331-2-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238341-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,vger.kernel.org,juniper.net,arm.com,hisilicon.com,huawei.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96A84412A9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+cc Suzuki and Sizhe..

On 2026/4/15 01:25, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
>
> hisi_ptt_wait_dma_reset_done() discards the return value of
> readl_poll_timeout_atomic(). If the DMA engine does not complete its
> reset within the timeout, hisi_ptt_trace_start() proceeds to start
> tracing regardless.
>
> Return a bool from hisi_ptt_wait_dma_reset_done(), consistent with the
> other wait helpers in this driver. On timeout, log an error, de-assert
> the reset bit, and return -ETIMEDOUT. Move ctrl->started to the
> successful path so a failed start does not leave the trace marked as
> active.
>
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

looks good to me.

Reviewed-by: Yicong Yang <yangyccccc@gmail.com>

I see the Suzuki has sent out the PR for 7.1, so this may wait after the merge window...

thanks.

> ---
> v2:
>   - Return bool for consistency with other wait helpers
>   - Add pci_err() on timeout
>   - De-assert RST before returning on timeout
>   - Move ctrl->started to the successful path
>
>  drivers/hwtracing/ptt/hisi_ptt.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 94c371c491357..b5d851281fbf0 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -171,13 +171,13 @@ static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>  					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
>  }
>  
> -static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>  {
>  	u32 val;
>  
> -	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> -				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> -				  HISI_PTT_RESET_TIMEOUT_US);
> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> +					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> +					  HISI_PTT_RESET_TIMEOUT_US);
>  }
>  
>  static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
> @@ -202,14 +202,18 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
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
> +	if (!hisi_ptt_wait_dma_reset_done(hisi_ptt)) {
> +		pci_err(hisi_ptt->pdev, "timed out waiting for DMA reset\n");
> +		val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +		val &= ~HISI_PTT_TRACE_CTRL_RST;
> +		writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +		return -ETIMEDOUT;
> +	}
>  
>  	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>  	val &= ~HISI_PTT_TRACE_CTRL_RST;
> @@ -234,6 +238,8 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>  	if (!hisi_ptt->trace_ctrl.is_port)
>  		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>  
> +	ctrl->started = true;
> +
>  	/* Start the Trace */
>  	val |= HISI_PTT_TRACE_CTRL_EN;
>  	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);


