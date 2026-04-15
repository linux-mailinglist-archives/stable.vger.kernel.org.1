Return-Path: <stable+bounces-238205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB8bHkvs32m/aQAAu9opvQ
	(envelope-from <stable+bounces-238205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB6B407705
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFFBE300844B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0DF3806AB;
	Wed, 15 Apr 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qa3PUdj1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEC21D3E2;
	Wed, 15 Apr 2026 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282623; cv=none; b=eaF62QXJwVOi07VoeL9rvkseNyCTWKo0LeO4psMI9+k6vqZn/cW/vUr29KgZL9U6E8C1VEwr4FEDdpv49/NRgIBurfg8ppptaSsg2FkC0MISFyuWx17rOVVzUgX9+OhGMsGKiR5D0yX0ZwlaXL86FjtiXF6YsnF5may4nBBUxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282623; c=relaxed/simple;
	bh=fM4iJhfwJO8swmu+tDLKIU9RQaT0emy/41HcnpeKuas=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TiFigLayME0rZHKVmWA4FEb+RtPURnkySYT3fZNntz5XPUalkxfIJ8BWruWwZFP7ugN8Is72NvCRrAJf/ushF7afAZpKpHfve1T5Bu0E3chN4N6QOW61P8h06q+gskQdQVa3ou/0LzDSAnp9Dg3rpMXQCMJTdDSpOj05/5vvK8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qa3PUdj1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FEtFVr1605298;
	Wed, 15 Apr 2026 19:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DZNVyZ
	6ysBuYj8YiFGxPq92RAqtqeptyZUH90mqXodA=; b=qa3PUdj1AQK9gen7EvFJIW
	mzHlJQCBOalvdYabpK0wbS8j8zSQK3okmk8zcmbQoDi4J3Y5t77PPhvBZU+YWoeH
	t/Yy9eWWYHJwkOobYwv3fPwA9+BXokryqJmmn5jmHd2WadBvavmQMo6Jpx6GSMbs
	sGARwAFg1f2E1DvKBNswnMWcoBjZve6kJyD+MXNHf3ujUtBv6WvxuzZrqpxM7zh+
	fyUP7XCM3GVFstOIx4lxnvQqU3KUNitl9vWr+jQyu4r1+8cBoGQW0uxpifVKjPhf
	mjXSfARAUzyPfAPXyrIz1PP/4wsQhtxHHdILVkSzd4QS4brH3fclvN2ZcE8ASiaA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nj2br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:49:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FGKmOY015149;
	Wed, 15 Apr 2026 19:49:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msr04m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 19:49:58 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FJnuTn32899644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 19:49:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1386658053;
	Wed, 15 Apr 2026 19:49:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319B958061;
	Wed, 15 Apr 2026 19:49:52 +0000 (GMT)
Received: from [9.111.81.211] (unknown [9.111.81.211])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 19:49:52 +0000 (GMT)
Message-ID: <9a9a257de499ae3e1cfd170c1ce1d05428186167.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/2] PCI: Fix AB-BA deadlock between device_lock
 and pci_rescan_remove_lock in remove_store
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, bblock@linux.ibm.com,
        linux@roeck-us.net, lukas@wunner.de, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
        matthew.brost@intel.com, michal.wajdeczko@intel.com,
        piotr.piorkowski@intel.com, dtatulea@nvidia.com, mani@kernel.org,
        kbusch@kernel.org, lkml@mageta.org, alifm@linux.ibm.com,
        julianr@linux.ibm.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
In-Reply-To: <20260326083534.23602-3-ionut.nechita@windriver.com>
References: <20260326083534.23602-1-ionut.nechita@windriver.com>
	 <20260326083534.23602-3-ionut.nechita@windriver.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 21:48:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LvVqhxcBpZe1_m0VUeEFYuZOoDGohB15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE4NSBTYWx0ZWRfX/JJtUUHVep2I
 mh9HmxoEI/EQkMrIWaXygJHglrLO0POi8KhA8DZTlg1xNwVC+jYqe6pMpV85yOWaLWri6b8s7qr
 lDai7vgew58Jl0Add9TeMELdVMQm4TmHKlVXpjSqkuDYfDU+uljZrDGTtVw6ZO276egGnjljDKz
 LYET3OOOTSsgLDsVTm8O/rqGmXjaE86LrQbxU0jdyg0iCGfoWYVGan3lbEPR13sTzth84sL8NP/
 6iS/0gqxcEr+ntzUo2zy8vzhMYHVtT3siRQrRwrKLjrVoew+JgTuGd3dS4xjGT8sABRXlyrAXzI
 o2XAVS6jrN90eUcSCbCk2ZPNkZd2/4RcQPoe9EnxQoNvBNtd8UPakQ43PVPBVHaINh/Vd5YvkmY
 vXI1QiUzPM6zY20m+m/NWTVHE1h/jZldTVGx8VzKifbQ4OGF4rxSMvYs3kl8UZnuOwwFlMv4VwW
 dWd7/OrFPveBq17UQXg==
