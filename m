Return-Path: <stable+bounces-223724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AxcC8Qpr2mzOgIAu9opvQ
	(envelope-from <stable+bounces-223724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 21:12:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98509240B6D
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 21:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F5543037797
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C8336921A;
	Mon,  9 Mar 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZD079B0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4A369988;
	Mon,  9 Mar 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087138; cv=none; b=XHwJEx+lqLeW8oE4+KZXG4H04AogoKffRXsglzwl+TVLusf/ht8o05yx4BmT95QX5PYfVBSU+okxDvkoMCDle2Qb79HFxfnuh/6NI2wCHCJvcRpjoaqei5LHgMe44AE/JXYP6nISlBFFdyqkuO9yHCdY4pVtKt28PdBCUuFEpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087138; c=relaxed/simple;
	bh=uWwOdBU2a08z0cuh0zJU26zRh9KrZ3ZL35v2I19aoGg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=liv+DXER+MhbZ1FVEjBV4EDhgT+5iWXmL3gx4u6ujFjvsPY63BNOCn7miz9Be819H+L0i29v2ttSdmD+zkXNn0mH41SKn5vGb75kdpNS41J6TM+Kzk7pX229peKqWDhEFkLwVkTXfOK2gl3U4mUVsUPzy429zqz2glQfrkWEszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZD079B0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629DO3US606712;
	Mon, 9 Mar 2026 20:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EU4WET
	cdTHHGwXzUdVurkSSqWYzOCCl/PK33YjcIbK8=; b=HZD079B0mi0854AUCsoqPi
	CCHCLVjqcDtKST+chk1hLlO8C3z+Ui+uQ0zPrkvGqJe9s1Q45KVL3pTLtW9X1DDk
	O7bxbU2/tNrtsdkG3JC2UoLmFE1uKLB5nNvIpty2e7vCZ7SvzD8U3hEHKbHTdGfM
	U8NAWW6dYkqdJUMzINTRv7RPtOnbLVXZlXEGOmTxwdttxdWK+JOwRlYWA3cS0j2l
	lqTizxbmI0umZ7CEo5mG/os+sQm//FLWuaY36t++SPqUSMYwmTq7HSKVcGEqRQ4J
	Hnj3fJQyg0t9LuKjs/XQEbAJOf7lm+PTGg5eHLtKFxKqL2ErYuIb//QIjeGheqQw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr7yyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 20:12:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629FqYja015725;
	Mon, 9 Mar 2026 20:12:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121x3jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 20:12:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629KC55720513510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 20:12:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8301158052;
	Mon,  9 Mar 2026 20:12:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAD0358067;
	Mon,  9 Mar 2026 20:12:02 +0000 (GMT)
Received: from [9.87.131.75] (unknown [9.87.131.75])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 20:12:02 +0000 (GMT)
Message-ID: <eea6652a968a9ad772eaa8e161e165e4414b1800.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/1] PCI/IOV: Make pci_lock_rescan_remove()
 reentrant and protect sriov_add_vfs/sriov_del_vfs
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, bblock@linux.ibm.com,
        alifm@linux.ibm.com, julianr@linux.ibm.com, dtatulea@nvidia.com,
        mani@kernel.org, lukas@wunner.de, kbusch@kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org
In-Reply-To: <20260308135352.80346-2-ionut.nechita@windriver.com>
References: <20260308135352.80346-1-ionut.nechita@windriver.com>
	 <20260308135352.80346-2-ionut.nechita@windriver.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 21:11:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3OCBTYWx0ZWRfX0+MG6fMu05jz
 0EJId08fq3Trdrv5sEEGQIlaS8vM8ygTWGMrZmfpCs7OY2iZCH3/dIBWyA4xM9j4PdUrKpdX50h
 JsZ1+B9L/w2KGVmuiXgYgxn57WoAz51AAOAd/lJyfovl4cTQ5EnuWYX8SyjK98QhRThwqECxgwS
 odeBUKYvDaGrSuiykQiAHezVEisJCpRWMMb3IgujjNomBtqFYAOar8pR1owm2XwO7AhZpjpuE9O
 wmVRT/BGnstvDId5IS3yI/8E0rDbMDO8nFpRuuIy6VUX/CXavEG7CLsgj/JWXHpgFm7GjNnXf1V
 d6RMMXQPEjeP7iYEj6q/rBFveUFpdFJxL3z1mY8FXcp7aRgLOB1aHvp68xvjpIHKY9RAdNgPGTi
 luMA0U2FO8m1VuGQtERA3DuMi82dw2hYA99yv1TUSL47MLTUhorOMKiJUlHXdYtV/XvZOESNJ57
 DYqlbDIHlU4LCthgqgA==
