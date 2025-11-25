Return-Path: <stable+bounces-196884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F2C8487C
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 571BA34DAEB
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA092E265A;
	Tue, 25 Nov 2025 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eve7g18+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD5D271
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067325; cv=none; b=AIRQZZWUMgt5E+Ii92W+vkwVGjLT63lgbE9h1qlDjMxgyQz+FYHhQjFyXTvjfH28AKxoFuSahE7oPnWrBJNJzPf6huKdbVSaisV6VuygATOYJrx5h2vgqNfPt+9gCZYWcJ4ijkW1QKqa9dF8G9qGxURcvimO6y4kwA6YuVptuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067325; c=relaxed/simple;
	bh=6Nydaetgb9U+tMxAvPw0lf0b8N3OD98FyZy2NZ2uJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjb2gbTluuqyb87HXb7hak2PbW8dFnerBqm9oJriNuwSpWnBOuFQQxdCrB+/4I2f2ASxaOjUkpS5ec9vhYOLwIEMEG8JQkBakHGajhJdYjSXsTCLtsta1ZyEUpvNgUIEOJfm8eM+Ml59DKZeMj8ahgKAbIzOtO1inxTRJ/nGMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eve7g18+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP3FYmw005955;
	Tue, 25 Nov 2025 10:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1tiKEbSp/YYbYaLDV7P35JMwtzcsyl
	Czaj1O67Xz3s4=; b=Eve7g18+ej2l5mk76Q2ilp4pkqC+QOHybUCedcj5sWizbs
	rHjN3Nkw3b25fLOSiz7JFLyrF2mpMynZPKly1x4SPkyMZmTufSP4oe/31JPkbuC9
	9tnBZLhkDKGVRMafsUobADCHTU1/xP2cOAbDsTtbV0QLfxl0L21EnogAJrGVSPY3
	OXjgpJLj5E9QGt6iqpJSXTbpgvsAmNM2XXIjNNl60JWdI/2wVP8IhMUZsNQthfT8
	Qg4pux09dRVZ//9IUmWwLQ8FpD0vJsqtbKRkoKV9q+v6NIgdKxTFGdTxwcnXw4/P
	NbZXJixsb0iUg96IfiZ9lfhe7WAT9H4MR2DlMb/g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4w9csp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 10:41:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP93VHO000882;
	Tue, 25 Nov 2025 10:41:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvxu922-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 10:41:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APAfoOL31326702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:41:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF7BA20049;
	Tue, 25 Nov 2025 10:41:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAC0120040;
	Tue, 25 Nov 2025 10:41:49 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Nov 2025 10:41:49 +0000 (GMT)
Date: Tue, 25 Nov 2025 11:41:48 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 6.12.y 3/3] s390/mm: Fix __ptep_rdp() inline assembly
Message-ID: <20251125104148.10410E98-hca@linux.ibm.com>
References: <2025112418-impish-remix-d936@gregkh>
 <20251124171719.4158053-1-sashal@kernel.org>
 <20251124171719.4158053-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124171719.4158053-3-sashal@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX6aaJ525ci6Bk
 +sv8PkEN8MaaoyiHwJ+hNEN4LL3GBWM7FhicklGlXy9gHafztUPr6oPZtNuvvoA0eIaTlHdhRWC
 hAldjRpZoQApnFJBPwG1Nii5Ys7oeDsSeBPXJQZUaAV59gQrRBt4U8ccTWir6p/Hklplsw6Dvpt
 UdABF0zJymxmZWCpxLd9ViKSpSwpxRl5046USNeuISRn6+BH6887WAyGcd0AZYkZnAm+1phks5L
 P0mIjY9aGRYPUXiBQ6iHzi7u40lOAT7rEOZOVMx41tpRvAEisukSyqlge1YQxSI/7GcsUEDXkOQ
 tH9BDDry9Bw5aK+1sxtOxGlNeD1aEd/BE/FMR0Mfw3NZ/mrggpAxeaG1tu4ZDDduidmDdV5iEKV
 PumlKCON4FJN0xaBAq7f0jOnEqGoZg==
X-Proofpoint-ORIG-GUID: kOU2dQlJvFhlfYl55filu2w4WfENazUo
X-Proofpoint-GUID: kOU2dQlJvFhlfYl55filu2w4WfENazUo
X-Authority-Analysis: v=2.4 cv=TMJIilla c=1 sm=1 tr=0 ts=692587f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=IovQu9Nc8JwbWXVCFKAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 clxscore=1011
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220021

On Mon, Nov 24, 2025 at 12:17:19PM -0500, Sasha Levin wrote:
> From: Heiko Carstens <hca@linux.ibm.com>
> 
> [ Upstream commit 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c ]
> 
> When a zero ASCE is passed to the __ptep_rdp() inline assembly, the
> generated instruction should have the R3 field of the instruction set to
> zero. However the inline assembly is written incorrectly: for such cases a
> zero is loaded into a register allocated by the compiler and this register
> is then used by the instruction.
> 
> This means that selected TLB entries may not be flushed since the specified
> ASCE does not match the one which was used when the selected TLB entries
> were created.
> 
> Fix this by removing the asce and opt parameters of __ptep_rdp(), since
> all callers always pass zero, and use a hard-coded register zero for
> the R3 field.
> 
> Fixes: 0807b856521f ("s390/mm: add support for RDP (Reset DAT-Protection)")
> Cc: stable@vger.kernel.org
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/s390/include/asm/pgtable.h | 12 +++++-------
>  arch/s390/mm/pgtable.c          |  4 ++--
>  2 files changed, 7 insertions(+), 9 deletions(-)

...

> @@ -1304,7 +1302,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
>  	 * A local RDP can be used to do the flush.
>  	 */
>  	if (cpu_has_rdp() && !(pte_val(*ptep) & _PAGE_PROTECT))
> -		__ptep_rdp(address, ptep, 0, 0, 1);
> +		__ptep_rdp(address, ptep, 1);
>  }

I don't think it makes too much sense to backport only two of the many
cpu_has_xxx() conversion patches just to avoid the minimal difference
in context for this patch. From my point of view this puts the stable
branch into an inconsistent state wrt s390 and cpu features - old and
new interfaces are mixed.

I will provide a different stable backport patch which addresses only
the context diff. Then you can decide.

