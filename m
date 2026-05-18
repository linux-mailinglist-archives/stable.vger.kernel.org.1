Return-Path: <stable+bounces-249214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIZnEMPFCmqa7wQAu9opvQ
	(envelope-from <stable+bounces-249214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:54:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36005682DF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3DF13007BB7
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2233E0250;
	Mon, 18 May 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fa1MnSnA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A83D47DC;
	Mon, 18 May 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090815; cv=none; b=KhqvJSw/vGrve29xyvmm4fMl7HeCHoDHi3deOfgQlAYUIdtWKtXtWQ3cpVgeEy1021FCmSJvkCwsF0oQ4BF/PV76fkoXX6C1De2BhV/G3BbjT5pBJYFzYmNGuYFzAEhLL29ZTXrtoVyKKb7EE0F3rOyQKUFQDMYzt/x2AnfXsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090815; c=relaxed/simple;
	bh=Gneunzj9DCjpkeTuQarMHV9K1OomFkjJKTZtojfYiYE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MwL8sXuDOzRcT+NTH6bk7O7rnmwx/qTOeE1s7mfLnkIHaO/x7tGSbVXYZXzn4Xfa3aIYm6f8lJYVXR0SFoZ1Oph1fGF8hTvHBxEE7bAv25hh5dtm7r3EoB7hNYJ69UlBuXL9C/YO9raNrHXPweS5pvklkxTL9jTwXao7dTW/YeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fa1MnSnA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLeg1E1409980;
	Mon, 18 May 2026 07:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oOAsXA
	ytSQAgmxOv/NeD2RAa3hTI0NZumiDSDgpMwgE=; b=Fa1MnSnAlbHAnH6j/X4CWO
	ykG9AXfzjPI9nvZ77JwvVKc+08p6WN0qkoeI7KoNCAWL2V0iaEtORwNzHfMfScWS
	R0gWG8mDmV6Ic66G8jesW44GrfVblZCdqStYgBQva7apexZ7Jzuc8hAPQhgWwuqP
	xlosGsk3n1tpbIblyL8dR2DI7Nr9f4ZG0S23RbAOqyzR2APneifOO+UMTda9AJpv
	+1FPuEas0GkkGpRzVQPbQf+JxiUCtNmZbOMTmx+iNGFzIU4e5/SODDbb0liZ8dMk
	SJDMHHqD1xERNI7xyhkLlqPIXLIjpeOnnN6LMpI8/KlAL9jPbeFd4oV45UT08PDA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xpx9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:53:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I7d6kF021481;
	Mon, 18 May 2026 07:53:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vmy4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 07:53:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I7r9lG42795364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 07:53:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6AD720043;
	Mon, 18 May 2026 07:53:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 882F72004B;
	Mon, 18 May 2026 07:53:07 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 07:53:07 +0000 (GMT)
Message-ID: <e9a263a7-0f90-4393-b407-0c3a771d3780@linux.ibm.com>
Date: Mon, 18 May 2026 13:23:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long
 branch stub
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260517214043.12975-1-adubey@linux.ibm.com>
 <20260517214043.12975-3-adubey@linux.ibm.com>
 <e074658e-401f-4d12-8997-4007d86b9826@linux.ibm.com>
In-Reply-To: <e074658e-401f-4d12-8997-4007d86b9826@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA2NyBTYWx0ZWRfXykjks/YEhS5D
 cqJYGQodr4wrTAclW+vVBcLiN39k0bFFKlebpa31AM+ddPlJQdUkEEgOVKyAASbCSXWDt1lGlBz
 pXFUZsKPL8JWBhf5SWvaLi7b6SYmaTePk0bElVUMBUMx7JziNwt0BdlFilso9ciiidW6TILeXEn
 AoTRwrq2AW7KOeeqiQbmPhm+xCuVzHm56qjtPXNnBFhdJKrIc3dLXyf7YzuD6GD17PbRVSBos2g
 h6lw3edrsvu2PJzDjULrWu7YAe0x7T9yhw0JaeliuDpKEx9dfea5vT6aXIhDduIvYxdKOmU5fFF
 yg0FISEAe3UYfqnKf5bpB1znjthNEW1Jcp5q25YWBa5nvOZCzk4ar/1BiVmny0KF6bzX3Zcohxr
 l604DuftyU/V6+1y6tEgb+BHioy1E8XEMJpAc/jl6ZHFEGS49h6mLSax+GD02ltI7eexc/WMz/v
 h8MpH68WL7ALZm8yCsw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ac56a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PIyfoD_1ohwjx45KiRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: E4NaMlrcjvD3dE8O6znwFtvl7-BB6LuG
X-Proofpoint-GUID: E4NaMlrcjvD3dE8O6znwFtvl7-BB6LuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180067
X-Rspamd-Queue-Id: D36005682DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-249214-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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



On 18/05/26 12:55 pm, Hari Bathini wrote:
> 
> 
> On 18/05/26 3:10 am, adubey@linux.ibm.com wrote:
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>>
>> Move the long branch address space to the bottom of the long
>> branch stub. This allows uninterrupted disassembly until the
>> last 8 bytes. Exclude these last bytes from the overall
>> program length to prevent failure in assembly generation.
>> Also, align dummy_tramp_addr field with 8-byte boundary.
>>
>> Following is disassembler output for test program with moved down
>> dummy_tramp_addr field:
>> .....
>> .....
>> pc:68    left:44     a6 03 08 7c  :  mtlr 0
>> pc:72    left:40     bc ff ff 4b  :  b .-68
>> pc:76    left:36     a6 02 68 7d  :  mflr 11
>> pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
>> pc:84    left:28     a6 02 88 7d  :  mflr 12
>> pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
>> pc:92    left:20     a6 03 89 7d  :  mtctr 12
>> pc:96    left:16     a6 03 68 7d  :  mtlr 11
>> pc:100   left:12     20 04 80 4e  :  bctr
>> pc:104   left:8      c0 34 1d 00  :
>>
>> Failure log:
>> Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
>> Disassembly logic can truncate at 104, ignoring last 8 bytes.
>>
>> Update the dummy_tramp_addr field offset calculation from the end
>> of the program to reflect its new location, for bpf_arch_text_poke()
>> to update the actual trampoline's address in this field.
>>
>> All BPF trampoline selftests continue to pass with this patch applied.
>>
>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>> ---
>>   arch/powerpc/net/bpf_jit_comp.c | 34 +++++++++++++++++++--------------
>>   1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/ 
>> bpf_jit_comp.c
>> index ef7614177cb1..b73bc9295c31 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -57,19 +57,21 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 
>> *fimage, struct codegen_context
>>        * In the final pass, align the mis-aligned dummy_tramp_addr field
>>        * in the fimage. The alignment NOP must appear before OOL stub,
>>        * to make ool_stub_idx & long_branch_stub_idx constant from end.
>> +     *
>> +     * The dummy_tramp_addr field is placed at bottom of Long branch 
>> stub.
>>        */
>>   #ifdef CONFIG_PPC64
>>       if (fimage && image) {
>>           /*
>>            * pc points to first instruction of OOL stub,
>> -         * dummy_tramp_addr is past 4/3 instructions depending on
>> +         * dummy_tramp_addr is past 11/10 instructions depending on
>>            * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
>>            *
>>            * The decision to emit alignment NOP must depend on the 
>> alignment
>>            * of dummy_tramp_addr field.
>>            */
>>           unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
> 
>> -        pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
>> +        pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;
> 
> To get the address, should multiply the instruction count with 4..
> 
>      pc += (IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10) * 4;
> 
> Also, pc may not be appropriate name here. We are essentially
> calculating the pointer address of dummy_tramp_addr. `addrp` maybe?

Something like this:

+		u32 *addrp = fimage + ctx->idx;
+
+		addrp += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
+		if (!IS_ALIGNED((unsigned long)addrp, 8))
+			EMIT(PPC_RAW_NOP());

- Hari