X-Proofpoint-GUID: B0kcC_cKP2YO0U-h-mkj-lCb1ULpwdOg
X-Proofpoint-ORIG-GUID: 5MCbjXFN7vTcfpdozU8OIScKfhPTNzYi
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69af2999 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8 a=t7CeM3EgAAAA:8 a=A3-MaH4CrUij15lr6swA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090178
X-Rspamd-Queue-Id: 98509240B6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-223724-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,wunner.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Sun, 2026-03-08 at 15:53 +0200, Ionut Nechita (Wind River) wrote:
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
>=20
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
>=20
> We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> be called from paths that already hold pci_rescan_remove_lock (e.g.
> remove_store -> pci_stop_and_remove_bus_device_locked, or
> sriov_numvfs_store with the lock taken by the previous patch). Using
> mutex_lock() in those cases would deadlock.
>=20
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
>=20
> pci_unlock_rescan_remove() decrements the reentrant counter if it is
> non-zero, otherwise releases the mutex.
>=20
> This approach keeps the API unchanged: callers simply pair lock/unlock
> calls without needing to track any return value or use separate
> reentrant variants.
>=20
> Add pci_lock_rescan_remove()/pci_unlock_rescan_remove() calls to
> sriov_add_vfs() and sriov_del_vfs() to protect VF addition and
> removal against concurrent hotplug events.
>=20
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")

I think this should have an additional fixes tag for commit=20
05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV") and commit a5338e365c45 ("PCI/IOV: Fix race
between SR-IOV enable/disable and hotplug") especially if you
incorporate my suggestion below but even without it.

> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/pci/iov.c   |  5 +++++
>  drivers/pci/probe.c | 11 +++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 91ac4e37ecb9c..aba2fb90759cd 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -633,15 +633,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 n=
um_vfs)
>  	if (dev->no_vf_scan)
>  		return 0;
> =20
> +	pci_lock_rescan_remove();
>  	for (i =3D 0; i < num_vfs; i++) {
>  		rc =3D pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> +	pci_unlock_rescan_remove();
>  	return 0;
>  failed:
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
> =20
>  	return rc;
>  }
> @@ -766,8 +769,10 @@ static void sriov_del_vfs(struct pci_dev *dev)
>  	struct pci_sriov *iov =3D dev->sriov;
>  	int i;
> =20
> +	pci_lock_rescan_remove();
>  	for (i =3D 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove();
>  }

So basically after making the rescan/remove lock reentrant we can now
use it in the same spot as I did in commit 05703271c3cd ("PCI/IOV: Add
PCI rescan-remove locking when enabling/disabling SR-IOV") only now it
doesn't deadlock via self-lock during device removal.

With that I think you could actually remove the rescan/remove locking
in sriov_numvfs_store() introduced by commit a5338e365c45 ("PCI/IOV:
Fix race between SR-IOV enable/disable and hotplug") as part of this
patch. That way for the price of making the lock reentrant we are able
to reduce its scope. It does otherwise seem a bit weird, though
harmless with the reentrant behavior, to take it in both
sriov_numvfs_store() and then again in sriov_add_vfs()/sriov_del_vfs().

> =20
>  static void sriov_disable(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd794..ce4d351b5aa21 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3509,16 +3509,23 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static size_t pci_rescan_remove_reentrant_count;
> =20
>  void pci_lock_rescan_remove(void)
>  {
> -	mutex_lock(&pci_rescan_remove_lock);
> +	if (mutex_get_owner(&pci_rescan_remove_lock) =3D=3D (unsigned long)curr=
ent)
> +		pci_rescan_remove_reentrant_count++;
> +	else
> +		mutex_lock(&pci_rescan_remove_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
> =20
>  void pci_unlock_rescan_remove(void)
>  {
> -	mutex_unlock(&pci_rescan_remove_lock);
> +	if (pci_rescan_remove_reentrant_count > 0)
> +		pci_rescan_remove_reentrant_count--;
> +	else
> +		mutex_unlock(&pci_rescan_remove_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);


I still don't particularly love making the lock reentrant but I also
haven't been able to come up with anything cleaner for handling the
remove paths.

This is especially true for s390 where removing the last passed-through
PCI function (struct zpci_dev) on a shared virtual PCI bus also
logically removes the virtual PCI bus while also having to hold onto
the struct zpci_dev until the corresponding struct pci_dev is
released.=C2=A0So this is why Benjamin's series for s390 now strictly
depends on this patch to get that part safe without having to introduce
rescan/remove locking in pci_release_dev() which seemed quite wrong to
me.

Long story short. Until a major tree-wide refactoring of the
rescan/remove lock this seems like the cleanest path forward to me
and I thank you for tackling this.

Feel free to add my R-b independent of whether you remove the
rescan/remove locking from sriov_numvfs_store()

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas

