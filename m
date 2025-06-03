Return-Path: <stable+bounces-150701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E7ACC5A0
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788AE1892C7C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05422AE65;
	Tue,  3 Jun 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XYfP0g9X"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EAC2F2;
	Tue,  3 Jun 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950950; cv=none; b=aiEGAReoPCpr/YFirB5AuF8VlrFLCWJ97QCF7LtKU6BmxV6XNA36cgCZNuyxlW8MMqcGEOkl1m4pYd0//ht2hcs1xBQCad51cg3UQEyqOhkB2FvChunJn47HvthXOOZ7UXCEy8ML+5dcOQS94GpjHiAlIaMB0jDxr2h9+FYxCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950950; c=relaxed/simple;
	bh=jAo7imnYEvZOWw8Fr9iC9+rONadBLKDro0cCes3qcyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A39BKsVsneBbLX7r0Ib7KwfOpZI72Io4GppJvktR56NQWyN3ho7t0L3LgWcYPuyIABeXcX+TV9tswv05E2BwcWETQWm/tBs0zFmRHgCTjUZjVDsWVJyCG0xOUZ+mAa56eocng3FFTJq/OIHCX/KAcQGFY8JW/FXbg0lbIC01K10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XYfP0g9X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5538bTlK027989;
	Tue, 3 Jun 2025 11:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M5qepa
	eqT6cveuEEU+cn4QGRlJlvi+qXbr4Ty+t1sp4=; b=XYfP0g9XOdcQ6Za60rKNWT
	yhou7k4ZDnvconIFtPD0OkzJx9JuBjHY606CJokheDIfljfIHknYDapi4kQOqDml
	cc5nSjHfc8n9WZv3GN8sTtQj3Gf+8rGCDjJvWA+iCEHm8gBzkmelhrflUHvINLeJ
	2ZYIp6cyP6WnIbTn5YmQXIfsHsCnrleB4R5Jojv1KTqTUDXG3txYqKcWyr32b66m
	xgccBNtl+IYzGIurcr4BmoViFhzQUi0yDVzuw+N+2Zihwss4oMUcM8chUn41h+nD
	NVvuUOrwfvFMRnsbmwEIi8ltFAAXTZDZnIodB5zD8L+Ktzv3ZX/Y1IGW6eicJiwQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gw1v05h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 11:42:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 553Bg2CL017448;
	Tue, 3 Jun 2025 11:42:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gw1v05d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 11:42:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A0ou3024768;
	Tue, 3 Jun 2025 11:42:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmaj2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Jun 2025 11:42:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 553BfxRN46662054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Jun 2025 11:41:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82FFA20040;
	Tue,  3 Jun 2025 11:41:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C052220043;
	Tue,  3 Jun 2025 11:41:56 +0000 (GMT)
Received: from [9.124.213.177] (unknown [9.124.213.177])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Jun 2025 11:41:56 +0000 (GMT)
Message-ID: <4f502647-ceb6-4867-a270-8d86d9a6c700@linux.ibm.com>
Date: Tue, 3 Jun 2025 17:11:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Fix preemption string of preempt_dynamic_none
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250603-preempt-str-none-v1-1-f0e9916dcf44@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA5NyBTYWx0ZWRfXwrESZwEytLPU EROwRMEs3sy2A9Yy67Xzz3dBy6Augmq//FQKggKYVspadwYo9tPO4sBQl8jY2fTmDVNJC3lvaZD lQ8DICOV+1oOp7+tVWgoXOGSfbLSXMZDs3MU07CyMj40B+q5KlfBCCcMiLFi7M84MBjUG/+TkkB
 zPTw+pFBBNjYRgvjB5jiTEaDW3ye8F7GrJ9wdYyVcZL4u2G0BzCVmkXtFHIjYzfDBRAfeRy//u5 QAOK/lRyUhDdjbYYFbaqXfWtBP1XT/Gd6OYFu9Jpd1yvAePps5+Nm4dIV9bK39h+hTmlIsH8yK2 nk6mS7OKhnieWNZQtwgJ7U/qJVmrbyg6D7BghJDuMhVb/YO6hnqmuyuPVQRjBq4YdBulvjLD4kB
 9N8L3Us1Pnpo3wbFJsPCeY6qElupgvxphsB6KsNSiczyBOYev0n0B5y3RQj8GxtqrkX3aNB3
X-Proofpoint-ORIG-GUID: 6xIctwjM1jjiEpge3fJO6ZYht28VPaPu
X-Authority-Analysis: v=2.4 cv=HcIUTjE8 c=1 sm=1 tr=0 ts=683edf8a cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=e6ZWrvrJy5nLrC09UCQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4_FCnkEz8b1Oqhj0vY5_90HGyzr3yNrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030097



On 6/3/25 15:22, Thomas Weißschuh wrote:
> Zero is a valid value for "preempt_dynamic_mode", namely
> "preempt_dynamic_none".
> 
> Fix the off-by-one in preempt_model_str(), so that "preempty_dynamic_none"
> is correctly formatted as PREEMPT(none) instead of PREEMPT(undef).
> 
> Fixes: 8bdc5daaa01e ("sched: Add a generic function to return the preemption string")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   kernel/sched/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index dce50fa57471dffc4311b9d393ae300a43d38d20..021b0a703d094b3386c5ba50e0e111e3a7c2b3df 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7663,7 +7663,7 @@ const char *preempt_model_str(void)
>   
>   		if (IS_ENABLED(CONFIG_PREEMPT_DYNAMIC)) {
>   			seq_buf_printf(&s, "(%s)%s",
> -				       preempt_dynamic_mode > 0 ?
> +				       preempt_dynamic_mode >= 0 ?
>   				       preempt_modes[preempt_dynamic_mode] : "undef",
>   				       brace ? "}" : "");
>   			return seq_buf_str(&s);
> 

Yes. It looks correct with patch:
latency: 0 us, #1/1, CPU#0 | (M:PREEMPT(none) VP:0, KP:0, SP:0 HP:0 #P:80)

Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>


