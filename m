Return-Path: <stable+bounces-217615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODjRMVYpmWkuRQMAu9opvQ
	(envelope-from <stable+bounces-217615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:41:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C2616C0A3
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 04:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9BD303815B
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C742C08D0;
	Sat, 21 Feb 2026 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yq0eTwaj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD292848A1;
	Sat, 21 Feb 2026 03:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771645264; cv=none; b=q1QzdQHZNqV6o79yyznKy1PtjZV6xHqj+pqk1yrXnFXtX50oBtscjEAWW/Cf6xEazm91HX/RY5rTxhCankXUtFHIEllQSIABTPGjx+xAXKXdY/jFpGwgb7uttUb/axUm8V6SeXTq6W82rajmZo8RQzZzdlpPWtDPHjKO2jScdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771645264; c=relaxed/simple;
	bh=tJVa05rqOg23XtzRQOJTSzGG+5KGWnhJBaxT/IozRq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j4btV8b4AzntdCOfc8W5MfRBJHugK7hulAJxlmrVfJRtN/4us8N7YMPQsbu/NoxOYtG46a5E5xUHmnx4FLc6s1+TeMrVxG1FkGE4jDs34LTygKzc0F/V0ufven/lgbhOFI0xQsTVfevaZRg4LyHlnwA1kM0RZe7Og6YMgmBPArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yq0eTwaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61L2vonU2154671;
	Sat, 21 Feb 2026 03:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7YEdIo
	rcSclRf2uO+viXOh2ARWoPpyG/p/Rdh98ljeI=; b=Yq0eTwajpbJ7a5YjNHqd6f
	zY2tuZHs6ZI779NkNNNt+7gIoZ4SxISqVJa8jL85IKVrMwJmESlQ9YSvCh5Nfiic
	/6vhoJgHVvQs5cFE2i9OKjvYpcrkva2tvDPJouuDdY2KB/14y1eN4Y4umBcekzOV
	wMEa50oWjzFQ+Yv734oNs6v5Yt8NhRu37+rNj+GvifWwlE6O6Fu2IDXhFYylSdnE
	g6sM/PdPjvB5KfY5H01N84PDNITsfEgjh71dHqAgdUIN8Mk1pAXSSxF4ARjVkM82
	rg4WQCV5L41AdIYFOZlQwhy+anj5BveLoxObXLXQO75GsYkUjZdSNZktba7nasVQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brg2gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 03:40:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61L0gq2h030208;
	Sat, 21 Feb 2026 03:40:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45jwxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Feb 2026 03:40:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61L3efEj31392294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Feb 2026 03:40:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38445804E;
	Sat, 21 Feb 2026 03:40:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418115803F;
	Sat, 21 Feb 2026 03:40:38 +0000 (GMT)
Received: from [9.61.251.42] (unknown [9.61.251.42])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Feb 2026 03:40:37 +0000 (GMT)
Message-ID: <b53acfaf-9f56-48f0-9e0d-d7af272c6683@linux.ibm.com>
Date: Sat, 21 Feb 2026 09:10:36 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] powerpc64/bpf: do not increment tailcall count
 when prog is NULL
Content-Language: en-GB
To: Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>, stable@vger.kernel.org
References: <20260220063933.196141-1-hbathini@linux.ibm.com>
 <20260220063933.196141-2-hbathini@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260220063933.196141-2-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d_G8T0EP50HMIWmbO1rg1NhBEuAzHD-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIxMDAzNiBTYWx0ZWRfX6Z07WmDh1H2U
 dSTJ8JNX441rqfArophoM/Lbmp2IDhGlXcfiyFLs0by4pdD546vg2B8I3JLWFjAVXtlAm+9hbFB
 lIEc0kSanyQUrjsvpUlrQMPzMPDF7rFju/p7huHCzGmIWpOrJBfAjKrnc3F7r2sTzlVUz24CPEv
 y9B1M8g8kUcsMOZ0dN4Rx963ArThB/a8JFu8+ghG6PZMJ1PksgvsiEy8jN+jG8dSzsaYOCpAnYF
 3bX88cYsH03oMbZAeX6ogsgdtrjMvk1CXFk263Cs0gvByN3uOmU/fds4wv9zpLOzKBu/iCeXj8P
 TiEHBaqQ9BwgARmbyD1giYVfWoqzLsqSmBQ6wWw+0rhm+SZG5/Do3yOOJ7aap10V4LoC7rqNAQE
 imDRXKJPCAZ/vmSk4q9Jqsgo420IyXFJi2d7X2EH7ydxZRzBinw5q15YXlGgTBMjuYuGEDsXT7b
 3nV1LOEdsvwC0ptPuYA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=6999293b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YpS5cAcgm0N0_-8T5d8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d_G8T0EP50HMIWmbO1rg1NhBEuAzHD-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-21_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602210036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217615-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 13C2616C0A3
X-Rspamd-Action: no action


On 20/02/26 12:09 pm, Hari Bathini wrote:
> Do not increment tailcall count, if tailcall did not succeed due to
> missing BPF program.
>
> Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> * No changes since v1.
>
>
>   arch/powerpc/net/bpf_jit_comp64.c | 39 +++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index b1a3945ccc9f..44ce8a8783f9 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -522,9 +522,30 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   
>   	/*
>   	 * tail_call_info++; <- Actual value of tcc here
> +	 * Writeback this updated value only if tailcall succeeds.
>   	 */
>   	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 1));
>   
> +	/* prog = array->ptrs[index]; */
> +	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_2), b2p_index, 8));
> +	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2), b2p_bpf_array));
> +	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
> +			offsetof(struct bpf_array, ptrs)));
> +
> +	/*
> +	 * if (prog == NULL)
> +	 *   goto out;
> +	 */
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), 0));
> +	PPC_BCC_SHORT(COND_EQ, out);
> +
> +	/* goto *(prog->bpf_func + prologue_size); */
> +	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
> +			offsetof(struct bpf_prog, bpf_func)));
> +	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
> +			  FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
> +	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_2)));
> +
>   	/*
>   	 * Before writing updated tail_call_info, distinguish if current frame
>   	 * is storing a reference to tail_call_info or actual tcc value in
> @@ -539,24 +560,6 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	/* Writeback updated value to tail_call_info */
>   	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
>   
> -	/* prog = array->ptrs[index]; */
> -	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
> -	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), b2p_bpf_array));
> -	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_array, ptrs)));
> -
> -	/*
> -	 * if (prog == NULL)
> -	 *   goto out;
> -	 */
> -	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), 0));
> -	PPC_BCC_SHORT(COND_EQ, out);
> -
> -	/* goto *(prog->bpf_func + prologue_size); */
> -	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_prog, bpf_func)));
> -	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
> -			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
> -	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
> -
>   	/* tear down stack, restore NVRs, ... */
>   	bpf_jit_emit_common_epilogue(image, ctx);
>   

Tested this by patch, Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



