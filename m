Return-Path: <stable+bounces-268539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XZVHH1gqPWpLyQgAu9opvQ
	(envelope-from <stable+bounces-268539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:17:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CD6C612C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=IYIcIpN9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268539-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268539-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4943037DF1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0178A2FFDCC;
	Thu, 25 Jun 2026 13:14:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD242877F7;
	Thu, 25 Jun 2026 13:14:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393273; cv=none; b=B1jUAL/GbhFb0Hj6JgCOIwurTARwC1p7jO8EDu6ypGPf8P/x8pcrKvQwPqGuRiBHbK13+vdySs4jPbpr5svISxyvnLDLgpiQIc2U/xg8Pqsmhk0opKeHJL5nIxZAoV5QsqNdRiM67nyweISMSAGeGZiZeFxKCRxK2cLmbdaCXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393273; c=relaxed/simple;
	bh=z4rFp7k0eeoEbdpaSlF+5UhT4MV9A6VxOAXFNW6coKw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXEWvxbjF2YooALfWDUSd9S2mJTSEFJ8heCP48LPLvASdWQTFATl8sKyiiOmVc6F8AZXW39O5NfzuGZeUPf0ZA02uWQBNV1OQ0INxGQmQaL3Ouy+SO32uC7ZAUzErE+ENrALDeQxBcEEtdf/M5mUhhK09xHxeAub31H4emAJG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IYIcIpN9; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mchZ2927284;
	Thu, 25 Jun 2026 13:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BLcpOz
	3tDfXejPRdrUmXpXZLUG8klxCosEZiH+JS9sk=; b=IYIcIpN9X968sRU/ZBrlQs
	Vq+IUwSo4u/cuX8VYOdY5qim0bupYBc7fUvZrclib9LRbzZv3WzS2nvsWbHlC/yM
	iE4UjtKi6uwx6V7u5WnzQiXZMbPP6ADDVwQ3KSod1A7X0Snes6Y5O28ypieMxasX
	Re+dZmPNwk4EsIi6Rwdymq3NQjv4xYpIQaLd2gf+w+kdd6FI50hkVLUvy5Sz5yQQ
	j0FiOurFOG5+Q1fs6ghTxWvkRHkvup7ltbSOeEdHatvhoGKMrTxMRWaYSk1qmoKG
	A+p/YvId8ASC6kJNuTuu+sCjUR4yFEbYtj4Yng5YaTh8sT5zsAVVnzsiq3Ot8DDA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9j1x21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:14:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PD4pcE004165;
	Thu, 25 Jun 2026 13:14:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vywywn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 13:14:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65PDE8CH50135484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 13:14:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E0862004D;
	Thu, 25 Jun 2026 13:14:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532232004B;
	Thu, 25 Jun 2026 13:14:06 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 25 Jun 2026 13:14:06 +0000 (GMT)
Date: Thu, 25 Jun 2026 18:44:09 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
Message-ID: <20260625184146.6de49c63-67-amachhiw@linux.ibm.com>
Mail-Followup-To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
 <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
 <20260616115521.79ad9699-39-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616115521.79ad9699-39-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kv6FQlySRDKFNYhOu6GEp5VeNkjjMeLK
X-Proofpoint-GUID: B9Yv9BDjsEAuMLcK1auWlmEp-F6Swf5O
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3d29a5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=9X2PJUVLfxp5_PpBzxQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfXzyZjCmX1Fzgo
 qHC+T7GcfyD0oOSJTMm7XWZUUZ/f+izui8jsLI6fOeYUADa/qkieT0imhOlMhyCPGeV9j1Gq6r2
 0Nmuz/qxIu2yOoeKuwpWPEJmGZlSjfyLs3ZryOe85ZCH6+tXkIfJbtdojNyvEN9d5oAhfSc4aTx
 nmapeeGDj6ouqr7g97UEhpYpcELd1V5tQhqq0Q4jeux86ILHxN5qZgDjW7tl/HnP4SAHeV+KzEJ
 T2BL8LrMtIOoe9XyYFKs6fODu9/RoL4nGNizq8wl8VC7cbLgYX8AMCt9t+KbjiUI3SYVlwr/TRL
 fP0+DGqWx7t54LRkhuzZmS2tr3ET/ltuBz34HpZFPxIC4j9En5gBdwCu7P4x91Yuo5q88aWRRdW
 NTshsNkW96clgZi+Wutm5H0Bg7BGNoULU56VqY0Lo3NUyKy+73MprRCkW4bGFkMFITkZ5hsOBn1
 9j8wR30gXx8pcyXde8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMCBTYWx0ZWRfX2Wg0K30Z/iWS
 tMbO4HJ/psgw1162EE+qOPC8fM5BONNYjE2ShYPxZbmvvOx7kszMW0YIsvn93ebhohC8Y5rwD2D
 QFq+2g8EfYtMTk/cQjW0uGrtHZMNZps=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lists.ozlabs.org,linux.ibm.com,gmail.com,ellerman.id.au,vger.kernel.org];
	FORGED_SENDER(0.00)[amachhiw@linux.ibm.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:vaibhav@linux.ibm.com,m:harshpb@linux.ibm.com,m:ritesh.list@gmail.com,m:anushree.mathur@linux.ibm.com,m:gautam@linux.ibm.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:riteshlist@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amachhiw@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F8CD6C612C

Hi Christophe,

<snip>

> > > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > > index 3af6c06af02f..e5853daa6a48 100644
> > > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > > @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
> > >   	if (isa >= ISA_V3_1) {
> > >   		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
> > >   		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> > > +
> > > +		/*
> > > +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> > > +		 * Power11 and later processors. While ISA v3.1 is supported
> > > +		 * by Power10+, this flag specifically indicates Power11+
> > > +		 * for code that needs to distinguish between P10 and P11.
> > > +		 */
> > > +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
> > 
> > Are we sure this test will always be correct ?
> > 
> > For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1
> > 
> > Wouldn't is be cleaner and safer to just do:
> > 
> > 	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11
> 
> You're absolutely right to point out the PVR ordering concern. But PA6T
> cannot actually reach this path because we're already gated by:
> 
>   if (isa >= ISA_V3_1)
> 
> and PA6T does not implement ISA v3.1.
> 
> My rationale for using `>= PVR_POWER11` is that `CPU_FTR_P11_PVR` is
> intended to be included for Power11 and later processors, not just
> Power11 itself, as it identifies a CPU feature. Using `== PVR_POWER11`
> would mean we'd need to revisit this code for every future generation.
> 
> This approach is consistent with existing kernel code. For example, in
> arch/powerpc/perf/hv-gpci.c:
> 
>   /* sysinfo interface files are only available for power10 and above platforms */
>   if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER10)
>       add_sysinfo_interface_files();
> 
> Also, I couldn't find any current users of `PVR_PA6T` or `PVR_BE` in the
> kernel tree, so there doesn't appear to be a present-day ISA v3.1+
> example where the comparison would misidentify a processor.
> 
> Please let me know your further thoughts on this.

Just checking in — did my previous response address your concern, or do
you have further comments?

Thanks,
Amit


