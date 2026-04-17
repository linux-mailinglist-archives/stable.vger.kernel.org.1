Return-Path: <stable+bounces-238472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGGtJ/kB4mna0QAAu9opvQ
	(envelope-from <stable+bounces-238472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:48:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0584198B2
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35392318AE2D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECAC3B19AA;
	Fri, 17 Apr 2026 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e73eTsvI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED46219EB;
	Fri, 17 Apr 2026 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418267; cv=none; b=HpEBcLDPl4KaMMPcGOFJULOOCEe6m5/yCzsVN1CKxjc2OSayH2CIXYRptJJph8uxqsw7rM3BnulhBtjehdxA5NpfZnx6B6hagDdleuKa/aQa7alEe+5D6ngtIv1WfeZV8wOWvl6UBsi6deXJpq9nF2wUIpPXkrloa73WPLsQBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418267; c=relaxed/simple;
	bh=Qqsjzyx7JIN/FNMsD6hyTWWLReS2YakaWfwbzyzjf0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOctFfHz32xfgGC2DyW1z0beB8u2DSN+VxM0TyIwGRzz8CKrWIEww6sew4hIlu400QQNZlw4L17wVJkTfe2WjPXoqwEV+RVXEz5NYtN7+l/cFsO10LoyECuY8eK4yHZbweAIJJb966FTxDY3tLj90CzdK0RxM5rucGyuRbaQUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e73eTsvI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GJHOuX1860002;
	Fri, 17 Apr 2026 09:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ylhcWA
	MoRMz5RLxhUd4Za9Ti0jJBJoVhrjk5Uufr7vA=; b=e73eTsvIhJ0awn0Or42Bp+
	aREr77SE06xCFCSpmxMqkpXR8AmtBAKls6MaSXZHYbDlmKgwJcwl0vXi0Gr9g9Sm
	5aKG6ONY2HQ/swDE5JTMjjKynGU9UZ9f/53skHHeWvW3g/AGIQF2EMoSIciHG/Im
	SvX4o09OE/z8sKS6MR5hiZ1EcWHCA51pF4rDTkMBaA/VAEMZpbpXmuGJLcCWXIb+
	h8QRIuS1QHWEs/UjZWh+clGw2HLUjWYDt1Y9vk3qC5Huyte1ghzAUAp5GHxK8UU4
	b3u3vuAt1UhgN77qcGRy6nMwZk9OhmXc0liKcdn1ei6hewUnRecna7/xRCJorvqA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89prncm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:30:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63H8MfE6025621;
	Fri, 17 Apr 2026 09:30:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujxe9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 09:30:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63H9UeYr48169468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 09:30:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 224D62004E;
	Fri, 17 Apr 2026 09:30:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA5720043;
	Fri, 17 Apr 2026 09:30:37 +0000 (GMT)
Received: from [9.39.28.188] (unknown [9.39.28.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 09:30:37 +0000 (GMT)
Message-ID: <dc17d2a4-058a-4ca7-b701-32a53c71f07f@linux.ibm.com>
Date: Fri, 17 Apr 2026 15:00:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/fadump: reject empty bootargs_append writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZpuidKosRXgK6xFjk55b3s7C5Ioqw6nb
X-Proofpoint-ORIG-GUID: FgBNQs713CIGiH4qqfKSSI_ZCZl0tnqc
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e1fdc4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=ISPHxN_rHVCBf9gf85UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5MiBTYWx0ZWRfXzZJRh73LJd6m
 sOfnU4KimGoboDbpWbqRA/IniEZ+4+85ZNQUGiMgaOJ2+979mCXqtEPV9t9p5/4ZuQWN+ncoyk0
 8WV5n6fNTy7hNu9Rev7m+W7v3E2WsOlQ0CusdTZ1vQKI/UDk1D0nIpBhZSypUl8ZSaao8jH0G2r
 WQPplU4UO9xefl2qZUTQLC8Q/VkAWIUNFThYG8R7VHwxA2EpU3tQCIYSn2pO9h48InZss56XDCD
 n8gCqgT2awh8rZo5tKOwkYMppXtNqf6haXR37Z6VVC4nlyivCHtWSngvWgh+hb4UL7S7xFY0Lt4
 u6KlBY6jllNGw9q0VgFAXuM3rpt0B3S53PUVCge22WWlKC2kfxpp76ubqGk1tPZLON1cwh5aNl3
 XVPZ+rsJ4nNlB2/ihlWZf/XeYReFVmxGEvfI1ke7AJnZLuyuRgIHFEjtMijB9eRTzcFnBZD1HdA
 qrJ842Y3bjravnwF1Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170092
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.ibm.com,suse.cz,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238472-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EF0584198B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 17/04/26 13:09, Pengpeng Hou wrote:
> bootargs_append_store() indexes params[count - 1] when stripping a
> trailing newline from the sysfs write buffer.
>
> kernfs passes zero-length writes through to the store callback, so an
> empty write makes that newline check read before the start of params.
>
> Reject empty writes before looking at the last input byte.
>
> Fixes: 683eab94da75 ("powerpc/fadump: setup additional parameters for dump capture kernel")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/kernel/fadump.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4ebc333dd786..03ab5565e420 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -1479,6 +1479,9 @@ static ssize_t bootargs_append_store(struct kobject *kobj,
>   	if (!fw_dump.fadump_enabled || fw_dump.dump_active)
>   		return -EPERM;
>   
> +	if (!count)
> +		return -EINVAL;

How you manage to call this function with count as 0?

> +
>   	if (count >= COMMAND_LINE_SIZE)
>   		return -EINVAL;
>   


