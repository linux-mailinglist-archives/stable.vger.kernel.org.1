Return-Path: <stable+bounces-249133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG0cCSP/CWqqvwQAu9opvQ
	(envelope-from <stable+bounces-249133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C7562C2B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B65D93006B14
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316E3CB8E5;
	Sun, 17 May 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QkuFGwr1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623A2459E5;
	Sun, 17 May 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039976; cv=none; b=uTeofYoSn/46NB3pcv1iIvlG88I1srktbW5QvrSQSDR02OKdFebtaiTk8R1xN7rx/iou3yIu1eN3g1nvpE2I2/yJkIj423mvEmkLSoYiKNLcMF63V5V2hnvm8ZeTWpyh4+KbyeJowyAtarSgc+Y6LtbkEnLngce0ySnMRAuEzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039976; c=relaxed/simple;
	bh=LSrZIjSMC9bdEkQlWcQGlIFkZF2tAKMPlGMluXJUtU8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=J3sl8TuAAhcojJ2bNOvaDmyAH8oAvVtaF3UpqGVxuMdg7ake/YgmVB0HBSJ8McKb/foIO56wZ4CWQkOq/bK+qJSnSpSKMMtTBj3QuaM6DdkFtFp/WQzpja0OclwDopgI1Qs9dO1eLeLja++tG2kIR6rcqbb2r5Ga8d44iydwiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QkuFGwr1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HCfTjM4141466;
	Sun, 17 May 2026 17:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sSwTRB
	GQO/SP4XfT8sDGOUbmXuHvETtJn9laC+LQKyk=; b=QkuFGwr1kHXctGbVdGKk4k
	XAdicNRjrvyeb1b8lzU+XPLEJbGmTpxoUfRV0l9w6uCpr1um5XKUYAb8zH8da+Ef
	aMUM3sqcfMqjujUKJXRyx/OtH0bQ0PMjt5dg5nJyaeoiQxUd+4eQj8scY8o1Yeox
	BtScFK25WipK4cgu8nilEbLWBlL2swkId4c/oaMTdlZmoNSI+p9k0h2/8cTLNR2W
	aGi7TLVCxKJkQPTlLE0camLuvTgmrscLD/LDAdOuhs0u7sU7nRU92UAcHOrLn8Jh
	hFq5OTWCjYDZuPHLnbwKp3JoEj9znMM3X40GthYT/tT5r8D5X/TAo+G7FCIVFwsw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havvbny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:45:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHd77X002229;
	Sun, 17 May 2026 17:45:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754g28p4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:45:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHjoKm30605984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:45:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 523CD5804E;
	Sun, 17 May 2026 17:45:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C5975803F;
	Sun, 17 May 2026 17:45:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:45:49 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 May 2026 23:15:49 +0530
From: adubey <adubey@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] powerpc/bpf: fix alignment of long branch
 trampoline address
In-Reply-To: <7d3bbb94-575f-4119-9ef0-62cff98795ce@linux.ibm.com>
References: <20260411221413.44304-1-adubey@linux.ibm.com>
 <20260411221413.44304-2-adubey@linux.ibm.com>
 <7d3bbb94-575f-4119-9ef0-62cff98795ce@linux.ibm.com>
Message-ID: <273c38d74bafbdf8ad4e22d0df94e6ac@linux.ibm.com>
X-Sender: adubey@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX/D/17EsNSKnN
 Vj9JkarDQ8JEjSVaBTL1xcfCmFbd+hZhYoj7l2ldCZlQMeCY55bsGxPVQLH2w3+Wa8/KR8i7hNz
 hyWhk/D+6bhsJW23wuuMVzjmlcU8HVd/vJeilGOb9IiNGG0ihNFBvjapNpu7nn0wKju+tfWTjsz
 +23fjwF5FYStcOSRqu+QxRtSnTcsnQqNpYny3vt+93YaL07TKFqHmbClEbhGLl0n1ht/F0ejUcF
 U4Cb8lls1XAGhxnHBD7BG56uDSkCBDmxbXbi3F71LX6oiW8ScX7KBywW0ctEPlmHm7h6zDlznCp
 lbkaDSJKfus4TFm5BSJ/vc4UR8GqxyYJAFBSdlgtHVL++azD1Jfg5h4G+Lg4gqmx6L7GKMXHzto
 MxGEMsSkYTTrgU3Q4BLaQ7KnUyDLoVOcF1OWvJPp+9GpvFQLsldgUwfz4goqxU1ZnkKaJJgUIzc
 5R/HOTDiRBVmQ8fdSUQ==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a09fed0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=I4iyMijFOUpp9DcVwYYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FPkm5COqXv7hbfoCe4W3pq1iNDUPrnqq
