Return-Path: <stable+bounces-239315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEMzEKdW5mktvAEAu9opvQ
	(envelope-from <stable+bounces-239315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:39:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A042FC59
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 785A83244C68
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99A33A70A;
	Mon, 20 Apr 2026 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BnjKsRD/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248B33262B;
	Mon, 20 Apr 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699932; cv=none; b=QQh+seZfbWn19eSXXpF29emklEqzeIkmvRUWmxIB2puue7ckkQ0S6DkHWA3htxyAuO5JXa+Ygumo4InLFcNi/qYsQuhorc/CbInYyZSgFcjNwmZ/tRfLSooW2lKZ2BCJQ6tqdtjrFbdMTtS5wabPoW5Jh1ZCJPz25mIT7Sp7XqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699932; c=relaxed/simple;
	bh=E4pRxTPRrQmp7ZXujCObeaSRgz5fXjXQsqFdenkuzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osE5C6ChEA+i3V8/SQCPJMsm7X4Znrf96njISZpsz8f3fNrXhmoNpqMbjEFzuRNN+N7mJKpU0Fy4pSp6ib2LTMinGeBap3q75oYK6Zjn/mOvqIfvPoZpK6rF3rb/tuHnXwD0ch2vxmOTOs20a7zQdp+oUK+cgC3W9i7GAP2nEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BnjKsRD/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K84NOK1315637;
	Mon, 20 Apr 2026 15:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=j/Yy/BcjOlWutxPpKZ3uZ3CWZ/zwdwMrV75ynpcqHwY=; b=BnjKsRD/HhHT
	4wrOKZa9QknWLLBvQZzoMCccxon4vohS3SJyIpAuZ3SIH1yje/ze0Mg8/qaAnRu/
	ypX6b0XrsY6fizAmfxg2jrJBpydDDHvyeKanCahvky1BidVdwohcgRI7OcNyF7V4
	aDSDNS9b63vB4lfz4TQ9OC0lGYFlPbNqMarBhGKtNwYxbk9F7qgFBH81rdzdqhnc
	lxuoG3g1ZeO8JCVnyQJle+oFrxquHZ4YlYt66TpRhgOJ87NP3enKWd14dMSwzUBg
	4O0pbufx4HUjqW9UWgJXrBV62aA2iUEktlOQ26sIIY/EjN4ew0+7Zv7dPj+m4EZj
	lF2uZcLy8A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6fupd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 15:45:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KFZRNo002996;
	Mon, 20 Apr 2026 15:45:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsgw8xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 15:45:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KFj0Z151511778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 15:45:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 425052004B;
	Mon, 20 Apr 2026 15:45:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1F920049;
	Mon, 20 Apr 2026 15:45:00 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Apr 2026 15:45:00 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wEqnz-00000002hi8-3kSI;
	Mon, 20 Apr 2026 17:44:59 +0200
Date: Mon, 20 Apr 2026 17:44:59 +0200
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
Subject: Re: [PATCH v11 2/2] PCI: Fix AB-BA deadlock between device_lock and
 pci_rescan_remove_lock in remove_store
Message-ID: <20260420154459.GA2707369@p1gen4-pw042f0m>
References: <20260326083534.23602-1-ionut.nechita@windriver.com>
 <20260326083534.23602-3-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326083534.23602-3-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e64a02 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8
 a=38I2V2JNsOjyXGpjdSMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE1MCBTYWx0ZWRfX9+HYG0zg13HD
 X8IaCoDz5SaK7kzmmd+5ikBq0D0pYM+LSYieRugIpTLumhJ0pyId6YwTpFp304BqzlCq0gVbwwt
 E/sUkUVa+jZv30/gmBW7FaWeirvVJlV9G9AY7UrB6Z4tvc1zD9tsDI6ToY8znrCJMDofdTjcgLL
 vWeRdQ5xhJh1hoknt4DpJUk2X0I6c7kz2SBwZRUZ69RIQA79oAKgpRrUVpRojHfLfQxXJlVxFal
 Io7tjFMEHlnUz9lpoM/D10GwBek07/dZjGjbKyvMiZ2nCihdKObkxDsX4ttKOUFn1zrE1vLUEfC
 JRZ4bZh7M/n/or7fFzhjtJbiV4GagKR8X4o7cUU8np7UDulSeDTIdAEq/clBME0ahOYkB+Usi+p
 EH71j0jm/sbHYA18vSDmwv+HgsuFiXEjXGdiGXIUvbyjXVrzRbCIXoPbzSGMQ8EbvpxJ9EtFIGa
 E5C5Db7zrbm0TITiHCw==
X-Proofpoint-GUID: 2aQkmJIgEF6oHEufyLTzgYL4HSGwrj6v
X-Proofpoint-ORIG-GUID: mdSpiUkZJHREJzle4vcqThZCVQUI064d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200150
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239315-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 620A042FC59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey Ionut,

On Thu, Mar 26, 2026 at 10:35:34AM +0200, Ionut Nechita (Wind River) wrote:
> remove_store() calls pci_stop_and_remove_bus_device_locked() which
> takes pci_rescan_remove_lock first, then device_lock during driver
> release.  Meanwhile, unbind_store() takes device_lock first (via
> device_driver_detach), and the driver's .remove() callback may call
> pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().
> 
> This creates an AB-BA deadlock:
> 
>   CPU0 (remove_store)               CPU1 (unbind_store)
>   --------------------              --------------------
>   pci_lock_rescan_remove()
>                                     device_lock()
>                                     driver .remove()
>                                       sriov_del_vfs()
>                                         pci_lock_rescan_remove()  <-- WAITS
>   pci_stop_bus_device()
>     device_release_driver()
>       device_lock()                                               <-- WAITS
> 
> Fix this by first marking the device as dead using kill_device() to
> prevent any new driver from binding, then calling device_release_driver()
> before pci_stop_and_remove_bus_device_locked().
> 
> Marking the device dead closes the race window between unbinding and
> removal where a new driver could theoretically bind: once the dead flag
> is set, the device core will refuse any new driver probe.
> 
> After device_release_driver() returns, the driver is already unbound,
> so the subsequent device_release_driver() call inside
> pci_stop_and_remove_bus_device_locked() becomes a no-op.
> 
> Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)

sorry for the late response, it slipped past me that I haven't given this a
review yet.

It looks fine to me. It solves the report we had with the previous patch. I
also tested this, and so far it looks good in my (s390) setup.


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

