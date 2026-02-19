Return-Path: <stable+bounces-217465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPnMN81Dl2kiwQIAu9opvQ
	(envelope-from <stable+bounces-217465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:09:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FF160F4B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC5F3034B3C
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF273326927;
	Thu, 19 Feb 2026 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dIAF9hgT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841EE2C11D7;
	Thu, 19 Feb 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520954; cv=none; b=ZqAIoUhJfx980K21yBnsWJ30jQGj+whv3R6WM9JhS5xxaCAMkxLuJP6hWUb9UY7CkQW/42L5b03Avxlxdzo6xn5IGyOT1DlsVdUrVWLPqkDjal9f01CqDB2LBq2yp2zQmXE39TxbRVXUimG6yZCLikdYXkujMyLw0fO7YjyQcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520954; c=relaxed/simple;
	bh=qaYkkAXQbYuosZiFLTR76Kohti5u4f3cgkvaWnfFKxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih2i2lf7UfaPaiYafGk5FrXUhE8ZojNhepZl/bLjNHIHE5xSOj8hfSxwN1jwWdTMDOg0pCswGHHRJvtNQUim2qOhjr//Q3xvXCZegrqWAUVLVMxPkA/IEh5mlTsMoXBNz7j8Omd6Q0PX/lTLm6plJOj/aIRaa/wwnE6pg32k5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dIAF9hgT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9A0ht1260396;
	Thu, 19 Feb 2026 17:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=Z0IkPgkO30KuSHPy4oc9lpsYFrBydsPKPI1SC5MDzYs=; b=dIAF9hgTvypz
	TGdCEFrXXvrn0vuQmB3hwhT67L6XSMpdQmULi6mKtat2KY1TejbWCeZFNpzdK6rb
	FJI7zvnnxb00TuuMiikvlIP1VW3qcrz+Is9rRBD6d8vXuTw410781HyCgauHgtLE
	spMa3eNDJkBZrSjTgoOxkl6udtu2MSmF6nuaZYKvdDi+sExjeKQ76CMKsSjWi+8U
	aI6QWhFTAw+VFMqaEpqdaXSUWwaRNK/e+pH0CZLnBuoa+OwPX9pSfh/dlkdKUq+6
	XX+GAvqlUlZg2NwlNcTd0kd1ccwt5q+aLjmrP2UQm5ffYXk6UoVe3PiHShWuExcW
	bQsfP8qe+w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s75yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 17:09:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JE8Ebw015697;
	Thu, 19 Feb 2026 17:09:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45d1sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 17:09:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JH95PE26673500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 17:09:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DAB2004D;
	Thu, 19 Feb 2026 17:09:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E63820040;
	Thu, 19 Feb 2026 17:09:05 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Feb 2026 17:09:05 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vt7WS-00000007Foi-3XR9;
	Thu, 19 Feb 2026 18:09:04 +0100
Date: Thu, 19 Feb 2026 18:09:04 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH v1 1/1] PCI/IOV: Add nested locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <20260219170904.GB25740@p1gen4-pw042f0m>
References: <20260214193235.262219-3-ionut.nechita@windriver.com>
 <20260214193235.262219-5-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260214193235.262219-5-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=699743b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=t7CeM3EgAAAA:8 a=RkMA2bByp6Z27F5s2eAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VGQ6FpoF8AQLE55TEPzPgeRZaPsT11vk
