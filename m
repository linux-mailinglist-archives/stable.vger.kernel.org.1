Return-Path: <stable+bounces-256561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DgIITFUGWphvQgAu9opvQ
	(envelope-from <stable+bounces-256561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:54:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCB5FF8E8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 645103065F1C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147A43BA23F;
	Fri, 29 May 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Plm0Ocof"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119273B7765
	for <stable@vger.kernel.org>; Fri, 29 May 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044558; cv=none; b=RVkhxqC2nuvTR3Ud1NG6W+qBbQZI2RD9VbmSuuYBkbk1heF/ZaA9yDbF/WbUuKlUjW+/AdkJtZXCaO5IYAXg6iN2AzWwuxgBmFo4xbxjZ0zQE8NCNHNe03eGCPNrNDmcFkqHBWu88Kw0hdnSX4oa8QzYt23R6YbwOWxi3BYEV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044558; c=relaxed/simple;
	bh=YZr+dlLLOVM9f5tjE//CCE91T1arzl5Qo6vnfIVtoTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE5yn7ZL2L/vC339HKIl6v4HqhuHloR0s5nwBkW/uw3EMj5G3ZckcadCa53w7BN6zC/KpEPF+cOwfuPDknMOHIL603+cvYilCTu4HVtTuU1HIX5ESSQix/5W/yFZ17qpv+UyplqF5UW/xFOv457kGJlGtPzZyJWUHXMDufjb4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Plm0Ocof; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-459bf19e87bso8263473f8f.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780044555; x=1780649355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cAHycA+rCv3IP7skEZFX6/tynpWg60FhTiaPBN0RaDI=;
        b=Plm0Ocofnmj/BsxXd0HiQqQ5mXyK+ncDa77teth7Ze40njW+zFwxp1ZgkbYc9VbSaS
         HxC0dBkUKjyYdAbK6QI9hRnZcDAl1zPT+oyshdhONUSEWy45esLDfZ52MXpEHAxWuipp
         Xp9EnNmQVV4Kwu1u1qizQjuzd4RsGG5YiUteS3iBSi0G0V3bjPn5iZvVzpT2Hn3xKD/X
         U/3LoT1aGjtlHkibuZwkgg+U5WV3lN7i6HrfgT98jJ7IKerBTBExIkOh/LSiZ5Z4tHr8
         4wWjp28N2gJTiL/AM/v4xr2WbZ/1tob+z21z0XHZjZYQb0/SNwppisfsMwSTD9j5dXmG
         iIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044555; x=1780649355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAHycA+rCv3IP7skEZFX6/tynpWg60FhTiaPBN0RaDI=;
        b=SHOjIi2l8Jr1edPfd7MGiS5257UBGTknaWPs8gOO5SJjByjJmlmpFu9HzGG34n2bH4
         jr+B/KwbW6nn1AXrU81NB6RHSun8KJSPJKyp7zpO/ukSGfYF2ZFOkvml7NMhiLVaEDd0
         nKYLts14dwWkjUTEbHnGSkbXbLDOaM3K8nsioqAaEQiUQEd/lFbD4QUh3t+0MpRl0fSd
         fgZO6YnLApyU8J6yEb+x+A/dtbx88V5Cc6HMjgp9XkEtFj2kqRWQeB0Wu3wM1JRJJmvZ
         sfTi4wkonDULiH0ICeMQ55zMpDz/N5ajVvlZPE+eUg//hTa6X6OkssZePL8F73eRE0Fi
         +hGg==
X-Forwarded-Encrypted: i=1; AFNElJ8JQTtGTAPM+NvhPPttddtaTD4/40gWVZ0zz59xqg/UNj9EEUgtU6k+UWcCknbn+lcT0FQ0a2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUZj+nYsVZnndk4p5qNwCnKTkvlFrEbT466+9ueeiWgKiyXcP
	s99IzpenRycmoPGC6fjiIvRmqesiDctnn6hmqgrg9WAObnNLlo6A7Aucy0SGrFaRBuM=
X-Gm-Gg: Acq92OGPdXmhe7Q4dVDtHz0b7uwtdS/t6l3ZH6qw7lLFbb+UIrgR7dO1HXSvvZ834wL
	UkgpIyEZ8B7IWWbvJIqaWmnhT9GXFaBtTBtisVhScbUA5d8ZhMEl8Ys9HgkwztwtBGZ+Sabb/32
	+nT8WJH54BW7AD9Q4WCzMFdOXqfV+sn8mO+Y2f3PMWM4uIqlwmlwqfTxIIahEdgBpplC1q35ugk
	he7A5+Q4ekUvKLH90KDXmroKqeA9Dj2BS7qd7yOSq/7J1AB0YXnFfG8nTdixZrosDorOd2A0rOM
	xXXhrWptiymp2vyWP/TM+kcRqEQlT+TeQaq/aKu8L7w0ibto3DKeDGIu7HYVWhoOOC44lgUEBnk
	hs7xgwskQt3QY/fCO0qor2yJOV5WGW8R6pxUxofp2bDo8xahXTgig9+foT2CJcYRjPyZhdtVvh8
	PAlyS5qRKknBp70PQxK1AmQoMg2e1MACGaaHIr9jH5s0V1Pp+Qzw==
X-Received: by 2002:a05:600c:4ca3:b0:490:5cd8:d20a with SMTP id 5b1f17b1804b1-4909c082256mr20357415e9.11.1780044555451;
        Fri, 29 May 2026 01:49:15 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c50f6sm2316210f8f.16.2026.05.29.01.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 01:49:15 -0700 (PDT)
Message-ID: <d3f052be-910e-4705-9390-86580f62289a@linaro.org>
Date: Fri, 29 May 2026 09:49:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etb10: restore atomic_t for shared reading
 state
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: mike.leach@linaro.org, mathieu.poirier@linaro.org,
 gregkh@linuxfoundation.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org, suzuki.poulose@arm.com,
 alexander.shishkin@linux.intel.com
References: <20260528165201.319452-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260528165201.319452-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256561-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james.clark@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:mid,linaro.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21CCB5FF8E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 28/05/2026 5:52 pm, Runyu Xiao wrote:
> The etb10 miscdevice uses drvdata->reading as a shared exclusivity gate
> for userspace buffer access. etb_open() claims that gate with
> local_cmpxchg(), and etb_release() clears it with local_set().
> 
> That gate is shared per-device state rather than CPU-local state. A
> running system can reach it whenever /dev/<etb> is opened, closed, and
> reopened by different tasks while the device remains registered, so the
> same drvdata->reading variable may be claimed on one CPU and later
> cleared on another.
> 
> This code used to use atomic_t for the same gate, but commit
> 27b10da8fff2 ("coresight: etb10: moving to local atomic operations")
> changed it to local_t even though the access pattern remained cross-task
> and cross-CPU. Restore atomic_t together with atomic_cmpxchg() and
> atomic_set() so the exclusivity gate again uses a primitive intended
> for shared state.
> 
> The issue was found on Linux v6.18.21 by our static analysis tool while
> scanning surviving local_t-on-shared-state sites, and then manually
> reviewed against the live etb10 file-op path.
> 
> It was runtime-validated with a reproducible QEMU no-device KCSAN PoC
> that kept the same report-local contract:
> 
>    1. use one shared struct etb_drvdata carrier and its
>       drvdata->reading gate;
>    2. call etb_open() and etb_release() sequentially on that gate to
>       confirm the original claim/clear path;
>    3. bind the open side to CPU0 and the release side to CPU1 for the
>       same gate to show cross-CPU ownership;
>    4. run bound workers that repeatedly race etb_open() and
>       etb_release() on the same gate until KCSAN reports a target hit.
> 
> The harness recorded:
> 
>    L1 passed open=1 release=1
>    reading_after_open=1 reading_after_release=0
>    L2 passed open_cpu=0 release_cpu=1
>    cross_cpu_release=1 reading_after=0 open_ret=0
> 
> Representative KCSAN excerpt from the no-device validation run:
> 
>    BUG: KCSAN: data-race in etb_open.constprop.0.isra.0 [vuln_msv]
> 
>    write to 0xffffffffc0003810 of 4 bytes by task 216 on cpu 1:
>     etb_open.constprop.0.isra.0+0x38/0x80 [vuln_msv]
>     l3_worker_thread_fn+0x4f/0xf0 [vuln_msv]
>     kthread+0x17e/0x1c0
>     ret_from_fork+0x22/0x30
> 
>    read to 0xffffffffc0003810 of 4 bytes by task 215 on cpu 0:
>     etb_open.constprop.0.isra.0+0x18/0x80 [vuln_msv]
>     l3_worker_thread_fn+0x4f/0xf0 [vuln_msv]
>     kthread+0x17e/0x1c0
>     ret_from_fork+0x22/0x30
> 
>    value changed: 0x00000000 -> 0x00000001
> 
>    Reported by Kernel Concurrency Sanitizer on:
>    CPU: 0 PID: 215 Comm: etb10_l3_a Tainted: G           O       6.1.66 #2
> 
> This no-device harness is not a real ETB10 hardware end-to-end run, but
> it preserves the same shared drvdata->reading gate and the same
> etb_open()/etb_release() claim/clear contract. No real ETB10 hardware
> was available for runtime testing.
> 
> Build-tested with:
>    make olddefconfig
>    make -j"$(nproc)" drivers/hwtracing/coresight/coresight-etb10.o
> 
> Fixes: 27b10da8fff2 ("coresight: etb10: moving to local atomic operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/hwtracing/coresight/coresight-etb10.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 35db1b6093d1..98269ea6f7ae 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -85,7 +85,7 @@ struct etb_drvdata {
>   	struct coresight_device	*csdev;
>   	struct miscdevice	miscdev;
>   	raw_spinlock_t		spinlock;
> -	local_t			reading;
> +	atomic_t		reading;
>   	pid_t			pid;
>   	u8			*buf;
>   	u32			buffer_depth;
> @@ -603,7 +603,7 @@ static int etb_open(struct inode *inode, struct file *file)
>   	struct etb_drvdata *drvdata = container_of(file->private_data,
>   						   struct etb_drvdata, miscdev);
>   
> -	if (local_cmpxchg(&drvdata->reading, 0, 1))
> +	if (atomic_cmpxchg(&drvdata->reading, 0, 1))
>   		return -EBUSY;
>   
>   	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
> @@ -641,7 +641,7 @@ static int etb_release(struct inode *inode, struct file *file)
>   {
>   	struct etb_drvdata *drvdata = container_of(file->private_data,
>   						   struct etb_drvdata, miscdev);
> -	local_set(&drvdata->reading, 0);
> +	atomic_set(&drvdata->reading, 0);
>   
>   	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
>   	return 0;


Reviewed-by: James Clark <james.clark@linaro.org>

Semi-related to this change, etb_read() doesn't have any lock when 
reading drvdata->buffer_dept or drvdata->buf. It locks in etb_dump(), 
but then unlocks before actually calling copy_to_user().

Seems like concurrent calls to etb_read() might end up with corrupt 
data, although I'm not sure if that would ever happen in practice 
because it only allows one open file handle.


