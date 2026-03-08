Return-Path: <stable+bounces-223468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEPnBCn+rWkV+gEAu9opvQ
	(envelope-from <stable+bounces-223468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 23:54:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07314232929
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 23:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 470EF300691A
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD633262C;
	Sun,  8 Mar 2026 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o3hp+eSM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CFD31195A;
	Sun,  8 Mar 2026 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773010466; cv=none; b=HY3mtsVYeHFuCcuqKBrOGASqdr/2GKMTlOa4Z7MWdOJQ9WoXWFvGcYNbCR+DiTN1hwZuT+HDci6bPyUe8GXf5WPVC4dQICN1BG9Td7eh1OD7T1sZBMKaDXGeMDswggdbLxM6hEQ39tiVTGqpziVtgMv/D68UvZCCqOQapLGH+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773010466; c=relaxed/simple;
	bh=44slylXGCygSSwtkCaBksHPG+mOcFHFsXqxsya3nQeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQfT0xxcFhz+cXNlX1sgwPAEZbMYA6r1i8dX3bmmypSF4dFp2TrXTFRRjjNOrFB+kMyuv0oEHJ7gph19GnD6q5bveHU6/MPu9bFLOAmF4JflYumtaYaaGQh/UW9vyffGR+1iW7+Ico4WDiKYeSVPkbpY/zWWHEvvQ9zX6sEhbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o3hp+eSM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628MF1lU1527158;
	Sun, 8 Mar 2026 22:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=pH7xO9uh+VKhfiZB0WjQ91+mVFhzbRfV5Z5ktd6zwJg=; b=o3hp+eSM6igl
	M0/aoX29+r7rAly1jb6oExN2f4PmKidXMj95ifGt/wJcdoYO8XfvkXVj4bkzbRmN
	v7tAJ/cSlz8ViieuKs58ucRAEWySIxFJWRSGhKNbP6BzCRVTu2Vetp1bU5kBfIh2
	lhsV3hg7QNBWvyVCXoqdiZzLIpd8zj4SPxxYDyLwmOwu+TxLH3odNZdeXch4YtSh
	2Ege1jd/sR5letpH34q/C5UL2hvQjJRjo+nqgkS/u3paMiTBYaI1TNXrKlTnzD9I
	rFEU7GL/4kvmDxQy1j5saNn1eGX72be6Z2E9PGy7NWUfS4l2+45+OsYDBso4hUma
	1VM9cJK9JQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun49ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 22:54:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628KERFe021181;
	Sun, 8 Mar 2026 22:54:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsjx3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 22:54:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 628MsBI852166984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Mar 2026 22:54:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 287822004B;
	Sun,  8 Mar 2026 22:54:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CBC320043;
	Sun,  8 Mar 2026 22:54:11 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.111.6.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun,  8 Mar 2026 22:54:11 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vzN0k-00000001z6J-1YeB;
	Sun, 08 Mar 2026 23:54:10 +0100
Date: Sun, 8 Mar 2026 23:54:10 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, helgaas@kernel.org,
        sebott@linux.ibm.com, schnelle@linux.ibm.com, alifm@linux.ibm.com,
        julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
        lukas@wunner.de, kbusch@kernel.org, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v7 1/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant
 and protect sriov_add_vfs/sriov_del_vfs
Message-ID: <20260308225410.GA46248@p1gen4-pw042f0m.fritz.box>
References: <20260308135352.80346-1-ionut.nechita@windriver.com>
 <20260308135352.80346-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308135352.80346-2-ionut.nechita@windriver.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VaNGpKzTEXBQKq63s8HD3H9MOS_tLkMe
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69adfe1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8 a=xHlSXgK-8sZQpV_rmxkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDIwOSBTYWx0ZWRfX/eETzeq5+IeY
 n50QTQua5VQWv7a9fD89PRPztZYLxyq/a964aAWjldgrtahbHqB0ZcBP+4xNyaYimUDjNmyHgWo
 h0Ndg/wuedkfW3pAddikRLKA0vmXieZ5Sachvn7jetJ/YyO6TEd2aP1l7xsB6MZIAP6MOeNtLir
 K6ltzIQXUmt+aLsKAP4mlCjBvWov/Nlok4u8NqRiSm05a2X492mtf4GXiqCPdFhntCMfDmGceUJ
 1njtKzNgc17HO2aKTagJeFDY/PW1UaEPI5n3qUy9oZsw8Swr1FZ0pg1aCsj3s+zfT7Ezn+tpn1e
 k/2k3MlXls9utlwEWAEdOPpE/t9YPdv3z5D64OyfDLQPQRqNw1EXtkHyfEBl9ugy1Y7SmSzhH/s
 JY8F1vxd2yyC2vqcRBirmNWhMRsR5T4kQLml81JPOTy36Q0HVUR0cUhWHquaDc3UJEeDDjbXJys
 jtJ4AEmyi+Emj/rcotA==
X-Proofpoint-ORIG-GUID: Dp_Q7a3nFw8xJ82YVL7swqNSBsTqmuVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603080209
X-Rspamd-Queue-Id: 07314232929
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223468-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,p1gen4-pw042f0m.fritz.box:mid,windriver.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 03:53:52PM +0200, Ionut Nechita (Wind River) wrote:
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
> 
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
> 
> We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> be called from paths that already hold pci_rescan_remove_lock (e.g.
> remove_store -> pci_stop_and_remove_bus_device_locked, or
> sriov_numvfs_store with the lock taken by the previous patch). Using
> mutex_lock() in those cases would deadlock.
> 
> Make pci_lock_rescan_remove() itself reentrant using mutex_get_owner()
> and a reentrant depth counter, as suggested by Lukas Wunner and
> Benjamin Block, since these recursive locking scenarios exist elsewhere
> in the PCI subsystem:
>  - If the lock is already held by the current task (checked via
>    mutex_get_owner()): increments the reentrant counter and returns
>    without re-acquiring, avoiding deadlock.
>  - If the lock is held by another task: blocks until the lock is
>    released, providing complete serialization.
>  - If the lock is not held: acquires the mutex normally.
> 
> pci_unlock_rescan_remove() decrements the reentrant counter if it is
> non-zero, otherwise releases the mutex.
> 
> This approach keeps the API unchanged: callers simply pair lock/unlock
> calls without needing to track any return value or use separate
> reentrant variants.
> 
> Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
> sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
> removal against concurrent hotplug events.
> 
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/pci/iov.c   |  5 +++++
>  drivers/pci/probe.c | 11 +++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)

Looks good to me. Also, I ran tests with this in our test lab (s390).


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>

Thanks.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

