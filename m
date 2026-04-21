Return-Path: <stable+bounces-240141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANn6NdJy52kO9AEAu9opvQ
	(envelope-from <stable+bounces-240141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:51:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFF43ADD9
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCC7B303B5CE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41113D648F;
	Tue, 21 Apr 2026 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TWIG9w6n"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88323D6473;
	Tue, 21 Apr 2026 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775714; cv=none; b=iCZTlC63ZuSknMoccn40KNCILY1k5rC/SKGwUyqSphFXdV0rwrmh6/YFTGmpD4D5sZPMckQ0epVBIjnqpdgIH/q+bjhUs7NxkeXLrpBc3CM9DK8130uCaI2geFdR01Jzyq0qp2MMoOrtdQLQydGG9n2LT5pMOP6V4RbT9weGeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775714; c=relaxed/simple;
	bh=DqkUUpZt+hpjmPvXz874JmbMRCHrWto+MnCeLhZXaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK2x/jQDOn312nYzGE8xYjPQINd6KwvdcQKgLDjx+N6kFjKHsR0TK9YOAgdQBp4QkLL/PTfS+BvJbIcx30Cj7JySywRg6LuTzGNbO1OuUi+M5G/uLCph5vGGUEHyD191EiQLN+nQj1DrhTSbhzi+6Sv5rgjMZ9sn7F0B2WyBMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TWIG9w6n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCYaeP1926131;
	Tue, 21 Apr 2026 12:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=M79HhCpXrEJibLCm0ot7+Qrs+NU6rdb9PIvmAG0wnZI=; b=TWIG9w6nErxf
	SXoy89Ivu/SGbjMR8Skso48WhgB85VrsY3DHXFOlpODlGugqAc/lkeYgG+gfc8OT
	PVq18Vs1EIAUeTc8nFt9a7pjAMBpI/yGg2ECHERdNixadBajvGq2U2PEN56JdFAR
	G7dpKnbf1VsoGAHfpFRWf5/YPKXqdetwsCfgA6MkASocy7vWyn0fmsIMBZLVL61n
	NvUlKFYkTwfSyJsMUWu+eqaAlWaPJXAEqbODK4vs13GXBODf7NAztw8qHmR5PMa4
	baGicRpWWzTmJaFj71AaLB1dckYWzyT2IB5n3hLfZ34TWTkgOnrb4FZLxxE1kD3i
	oqvnhWQTwg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf4afc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 12:48:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LCZHqP017802;
	Tue, 21 Apr 2026 12:48:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvrtuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 12:48:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LCm19Z50397526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 12:48:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D5882005A;
	Tue, 21 Apr 2026 12:48:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECFB320040;
	Tue, 21 Apr 2026 12:48:00 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Apr 2026 12:48:00 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wFAWG-00000008gcr-2uSw;
	Tue, 21 Apr 2026 14:48:00 +0200
Date: Tue, 21 Apr 2026 14:48:00 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        sebott@linux.ibm.com, schnelle@linux.ibm.com, linux@roeck-us.net,
        lukas@wunner.de, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v13 1/2] PCI/IOV: Make pci_lock_rescan_remove() reentrant
 and protect sriov_add_vfs/sriov_del_vfs
Message-ID: <20260421124800.GC2707369@p1gen4-pw042f0m>
References: <cover.1776756380.git.ionut.nechita@windriver.com>
 <288517e50996200c368cfe172de86ceb02bbd342.1776756380.git.ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <288517e50996200c368cfe172de86ceb02bbd342.1776756380.git.ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _T_YS1t-0kR617j0Vc0usA0NLymckQlx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyNyBTYWx0ZWRfXzv2wYY+WCjIe
 KBgiHPcxBLxGsTuee1IKtW8ise3WgABts9BprOSl012ZwwNKw35SyWA6syU2817r/qmDSM0toLU
 7NP/hWT2zhQBXxGJRAHnoGaVZrBt98wlMN/5suML0AT9fNSk1RsMy/Xb6gWKDivB/3y1JLDtjKF
 FLqiDAOuMmOG8DiCtZZm8SVWXI9teaFw0iWZHZuwfOKNYklNhJOsDeIl7+uOClDYABfMYlx6iCe
 jxZaJ6ZHEMTyWeTZCGoynVgpwkF2IwAVObNVBiAfEviFjX18X9MTALOPt2Zp4sLAPqTDDbLt0Y6
 lROPWBdCPDBzx4MlcUJ8wmWHpDBBZMfgYAfpm5F7AxAawDYCizIBxDfIJRpl+pHuWeWBxKniMVB
 BLhsmciMRJBJkXgLfBt455APvm6c0rhiitA4wrK7lu8tvPmCF1KWHLbBSMu/yB/wQzPhBIbWMiE
 biMGOASBmX55wQ4MtwQ==
X-Proofpoint-GUID: JO6cXdAwmXMtH6EKkilw8ZwQUwRUzAXu
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e7720a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fGqJzq9b8BsJZAzwzYEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210127
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240141-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,linux.ibm.com,roeck-us.net,wunner.de,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99FFF43ADD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 10:34:20AM +0300, Ionut Nechita (Wind River) wrote:
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc..0e62081bc5e5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3513,16 +3513,30 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static struct task_struct *pci_rescan_remove_owner;

You could make this variable `const`:

    static const struct task_struct *pci_rescan_remove_owner;

so it is clear that this pointer is not meant to be used to modify the
task_struct in any way - just for these comparisons.

> +static unsigned int pci_rescan_remove_depth;
>  
>  void pci_lock_rescan_remove(void)
>  {
> -	mutex_lock(&pci_rescan_remove_lock);
> +	if (pci_rescan_remove_owner == current) {
> +		pci_rescan_remove_depth++;
> +	} else {
> +		mutex_lock(&pci_rescan_remove_lock);
> +		pci_rescan_remove_owner = current;
> +		pci_rescan_remove_depth = 1;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
>  
>  void pci_unlock_rescan_remove(void)
>  {
> -	mutex_unlock(&pci_rescan_remove_lock);
> +	if (WARN_ON(pci_rescan_remove_owner != current))
> +		return;
> +
> +	if (--pci_rescan_remove_depth == 0) {
> +		pci_rescan_remove_owner = NULL;
> +		mutex_unlock(&pci_rescan_remove_lock);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);


But anyway, with, or without this change, this looks good to me. I hadn't run
into any linker issues, but I only ever used our debug config.
Also holds up with my tests on my s390 rig.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>


-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