X-Proofpoint-ORIG-GUID: Lx6ROSBznCrtU7ji-kv_q2BEzQgFil6q
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69dfebe8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8
 a=wQknxR_JBLlKyCFetn8A:9 a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22
 a=KSHYvF9M28j0gckGFaEs:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150185
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-238205-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,linux.ibm.com:mid,windriver.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7FB6B407705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 10:35 +0200, Ionut Nechita (Wind River) wrote:
> remove_store() calls pci_stop_and_remove_bus_device_locked() which
> takes pci_rescan_remove_lock first, then device_lock during driver
> release.  Meanwhile, unbind_store() takes device_lock first (via
> device_driver_detach), and the driver's .remove() callback may call
> pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().
>=20
> This creates an AB-BA deadlock:
>=20
>   CPU0 (remove_store)               CPU1 (unbind_store)
>   --------------------              --------------------
>   pci_lock_rescan_remove()
>                                     device_lock()
>                                     driver .remove()
>                                       sriov_del_vfs()
>                                         pci_lock_rescan_remove()  <-- WAI=
TS
>   pci_stop_bus_device()
>     device_release_driver()
>       device_lock()                                               <-- WAI=
TS
>=20
> Fix this by first marking the device as dead using kill_device() to
> prevent any new driver from binding, then calling device_release_driver()
> before pci_stop_and_remove_bus_device_locked().
>=20
> Marking the device dead closes the race window between unbinding and
> removal where a new driver could theoretically bind: once the dead flag
> is set, the device core will refuse any new driver probe.
>=20
> After device_release_driver() returns, the driver is already unbound,
> so the subsequent device_release_driver() call inside
> pci_stop_and_remove_bus_device_locked() becomes a no-op.
>=20
> Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and=
 hotplug")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d8143=
9288f@roeck-us.net/
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chloru=
m.ategam.org/
> Suggested-by: Benjamin Block <bblock@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index a2f8a5d6190fd..e87aa96c02bde 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -518,8 +518,36 @@ static ssize_t remove_store(struct device *dev, stru=
ct device_attribute *attr,
>  	if (kstrtoul(buf, 0, &val) < 0)
>  		return -EINVAL;
> =20
> -	if (val && device_remove_file_self(dev, attr))
> +	if (val && device_remove_file_self(dev, attr)) {
> +		/*
> +		 * Mark the device as dead so that no new driver can bind
> +		 * between the unbind and the removal below.  Once the
> +		 * dead flag is set, the device core will refuse any new
> +		 * driver probe.
> +		 */
> +		device_lock(dev);
> +		kill_device(dev);
> +		device_unlock(dev);
> +
> +		/*
> +		 * Unbind the driver before removing the device to avoid
> +		 * an AB-BA deadlock between device_lock and
> +		 * pci_rescan_remove_lock.  Without this, remove_store
> +		 * takes pci_rescan_remove_lock first (via
> +		 * pci_stop_and_remove_bus_device_locked) and then
> +		 * device_lock during driver release, while a concurrent
> +		 * unbind_store (or sriov_numvfs_store) takes device_lock
> +		 * first and then pci_rescan_remove_lock (via
> +		 * sriov_del_vfs), creating a circular dependency.
> +		 *
> +		 * By unbinding first, the driver's .remove() callback
> +		 * (including any SR-IOV VF cleanup) completes before
> +		 * pci_rescan_remove_lock is acquired, ensuring both
> +		 * paths take locks in the same order.
> +		 */
> +		device_release_driver(dev);
>  		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> +	}
>  	return count;
>  }
>  static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,

This looks good to me and this use of kill_device() seems to match
pretty well with the comment in kill_device() as setting it on tearing
things down. Thank you for working on this rats nest of PCI
rescan/remove lock issues!

Feel free to add my

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

