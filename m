Return-Path: <stable+bounces-154657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0DCADEC55
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072B43A96A2
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 12:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733C929C33D;
	Wed, 18 Jun 2025 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFCzlY2A"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DC285C87
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249592; cv=none; b=Mtjt5xtkbynL+9ltewVxfWITBKfJg6yuQfhyR8jlBwpH/Sy+GL9t4Y0H6myqFLRnLUmSn9p4PbKEIhyMvpCTDexntShOTSDBVquob51bb92xC1iwT3kBXuhAiB1AqrFKt1Frr6+CHxl0o+7NMJipIa5s/5YuKfxePZ0Bu4813OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249592; c=relaxed/simple;
	bh=mz0uiMmed9z9tOHShNrfShXtsw2Ac1cxhClTJyFThvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESOGr5yxi/7w4D2bAPPP6FsuKhLg3AwDdiaAFwvUwWe+Y3kUVFwy2JjEekJ1X4y4CClL9N6yg5ujDmVwq9g9Wt/g3gi2bD24D6j4yCj3E9Z4+KcX9KE+hUJCXx5IxWevMi+CPMy64UeRRaFnVtRAf/5gbQMyCYwagwBrRNokars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFCzlY2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8jFDh002625
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 12:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bhcW6+q7VLFC3B8HTp/6QcrhI6U7A912t6H6KHU0qA=; b=nFCzlY2Aj9CmiXJK
	vovllZcVekEKXnnJzolwXB8/nfVjjn5EivDPbHazXJENQaUTD9orHGm86wNFTmyb
	Hb7Y/fTUzSGn3CAB+S6cqvSeJMT98z8M/u7lspD4QAI9c6N+14TsPzahR7Xm7yhB
	cg/MWPXpbluhIFLT8P8hZhxIyR/6qQsvEax3bB8XWQ6DGQO2Xe5v5JQvW824Sfz3
	T1NXl9BpInowjvnDb+4IWVxl/iw6rDLBAU+cOW9ELQIPQw/70vucYtItrE27to48
	d1RJ3VTV9eP0az/YtrEiNwhyAIx9iCCPPix87CBTOCwteOHOYie1BEHhKl3buoSU
	b+C3NQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hd46cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 12:26:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235f6b829cfso55244105ad.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 05:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249588; x=1750854388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bhcW6+q7VLFC3B8HTp/6QcrhI6U7A912t6H6KHU0qA=;
        b=tizeXSZg4ctKGjiIxVmPojEFxNh58VaHm+uH09an5o7m0H+yi2x4c137UZSHAH8zFD
         ph1UGu8PbbJRiStKgzds9C1pCQEcAVzxfiGAnJMLSthM5x9A33qhDPf2dvZ6UFd8FMbP
         qcfiIq+n9q6P6DggD76vUZeZRXaQuItc7v9FRsNusd0lV7PCQHYbm3Ui2HR2jA/MTC7E
         s9zvgOXtS7EgxlWOPu+iPB8AW5zNSVQqgThvZsq79czIB0/AKMIeA1ngVfEoNpXATuMy
         Oqka2ciyVD5e0F36bxRit1rB71vSXYPgH17K2b79FwlMosBYEncZ6622VBNLd93oAEE0
         /uOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiQYVTjibXf1a4OxPAh9tDKSWEAbzced12OykjntIULSK6FHwKi49w3DoqEuEIiADuXeV0+OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6aO0LqkpxI/hZFMmOTuaF0kTBfdGvd7Al3Yuo1VLLIdUYQAH
	rT6pceqkYpdDBR9GKJvbgIGyj2a9h+xsOKt+rhqZ2xMvWnOgzNhtfrGfzQLVKszHLsLpkmckRqg
	HiqA3l3tp3mK2gbYtnYHXHgvo3EA2zw4nt6Lw4hxX0amYzV38a62n1rGl3Wo=
X-Gm-Gg: ASbGnctAmVAXUFM2q8Mk1jkMHr8LeDh2/HMzd0tpVBvAJovbds7ZkNzQrGM1+DnB/jW
	fsOb/wg/QWrbay4BfrhQ+VrYGDkfyGYHUQC6fXpMXqjd5kG9mdAW4vxWNzfoYExvEIFJVcPbH1m
	DSe2br1pvmBIwn5FTmXv2fomZiNNgLHS/4N/wESxSE+ULquZp3LCa5jheC54Ci/BMjnbHL8nR5y
	Luan+LKZ74nEdFr5p4yI//VVGt3rhSm069dlBSu01zyzJdZqWFZuUmkIZkDKY9sY5dt8hD5u1B2
	mpI6sEgHyjaZciVcydcmqVL4hNYQfmFlBABparxHQUJnJNj4das=
X-Received: by 2002:a17:902:8bc8:b0:234:a139:120d with SMTP id d9443c01a7336-2366b32e4ebmr156887695ad.7.1750249588186;
        Wed, 18 Jun 2025 05:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcRD1XEJ8bRVvhnDu/jtve9MMGk6I/mHhVF0u4XWlqu8a3OclQos52HAfFvf5CU6P4xFa7yQ==
X-Received: by 2002:a17:902:8bc8:b0:234:a139:120d with SMTP id d9443c01a7336-2366b32e4ebmr156887415ad.7.1750249587820;
        Wed, 18 Jun 2025 05:26:27 -0700 (PDT)
