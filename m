Return-Path: <stable+bounces-253814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAjXB2GAEGrdXwYAu9opvQ
	(envelope-from <stable+bounces-253814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2525B76BE
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26967300DA46
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72085403EA5;
	Fri, 22 May 2026 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rO2z7vgM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF553911CE;
	Fri, 22 May 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465973; cv=none; b=bFfTxPAQ3u+xhEPEAm9L/I0gehAs4jXHL7RU92IPZ/KXj4ntyPf3I7phksGhObtgYF4J5SgpaETmg245vAOXQd0mLtYxbniKP9aB6lZZwCdZgtFDpCB30AcmhzfJqo8n8nI6rl6mZAxzCY7lqJHGha7Rbn2NX9Zh/CelI0UwfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465973; c=relaxed/simple;
	bh=VEseHeESDTqPqpZ+vXnSAU2mOHaLLoZ8cNZRCc/rvjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjiGwnl9edv4kWTrNi7E4/kY8Lo9mmT2a5n36ihqXEwrIurIjA5fg5ccLioSiro7WQFN2+RK7l95/R/HrFhxBlZ3abfyIC++htn9WW22JrX7kPvlPP5o5zK3pf62wxPP6jOKQglXDk0yLPLbdNnyLXpOcZSv1GbwuXO4sLnJTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rO2z7vgM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MFW1Qd980011;
	Fri, 22 May 2026 16:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=f2n9myvSSTBDKKfIeShW1Ra3D3ow85NLWqGBUox//uI=; b=rO2z7vgMIYla
	KApWOWzlu+MxuZkut7WzoB2w5b/O7w11R1n/28p7JLAwbcGq0WT7T4M7o+2VZ1jR
	hj8lt18Uq3UmaEBV3orm7XGSI0s6XVOny2ZcsM/uauATLSG2FVcwOEHSrf3y6gh7
	/YacnCHyPiR9IAuigFzgUrX1wdkLiidwZBLhWzTl+uxGhFsbVfc3ypvg+XP4wTji
	Lql35rehYqGGggp4kSZCxROI6UetYlxOnnOvYxwV5XL0oUz6r0ytxWl9J+W1xQuK
	bcfmDSnI+xgoP2Wp8OD8Bjk3IYyV+ALDiLI0UNvQaWFQ8cMKTNrEoiflMzWS5aJC
	VSN9TPYfzA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n4rh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 16:05:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MFs5Tf013158;
	Fri, 22 May 2026 16:05:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj1hgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 16:05:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MG5hXw29885022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 16:05:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D5042004B;
	Fri, 22 May 2026 16:05:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A5820040;
	Fri, 22 May 2026 16:05:43 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 22 May 2026 16:05:43 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.2)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wQSNb-0000000HS0j-1204;
	Fri, 22 May 2026 18:05:43 +0200
Date: Fri, 22 May 2026 18:05:43 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com, sebott@linux.ibm.com,
        schnelle@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v14 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
