Return-Path: <stable+bounces-223358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIJeCiPzqmncYwEAu9opvQ
	(envelope-from <stable+bounces-223358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:30:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98226223D21
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABA35307A11C
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DDD39A802;
	Fri,  6 Mar 2026 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pG33F6xg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78733B960;
	Fri,  6 Mar 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810824; cv=none; b=EzWQXSMmu0TifejvXrKfQZ4Bx5WcyFn+p4++U33Cs60nEfZyMR0Bc8TYeYJ12vdUCC5QCkdqEv4N4p7YrbDb1m0z6kB/VQ4kxgE2e4GqMJVyttzWZCb5vZ//s/PsXSPynXyklSgK1Ov9DaaaE8JuTf2DeJSkDU6pkVKe+Rq+eZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810824; c=relaxed/simple;
	bh=7Wk50g8rqG4HeWFgg2izhSBWfdgcOR8s9aItIZpfc7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbhnyDDJGEmuMdYvWsRCyqxUkyMe+WoQmioLexU5hFdDpMs8ytIDZ/JBHA1yhOskr3/1d/8y9KZ9A+sAa0RkuOSQ4lZoIaBSlBgBp7aH5VeatBFKiRkuarSXZxJGrPw0eYjllpAZFGQlg26htGJA4YYSFxN2CnPHR2dw9qGjD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pG33F6xg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626AfiMu3559845;
	Fri, 6 Mar 2026 15:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=q5kgqseMzlg7vRNkt9YBQ+vCvsfOYFApnpS9LBSUNQ0=; b=pG33F6xgLLOH
	SFWzU6ufr+pxpH1zmqWlKNRdH5o6/8UNJ2NJkdGLl4Mxp9PX1GF1MzbvCLOMkCaJ
	Xmul+y3MLDjDV4yYaE2jjN2fx1w4DYp9cBNCnQ4kU0Q643eRFuaG8Y07g6Hxwu4b
	9guyGRsdA4w/eWkcXd3fI1K6hb8ybrwrPK/ARZL8wTlDcVVvMgQkyZYSAFn6tg6o
	75Bsz7PhEJvhf9gJMK5EUo2628FwpqCN/js0HOjabR24vO62mHVYdORQoPsbNBKF
	GPfmn1gukslaAwTuIdJT6Bb3d3APIDbPE70b85xXOJ7UayhmIgWbPqSNtfS+KrIN
	Sx0HBkWRFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd969a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:26:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626D6M5F003243;
	Fri, 6 Mar 2026 15:26:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2yggtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 15:26:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626FQjZh37617924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 15:26:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8A1320043;
	Fri,  6 Mar 2026 15:26:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B5320040;
	Fri,  6 Mar 2026 15:26:45 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 15:26:45 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vyX4f-000000054GF-1vDU;
	Fri, 06 Mar 2026 16:26:45 +0100
Date: Fri, 6 Mar 2026 16:26:45 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        sebott@linux.ibm.com, schnelle@linux.ibm.com, alifm@linux.ibm.com,
        julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
        lukas@wunner.de, kbusch@kernel.org, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v6 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant
 and protect sriov_add_vfs/sriov_del_vfs
Message-ID: <20260306152645.GL1971507@p1gen4-pw042f0m>
References: <20260306082108.17322-1-ionut.nechita@windriver.com>
 <20260306082108.17322-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306082108.17322-2-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CwSDB7Ae9mxkIbM9fih1jXPrHqT2QzyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NSBTYWx0ZWRfX5X5nu7kG95or
 MjeylGOpNFOWjLjDd+b8Tp20yqm6aKh1u4u9yPvBmmEngBH0Cv6FHz2+nmghW1Id7/wxTEEsMK2
 9a0L/tW7ZeSA01h2VS7Ec1OcYiAbtSjNNPNjkhYxuWYlG3kJikuIkaL8Dpy9KdDEcAzzttkd9v+
 yyOiS/PW3ifWd11PbXKxU968JQuOH1VCeUDqzyc8WvxB72duoMfUYQqTYobAvjUGQmEsrdr1HkL
 KeAyhdIQYxga+cNdEJJzN2sqHvRORcf47Ud2MlXagk2D7b56guNrIripJCJo+yrqXr3UzPWg/u8
 EB4suOg728as3vX40m/uzgGCnXaJ1LeNArptobtHj9s+AgVY646naqg0vLEWAaHxj3Ov6gIaKNv
 ikZmYsvmEYvVRg0ePEkAZcxJsplEm0t+BeUt+3bvHdPtCmO2uBGrnbETAvHz3gK1c//ie5Fp8iW
 oa+oj3JyF1EFULv54rQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69aaf23d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8
 a=RHTUbazJTsWS8M0bD-YA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: qt7NbiWAQaq5ufIDnDp-4bCtwaRKMTwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060145
X-Rspamd-Queue-Id: 98226223D21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223358-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,windriver.com:email,nvidia.com:email]
X-Rspamd-Action: no action