X-Proofpoint-GUID: FPkm5COqXv7hbfoCe4W3pq1iNDUPrnqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190
X-Rspamd-Queue-Id: A74C7562C2B
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249133-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adubey@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On 2026-04-28 20:59, Hari Bathini wrote:
> On 12/04/26 3:44 am, adubey@linux.ibm.com wrote:
>> From: Abhishek Dubey <adubey@linux.ibm.com>
>> 
>> Ensure the dummy trampoline address field present between the OOL stub
>> and the long branch stub is 8-byte aligned, for memory compatibility
>> when content loaded to a register.
>> 
>> Reported-by: Hari Bathini <hbathini@linux.ibm.com>
>> Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
>> ---
>>   arch/powerpc/net/bpf_jit.h        |  4 ++--
>>   arch/powerpc/net/bpf_jit_comp.c   | 34 
>> ++++++++++++++++++++++++++-----
>>   arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
>>   3 files changed, 33 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
>> index 7354e1d72f79..1184ad15d5a4 100644
>> --- a/arch/powerpc/net/bpf_jit.h
>> +++ b/arch/powerpc/net/bpf_jit.h
>> @@ -208,8 +208,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 
>> *fimage, struct codegen_context *
>>   int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, 
>> struct codegen_context *ctx,
>>   		       u32 *addrs, int pass, bool extra_pass);
>>   void bpf_jit_build_prologue(u32 *image, struct codegen_context 
>> *ctx);
>> -void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
>> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context 
>> *ctx);
>> +void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct 
>> codegen_context *ctx);
>> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
>> codegen_context *ctx);
>>   void bpf_jit_realloc_regs(struct codegen_context *ctx);
>>   int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, 
>> int tmp_reg, long exit_addr);
>>   diff --git a/arch/powerpc/net/bpf_jit_comp.c 
>> b/arch/powerpc/net/bpf_jit_comp.c
>> index a62a9a92b7b5..c255b30a37b0 100644
>> --- a/arch/powerpc/net/bpf_jit_comp.c
>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>> @@ -49,11 +49,34 @@ asm (
>>   "	.popsection				;"
>>   );
>>   -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context 
>> *ctx)
>> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
>> codegen_context *ctx)
>>   {
>>   	int ool_stub_idx, long_branch_stub_idx;
>>     	/*
>> +	 * In the final pass, align the mis-aligned dummy_tramp_addr field
>> +	 * in the fimage. The alignment NOP must appear before OOL stub,
>> +	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
>> +	 *
>> +	 * Need alignment NOP in following conditions:
>> +	 *
> 
> I don't think I follow this table..
I have omitted this table. The new logic emits alignment NOP wrt 
misalignment detected
for dummy_tramp_addr field.
Please follow the changes at 
https://lore.kernel.org/bpf/20260517214043.12975-2-adubey@linux.ibm.com
> 
>> +	 * OOL stub aligned	CONFIG_PPC_FTRACE_OUT_OF_LINE	Alignment NOP
>> +	 *      Y                               Y                     N
> 
>> +	 *      Y                               N                     Y
> 
> Please help me understand why a NOP is needed here
> 
>> +	 *      N                               Y                     Y
> 
>> +	 *      N                               N                     N
> 
> and also, why a NOP isn't needed here..
> 
> - Hari
-Abhishek

