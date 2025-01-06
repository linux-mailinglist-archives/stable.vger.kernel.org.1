Return-Path: <stable+bounces-106851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A86A02771
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32C91630EB
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB5762D0;
	Mon,  6 Jan 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lYp1U3Yq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E139FCE;
	Mon,  6 Jan 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736172444; cv=none; b=F2W0BFzBEzQvgER4IBEFq6n6TRNBlLjImDnoIUBiUVh5CUxBGIeTpG6FH15LMOhBfQD+k606AZODcqvYpqB3lO9R6nreHLO74Oz1CqyNg8G1n2ZxbctkEaN6pO0s6Uz6vyTvmZtPdsciEB4Mwqj/Wi3fj4ZmjegwEy00tVkAe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736172444; c=relaxed/simple;
	bh=/9C/B/LcemZhglova26kzWe8CHKOrQjAUztr9Jd9fTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6zr23mGqCT5DEpX50oi2hV02Z+QoXV17yYztNpVFCwi5TFBhcjB9f48vSvG9wh8xGqcJT/39lGYZzs7jjkBdLyuP8XzNoWKEB7RNcYMZI7HiH0NH8SGgS2rMBKOYActxduGfhwLvhk/RHky//9sG+fI8pgh4HA2fTRmZlM0zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lYp1U3Yq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505NaqEp007181;
	Mon, 6 Jan 2025 14:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-description:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KeXVtT
	MY9ysxosD9h4kHGx7Wr7hGM/QRUps34uop+M8=; b=lYp1U3YqgwloOXPMav/0UT
	UvXGUVJc8FNUto/qpfKqwkWWhv7wbNWpz5mIkHKt6+PZozLwcYCoP05TbfUEhC2i
	bQUmpN3kUOaogOLFWaB8MYOQTolWfzqTACF5PtMTEukJ1itX8q2H8RaWLBaaEegD
	z5eiuG56VmrsKlQVdaz/WR8j9GyOZLUGdgztHDR+hNWWDARw6+hSISEPz9MT6eMZ
	fUg0waCy7wNmj3JWDbBzgj6tY4Y7XwietmbnGy4dYK+DW0DOBjUwawtso39x3MGu
	7e1LbiP14nKiTRH6WyLoTqeyfU4SBjZqfGefbODhwEwoWoa7oZtyMSGsQ0M6qXCA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4403wajtj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 14:07:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 506B34J5015795;
	Mon, 6 Jan 2025 14:07:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtknuvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 14:07:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506E7CXG57016730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 14:07:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 052A920043;
	Mon,  6 Jan 2025 14:07:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D86C520040;
	Mon,  6 Jan 2025 14:07:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 14:07:11 +0000 (GMT)
Date: Mon, 6 Jan 2025 15:07:08 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Koichiro Den <koichiro.den@canonical.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: Linux 6.13-rc6
Message-ID: <Z3vjjDsjZAfqLI6N@tuxmaker.boeblingen.de.ibm.com>
References: <CAHk-=wgjfaLyhU2L84XbkY+Jj47hryY_f1SBxmnnZi4QOJKGaw@mail.gmail.com>
 <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: Re: Linux 6.13-rc6
Content-Disposition: inline
In-Reply-To: <20250106131817.GAZ3vYGVr3-hWFFPLj@fat_crate.local>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LimqS1myUG2y4b7FJWApvxjnj72vJv-q
X-Proofpoint-ORIG-GUID: LimqS1myUG2y4b7FJWApvxjnj72vJv-q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=419
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060124

On Mon, Jan 06, 2025 at 02:18:17PM +0100, Borislav Petkov wrote:

Hi All,

> Something not well baked managed to sneak in and it is tagged for stable:
> 
> adcfb264c3ed ("vmstat: disable vmstat_work on vmstat_cpu_down_prep()")
> 
> Reverting it fixes the warn splat below.
> 
> [    0.310373] smpboot: x86: Booting SMP configuration:
> [    0.311074] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
> [    0.313798] ------------[ cut here ]------------
> [    0.317530] workqueue: work disable count underflowed
> [    0.317530] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:4317 enable_work+0xa4/0xb0
> [    0.317530] Modules linked in:
> [    0.317530] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #11
...

JFYI, hitting the same on s390:

[    0.176304] smp: Bringing up secondary CPUs ...
[    0.186596] ------------[ cut here ]------------
[    0.186603] workqueue: work disable count underflowed
[    0.186606] WARNING: CPU: 1 PID: 21 at kernel/workqueue.c:4317 enable_work+0x10a/0x120
[    0.186613] Modules linked in:
[    0.186615] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #206
[    0.186619] Hardware name: IBM 3931 A01 701 (KVM/Linux)
[    0.186621] Krnl PSW : 0404c00180000000 00000308470979ee (enable_work+0x10e/0x120)
[    0.186626]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    0.186629] Krnl GPRS: 00000308484bf9b8 00000308484bf9b0 0000000000000029 00000308484bf9b8
[    0.186632]            000002884717ba08 000002884717ba00 000003084726e5e0 000000000073e180
[    0.186634]            000000007fffffff 0000000000000000 0000000000000000 000000007af24840
[    0.186637]            0000000000e3a300 0000000000e3a300 00000308470979ea 000002884717bc60
[    0.186685] Krnl Code: 00000308470979de: c02000846cd0	larl	%r2,000003084812537e
[    0.186685]            00000308470979e4: c0e5fffee146	brasl	%r14,0000030847073c70
[    0.186685]           #00000308470979ea: af000000		mc	0,0
[    0.186685]           >00000308470979ee: a7080000		lhi	%r0,0
[    0.186685]            00000308470979f2: a7f4ffb2		brc	15,0000030847097956
[    0.186685]            00000308470979f6: 0707		bcr	0,%r7
[    0.186685]            00000308470979f8: 0707		bcr	0,%r7
[    0.186685]            00000308470979fa: 0707		bcr	0,%r7
[    0.186708] Call Trace:
[    0.186710]  [<00000308470979ee>] enable_work+0x10e/0x120
[    0.186714] ([<00000308470979ea>] enable_work+0x10a/0x120)
[    0.186718]  [<000003084726e64c>] vmstat_cpu_online+0x6c/0x90
[    0.186722]  [<0000030847075d9a>] cpuhp_invoke_callback+0x16a/0x4d0
[    0.186725]  [<0000030847076832>] cpuhp_thread_fun+0xc2/0x250
[    0.186728]  [<00000308470a8424>] smpboot_thread_fn+0xe4/0x1b0
[    0.186731]  [<00000308470a0d46>] kthread+0x126/0x130
[    0.186735]  [<000003084702508c>] __ret_from_fork+0x3c/0x60
[    0.186738]  [<0000030847d3a582>] ret_from_fork+0xa/0x38
[    0.186742] Last Breaking-Event-Address:
[    0.186743]  [<0000030847073d62>] __warn_printk+0xf2/0x100
[    0.186746] Kernel panic - not syncing: kernel: panic_on_warn set ...
[    0.186749] CPU: 1 UID: 0 PID: 21 Comm: cpuhp/1 Not tainted 6.13.0-rc6 #206

Thanks!

