Return-Path: <stable+bounces-233187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKvUNaXNz2m50gYAu9opvQ
	(envelope-from <stable+bounces-233187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:24:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 226BC3952E0
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5860B3050EC9
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69E6389DE8;
	Fri,  3 Apr 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cPoTp5cX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF81C84AB;
	Fri,  3 Apr 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225931; cv=none; b=nIJRfswb7iu4U0sJNpBANl6L2RnFgY/91jsKqqDDvCDZYZCmq7PAY5TDjD2VdmA+whQ3TOZcxhM4eiGNRnuoDwK+cVpXHMWeZc7u8jq6hJKgqjJFgpIjB9ea76/nuuirUI0Zjy1aREEaWiDZdX5lKGEgk9/qZAD1Ct2GSIqjsMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225931; c=relaxed/simple;
	bh=0iwaBQaqkRH+Ksohs6XVOlfusU/ItqF4j6SMhwXZ+S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8CEiESxCHi1KndekbmY/TrmZsZtXulKzwjYUb8ujOX0ehE27hCuObKqkkuZcv2MFn1Zu3FyR5lFFIQtjC2qo7uPUWnjpHiBnTUYphTMViVoi6GJvVeBsiizIxx0A1os0EmgwDR7O+2JOyd7LQ3wLllcbxingTRC6XFpBRVv7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cPoTp5cX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6334bMp9473627;
	Fri, 3 Apr 2026 14:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u4o+5x
	Qz4rBlXhhhaVbeSyCEljJvqzKGzcABXH9U2Ss=; b=cPoTp5cXxotZ2EImhK0AmD
	B1+mrQUjazLVY40Ju3LXE4bKGa5R+vWWn7A8lko+Q+JQT963ee3FXeTQd5WAzoNm
	vaXu7bPLrH1FjVt0CDR0aXvObxX6Rm8ehlfl11B9njduTJ0q5atE3c37feDFyY8d
	SeLz93iw2Jn25Fxi/6PhcFrWzNZuw6cqV0NZGQDt9DdlFrqjnxjnaLApLJGojVim
	mLMSvHLTy643neTdLFp53tRoYiXvjzXBsc2XkzyecPSTgIOKUT+kGjhdZMBJ4WSN
	i7w3LkOCbew7Fpu6TP4I3D8YQzcS/szhnX8rPF2YMsjGpIdbWSfB/Ymh9iLppteA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dh07em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 14:18:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6339F0Cs030947;
	Fri, 3 Apr 2026 14:18:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk6708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Apr 2026 14:18:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 633EIZs931785258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Apr 2026 14:18:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41A8920043;
	Fri,  3 Apr 2026 14:18:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F59F20040;
	Fri,  3 Apr 2026 14:18:32 +0000 (GMT)
Received: from [9.124.211.65] (unknown [9.124.211.65])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Apr 2026 14:18:32 +0000 (GMT)
Message-ID: <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
Date: Fri, 3 Apr 2026 19:48:29 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20260403100126.1468200-1-coxu@redhat.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260403100126.1468200-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEyNyBTYWx0ZWRfX5e3hD65KjPE8
 75KPQnF5RscaI0G98tuekDhtVJ7d8CjBopwmFeqTRoseeaSSo4QQat+GTdN6LxpSB+MtuS8etk0
 MLJVEfivV2tRSL3+E9awafsZfL/fIP8hb84ORKo9ANPBBBkQcMg6Nui/Pj/Uqol/4L4bycsRvjL
 p+Z2Eg0MXnAp8pArivvTu9NkO82ZS/0ibO1uuwYK6MqtYFKexLurk2QVbT8H1D/hZQuedrMnWG3
 J909VpewUoOIe7kJ9Y1o0RgflC2PUaIkXxjUKI99iWgiuunLJTxIZmcc6bGw4iD8rD0zqfro2qZ
 XrOOHAbeb0W9DqVGTJtOpkY6eF1R62inOCcCRJElss0WmYlHHUBeGYz8n0wMRREJWGH3xdoWzIX
 8swzIQXYZEef7fddAApzNoIyKlKlMLvFsI8lyS+D35WtxVuAG9mAXeFEFKC0X0+WCHl7L/RRj+c
 uf+IPl3T2jl95VjL0BQ==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cfcc3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8
 a=LspaYCeSQ2Tinx22wy8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: Asdp7Dmj9Ch6BF2KJMHwrnzxu_0HgNcH
X-Proofpoint-ORIG-GUID: Asdp7Dmj9Ch6BF2KJMHwrnzxu_0HgNcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030127
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233187-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,linux-foundation.org:email];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sourabhjain@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 226BC3952E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Coiby,

On 03/04/26 15:31, Coiby Xu wrote:
> If kexec_add_buffer fails, keys_header will be freed. And depending on
> /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
> following two problems if the kexec_file_load syscall is called again,
>    1. Double free of keys_header if reuse=false
>    2. UAF of keys_header if reuse=true
>
> Address these problems by setting keys_header to NULL after freeing
> kbuf.buffer and re-building keys_header when necessary respectively.
>
> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
> Cc: stable@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   kernel/crash_dump_dm_crypt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
> index a20d4097744a..92eebef27156 100644
> --- a/kernel/crash_dump_dm_crypt.c
> +++ b/kernel/crash_dump_dm_crypt.c
> @@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   		return -ENOENT;
>   	}
>   
> -	if (!is_dm_key_reused) {
> +	if (!is_dm_key_reused || !keys_header) {
>   		image->dm_crypt_keys_addr = 0;
>   		r = build_keys_header();
>   		if (r)
> @@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>   	r = kexec_add_buffer(&kbuf);
>   	if (r) {
>   		kvfree((void *)kbuf.buffer);
> +		keys_header = NULL;
>   		return r;
>   	}
>   	image->dm_crypt_keys_addr = kbuf.mem;
>
> base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d

Sashiko raised seven concerns on this patch. Most of them are
not directly related to the changes introduced here, but I
think they can be addressed along with this fix.

https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com


1. build_keys_header() does not release key_header memory on
    error. This can cause incorrect keys to be loaded for the
    kdump kernel in subsequent system calls.

Can be addressed by releasing keys_header on error path.

2–3. get_keys_header_size() uses key_count to find the size of
key_header buffer, which can lead to out-of-bounds access
at two places.
   a. Around kexec_add_buffer()
   b. In build_keys_header()

I think there is one more place where this applies is:
   c. In get_keys_from_kdump_reserved_memory() at memcpy

I agree with solution provided by Sashiko of using keys_header->total_keys
instead.

4. get_keys_from_kdump_reserved_memory() may run into issues
    if kexec_crash_image->dm_crypt_keys_addr is larger than a
    page size during memcpy. Because kmap_local_page only maps
    one page.

How about moving this in a loop and do map and copy page by page?

5. Related to releasing the keyring_ref reference count, but
    I did not fully understand this concern.

6. restore_dm_crypt_keys_to_thread_keyring() does not release
    previously allocated keys_header, leading to a memory leak.

As per kdump.rst, restore was introduced to handle CPU and
memory hotplug cases. Is it needed when there is no in-kernel
update to the kdump image on CPU or memory hotplug events?

But in that case, we rely on a udev rule to reload the kdump image
again.

I am confused about when exactly we need to restore.


7. Possible memory leak and data races due to concurrent kexec loads.

I think we can ignore this because both kexec system calls are protected
by the same lock.

I also noticed that kdump.rst still says CONFIG_CRASH_DM_CRYPT is
only supported on x86_64 for now. With the patch series below,
this needs to change, right?
https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/

- Sourabh Jain





