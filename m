Return-Path: <stable+bounces-57909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD971925EE4
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB121C216CC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E35143C6E;
	Wed,  3 Jul 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW/D+cdr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A91428F8;
	Wed,  3 Jul 2024 11:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006974; cv=none; b=SS0MUXCTIaMZ7KdpgQVObfy8GfvzId5TyCSS+HciV0S1FWgMR+NNB2YTbwf/+ZWAEFAZXEKfrjZmbUga3/aeAoO4HR9uHJKDcMX+61lURJ7qErw3YEXhhg9sw74ohAxyV1HulCdr2mr5QOdCNn4qXU2Hs/7kt23hFxZ4JH0uXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006974; c=relaxed/simple;
	bh=K7qNNKCemwJNnX+1BcIXpnr6N/yn50dUXjm/HbTkLYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiZpnN/whcYVxhAvnWof0wtPyjei8OD5DQrIJRvQ4NTN4nwtvd5NWm8W8Yx0Os5RsDUAgh6KezwwjLQ+9NXuHzvz9ejHbWh3FgjIJSG0LeQKS0RxJf9GkjvT12axQyxqWFq82l/8J+vYGIiPOq46aeaG8u9XCA5wJzbKmrGmUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW/D+cdr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb05b0be01so9158475ad.2;
        Wed, 03 Jul 2024 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720006973; x=1720611773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ge1wWoFHDAtDCXZQGNb/dsW5tPLZbTcFYOX+qhqBchw=;
        b=WW/D+cdrmECyM2sWCSx3FZ4WCkBKMiUy0HtJh1hlWIcxD0mrOLKycj9kv1/mMV+jYa
         WZpmP4G/aDsh+kmXza/DFcp/AjPUZXhJ5fpYsVNsAW3zObNBzyfLhlx9nGTcHyZhdCfK
         9Z3lc5LYKNxoSFhxgk8I8VfdmTduQHYt5aQFx3L/D6aMPtDQC2lAR9WeUfI2WO+BAGe7
         m8Dz2STGxzbITKgCDZG805EKyuycK0odBVjGHY9pzZ5Yj0eW3igqd7Bp7s8ubtbaN7UH
         zyW72LoMOkhIWpMRFGjID7G9Dy8qp5p6t6IF4l426ymrvtx/CDowK8lHWkNYKwiz5Qls
         NAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720006973; x=1720611773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ge1wWoFHDAtDCXZQGNb/dsW5tPLZbTcFYOX+qhqBchw=;
        b=Tabm+x7Y9qkn1rGnY+I2V1sABIwC+x03Jup0/YMiH4e1q1s79htZAHm6L0zSvTN4FQ
         L4ht//6HrFSuuKcfPLZwaQueiaTeMX1MZBC3yuILLW0kd0Gz3+n7hHHwnuYY37ehdekS
         KRxMhWUTymh11/T7tcjpV+clIVEo7xsXpMaMVNTc7GTj6eUzI2JJZphTkJRet1nUm2TV
         hhejko54IlDisT5N181y+oZp8+ZiMxYJi02qpXpEMlx7n8NdlA/FYGGmbN8Dx+bX4Dah
         AGAYAELfeC2AY2uyUJQBH+PT+xzHFitE1abqR+NmUOPHhvIHkmtB/w0Wxd+EQ3wpVz1o
         aNjw==
X-Forwarded-Encrypted: i=1; AJvYcCWqBm2GXPvYh2tsF/LAxt5KCvX2UAX61qnJdxEv1ieP0Ee56uFoDqFGOVOe8mKQ0swtxGaEnxQjkl0Y6cmXe8QHxLBCGz4jLMIHk6/ocW+QFYt7tvYop97Xmxzi2s7Z
X-Gm-Message-State: AOJu0Yx8U6EI7oQ67xQBjDeEmF+SseIz9iIPijWYE3PY8Q1HsWSe0C5W
	08YaXr8RJlZdlo3yg148dpnbg9S7nrOlEH7lp0DscC9SeFk/V0rs
X-Google-Smtp-Source: AGHT+IFbmGqpCrPp2DHnF9f4E0obqrsea7nIt1awnOigtyr4ECVltV3vSLfaUTJvNYIpmMopU63g7A==
X-Received: by 2002:a17:902:cf01:b0:1fa:fc13:8bbc with SMTP id d9443c01a7336-1fafc138ddcmr33072075ad.57.1720006972724;
        Wed, 03 Jul 2024 04:42:52 -0700 (PDT)
Received: from [10.150.96.32] ([14.34.86.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad58e84d7sm88502545ad.74.2024.07.03.04.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 04:42:52 -0700 (PDT)
Message-ID: <65a38070-cccf-45a0-af10-fd482eab64be@gmail.com>
Date: Wed, 3 Jul 2024 20:42:48 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 228/290] tracing/net_sched: NULL pointer dereference
 in perf_trace_qdisc_reset()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, netdev@vger.kernel.org,
 Yeoreum Yun <yeoreum.yun@arm.com>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>
References: <20240703102904.170852981@linuxfoundation.org>
 <20240703102912.767573728@linuxfoundation.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240703102912.767573728@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 7/3/24 7:40 오후, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Yunseong Kim <yskelg@gmail.com>
> 
> [ Upstream commit bab4923132feb3e439ae45962979c5d9d5c7c1f1 ]
> 
> In the TRACE_EVENT(qdisc_reset) NULL dereference occurred from
> 
>  qdisc->dev_queue->dev <NULL> ->name
> 
> This situation simulated from bunch of veths and Bluetooth disconnection
> and reconnection.
> 
> During qdisc initialization, qdisc was being set to noop_queue.
> In veth_init_queue, the initial tx_num was reduced back to one,
> causing the qdisc reset to be called with noop, which led to the kernel
> panic.


> Fixes: 51270d573a8d ("tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string")
> Link: https://lore.kernel.org/lkml/20240229143432.273b4871@gandalf.local.home/t/
> Cc: netdev@vger.kernel.org
> Tested-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Link: https://lore.kernel.org/r/20240624173320.24945-4-yskelg@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/trace/events/qdisc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index a50df41634c58..f661d3d7c410a 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -53,7 +53,7 @@ TRACE_EVENT(qdisc_reset,
>  	TP_ARGS(q),
>  
>  	TP_STRUCT__entry(
> -		__string(	dev,		qdisc_dev(q)->name	)
> +		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
>  		__string(	kind,		q->ops->id		)
>  		__field(	u32,		parent			)
>  		__field(	u32,		handle			)

Since that code changed in +v5.10.213, +v5.15.152, +v6.1.82 +v6.6.22
+v6.7.10, +v6.8, +6.9 and the stable is in an intermediate state.

commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of
__assign_str()")
Link:
https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/


I had to fix some other part for the stable branch backporting.


So, I submit another patch. Please check out.
Link:
https://lore.kernel.org/stable/20240702180146.5126-2-yskelg@gmail.com/T/#u

---
 include/trace/events/qdisc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index 1f4258308b96..061fd4960303 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),

 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	dev,		qdisc_dev(q) ? qdisc_dev(q)->name : "(null)"	)
 		__string(	kind,		q->ops->id		)
 		__field(	u32,		parent			)
 		__field(	u32,		handle			)
 	),

 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q)->name);
+		__assign_str(dev, qdisc_dev(q) ? qdisc_dev(q)->name : "(null)");
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
-- 