Received: from [10.218.10.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea7d98sm98727925ad.151.2025.06.18.05.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 05:26:27 -0700 (PDT)
Message-ID: <8cbc5220-c993-44a1-b361-418b36a3f336@oss.qualcomm.com>
Date: Wed, 18 Jun 2025 17:56:23 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: gadget: u_serial: Fix race condition in TTY
 wakeup
To: Kuen-Han Tsai <khtsai@google.com>, gregkh@linuxfoundation.org,
        hulianqin@vivo.com, krzysztof.kozlowski@linaro.org, mwalle@kernel.org,
        jirislaby@kernel.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20250617050844.1848232-1-khtsai@google.com>
 <20250617050844.1848232-2-khtsai@google.com>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <20250617050844.1848232-2-khtsai@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwNSBTYWx0ZWRfXyasnVKg+RdQ8
 Izr+wI6lPVUGUecEKEzOPkxJot+zEFSfb5a73ae1k2q6+0Hyp/160rhSX4dQ6V98XFxPZhw5HNW
 uFFFyC1UM/K/B1TpNOedRJkqZSruXbtX9LSxeRjOM77MpzkeHiAS8nA+piXwYFxn3kuxPQXMMMO
 m3ynJ3bsqd+q+ha6P/sFJ8JU1ij47nQ4VHcwy8zdNXGTFo+KcHa7XsRaATjip0WSivKmT2zewES
 NGbGVrPQnPm561V37HGUV1t7NzXkxNGIpLRHjQylH9+j+IRXETokLWY9MHtehK4RZoQJ83BHqwx
 WmWsK3sl4pykdhe5EsuBHCwebNeoQWutE9HJf5PAH5sy1OtQSfOKt0B+/5vz4Ps6Up4Up9Y5TVu
 JeN9UVx/lx+d1+kzwdm9FXmXFIY+4JX0Ws2vGKvrjIvPsT0OmX04OPRSAm16CBeHgSwAh4gu
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=6852b075 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=MIvUBlGXxtpg5XUkedoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: AfzlpCV9crnItmO6lRn40tI-cysn2HVY
X-Proofpoint-GUID: AfzlpCV9crnItmO6lRn40tI-cysn2HVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=843 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180105



On 6/17/2025 10:37 AM, Kuen-Han Tsai wrote:
> A race condition occurs when gs_start_io() calls either gs_start_rx() or
> gs_start_tx(), as those functions briefly drop the port_lock for
> usb_ep_queue(). This allows gs_close() and gserial_disconnect() to clear
> port.tty and port_usb, respectively.
> 
> Use the null-safe TTY Port helper function to wake up TTY.
> 
> Example
>   CPU1:			      CPU2:
>   gserial_connect() // lock
>   			      gs_close() // await lock
>   gs_start_rx()     // unlock
>   usb_ep_queue()
>   			      gs_close() // lock, reset port.tty and unlock
>   gs_start_rx()     // lock
>   tty_wakeup()      // NPE
> 
> Fixes: 35f95fd7f234 ("TTY: usb/u_serial, use tty from tty_port")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---

Reviewed-by: Prashanth K <prashanth.k@oss.qualcomm.com>

> v2:
> - Move the example up to the changelog
> 
> Traces:
> [   51.494375][  T278] ttyGS1: shutdown
> [   51.494817][  T269] android_work: sent uevent USB_STATE=DISCONNECTED
> [   52.115792][ T1508] usb: [dm_bind] generic ttyGS1: super speed IN/ep1in OUT/ep1out
> [   52.516288][ T1026] android_work: sent uevent USB_STATE=CONNECTED
> [   52.551667][ T1533] gserial_connect: start ttyGS1
> [   52.565634][ T1533] [khtsai] enter gs_start_io, ttyGS1, port->port.tty=0000000046bd4060
> [   52.565671][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> [   52.591552][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> [   52.619901][ T1533] [khtsai] gs_start_rx, unlock port ttyGS1
> [   52.638659][ T1325] [khtsai] gs_close, lock port ttyGS1
> [   52.656842][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be9750a5) ...
> [   52.683005][ T1325] [khtsai] gs_close, clear ttyGS1
> [   52.683007][ T1325] gs_close: ttyGS1 (0000000046bd4060,00000000be9750a5) done!
> [   52.708643][ T1325] [khtsai] gs_close, unlock port ttyGS1
> [   52.747592][ T1533] [khtsai] gs_start_rx, lock port ttyGS1
> [   52.747616][ T1533] [khtsai] gs_start_io, ttyGS1, going to call tty_wakeup(), port->port.tty=0000000000000000
> [   52.747629][ T1533] Unable to handle kernel NULL pointer dereference at virtual address 00000000000001f8
> ---
>  drivers/usb/gadget/function/u_serial.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index c043bdc30d8a..540dc5ab96fc 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -295,8 +295,8 @@ __acquires(&port->port_lock)
>  			break;
>  	}
> 
> -	if (do_tty_wake && port->port.tty)
> -		tty_wakeup(port->port.tty);
> +	if (do_tty_wake)
> +		tty_port_tty_wakeup(&port->port);
>  	return status;
>  }
> 
> @@ -574,7 +574,7 @@ static int gs_start_io(struct gs_port *port)
>  		gs_start_tx(port);
>  		/* Unblock any pending writes into our circular buffer, in case
>  		 * we didn't in gs_start_tx() */
> -		tty_wakeup(port->port.tty);

Just curious, since this is already under lock, checking for
port->port.tty would have also helped, right? Anyways looks like
tty_port_tty_wakeup is better.

> +		tty_port_tty_wakeup(&port->port);
>  	} else {
>  		/* Free reqs only if we are still connected */
>  		if (port->port_usb) {
> --
> 2.50.0.rc2.692.g299adb8693-goog
> 

