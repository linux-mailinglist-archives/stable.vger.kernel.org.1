Return-Path: <stable+bounces-203057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA544CCF404
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBF730084C6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260AF2EFD99;
	Fri, 19 Dec 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pz8NNeo6"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228A72DA771;
	Fri, 19 Dec 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138357; cv=none; b=XmL9MJkgcXE8VHqtVm5+Dx8iLdcpO2uz01r4l44iuZlFC43hp9QvaVofBDyRJFtX8TFl334hkl3u3Cyj9vh6rmmGDD5YHkigHh2IGh1HN8v+QXdjbC7tRWLVeG/gulxqSgIRR8fDmai2J5LV7TL0nZRntSKwQv8DH1nPCm69e+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138357; c=relaxed/simple;
	bh=AJsHHiIlSFNf4iYa+WNIvXXtarc0vNtt4N3jUiUlhSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Al9su4abXjvU+BBRyFt2dl2jCZ7AjZL7YOebfknip2/WRjvxDrK/ujhWaIijY5n4Qo4VlLMhzGBcrd6OZtDXGat/2OFpN4dc3gyPTT+4TGW/vzUxg2bz5fcavPJUjq/4SBYtDRGJA08m5Bo2N/VuMCW9nK4RKTs/aL5keEiF324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pz8NNeo6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ95cJf031413;
	Fri, 19 Dec 2025 09:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HjXwjE
	YyLAjERmT/P3jZFWsenxE3WpbszS0wG9QRvnM=; b=pz8NNeo64Ogk6Ctyp94Oit
	TF20GcgiK6f/m5IjTgrVRtIQQsaD+njb1SubwvESdjzSwWn3Kfq6HB7rG0oUVTn+
	Ia8Wy/gBx6DJq+PPY44zKCczF0AikLzOrxhtEB5SpDb/AZ8mQPtuL52qw4ZBXhNZ
	sngd3DssxKGy31FtEknPmGSbtTVg880gxnk/pLO0Lc/ZTy6Ub6b1m7cVb+JvwJWQ
	b816QEX44B8yZ9j+sahUQdo9ox+AFYoZngH0oq6rlvw2h2csauiaQ5tlOKvr0/VQ
	ffr9wAouzwxCPWbf51II/pjlDenqmUSDrzjr8R8bTs3Irkw0OePFqSH89ItAOdqw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3djsgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 09:58:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJ9sIAq022147;
	Fri, 19 Dec 2025 09:58:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3djsg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 09:58:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJ7iomG001277;
	Fri, 19 Dec 2025 09:58:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvpk2fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 09:58:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BJ9wrAu28836522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 09:58:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B3D2004F;
	Fri, 19 Dec 2025 09:58:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DFC020043;
	Fri, 19 Dec 2025 09:58:51 +0000 (GMT)
Received: from [9.124.209.192] (unknown [9.124.209.192])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Dec 2025 09:58:51 +0000 (GMT)
Message-ID: <857996ed-f60a-419d-8292-93b3494db2ff@linux.ibm.com>
Date: Fri, 19 Dec 2025 15:28:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/kexec: Enable SMT before waking offline CPUs
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20251025080512.85690-1-nysal@linux.ibm.com>
 <20251028105516.26258-1-nysal@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251028105516.26258-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 56bbVSljGG6tCNGybMMSg0HuxkEQpcUZ
X-Proofpoint-GUID: eFUgXrAxSkpzqPITDHZlqvcfCgYNpTJP
X-Authority-Analysis: v=2.4 cv=KrZAGGWN c=1 sm=1 tr=0 ts=694521e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=OpFFV_YLwuV3j5NzMVYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MCBTYWx0ZWRfX89RwAcVjNWnF
 swYDiMbtWJ6NNGPFb4gCQ9KwCzszVXcxQ6J2YT06SkK0vzbRW24mXMPBwUNt0Ib32tm1pWhUzTJ
 aHv3A74iyv5zs7pioX2zsvctEIqZtxIj3fG5PHuP0am6i6TnddegwvI/Fcf/5x2jJOJfoWHe09j
 tPlw5EbGvy32eI73ItO7Lp9fgPRlNjuPZrnUMds7zQv6ZSlhoQPl76ir/KQ3fDFUIWZADYoup/v
 1DO/7Gaigvg9Et7L59r9wdgKAN4pRWjYhIqNK9/gjLBZkVRPMWvwUkq3PijKEdJUlbbZTQ+3O7O
 wlOBYvBKAjAep6rXQpMldJPMgwzFiAZ848TZPQU3WfdJji+8/6H8begk1VEb65/k8LWxJJq+C3H
 K8hswym0Gs9uR9WyErLxqJiaSFYguElHWsj6UEFrdreIgOHyjvM9udeJi2hDqJjK0qzcY843Us2
 M+SPzRpVn1yDN64A+KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512190080



On 28/10/25 16:25, Nysal Jan K.A. wrote:
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
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core_64.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 222aa326dace..825ab8a88f18 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -202,6 +202,23 @@ static void kexec_prepare_cpus_wait(int wait_state)
>   	mb();
>   }
>   
> +
> +/*
> + * The add_cpu() call in wake_offline_cpus() can fail as cpu_bootable()
> + * returns false for CPUs that fail the cpu_smt_thread_allowed() check
> + * or non primary threads if SMT is disabled. Re-enable SMT and set the
> + * number of SMT threads to threads per core.
> + */
> +static void kexec_smt_reenable(void)
> +{
> +#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
> +	lock_device_hotplug();
> +	cpu_smt_num_threads = threads_per_core;
> +	cpu_smt_control = CPU_SMT_ENABLED;
> +	unlock_device_hotplug();
> +#endif
> +}
> +
>   /*
>    * We need to make sure each present CPU is online.  The next kernel will scan
>    * the device tree and assume primary threads are online and query secondary
> @@ -216,6 +233,8 @@ static void wake_offline_cpus(void)
>   {
>   	int cpu = 0;
>   
> +	kexec_smt_reenable();
> +
>   	for_each_present_cpu(cpu) {
>   		if (!cpu_online(cpu)) {
>   			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",

The fix looks good to me. I also tested it with QEMU using different
SMT values with the kexec_load and kexec_file_load system calls, and no
warnings were observed during kexec.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

