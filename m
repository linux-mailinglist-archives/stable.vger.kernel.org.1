Return-Path: <stable+bounces-220075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMPZLXQao2lD9wQAu9opvQ
	(envelope-from <stable+bounces-220075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270BB1C4615
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A53A306A30C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 16:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466722FE560;
	Sat, 28 Feb 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZMMHyFQv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780426ED3F;
	Sat, 28 Feb 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772296814; cv=none; b=olE5v0gi1D+iiNJ6aFHGqR8p3NzWXlXcfLhqjzWlHS6c85U1vn4E+VSWm/AjgVwp02mBToMs0lnp6zzLAuqaaiEs2c7CVF5MHn/M4cm9uFVAi2p8ptZfO19/KXr8TDjd/GF42O3IpkLJ9EGiUFBVi3EmdcM4leh56et/LYBU9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772296814; c=relaxed/simple;
	bh=20ZD/q9u7Pna7ErEGtD/WxcVWaoGoE94j4oG0k7JmeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaQSmrCZgQYbNcn1qfDJitqg6XzOHDghIx406MhC0ipsYaQPizUYswOt9UkcXxVY0SSj3S9jK5fmaDOs18PLgo7DpPhw/qda+I7G35Myw9u6oXGbMVAfvN6s9vCtxHzTMISuguo/XrpE10OEi3mZenvQX3uJCiAG+8BMwrcuNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZMMHyFQv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61S8R5FW2410721;
	Sat, 28 Feb 2026 16:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=aY9/FtC0CIEX57GULpy8Nu8sVV3CVSs/yEkBexGqGjw=; b=ZMMHyFQvyVRA
	8+TSxaesaTQ0cLMKR/WrAKS1m7/UQsZUkm09CZ/Lk2Aun1ygD2mYdGE/gcW2jI82
	HYrkQ0OdWFJ2cyJofL0i/dCMPDfhx49bFOuBJVmvRWTed93tgy7YyPf8A5yeJgMh
	KADfJPoQO8m85IMJum2idRXdWtnztL5UyPpNdf4zIs9OFOBl/5QmmzliV57SWehr
	haXPRCvlJR3tE+yF8EUOInFZ99zcjiD3CjFbh3pDncGKHZBVhhbpbDXx67uzHh+E
	U3y0BNYO+s679UgP83p/9GMywOmasRjibezqZGTqUddAOUeFQvHPB+c7qhfOaI1g
	N/A2L1SWow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhsb9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 16:40:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61SGZ2LX027789;
	Sat, 28 Feb 2026 16:40:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr2f1mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 16:40:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61SGdurA45351252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 16:39:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E97520040;
	Sat, 28 Feb 2026 16:39:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4501120043;
	Sat, 28 Feb 2026 16:39:56 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.111.19.15])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 28 Feb 2026 16:39:56 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vwNMB-00000006yKn-37Hu;
	Sat, 28 Feb 2026 17:39:55 +0100
Date: Sat, 28 Feb 2026 17:39:55 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com,
        schnelle@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <20260228163955.GH13050@p1gen4-pw042f0m>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
 <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a31a63 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=t7CeM3EgAAAA:8 a=0-soeC0At488xzAx-joA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDE1MyBTYWx0ZWRfX8KxAOqYzZ7l4
 CNURvvjqbHi1KZPw1bwf/vVAuDD3mNBp3ZoS2dPqNBXOoyMKAfVIWgByRycrOP6fx5KhoN0mOHV
 Wx94d2RY7NjxJ/rAlCNmCzwjkzZH2xNrHvgH6P7V3FDMyOzXdsX9HlADekGUdUgqHJolzE5CD9H
 RAkftL+i+/WuEhP+JIlKbCBLjWU7ZsMb0/9caAc+9ecfF4qhMxKkxxI6KrC82dhNy4iL4PqTlk8
 V5flE5vaAsIFSEG7t90o92vNdY8ZbQEp9fct2Mftzvncj/ofKbt5eHRRrGhcFPjnmtW3Mm1TbJ3
 GN7ijllNPlUPxC3hvbin3F0qq8bHrzz2PvpMTY4ma8gsIUkg4MG/yWQtWEMNT+pknVHIZIgEiLe
 NRM/2a3iqi7H9J89c/Wlo2B/X4IYV5uALVjnvdeGCtJAm0p5UATSTEwg0mfFx8dRaUV2GHpNUBD
 98eZ2vJuBFB1SJylmZw==
X-Proofpoint-GUID: P3js3V-P6kQsVOedTcTPfKQrdzxnP0iC
X-Proofpoint-ORIG-GUID: t-2faXCGWRuHPD_m5cyDJgQ_tOHP8O7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_05,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220075-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[windriver.com,google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
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
X-Rspamd-Queue-Id: 270BB1C4615
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 08:43:33PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> > From: Ionut Nechita <ionut.nechita@windriver.com>
> > 
> > After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> > locking when enabling/disabling SR-IOV") and moving the lock to
> > sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> > or manual unbind) that calls pci_disable_sriov() directly remains
> > unprotected against concurrent hotplug events. This affects any SR-IOV
> > capable driver that calls pci_disable_sriov() from its .remove()
> > callback (i40e, ice, mlx5, bnxt, etc.).
> > 
> > On s390, platform-generated hot-unplug events for VFs can race with
> > sriov_del_vfs() when a PF driver is being unloaded. The platform event
> > handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> > leading to double removal and list corruption.
> > 
> > We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> > be called from paths that already hold pci_rescan_remove_lock (e.g.
> > remove_store -> pci_stop_and_remove_bus_device_locked, or
> > sriov_numvfs_store with the lock taken by the previous patch). Using
> > mutex_lock() in those cases would deadlock.
> > 
> > Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> > pci_lock_rescan_remove_reentrant() helper. This function checks if the
> > current task already holds the lock:
> >  - If the lock is not held: acquires it and returns true, providing
> >    full serialization against concurrent hotplug events (including
> >    platform-generated events on s390).
> >  - If the lock is already held by the current task (reentrant call from
> >    remove_store or sriov_numvfs_store paths): returns false without
> >    re-acquiring, avoiding deadlock while the caller already provides
> >    the necessary serialization.
> >  - If the lock is held by another task (concurrent hotplug): blocks
> >    until the lock is released, then acquires it, providing complete
> >    serialization. This is the key improvement over a trylock approach.
> 
> Just curious. Why can't you use mutex_trylock() here?

One problem with mutex_trylock() is we don't know whether we ourself or
someone else is holding the lock when it fails, we just know someone holds it;
and we can't wait for someone else to release it when there is a chance we
hold it ourself already. That was the problem with
05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
before it was reverted.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