Message-ID: <20260522160543.GE206464@p1gen4-pw042f0m>
References: <cover.1776839248.git.ionut.nechita@windriver.com>
 <20260521201312.GA182641@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521201312.GA182641@bhelgaas>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: PxM4KYMojAWJnU1ACjWRWUqvvF1rO36m
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a107ede cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-mVaU32sIrbP48RIxBgA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 3g2Gaj7-UuMoG97Us30-BrpRfDObhRmJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE1NiBTYWx0ZWRfXxLYniXntxEcN
 wYbhNTtYegC/P1dThxhXenSki4TtwccLiv65FDYF97i5w6a7hVifQ0tUb49WkUTESC5boEUL3fU
 9I6R4aLdP0RN8p1obeX2fOW25NA/HzCiAaSDxMTYOnkMMC1SA7xlRZzSwL/3/WJVYLq7HB7JHiW
 mtQNwqRJG6NE9yakaSvT+TLrRR336Uf69dQukT4S/ChVEWMVUa0HKWZU7xkq4iWbx033zIdIhsM
 AsWeIlIA4IOD3VHVakvfwv8mkSuayBWNK5D0oKn37qmOjwbqnRkkiTZrzmyV8jlbcWSVLkQTtBH
 65D0e6Bdfj9VNWPLDOPwbS+M2D5XRThIRd4Us6TcDUOdS2yDBtoiZj6Zx+CEcuMDECWO4lwEUHw
 Zx9glGU9mLbTC8l3D9CeAqXm10fdZDZsze/eaIHM1NQ6c0H5jWXBvlvei0gBpAeoTDDYCoeB7IT
 8vO+mgjy7E4WkM2/vTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220156
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[windriver.com,vger.kernel.org,google.com,linux.ibm.com,roeck-us.net,wunner.de,lists.freedesktop.org,intel.com,nvidia.com,kernel.org,mageta.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-253814-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bblock@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B2525B76BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:13:12PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 22, 2026 at 09:32:40AM +0300, Ionut Nechita (Wind River) wrote:
> > This is v14 of the fix for the SR-IOV race between driver .remove()
> > and concurrent hotplug events.
> 
> Can you take a look at the sashiko feedback and see whether there's
> any merit to it?
> 
> https://sashiko.dev/#/patchset/cover.1776839248.git.ionut.nechita%40windriver.com

IIRC Ionut already responded to several of the findings a few patch versions
back:
https://lore.kernel.org/linux-pci/20260319202755.16081-1-ionut.nechita%40windriver.com/

Patch 01:

> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> [ ... ]
> > @@ -633,15 +629,18 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
> >  	if (dev->no_vf_scan)
> >  		return 0;
> >  
> > +	pci_lock_rescan_remove();
> Does moving this lock acquisition here create an ABBA deadlock? 
> Looking at sriov_numvfs_store(), the kernel acquires device_lock(&pdev->dev)
> before invoking the driver's sriov_configure() callback, which eventually
> reaches this point and calls pci_lock_rescan_remove(). This establishes a
> dependency of device_lock followed by pci_rescan_remove_lock.
> During a PCI hotplug event or sysfs remove_store, the subsystem first acquires
> pci_rescan_remove_lock, then calls pci_stop_and_remove_bus_device() which
> invokes device_release_driver() and takes device_lock(&pdev->dev). This
> creates the reverse dependency.
> Will an SR-IOV sysfs configuration racing with a hot-unplug event result in a
> deadlock? I understand this regression is fixed later in the patch series by
> commit 'PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock
> in remove_store', but wanted to point out the interaction here.

This is already addressed in Patch 02.

> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b63cd0c310bc0..91f1dae6943b6 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> [ ... ]
> > @@ -3513,16 +3513,30 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
> >   * routines should always be executed under this mutex.
> >   */
> >  DEFINE_MUTEX(pci_rescan_remove_lock);
> > +static const struct task_struct *pci_rescan_remove_owner;
> > +static unsigned int pci_rescan_remove_depth;
> >  
> >  void pci_lock_rescan_remove(void)
> >  {
> > -	mutex_lock(&pci_rescan_remove_lock);
> > +	if (pci_rescan_remove_owner == current) {
>
> Can this read cause a data race?
> This reads pci_rescan_remove_owner outside of the mutex critical section.
> Concurrently, another thread executing this same function can acquire the
> mutex and write to this shared variable.
>
> > +		pci_rescan_remove_depth++;
> > +	} else {
> > +		mutex_lock(&pci_rescan_remove_lock);
> > +		pci_rescan_remove_owner = current;
>
> Could the compiler optimize or tear these unprotected accesses? Should these
> reads and writes use READ_ONCE() and WRITE_ONCE() to safely perform the
> lockless accesses and avoid triggering warnings in tools like KCSAN?
>
> > +		pci_rescan_remove_depth = 1;
> > +	}
> >  }

Those two are wrong. `pci_rescan_remove_depth` is only modified when we
already own the mutex `pci_rescan_remove_owner == current`, so the writes are
safe. The reads are safe because, again, the relevant case is when the current
thread already owns the mutex, and then we already have the lock; when we
don't already have the lock we gonna try to take it, but this is also safe
because nobody gonna change the owner to us other than we ourself, and only
once we have taken the lock.

Patch 02:

> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -521,8 +521,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> [ ... ]
> > +		 * By unbinding first, the driver's .remove() callback
> > +		 * (including any SR-IOV VF cleanup) completes before
> > +		 * pci_rescan_remove_lock is acquired, ensuring both
> > +		 * paths take locks in the same order.
> > +		 */
> > +		device_release_driver(dev);
>
> Does calling device_release_driver() here violate the bottom-up teardown
> guarantee if this device is a bridge?
>
> If the device is a PCIe bridge, unbinding the pcieport driver will call
> pci_disable_device(). Because child devices do not increment the parent
> bridge's enable_cnt during probe, the bridge's enable_cnt will drop to zero
> and clear the PCI_COMMAND_MASTER bit.
>
> This disables bus-mastering for the bridge while its child devices are still
> fully active. When they are later unbound during removal, their drivers might
> fail to communicate with the hardware, leading to master aborts, PCIe AER
> errors, and timeouts on DMA flushes.

Ionut previously addressed this in the post I linked above; identifying it as
false-positive.

> > 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>
> Does this leave child devices vulnerable to the exact same AB-BA deadlock?
>
> When pci_stop_and_remove_bus_device_locked() executes, it acquires the
> pci_rescan_remove_lock and unbinds child devices recursively:
>
> pci_stop_and_remove_bus_device_locked()
>   pci_stop_bus_device()
>     pci_stop_dev(child)
>       device_release_driver(&child->dev)
>
> This attempts to acquire device_lock(&child->dev) while already holding
> pci_rescan_remove_lock.
>
> If a concurrent unbind_store() happens on the child device, it will acquire
> device_lock(&child->dev) first and then wait for pci_rescan_remove_lock,
> reproducing the original circular dependency.ecause then we can't concurrently change the state to `current`.

This is a false positive; we marked the device as "killed" and unbound the
device driver. So, when the concurrent unbind_store() is called `dev->driver`
is NULL and so it never gonna call device_driver_detach() and take the lock.
Or rather, it wouldn't even be called, because unbind_store() is supposedly
only called when some driver binds the device, which would not be the case
here.

At least thats my take on those latest findings.

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294