Hey Ionut,

On Fri, Mar 06, 2026 at 10:21:08AM +0200, Ionut Nechita (Wind River) wrote:
--8<--
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Tested-by: Benjamin Block <bblock@linux.ibm.com>

I'm not sure whether you are aware of this, but generally, once you make
substantially changes to a patch, it is common practice to remove the previous
Tested-by and/or Reviewed-by tags again:
https://docs.kernel.org/process/submitting-patches.html#reviewer-s-statement-of-oversight
(3. paragraph).

It's a bit of a judgement call what level of change is necessary to be
"substantial", but anyway, I thought I'd mention it :)

> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
--8<--
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd794..c7efb8e1010d3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3509,16 +3509,27 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static struct task_struct *pci_rescan_remove_owner;
> +static unsigned int pci_rescan_remove_count;
>  
>  void pci_lock_rescan_remove(void)
>  {
> +	if (pci_rescan_remove_owner == current) {
> +		pci_rescan_remove_count++;
> +		return;
> +	}
>  	mutex_lock(&pci_rescan_remove_lock);
> +	pci_rescan_remove_owner = current;
> +	pci_rescan_remove_count = 1;
>  }
>  EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
>  
>  void pci_unlock_rescan_remove(void)
>  {
> -	mutex_unlock(&pci_rescan_remove_lock);
> +	if (--pci_rescan_remove_count == 0) {
> +		pci_rescan_remove_owner = NULL;
> +		mutex_unlock(&pci_rescan_remove_lock);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);

I'm not sure Lukas meant to revert to a local cache for the task_struct, just
that the counter variable itself doesn't need to be an atomic.

How the counting is done itself is probably very much a taste question. I've
run tests in my test lab with this change:

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6686cee98afc..28c0384424db 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3510,27 +3510,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
 EXPORT_SYMBOL_GPL(pci_rescan_remove_lock);
-static struct task_struct *pci_rescan_remove_owner;
-static unsigned int pci_rescan_remove_count;
+static size_t pci_rescan_remove_reentrant_count = 0;
 
 void pci_lock_rescan_remove(void)
 {
-	if (pci_rescan_remove_owner == current) {
-		pci_rescan_remove_count++;
-		return;
-	}
-	mutex_lock(&pci_rescan_remove_lock);
-	pci_rescan_remove_owner = current;
-	pci_rescan_remove_count = 1;
+	if (mutex_get_owner(&pci_rescan_remove_lock) == (unsigned long)current)
+		pci_rescan_remove_reentrant_count++;
+	else
+		mutex_lock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
-	if (--pci_rescan_remove_count == 0) {
-		pci_rescan_remove_owner = NULL;
+	if (pci_rescan_remove_reentrant_count > 0)
+		pci_rescan_remove_reentrant_count--;
+	else
 		mutex_unlock(&pci_rescan_remove_lock);
-	}
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
But like I said, the counting comes down to about the same as with your patch
(as far as I can tell), just that it also uses the mutex_get_owner() call.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

