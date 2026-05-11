Return-Path: <stable+bounces-245093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICeqBP4+AWofSwEAu9opvQ
	(envelope-from <stable+bounces-245093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 04:29:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8F50732C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 04:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312A6300765D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 02:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE95221721;
	Mon, 11 May 2026 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rkv3D+yo"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A471FF1B5
	for <stable@vger.kernel.org>; Mon, 11 May 2026 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778466554; cv=none; b=C9vfIxSxECyq/rk5dk6tnL+QS1FmIM0uZzuy7bK1uwxmAqYqmb+nZ26cyCMB8Mh2/O6pRJIAXXfnNHItU3UeARyRvoft9nfkE8CnB9yQ1AMl8ou4lsl5UbiKz6ePZxZ05kh8ywjm39mJ38uEOiQp10nYzYvNbAlYjui/ZXadWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778466554; c=relaxed/simple;
	bh=pVRzuNK+DHmjL7Fmf1F7jJlaS6uao+7uhL4g0za3tQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9q0kkLgKJqB5Ugv87gxB1x9PevSb4J2O6bZqGHLZfohnzLl3opxMq1+kahaezsjR7ClWANAYeI4PuEl0dvrM/zGgGfQzWTkfCP0a/eAZ10dE+9rDIOnsnrSow4x96O0glHtkIOcu0X57rcZ5VsrAOBEjZx6+1VGdsxI3I1NVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rkv3D+yo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMkGXZ4017310;
	Mon, 11 May 2026 02:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BMoW0t
	rsqlT3iuBrpha7XA3r2rO9+gAYqfZT/Dna5o0=; b=Rkv3D+yovj2JFUr5SivrIj
	rdklm7tCeqA4OPlnlcnPdP4JZsseNgSWfsjyj/G+1ogARXTRimeyJPh3k4CH4GVS
	wO3lR6OCJLApemqnlY5JCJdGoxFRVzXmhILVZwk26dUzinFghqiQzHiyVoJZxXeI
	ko1hEvwTrg0SiMrdl/nPo1qyeddB0gkgqCdkFrlpLd7yO0prBW7cr2GE1kDMj6EZ
	7sEcoYy1dPrmMiNp+m2BTniK8zpn/2624B2vIj9GIyJfl6D7ED3p3rc4LR9QYfVr
	XnjeQr1Mh26pxu9pBi+AcBS2llXigCeyE4fNj7DrDdNNkuyquJMgmEZLx0NceN+A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqp7k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OU7G012693;
	Mon, 11 May 2026 02:29:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q3h7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2SxwN47907078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DB12004B;
	Mon, 11 May 2026 02:28:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EB7020040;
	Mon, 11 May 2026 02:28:56 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay <shivangu@linux.ibm.com>, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Mon, 11 May 2026 07:58:55 +0530
Message-ID: <177846637462.1289230.1137772952219441646.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
References: <20260407124349.1698552-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX2rFs4NThIIEK
 YoQvcWMMR2atJChjS9IvG/EDzWhpdBmm8gVARXVr1/Hk5JM9/jTr72d/BLInCgP56/VS7MMPc2X
 nwqrAfMIdcZu7GamnLqcmPtogvGgMEEqcC84yAAK9xEQrasOW+6tp+pnFfLFro2w0PBpr4FyEgW
 /NSfmPwmVhqFZXYrJivUkCzy0IKpvSQQXDtNxukE4ZqHYYeyghbzUqP1y1mxvyjn4sIB5hhq3mq
 ugg5LCQvRyxFTIAd6mxQLT1zpaty2OciYf/Fu1mZnLmJvRpIBRR6An5b5Vxsi63uB4j9O8I/eQ/
 SrkIh7QqgO0DVA+es1MMJGKpB3xe0ZNzG5hHRtcWYrDDtrjkLkn2QtJy4/zfvjHQq/YO4OWTn17
 VBpnt2my8mxEvYu0a5cDrQOhggLuwiLTIKZb8PZAGkeEhajQbT0DUAY0hSJceIGiH0AUOQK+HIk
 or7maxSbhwStoF2ellQ==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a013ef0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=AHMFlFXem74IdTo9uU4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1fTGHYbQ929IC6wLyLTjU6hW9PiYp2BV
X-Proofpoint-GUID: NPb261swPiS6b5L1HXFJT0VDkJ6DihND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110022
X-Rspamd-Queue-Id: 95E8F50732C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_HAS_CURRENCY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux.ibm.com,axtens.net,ellerman.id.au,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245093-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maddy@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 07 Apr 2026 18:13:44 +0530, Sourabh Jain wrote:
> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
> 
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
      https://git.kernel.org/powerpc/c/b3a97f9484080c6e71db9e803e3cc1bb372a9bc7
[2/2] powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec
      https://git.kernel.org/powerpc/c/38e989d504fc52900a3786b7144fb53cd67e0389

cheers

