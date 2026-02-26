Return-Path: <stable+bounces-219810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K9sExFPoGmIiAQAu9opvQ
	(envelope-from <stable+bounces-219810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:48:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F731A6EDC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F1831A07A7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383EE36BCCF;
	Thu, 26 Feb 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jcb9LgjN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8B363C6B;
	Thu, 26 Feb 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113264; cv=none; b=G3VGng9Pjfi0hdbwjJgUrOsLvH6l6Z9nab7NSRfHKz3y1SF+kBwi3EvlFFxh1ig0ABGqQDomRSukDtxbLuumxsXFQS+fIZOj0Uqk72+8tCadTLEMY2zYb4wnQMOfkCMfIAvoiffyls2Fd/V+aOuSxlGch2+hnzWjFiZtR8PaxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113264; c=relaxed/simple;
	bh=Cd4dpBLUHEkDK0iuCRBFU+xopfpY+DpvYGCUImgDuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk0D1LMol2DMBhiLQtPbTg9ZY5zVMiYKFlvm8QuUioB5AP+TQC4cQBfCxlsmCTC0XwHtA3Oj77Pju6i7Z66OQzkdSoAkMVIaYDalKhD7+JZAb/Nb8PieAJnl1fXkCR7+LgDQxQ6UouZO3WIlFaYhMAwz6DikzDbqPjbycZtrn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jcb9LgjN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q99f0k2839736;
	Thu, 26 Feb 2026 13:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=uMssfxhPFSn/6vIySmtb07vru5Ln5O2CT/2uar6TikI=; b=jcb9LgjNBXfm
	gmB0RiZ9M7lUG0G/EHKTtZYmZLM2oslFGR9wrTdi6D6sqUywGZ7KPsE9aKMER7E7
	iJ6BoSjJY1TDCaiQyKHyZFZbUsbloRsFbDiGbEb4r45SmXeAXKjcSJYhgdlFng3j
	6Q2/0rMVRJd/sMj4+pq2+tiBmM5XDTX0TWWCggmmApdRAaOmyIJHyCuLOK0uN426
	FYQDDmaRRvq4zsL4zJL7kVTrus2nA9d8LktJER2C882/Q0vNOUYYcztVe9dp96Wm
	kfry53xPD/WDmKZ6QVdUHkzLwfxKNFbrR/8xYdNXhAOlnVYwvjjkU0utezYB/KaC
	0u8aHVERHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs5smg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 13:40:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QBFsu4027797;
	Thu, 26 Feb 2026 13:40:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr23eu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 13:40:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QDerQ048955798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 13:40:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEEB520049;
	Thu, 26 Feb 2026 13:40:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD25B20040;
	Thu, 26 Feb 2026 13:40:52 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Feb 2026 13:40:52 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vvbbo-00000001FWX-2Zix;
	Thu, 26 Feb 2026 14:40:52 +0100
Date: Thu, 26 Feb 2026 14:40:52 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: ionut.nechita@windriver.com
Cc: bhelgaas@google.com, helgaas@kernel.org, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, julianr@linux.ibm.com, dtatulea@nvidia.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <20260226134052.GA13050@p1gen4-pw042f0m>
References: <20260225202434.18737-1-ionut.nechita@windriver.com>
 <20260225202434.18737-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225202434.18737-2-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DvPWJn3ZgTygi4SYrUIl9MfbtT4yi3fi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyMyBTYWx0ZWRfX5QXDFr9MaSr3
 LpuVYBOV/PgMhZwsw+LMUcltH48RrFTe0dH2bXTp45ncuWiTvYa000XvKCvIDpArzOAk8U8Hzrz
 ibpqDhkExZa7VBsKpFqQH6q23WiNRKelAXwyABGZ6xI2xwrJQk0Kpy5RL5M9E25y26QVuY8Yj6b
 lQFLBdwIfvoyAU5+7+BI7Dqa+646ugU+vZy3IM/446YO2RCkvMULE2lwOuj1uYRSNHPA5Q202/O
 kt2y8smdxkMswijlvnfX9Zsa1MAL11rjGsZPCcVhxFkXo6z2Hc6aFwriaZcJsB/MbvqgeFPtNVT
 5sZrQYnM1yiKz9gepUkIVURntTR5t61Ejh6kCZLQKyzNXjqQRQWmAUZQd8CFHcOt9H+4nuA6jaS
 ZhDBKOOqqNQe1vqDscyJ7wgcj76cO7DVdd0VTEjjLw/dwwXi45Uc+nbblicxQGHzUDhWTERprnJ
 GvjswCCPZW4lo8lPq7A==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a04d6a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=t7CeM3EgAAAA:8 a=Gb5hSY02JU1MmV-but8A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: mQi7RIAWRoQiojNv512PgMEhbY7_QUR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219810-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Queue-Id: A2F731A6EDC
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:24:34PM +0200, ionut.nechita@windriver.com wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
--8<--
> 
> Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> pci_lock_rescan_remove_reentrant() helper. This function checks if the
> current task already holds the lock:
>  - If the lock is not held: acquires it and returns true, providing
>    full serialization against concurrent hotplug events (including
>    platform-generated events on s390).
>  - If the lock is already held by the current task (reentrant call from
>    remove_store or sriov_numvfs_store paths): returns false without
>    re-acquiring, avoiding deadlock while the caller already provides
>    the necessary serialization.
>  - If the lock is held by another task (concurrent hotplug): blocks
>    until the lock is released, then acquires it, providing complete
>    serialization. This is the key improvement over a trylock approach.
> 
--8<--
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd794..467362c277f19 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3509,19 +3509,38 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static struct task_struct *pci_rescan_remove_owner;
                            ^
                            const *pci_rescan_remove_owner

Minor nitpick: you could declare this `const`; making it clear that this is
not meant to be used to modify the task in any way.

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
> +bool pci_lock_rescan_remove_reentrant(void)
> +{
> +	if (pci_rescan_remove_owner == current)
> +		return false;
> +	pci_lock_rescan_remove();
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_reentrant);

Otherwise this looks good to me.

I've run tests on s390 with hot-unplug from within Linux and externally
triggered, driver unbind/unload, s390 PCI recovery, and some other minor
tests.
No lockdep splats, no other warnings/splats; it looks good to me.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