X-Proofpoint-ORIG-GUID: NF2tbP-c82MSKgCb06jWn1QybEFEkgOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE1NSBTYWx0ZWRfX0lJvnKPQz6DY
 YOX3blLJWF03MAVQ8mGmU82+9D1KlUjoPVV4fPctnxtYl6aIDUflMWHjm+M78B02/tmcFdjCKcg
 YmkoDEHtSLI4S3jwctyB9ga1RzUBEY0KUbDiy+mSErEPPK5pg9wgZrM8A2HEjz8W0exSzrjCPRo
 4Olanh9h/NOL1zMQfufvltIBb+gyeJliUinXQUpBfV/cFUAwqvwsQdhifS52O3NSI9uzWvstSCF
 6kDO3yUCzHU+edd7aVO6zS3CBP6CxX2W/BNkAjbrT0WOcRVcuSJdN5jOmoa02/K7ughXe+VFiRe
 WGI3bNIPDUzHL/GLf8cHTUnmtorrTX6ILnECW7YECzzQcuz190Cry4cSEjWvwCdZhjb2yCoCNfV
 3F7wvvIIkUIzLJtEliP9O2Usw0QtXSBAVwHYuOzB12N5BEGUcGvcoQuyh9INRXHdvFdHE5zkWBO
 mG54rodEY4AVaDLPddQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,linux.ibm.com,gmail.com,vger.kernel.org,yahoo.com];
	TAGGED_FROM(0.00)[bounces-217465-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D4FF160F4B
X-Rspamd-Action: no action

Hey Ionut,

Incidentally I'm also working on patches related to `pci_rescan_remove_lock`
on s390. Not the same issues that you tackle here, but I also found the
unprotected calls from driver unbinds; so that's nice :).

I've put your patch on top of what I have so far, and functionality wise it
looks pretty good from my POV. I've run it with lockdep enabled with my tests
for our architecture issues (this includes the hot-unplug events), plus the
driver unbind calls, and could not trigger any lockdep splats and/or actual
deadlocks.

On Sat, Feb 14, 2026 at 09:32:37PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4a659c34935e..38372ac0e2ad 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -629,19 +629,25 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
>  {
>  	unsigned int i;
>  	int rc;
> +	bool nested;
>  
>  	if (dev->no_vf_scan)
>  		return 0;
>  
> +	nested = !pci_lock_rescan_remove_nested();

You always call the function and negate the result (which makes sense), so I
was wondering, wouldn't it be easier to just return the result reversed
already?

>  	for (i = 0; i < num_vfs; i++) {
>  		rc = pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> +	if (!nested)
> +		pci_unlock_rescan_remove();

Hmm, you could have a sort of `pci_unlock_rescan_remove_nested()`, and pass
the return value of the `pci_lock_rescan_remove_nested()` call as argument
(probably as `const`); that way you wouldn't need to open-code this
everywhere, and I can't think of a situation where you'd want to call the
nested lock function, but don't check the result for the unlock.

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c8a0522e2e1f..7d3b705728fd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -367,6 +367,7 @@ static inline void pci_remove_legacy_files(struct pci_bus *bus) { }
>  /* Lock for read/write access to pci device and bus lists */
>  extern struct rw_semaphore pci_bus_sem;
>  extern struct mutex pci_slot_mutex;
> +bool pci_lock_rescan_remove_nested(void);

This is mostly a nitpick: I'm a bit surprised this isn't next to the other
declarations in `include/linux/pci.h`. Are the any reasons for this? To
restrict access/use?

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7711f579fa1d..5f38ed0c641a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3478,19 +3478,31 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static struct task_struct *pci_rescan_remove_owner;
>  
>  void pci_lock_rescan_remove(void)
>  {
>  	mutex_lock(&pci_rescan_remove_lock);
> +	pci_rescan_remove_owner = current;
>  }
>  EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
>  
>  void pci_unlock_rescan_remove(void)
>  {
> +	pci_rescan_remove_owner = NULL;
>  	mutex_unlock(&pci_rescan_remove_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
>  
> +bool pci_lock_rescan_remove_nested(void)

Again, mostly a nitpick: we already have "nested" mutex functions, but those
don't (somewhat surprising) relate to any reentrant property, but annotate
for lockdep. Might be better to avoid the term here, to prevent further
confusions for anyone already aware of those.

> +{
> +	if (pci_rescan_remove_owner == current)
> +		return false;
> +	pci_lock_rescan_remove();
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_nested);

In general, having reentrant locks might be an issue if the code under it
isn't aware of the possibility, but I'm not sure how we'd go about
proving/disproving this. It's hardly possible to review all the relevant
code, with how broad the protection of this particular lock spans.

And in the past the community seemed to be rather ambivalent to the concept.
Do you know other "prior art" for this in the kernel?

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

