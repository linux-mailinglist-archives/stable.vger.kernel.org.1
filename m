Return-Path: <stable+bounces-253575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGAHA+UZD2qLFgYAu9opvQ
	(envelope-from <stable+bounces-253575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8A5A7801
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDE8317EAD9
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127D36A036;
	Thu, 21 May 2026 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGcdv02E"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364AB31E83D;
	Thu, 21 May 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373186; cv=none; b=VTQYIkK/4x6SaILL7o5pCEv+8Jf9SCRsMkxm2iMYSfnFmISnYksZ6MjVqRlbNLy35VKoV/D3hyrliXEzP2p361hLCqfqzKmVky1QeONnaXzM5OFpoSq6dFpIXvlMTcGk9H7QGAcdv9es6Th815WfSvyKfcT0JeKpxRNAuHVmPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373186; c=relaxed/simple;
	bh=bzgDHbbJSnGY/qtVpQ/JRbmEnyRseYEXhj6VsHLrwTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XicYI+wQbZittGZ1P+AsUfbqofi/H1MRns7DFyhEjrmys1wQ0tARs+vFI88iO33dc0m3j4TpUT+PaY7edQ2Ojfhffmu8botMkLrNzN4BdJs3dkvYkEKFTLLXBs15LG33zybeRGUOn20gCwY7qmcHp7J3THo8nSjxc3fRpkb9mIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZGcdv02E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L0PXGm843724;
	Thu, 21 May 2026 14:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=aq2ziAevdOR20ZlrVFB+myc4dHn3YIrNxhMNT4jPeQg=; b=ZGcdv02EcfxQ
	KAKbShpbWj7AgFnSwWmSfI3FTea+CgsaKOQoyarTcGR0XaRKS4BNs3hfQS6ac72Y
	5wqBMc/5mK2ccA/3cvKQUEGN60MisYPWy6QGnjYuIdvrvcEwM0YPGONtxlDOfI7L
	wo1+/ILCLJ25zbLhoFOEM+dE77tR5+JnDhOTIOIHxkHAcxnkgrzeuF2f1CX5m3pd
	bHvIsqYGP09cdYGN1Pk0p+3RqP1arLhBye+v7YjaACmhLGog4CMrmzdcC7zgagUl
	gCiLHQ3x7jiAWbNHoGBZiLXnj3c5BTMg6g2XBuYkQhePrbp+g4NR7fA60o9d+mi3
	0WrCTEdDpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y7fm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:19:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LE9JqD017826;
	Thu, 21 May 2026 14:19:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gmanj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:19:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEJ3nm49545696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:19:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C69B20043;
	Thu, 21 May 2026 14:19:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1954E20040;
	Thu, 21 May 2026 14:19:03 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 May 2026 14:19:03 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wQ4Eo-0000000Dcd9-2nEy;
	Thu, 21 May 2026 16:19:02 +0200
Date: Thu, 21 May 2026 16:19:02 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        helgaas@kernel.org, schnelle@linux.ibm.com, linux@roeck-us.net,
        lukas@wunner.de, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v14 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
Message-ID: <20260521141902.GD206464@p1gen4-pw042f0m>
References: <cover.1776839248.git.ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1776839248.git.ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfX8WW7ICgrgEay
 KWozYAaeNpnS6PreqGOEu9gXfNXYnuuIflenLcdGAD98uC2+q3eV3XSRFBTBT+O8100XOiy+Vkc
 7dRSiu33DTAJFcACrmX6NCnXYGd7LvpEqZPdOSWIBjhb8I5x1Yge/OffSeOc7zEYnQx6wGPHj6B
 /T7YlBkQFTncQ6/eJFu5c6eTEj7qqal9zdCVCypx0SIYIlpVLmCwVcTZI6/vq7REpSB8S5275Nw
 8iBFDjIWf1ss5qGGdhsSW3jL+ZnZyUp+9LFkxlmkNrijY0+SwkUfcqDMSlkXLpEgBYhx6zP8ZnP
 HZv5QjealdfK7/vzN6NkJ9xRjG6V19RszVzAV/PJvsCv6Cn/1EVC+6M5TXZV5Y/GA+vUR7BCuvq
 pu/UyQMchEzLiHP+7Mm4DuKgM1h9IyM7Thvo8+TWP/L2muZBsni3DrpxwbPhMJFCR1utpW5+Ms8
 nK1Tel31xbEiJ5N7aKQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0f145b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=J6SQpo7RyPDJe7EV0JwA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: KHf9ZanH9jMYZW6Db_6NeGxoWj_KLa6I
X-Proofpoint-GUID: QN3mdofEJ83IA20oSJrx_2TLWc2wNWLf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,windriver.com,kernel.org,linux.ibm.com,roeck-us.net,wunner.de,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:email]
X-Rspamd-Queue-Id: 80D8A5A7801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey Bjorn,

On Wed, Apr 22, 2026 at 09:32:40AM +0300, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> This is v14 of the fix for the SR-IOV race between driver .remove()
> and concurrent hotplug events.
> 
--8<--
> 
> This race has been independently observed by multiple organizations:
>   - IBM (s390 platform-generated hot-unplug events racing with
>     sriov_del_vfs during PF driver unload)
>   - NVIDIA (tested by Dragos Tatulea in earlier versions)
>   - Intel (xe driver hitting lockdep warnings and deadlocks when
>     calling pci_disable_sriov from .remove)
>   - Wind River (original reporter and patch author)
> 
> Test environment:
>   - Tested on s390 by Benjamin Block and Niklas Schnelle (IBM)
>   - Tested on x86_64 with Intel and NVIDIA SR-IOV devices (earlier
>     versions)
> 
> Based on linux-next (next-20260420).
> 
--8<--
> 
> Ionut Nechita (Wind River) (2):
>   PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
>     sriov_add_vfs/sriov_del_vfs
>   PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
>     in remove_store
> 
>  drivers/pci/iov.c       |  9 +++++----
>  drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
>  drivers/pci/probe.c     | 18 ++++++++++++++++--
>  3 files changed, 50 insertions(+), 7 deletions(-)

do you think this patchset is ready integration? Or what do you think we'd
still need to do to get there?

This race, and especially those I fix in the follow-on patchset
https://lore.kernel.org/linux-pci/cover.1776868550.git.bblock%40linux.ibm.com/
are pretty painful on s390 with PCI hotplug. It forces us to reboot the
system, since there is no other way to get out of the deadlock.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

