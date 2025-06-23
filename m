Return-Path: <stable+bounces-156167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B73ADAE4E2A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04633B821B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9882185B1;
	Mon, 23 Jun 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LbTXO1cJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100B3C26
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710685; cv=none; b=OSEacSUqQRgnfETR05i5mylNqOcbQ7a3o+qYPPCiavfI5NpF8FFqWvZwFhb6PZgj4KOKAfbHbmQNTpQxEFOi0xW6u5d4Tm0baYt5cSbF9L2IORkF/jR9mCXeCjyAlcZhabfYvxEfm+X4DxXcmpLQil4gU8pwoMS0uZrv6tXyyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710685; c=relaxed/simple;
	bh=XtezxSdOP+UjFwJsKuZxcQFunjHVQrFml5JuZ4SELms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+bbXE14NpB+gA9XCIwxGfKrTxOhAW8y6hsJfbnkIW3g8Ez5k5uy5nokOyHvgx4s2LsqQrdnI3og2TXLzccuFaDmCa8OT/BxTjypy6B3Wq8biqRGdHkQMph8OUl5h94lgX2hP67tZR32Ua7GT9HOf95lhxsVOgqlnf2qXrNXSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LbTXO1cJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGGwGd021368
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AM7e+WI1WjWum2hqHb+x3pciVPxEtvXw/CoY4ovDRVE=; b=LbTXO1cJsevhn1gw
	qbDyV0jBQYG7wl2/Ugt2HLZQ2YNZNWLbreRtj0RpHhShlPQKpCcFH9WEWJcfaxAc
	oU7bD1v0qhQ6CDlyKhBvXFABo68mxNNYoJBpHOrsv9cArI5U25mN2PZ+2w3nxbYu
	Ztv1kL/PLyhueZHJ32bsIqdPegRVoGwipbkUHNXzmwsKLf28AP5LVi4gmXdPNiao
	wanEp/wY0344x3qhsd/0/to690GNxjpEQqERUiEYyI8l48/HOgMCVzHBD31sjUa/
	kt5UP8yDS56m0UqqUBUaSKAt0SD4w62XJ+sOj3B3v/MH12gIhL/6Ac9r9Ob2n6AK
	VMD7/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpt36t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:31:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7cfb7ee97c5so12746785a.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710681; x=1751315481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AM7e+WI1WjWum2hqHb+x3pciVPxEtvXw/CoY4ovDRVE=;
        b=iFmgLf/94dn+/2e9yLm4RlMTBelDOXr1QcTy4Iu7cXFC5D/CdRNDEVhP3WkuYTcNtH
         rBTQlbybS7bnN6eDHQnp0prfafrL9wQfkYH4dxuf/QEnxzbylKCCWl3h7Um71p1Gay6X
         zkSJW/w4qJDw3/VGcPRjxeggiq1FsseWSILP382rg8fhiKmNlE+Xt0xnIegP6JMsUpO+
         +rNku4yc6XYEAkTQmDRkm4eT2XiXGSv6LerG/vIcllBQGBncge8U9cX6mLMwKIwsfZjb
         7+mIo+Rv4B3D0+xgv6hEZ/5NbXoUhrRd5tpnxGlJsbvWLgqvEte6J+92hbYXEy40kVzC
         X1JA==
X-Forwarded-Encrypted: i=1; AJvYcCUP7ev2wWBLKd2+zEOyByxBfAbeoMfobhYKWDrNXv14LcmfHZcFN/45qm3qldhK25CzSsdasEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtE/9at1jZCWWglMn6mZFYwFoTB4ubXfEnMLW52/hbIzfqOW8
	EOheOgvzo1ILRQbWo9w+3aovlTaOIKNgiQ0Q6uivvNOWQsqACoAm64CKF6YbnKwvmUIbNMThD6m
	Ru+2KWjIfGciVZiBi+U0AdPPhYTDe088NwLHt4FAfxS87CIFL1xkWH/tF4G3Ymd+sAlQ=
