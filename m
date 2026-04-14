Return-Path: <stable+bounces-237799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFedJ2wh3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD53F9315
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 066733005AE3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E92472B6;
	Tue, 14 Apr 2026 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lnpz/coF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611320DE3;
	Tue, 14 Apr 2026 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165225; cv=none; b=cEV1EvblH5WGEZe6fsT1ALo3RqFCN6zpYQuXWC+YSbZXI76g6Rk3SAXWiVWayM/YykFVkyBgJH57NMb8eKUGcGrU+UE59BeKABo99NG5BrrGDxW4RxSAExTaFhI2Uh30n4DxqxNFyRDPXud0GPNyy9ESYGn9EuD/RwyXWCHPGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165225; c=relaxed/simple;
	bh=AUnyCh4osOCdG2pYKaeVZMZlj1d1PkbKSPkp62X0HhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5uNKYD86rG80+F+gRf/wiZkKIQHDcHUe2mo+fLrO+GDLn3Mul2CaMzPrDwneaN+DwmXxlj4oMpEIfTZ0/plXwWxDXlqiNQTv+N5qY6dW406dcXKlzOPy/JsSINjFcEr1492VgEDncgguVI6i/pQArPcG2FCpxJorK0nV6qDY+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lnpz/coF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIq1G1860578;
	Tue, 14 Apr 2026 11:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=18wnu0
	j6nOlBo7L66MN9NA7h7B+h1kmUSFuqSPpe4YY=; b=Lnpz/coFjQnxQwuMCjNkhE
	98/FSVSTpLcwDZddkGiEgUhB3W+zOk8IVKR8nCRjk4nz7QbtzVuWKAchobLrilWV
	Wgt2t3iYQnTSl5lTlA5o12jAWMqXkLDxu7q6dCACf+394cVUKM1zbWXZ5OJOAv3A
	PLmGyR1r/mFyTYboAhiRmFyRpxmlbuqx6cj5oD7Ge5zYVljngCt3KDDSsLpiuMwn
	xBoQOFuJH+TC9cBCKBk2Qx2q5fMO0X82cZj1kvPRrk1trkrvheBmBcwVPD0/NtpJ
	pdg7ln6kjI2IlNI/EzZmbpPqmd5eNsJ7e/mxzm6Zr/nLA0+Px+Zyjt8kE1iCx2BQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pa8uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 11:13:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EALejN004188;
	Tue, 14 Apr 2026 11:13:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k92vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 11:13:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63EBDQ8F22676018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 11:13:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1BDB58053;
	Tue, 14 Apr 2026 11:13:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C9758043;
	Tue, 14 Apr 2026 11:13:23 +0000 (GMT)
Received: from [9.39.26.89] (unknown [9.39.26.89])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 11:13:23 +0000 (GMT)
Message-ID: <b1a5b96a-a525-4566-876d-5286c1367d7a@linux.ibm.com>
Date: Tue, 14 Apr 2026 16:43:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memblock: fix off-by-one page leak in
 reserve_mem_release_by_name()
To: DaeMyung Kang <charsyam@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260414094439.982853-1-charsyam@gmail.com>
 <20260414104353.989063-1-charsyam@gmail.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260414104353.989063-1-charsyam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wkLhB1sG-uScmjyYMpuqjEOmKu6tMIPb
X-Proofpoint-ORIG-GUID: 7JcEVzdBO7YccUBjh6yMYYB6HFHeu3pv
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69de2158 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=A9Q-lSG_ta5snbpTm5QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEwMSBTYWx0ZWRfX3M/DsbIwZE4i
 QAWM4kkD8F/DarLEXqCHMCquT2f/UVJ7m+ub+kBtazP1cOwUOIJTAsIOXzjPzwrWJr+wlFgqaK5
 zprW8W8enLD+5lQUXdOgnxxwrnDzcrpLK16CaqzBVOKAOVYqRrZrMyQTFDMk1L/arC82TyUhlXu
 OpSY9WCcLjihggUiuQYfjXo/QEZ2nQV84Nbyzzrhttlwn/FVi24h4giwqqGePAys21GhXCPyhaP
 JDDrUo5U7YWwTOKV/sDidYh6vmiIm6n1uwemOKXMa/sGn1zpsw6FqAx9lPfUO3Hvjra+YAD8f+B
 LlJHkNE/ZsvpFkdoL0tc2xgumxR0tZa0xnD0R2KeJVnMhUSca+as1Ycd1Bq63ECeR4iDwB2PlpR
 GHZ5H927brRWyFnpnqbgR0DBGr6XLzRkjksaj82OWTKKy+Twy/nVpQXELBM/OH9PVVFBpZgpwEh
 g3JrLg7FykuytS6jdAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140101
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237799-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donettom@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 17BD53F9315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

On 4/14/26 4:13 PM, DaeMyung Kang wrote:
> free_reserved_area() treats its 'end' argument as exclusive: it aligns
> end down via 'end & PAGE_MASK' and iterates with 'pos < end'.
>
> reserve_mem_release_by_name() instead passes 'start + map->size - 1',
> which causes the last page of a page-aligned reservation to never be
> freed. For a reservation spanning N pages, only N - 1 pages are
> released back to the allocator.
>
> Fix it by passing the exclusive end address, 'start + map->size'.
>
> Fixes: 74e2498ccf7b ("mm/memblock: Add reserved memory release function")
> Cc: stable@vger.kernel.org
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>


I think it might be better to send v2 as a separate patch  rather than 
as a reply to the previous version.

This patch looks good to me.

Reviewed-by: Donet Tom donettom@linux.ibm.com

-Donet


> ---
> Changes in v2:
>   - Add Fixes: tag and Cc: stable (per Donet Tom's review).
>   - v1: https://lore.kernel.org/lkml/
>
>   mm/memblock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b3ddfdec7a80..d4a02f1750e9 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2434,7 +2434,7 @@ int reserve_mem_release_by_name(const char *name)
>   		return 0;
>   
>   	start = phys_to_virt(map->start);
> -	end = start + map->size - 1;
> +	end = start + map->size;
>   	snprintf(buf, sizeof(buf), "reserve_mem:%s", name);
>   	free_reserved_area(start, end, 0, buf);
>   	map->size = 0;

