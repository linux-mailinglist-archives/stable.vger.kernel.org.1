Return-Path: <stable+bounces-191388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B46BC12DF6
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 05:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21E0B4E2C06
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984A27E1C5;
	Tue, 28 Oct 2025 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c2iR0ytx"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780226AA94;
	Tue, 28 Oct 2025 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761626668; cv=none; b=qpeh3prc+vs7M2OaBGCqc8TC+Pr2aW02TFAku8ljw9xz7eH58TFwihjgrGSmeR0bV+O/N+qPLssXxBB1Dya/yEx6LA4ObSe+VZtbVC9ztqOVJa/wARxoGwtbpPFHth4j2PI8KqnQuyDKE5szVFp0JiLyWdCRfFOgDmIRYpp9L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761626668; c=relaxed/simple;
	bh=wUt+RBpcmAmXefvbcuipi7AJd6NJf/nLovPZjczZppQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jE/TlyBOPBQKOW2aq3kML9N9s7T2xKsjI6IJ1Eqac0FTPCvcMphI+6KEKlrSU88aH9OwtEussamqC3wUNtYFjYLwAKadjNjcKaOsCWXGsLMrvExuN+BEsd1tZVtqLot+x1IZZlFNkyoeuN+1SzrtYpWNrHUOWn3N39bnS8LHmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c2iR0ytx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJ3aTD008697;
	Tue, 28 Oct 2025 04:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=anze7E
	q7+zdgnMdZzYJmUHn38ayPEjEKQqPB9NIDJls=; b=c2iR0ytxqFaF9TgaFLhQpe
	f5HbwyKLHbqAagictMvVejSpCfA9ajleNWJrGbIOD+ETOp2rJg0HSgCW16hw+kSh
	r2jehLsfkW7464qCdIf368HvoFcYUhHCpsyQUa/Ea+mlYjKeSzbqAG5mfevDWYMi
	0g9jTFF/RmJ8HxVPkSwJRMCxJUa2RjTld8NA01qpOR9yhwLpqlqs/xE3U6ijE7im
	lIY/VabjlsR87aEBT4rPYHEnZGtJk8SCIaC3aH1mSItfvsE8iLuid8978ghBUM/i
	iTj1JZyFNT+Cmb0GBwkD2pLSClMHB5RkUEROuDo9BXUiApXbZOwqCAA0XItv7Y9A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p99217h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:44:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S4fCfL009548;
	Tue, 28 Oct 2025 04:44:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p99217f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:44:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3QLW4022923;
	Tue, 28 Oct 2025 04:44:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xh39t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 04:44:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S4i5Sa37159228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 04:44:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8FF920043;
	Tue, 28 Oct 2025 04:44:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D632520040;
	Tue, 28 Oct 2025 04:44:02 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 04:44:02 +0000 (GMT)
Message-ID: <f1544738-bc22-4b6c-b643-7e7076217395@linux.ibm.com>
Date: Tue, 28 Oct 2025 10:14:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/kexec: Enable SMT before waking offline CPUs
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20251025080512.85690-1-nysal@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251025080512.85690-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69004a1b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=FNYM6xYWznnmATNcaFQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FxmdnNuzaqm78WhLlnDMk9_nePRBgCOm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX7QkWKQhFuOOO
 V9MA81mTt9sfU1UD8Rq3/20G1aeAxSbe8CFEPB7VnCN4pwya45IxorLcSrfBcX/F6suOnwW34CB
 Cn8L+SYmX9LxK5UTibbSis7CZckp43117R0xE1ZoGvcKAR26z2hgFrCxVqzDNkUDPwdVjnydw6F
 qJtIDFi5uh0mstIzJE2S80w7QpJ/nSfhGhz56vsYUOXVqyCGhYsfa+fhCe0+PUUj5Laj+HfKzak
 r7JBMdSnqeEcAuWlskJqzOpcPoS4z5X46mGRWD1vQVnPbWUJdjYwUiPaZU0UAV6tMyWZ/ScVEJF
 MYK+a9KsRBkULhLeZdBs7iit8B0uR6Ct4rQ7+JvafBgR5EkDr3KH9OPlUMa+qld4QCne36e25ZQ
 YvNeualAVKZNQLfjbKa7yFGgbnSQoA==
X-Proofpoint-ORIG-GUID: lthnj5OCypztazoUVbkfPZXSBi221ky3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

Hello Nysal,

On 25/10/25 13:35, Nysal Jan K.A. wrote:
> If SMT is disabled or a partial SMT state is enabled, when a new kernel
> image is loaded for kexec, on reboot the following warning is observed:
>
> kexec: Waking offline cpu 228.
> WARNING: CPU: 0 PID: 9062 at arch/powerpc/kexec/core_64.c:223 kexec_prepare_cpus+0x1b0/0x1bc
> [snip]
>   NIP kexec_prepare_cpus+0x1b0/0x1bc
>   LR  kexec_prepare_cpus+0x1a0/0x1bc
>   Call Trace:
>    kexec_prepare_cpus+0x1a0/0x1bc (unreliable)
>    default_machine_kexec+0x160/0x19c
>    machine_kexec+0x80/0x88
>    kernel_kexec+0xd0/0x118
>    __do_sys_reboot+0x210/0x2c4
>    system_call_exception+0x124/0x320
>    system_call_vectored_common+0x15c/0x2ec
>
> This occurs as add_cpu() fails due to cpu_bootable() returning false for
> CPUs that fail the cpu_smt_thread_allowed() check or non primary
> threads if SMT is disabled.
>
> Fix the issue by enabling SMT and resetting the number of SMT threads to
> the number of threads per core, before attempting to wake up all present
> CPUs.
>
> Fixes: 38253464bc82 ("cpu/SMT: Create topology_smt_thread_allowed()")
> Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.6+
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core_64.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 222aa326dace..ff6df43720c4 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -216,6 +216,11 @@ static void wake_offline_cpus(void)
>   {
>   	int cpu = 0;
>   
> +	lock_device_hotplug();
> +	cpu_smt_num_threads = threads_per_core;
> +	cpu_smt_control = CPU_SMT_ENABLED;


Above variables are  #define if CONFIG_SMP and CONFIG_HOTPLUG_SMT is not 
there.

I think the above code should go under #if defined(CONFIG_SMP) && 
defined(CONFIG_HOTPLUG_SMT).

Seems like the build failure reported below is also pointing the same issue:
https://lore.kernel.org/all/202510280824.Fe2D1Sbw-lkp@intel.com/

> +	unlock_device_hotplug();
> +
>   	for_each_present_cpu(cpu) {
>   		if (!cpu_online(cpu)) {
>   			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",


