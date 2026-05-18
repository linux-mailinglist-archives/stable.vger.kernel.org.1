Return-Path: <stable+bounces-249206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCaPLFPACmq87QQAu9opvQ
	(envelope-from <stable+bounces-249206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910A5679B9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ADE43006157
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E571431F9B5;
	Mon, 18 May 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W20J4MJP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E43D0BE5;
	Mon, 18 May 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089173; cv=none; b=t6wrgaeWKk5REATxjJPKo426g9lNdMgK0KfOhfbkR2m7Eh2e0h7SEUgRtklbl6DaDQDa2beewgJNQeeAW12uxBhgmqt0XonVf6UXenMPfhZvEmXFyzKYt+hkC6jFGLwqJ478MOCAbnyaigaebTG7mFnrFQoqOIjth8wcsLlzo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089173; c=relaxed/simple;
	bh=ItILD+8MC/UCfiDqeGg6Vcn7s/U85Ya+y5BT7bVnPjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjhPYrmf3EFYmYJ6XP19iKePF2D7mGKOLHJ8TS7R4e+UrkEwPLpQNk7gO9m+5piE+ajM1MnPYHHGNqhvSLYpZ0y6X6+fVhEvkk3SVvxRpT5eAsKUSOAPWZjFFpixA1GZWrB2sguO1kbGEL1UmJmnSEfRLeOkYw5kbuXGXTWUUak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W20J4MJP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7HBUX3901160;
	Mon, 18 May 2026 07:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cb9nWJ
	uF3hQ3miUzMebgNN6Kj7RqYUCcNl6nTWfgSd0=; b=W20J4MJP+al4K0g9lt0N+o
	8Y4T0nr8BD/aG0V3GCwSjHdrdv449aFHU0NhIJ9FHBNeCEQpsVqfZH0WvIjw7BYV
	9GOZ7nweeMzHOePMe/v0zqSVdzeLWxfPTQMXI1mObyBFh41I7VEHopccmCDvP9NP
	mUIr4c+54w5eUeLK5nvogVEoowtFKm+iESo8G55q40dGbAT/Q4lzhHkHK6f/Fqrl
	ZKN7kFTr+7xBvNnC/K2JgEWfA40fRUjVOFp90D4akemCDFChBzyczFsQByFR1aCU
	7+hKB08j/daHXyIFGCAnqMXCjaALElxQGJprt2OG+gS6dNCXSQpavbbGXMBUt0iw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mess7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:25:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I7O4ri010865;
	Mon, 18 May 2026 07:25:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpvxku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:25:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I7Ppe244892500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 07:25:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1212420043;
	Mon, 18 May 2026 07:25:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C10220040;
	Mon, 18 May 2026 07:25:48 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 07:25:48 +0000 (GMT)
Message-ID: <e074658e-401f-4d12-8997-4007d86b9826@linux.ibm.com>
Date: Mon, 18 May 2026 12:55:47 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
 <20260517214043.12975-3-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260517214043.12975-3-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MF7cg5mXDx7I93ljsD12K5d6Cutk981Z
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0abf03 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=jJgxMy1UuW8321J8VzYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MF7cg5mXDx7I93ljsD12K5d6Cutk981Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2NyBTYWx0ZWRfX40xScc2nOQVE
 d5L/d1A0SmTd3+AVfStaX/sD/c4t0HUwUFo3M4LuYuAL7obV6nQAHNUB4vJ0C07x1GVs+fEN4kJ
 GdpvEAyte2k5lbR3PtH4QS6EtqEfzBjRatJTwSDAG+shF2qPuIUnOMGls7itPjBwjHj8SZy7qDL
 NeFovnGAEFXEtZUcZjtRkJe5JP6LZD0Vcua8Pe+eyl+a7J3Gabn6KJNSkEWzOQ+7r3/GXjpMv3d
 0WRcLVzUlODBBi4JvEnHpDPdPFhRo6jFmMLn+DYyVTPNpzJlrxDfF7QwmZa6WTro3XrIzNOEiCs
 RQKo4U4GhSWxA1lsNMBgh2vIxoBG27tpGzOOyzPnflSIo/YS+O2iT15RFWTvbtI+uHlYyDVZg15
 A2IVJrD5+BhgaNbCFm9rXvg2u4cgglY2H0rUS8BfsVS38AHbsuTIlLgGLWhGHBMMXfuD0nbWB+C
 IW4q8pVamAqsIR7ZJRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180067
X-Rspamd-Queue-Id: 0910A5679B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_FROM(0.00)[bounces-249206-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[hbathini@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 18/05/26 3:10 am, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Move the long branch address space to the bottom of the long
> branch stub. This allows uninterrupted disassembly until the
> last 8 bytes. Exclude these last bytes from the overall
> program length to prevent failure in assembly generation.
> Also, align dummy_tramp_addr field with 8-byte boundary.
> 
> Following is disassembler output for test program with moved down
> dummy_tramp_addr field:
> .....
> .....
> pc:68    left:44     a6 03 08 7c  :  mtlr 0
> pc:72    left:40     bc ff ff 4b  :  b .-68
> pc:76    left:36     a6 02 68 7d  :  mflr 11
> pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
> pc:84    left:28     a6 02 88 7d  :  mflr 12
> pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
> pc:92    left:20     a6 03 89 7d  :  mtctr 12
> pc:96    left:16     a6 03 68 7d  :  mtlr 11
> pc:100   left:12     20 04 80 4e  :  bctr
> pc:104   left:8      c0 34 1d 00  :
> 
> Failure log:
> Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
> Disassembly logic can truncate at 104, ignoring last 8 bytes.
> 
> Update the dummy_tramp_addr field offset calculation from the end
> of the program to reflect its new location, for bpf_arch_text_poke()
> to update the actual trampoline's address in this field.
> 
> All BPF trampoline selftests continue to pass with this patch applied.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index ef7614177cb1..b73bc9295c31 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -57,19 +57,21 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
>   	 * In the final pass, align the mis-aligned dummy_tramp_addr field
>   	 * in the fimage. The alignment NOP must appear before OOL stub,
>   	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
> +	 *
> +	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
>   	 */
>   #ifdef CONFIG_PPC64
>   	if (fimage && image) {
>   		/*
>   		 * pc points to first instruction of OOL stub,
> -		 * dummy_tramp_addr is past 4/3 instructions depending on
> +		 * dummy_tramp_addr is past 11/10 instructions depending on
>   		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
>   		 *
>   		 * The decision to emit alignment NOP must depend on the alignment
>   		 * of dummy_tramp_addr field.
>   		 */
>   		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);

> -		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
> +		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;

To get the address, should multiply the instruction count with 4..

     pc += (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10) * 4;

Also, pc may not be appropriate name here. We are essentially
calculating the pointer address of dummy_tramp_addr. `addrp` maybe?

- Hari