X-Gm-Gg: ASbGncsnirqoFwK7mbptHNGfN5E3rAUATW7wgkg0lZX0JPfphPQazfq7BbHXwUt45XM
	f2vkLQvPvQxcxRDOffhHsBgtIxwwlEC3mD4DWLQRGDdhoznSb9GdwfSLcnIDJXbrrikzxdFm6ZN
	85uADQ6GSzPjJHDh/67YUcwMKPNTC6JpiZNYsprk6881pkusy+A0BHcAWv0nfwPE8Th9JPf8xSH
	fVPmwW1+TBBsZ7nlWCKIezAEANQMHLFGYJda014qpk0UkbK0UfaU80WplwSq7hoC1N4qys6Rokb
	CUMYx42pdbN3gF63xMI4XtAkHYdLhjg0KEhVCNBUH1j7ZHsBX3wRvroASZD+xTNPdEtZ77Kbg9P
	ToPo=
X-Received: by 2002:a05:620a:1709:b0:7c0:be0e:cb09 with SMTP id af79cd13be357-7d3f98e0f77mr751552185a.7.1750710680672;
        Mon, 23 Jun 2025 13:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2QiIiGmM7antIjBt+7B/nWxD3Vu79fMhrZLayBKhhmi2EdbbLBrOXxNxUombVXn8rh4ofRw==
X-Received: by 2002:a05:620a:1709:b0:7c0:be0e:cb09 with SMTP id af79cd13be357-7d3f98e0f77mr751550685a.7.1750710680162;
        Mon, 23 Jun 2025 13:31:20 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f196c79sm12687a12.4.2025.06.23.13.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:31:19 -0700 (PDT)
Message-ID: <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 22:31:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
To: Mathias Nyman <mathias.nyman@linux.intel.com>, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu, oneukum@suse.com,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=6859b999 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=tT9duwjsjWl6H1QRmFEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEzNiBTYWx0ZWRfX0iuGPYl7Obpp
 8zjCrycT4fnK8U/D2SyCRWVnVEK922WLcPa2WZDlN3eGx997dvU3fitH1be/LYTvOQFY0Ezsgvs
 G0X+RcBUBUdfg2buyQq/E7GiQkBFpmxEaQvgKmINgeRvvpYIq7AYjisY3L34jrnA1xZgwrPnmiZ
 ZGH/E3WN1XzzCPbrHLJ0eZZNe/5+Pvn3qY7wu4qLGv+7do4dqw4np1Rw1yU/bLpiAeHhhWB5oKa
 rfEesL4QeQ7Wp0wl0rqGpjlDvqI4GFMw65+rs5aG7nmOUYbO9f4N4HGe7DVkfRfATTDDx6IhGlo
 oevC1lpeyR4FcVMtSs9aSywEbWz/jE1bou4/vqbkp11pSPyjPYPMEX1SwYUeZPo2a8cYnRhSAB1
 FwqeQhwmLVSri4ysOwgC/u6XdsKBQ+p8VsggCR3eoX4DSdRe8R/JMbu+Yq6IiA4MW1aNKU4A
X-Proofpoint-ORIG-GUID: uQAvDzdJcldxb9PU-Wtmh28NiXXk0Md7
X-Proofpoint-GUID: uQAvDzdJcldxb9PU-Wtmh28NiXXk0Md7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=751 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230136

On 6/11/25 1:24 PM, Mathias Nyman wrote:
> USB3 devices connected behind several external suspended hubs may not
> be detected when plugged in due to aggressive hub runtime pm suspend.
> 
> The hub driver immediately runtime-suspends hubs if there are no
> active children or port activity.
> 
> There is a delay between the wake signal causing hub resume, and driver
> visible port activity on the hub downstream facing ports.
> Most of the LFPS handshake, resume signaling and link training done
> on the downstream ports is not visible to the hub driver until completed,
> when device then will appear fully enabled and running on the port.
> 
> This delay between wake signal and detectable port change is even more
> significant with chained suspended hubs where the wake signal will
> propagate upstream first. Suspended hubs will only start resuming
> downstream ports after upstream facing port resumes.
> 
> The hub driver may resume a USB3 hub, read status of all ports, not
> yet see any activity, and runtime suspend back the hub before any
> port activity is visible.
> 
> This exact case was seen when conncting USB3 devices to a suspended
> Thunderbolt dock.
> 
> USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
> USB3 devices expect to be resumed within 100ms after signaling wake.
> if not then device will resend the wake signal.
> 
> Give the USB3 hubs twice this time (200ms) to detect any port
> changes after resume, before allowing hub to runtime suspend again.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
Hi, this patch seems to cause the following splat on QC
SC8280XP CRD board when resuming the system:

[root@sc8280xp-crd ~]# ./suspend_test.sh 
[   37.887029] PM: suspend entry (s2idle)
[   37.903850] Filesystems sync: 0.012 seconds
[   37.915071] Freezing user space processes
[   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
[   37.928138] OOM killer disabled.
[   37.931479] Freezing remaining freezable tasks
[   37.937476] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   38.397272] Unable to handle kernel paging request at virtual address dead00000000012a
[   38.405444] Mem abort info:
[   38.408349]   ESR = 0x0000000096000044
[   38.412231]   EC = 0x25: DABT (current EL), IL = 32 bits
[   38.417712]   SET = 0, FnV = 0
[   38.420873]   EA = 0, S1PTW = 0
[   38.424133]   FSC = 0x04: level 0 translation fault
[   38.429168] Data abort info:
[   38.432150]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[   38.437804]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[   38.443014]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   38.448495] [dead00000000012a] address between user and kernel address ranges
[   38.455852] Internal error: Oops: 0000000096000044 [#1]  SMP
[   38.461693] Modules linked in:
[   38.464872] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc3-next-20250623-00003-g85d3e4a2835b #12226 NONE 
[   38.475880] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023
[   38.485096] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   38.492263] pc : __run_timer_base+0x1e0/0x330
[   38.496784] lr : __run_timer_base+0x1c4/0x330
[   38.501291] sp : ffff800080003e80
[   38.504718] x29: ffff800080003ee0 x28: ffff800080003e98 x27: dead000000000122
[   38.512069] x26: 0000000000000000 x25: 0000000000000000 x24: ffffbc2c54fcdc80
[   38.519417] x23: 0000000000000101 x22: ffff0000871002d0 x21: 00000000ffff99c6
[   38.526766] x20: ffffbc2c54fc1f08 x19: ffff0001fef65dc0 x18: ffff800080005028
[   38.534113] x17: 0000000000000001 x16: ffff0001fef65e60 x15: ffff0001fef65e20
[   38.541472] x14: 0000000000000040 x13: ffff0000871002d0 x12: ffff800080003ea0
[   38.548819] x11: 00000000e0000cc7 x10: ffffbc2c54f647c8 x9 : ffff800080003e98
[   38.556178] x8 : dead000000000122 x7 : 0000000000000000 x6 : ffffbc2c5133c620
[   38.563526] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
[   38.570884] x2 : 0000000000000079 x1 : 000000000000007b x0 : 0000000000000001
[   38.578233] Call trace:
[   38.580771]  __run_timer_base+0x1e0/0x330 (P)
[   38.585279]  run_timer_softirq+0x40/0x78
[   38.589333]  handle_softirqs+0x14c/0x3dc
[   38.593404]  __do_softirq+0x1c/0x2c
[   38.597025]  ____do_softirq+0x18/0x28
[   38.600825]  call_on_irq_stack+0x3c/0x50
[   38.604890]  do_softirq_own_stack+0x24/0x34
[   38.609220]  __irq_exit_rcu+0xc4/0x174
[   38.613108]  irq_exit_rcu+0x18/0x40
[   38.616718]  el1_interrupt+0x40/0x5c
[   38.620423]  el1h_64_irq_handler+0x20/0x30
[   38.624662]  el1h_64_irq+0x6c/0x70
[   38.628181]  arch_local_irq_enable+0x8/0xc (P)
[   38.632787]  cpuidle_enter+0x40/0x5c
[   38.636484]  call_cpuidle+0x24/0x48
[   38.640104]  do_idle+0x1a8/0x228
[   38.643452]  cpu_startup_entry+0x3c/0x40
[   38.647507]  kernel_init+0x0/0x138
[   38.651026]  start_kernel+0x334/0x3f0
[   38.654828]  __primary_switched+0x90/0x98
[   38.658990] Code: 36000428 a94026c8 f9000128 b4000048 (f9000509) 
[   38.665273] ---[ end trace 0000000000000000 ]---
[   38.670045] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[   38.677126] SMP: stopping secondary CPUs
Waiting for ssh to finish


Konrad

