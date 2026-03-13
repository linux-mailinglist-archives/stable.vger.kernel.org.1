Return-Path: <stable+bounces-225250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDV3LKOjs2k4ZQAAu9opvQ
	(envelope-from <stable+bounces-225250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1427D7A5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A85230584E4
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414631716F;
	Fri, 13 Mar 2026 05:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S9/cLiAI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C473148A6
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380504; cv=none; b=dv1tM3HGZVH6VxFkyNR7LXceLIUftroUyjDc2ehysgsjeFjwvMTLdvSFMnSooeHmQ8NKbgUCEe1JB91oW1g7Tco0ggn8ey9Qs6C5r7pUW7kJfHwsTKuDRArmXAChFqSbK3XixmmFfcEmZIqO/xDGh4urbCE//bRR78io2ouBtik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380504; c=relaxed/simple;
	bh=/ikYfKU4tl0ZZh8Y950yOU14Ams80eGEjTAvYzQrKtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TuBD0fDMNOo0Y97pv+djsR1n3HBy6XdaBz9JEf5EM3Je87vwKSTpUL9HcbRbmO+9XnseOXw4tO6kzn/4kb5zminJ/Im+h8X/hE2mPL2p+969SEr82ZLS/9Ve8qS8BsATjG2SVeSbzXuQXeJJDka4nSmjC3rZbBr5hMnsfeAR/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S9/cLiAI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEA2NI2303382;
	Fri, 13 Mar 2026 05:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LipRsW
	D9Akfezt5RfXCY4x0iEHhZC4fSycBnykKn/fo=; b=S9/cLiAIodcQk5rN/Tl7wi
	hO4yqz1Cfnrjj6HB8TFUKvkyhw8NtaHeLGEcUS2Itg/FK9CYAy+DIHW8ZiMJ8YcW
	hKzZ1EW/iXzN8qMDBq4kwEbpJEUej7W80jECUnUbhEgYCwRTzs8C1fb3XzpePOgh
	KUnI4J7iPEwKY5Gn7cDNPXnFWy25ET1NuXoHYrFkW2Y4wosSmMRNtUYMDu89nAbk
	fF+qbSWkMVOl8xa+PcfKjOuG7tmJspwF3lTWVzvG4jSIPtCJl80g+9BX4h8x3d0O
	JMHr8Lvv3mU1BVKVHzstnvWWbPHgt+MHJN4jcxIeGU+hw0mXDVN4mFyJ8BY+2ZrA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95x1t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 05:41:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D5Farx018398;
	Fri, 13 Mar 2026 05:41:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha85cue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 05:41:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D5fSVb2425400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 05:41:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1A5558053;
	Fri, 13 Mar 2026 05:41:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DC115805F;
	Fri, 13 Mar 2026 05:41:25 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.43])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 05:41:24 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] powerpc/iommu: fix lockdep warning during PCI enumeration
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260310082129.3630996-1-nilay@linux.ibm.com>
Date: Fri, 13 Mar 2026 11:11:12 +0530
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, nicolinc@nvidia.com,
        joerg.roedel@amd.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, maddy@linux.ibm.com, sbhat@linux.ibm.com,
        stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F038208-0573-42A3-920B-1A74646E8F8F@linux.ibm.com>
References: <20260310082129.3630996-1-nilay@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA0MiBTYWx0ZWRfX75eeEMrDXGsv
 eZZW2iZLV2POyXAESjIGAT/Ncx0jlOGvzB7qNLeOhn+cYayj04YL+n94YG/3t9jObKghvFWvmMx
 zbOu9sC8euaPsMvmCEeFokUjMUTMUBn/qwMvRlVrWMqIdQhluoOPCFbfB1JNUi6f49W7Hk5/ea8
 8IG52NQEWodbI8KAWkK6m6CSOrGAmjweBvzuqLBcusvbTjlBQY9pPpFUzlTwe1/Jvx/BJIhZJdI
 T2aeAPuII4xcUP/CfjGIpnXwRDx4M0LpZp/v2PrNYUeYWdhMT+FOkh75uslXx7I54KDbB4MxBqQ
 n47XJcxaSvTu5CI8XgH3ML9sCNPLHMa/hWC1MP32o2Vs9W4WYKsTATZGMT5pNdRsbAs2xv5nzQX
 s79SuqPXLRksvpvdcNQXEMESulEOh0Lflce8UX7RMSil+x9IP71K9rZIUhhd51HaypNZNwLbbZc
 gksLWR4u6auwbDGt/Wg==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b3a38a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=9Wz3lNwHXGX-eYGAIucA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sr9DuORW7GXMJevgU0qZ2ycY8Nx_Bo4T
X-Proofpoint-ORIG-GUID: Sr9DuORW7GXMJevgU0qZ2ycY8Nx_Bo4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130042
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-225250-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2AA1427D7A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 10 Mar 2026, at 1:51=E2=80=AFPM, Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>=20
> Commit a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev()
> helper") introduced iommu_driver_get_domain_for_dev() for driver
> code paths that hold iommu_group->mutex while attaching a device
> to an IOMMU domain.
>=20
> The same commit also added a lockdep assertion in
> iommu_get_domain_for_dev() to ensure that callers do not hold
> iommu_group->mutex when invoking it.
>=20
> On powerpc platforms, when PCI device ownership is switched from
> BLOCKED to the PLATFORM domain, the attach callback
> spapr_tce_platform_iommu_attach_dev() still calls
> iommu_get_domain_for_dev(). This happens while iommu_group->mutex
> is held during domain switching, which triggers the lockdep warning
> below during PCI enumeration:
>=20
> WARNING: drivers/iommu/iommu.c:2252 at =
iommu_get_domain_for_dev+0x38/0x80, CPU#2: swapper/0/1
> Modules linked in:
> CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc2+ #35 =
PREEMPT
> Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 =
of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries
> NIP:  c000000000c244c4 LR: c00000000005b5a4 CTR: c00000000005b578
> REGS: c00000000a7bf280 TRAP: 0700   Not tainted  (7.0.0-rc2+)
> MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22004422  XER: =
0000000a
> CFAR: c000000000c24508 IRQMASK: 0
> GPR00: c00000000005b5a4 c00000000a7bf520 c000000001dc8100 =
0000000000000001
> GPR04: c00000000f972f10 0000000000000000 0000000000000000 =
0000000000000001
> GPR08: 0000001ffbc60000 0000000000000001 0000000000000000 =
0000000000000000
> GPR12: c00000000005b578 c000001fffffe480 c000000000011618 =
0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
> GPR20: ffffffffffffefff 0000000000000000 c000000002d30eb0 =
0000000000000001
> GPR24: c0000000017881f8 0000000000000000 0000000000000001 =
c00000000f972e00
> GPR28: c00000000bbba0d0 0000000000000000 c00000000bbba0d0 =
c00000000f972e00
> NIP [c000000000c244c4] iommu_get_domain_for_dev+0x38/0x80
> LR [c00000000005b5a4] spapr_tce_platform_iommu_attach_dev+0x2c/0x98
> Call Trace:
> iommu_get_domain_for_dev+0x68/0x80 (unreliable)
> spapr_tce_platform_iommu_attach_dev+0x2c/0x98
> __iommu_attach_device+0x44/0x220
> __iommu_device_set_domain+0xf4/0x194
> __iommu_group_set_domain_internal+0xec/0x228
> iommu_setup_default_domain+0x5f4/0x6a4
> __iommu_probe_device+0x674/0x724
> iommu_probe_device+0x50/0xb4
> iommu_add_device+0x48/0x198
> pci_dma_dev_setup_pSeriesLP+0x198/0x4f0
> pcibios_bus_add_device+0x80/0x464
> pci_bus_add_device+0x40/0x100
> pci_bus_add_devices+0x54/0xb0
> pcibios_init+0xd8/0x140
> do_one_initcall+0x8c/0x598
> kernel_init_freeable+0x3ec/0x850
> kernel_init+0x34/0x270
> ret_from_kernel_user_thread+0x14/0x1c
>=20
> Fix this by using iommu_driver_get_domain_for_dev() instead of
> iommu_get_domain_for_dev() in spapr_tce_platform_iommu_attach_dev(),
> which is the appropriate helper for callers holding the group mutex.
>=20
> Cc: stable@vger.kernel.org
> Fixes: a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev() =
helper")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

This patch fixes the reported issue. No warning is seen, during PICe =
init.

Logs:

[    0.107228] EDAC MC: Ver: 3.0.0
[    0.108270] NetLabel: Initializing
[    0.108274] NetLabel:  domain hash size =3D 128
[    0.108278] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.108307] NetLabel:  unlabeled traffic allowed by default
[    0.108362] PCI: Probing PCI hardware
[    0.108539] PCI host bridge to bus 0019:01
[    0.108545] pci_bus 0019:01: root bus resource [mem =
0x40080000000-0x400feffffff] (bus address [0x80000000-0xfeffffff])
[    0.108552] pci_bus 0019:01: root bus resource [mem =
0x44000000000-0x47fffffffff 64bit] (bus address =
[0x6204000000000-0x6207fffffffff])
[    0.108559] pci_bus 0019:01: root bus resource [bus 01-ff]
[    0.109223] pci 0019:01:00.0: No hypervisor support for SR-IOV on =
this device, IOV BARs disabled.
[    0.123390] IOMMU table initialized, virtual merging enabled
[    0.123522] pci_bus 0019:01: resource 4 [mem =
0x40080000000-0x400feffffff]
[    0.123528] pci_bus 0019:01: resource 5 [mem =
0x44000000000-0x47fffffffff 64bit]
[    0.123589] pci 0019:01:00.0: ibm,query-pe-dma-windows(53) 10000 =
8000000 20000019 returned 0, lb=3D1000000 ps=3D103 wn=3D1
[    0.123628] pci 0019:01:00.0: Adding to iommu group 0
[    0.136163] EEH: Capable adapter found: recovery enabled.
[    0.136393] vgaarb: loaded
[    0.136708] clocksource: Switched to clocksource timebase
[    0.139813] VFS: Disk quotas dquot_6.6.0
[    0.139895] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 =
bytes)
[    0.147370] NET: Registered PF_INET protocol family
[    0.147545] IP idents hash table entries: 262144 (order: 5, 2097152 =
bytes, linear)

Regards,
Venkat.
> arch/powerpc/kernel/iommu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 0ce71310b7d9..d122e8447831 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1159,7 +1159,7 @@ spapr_tce_platform_iommu_attach_dev(struct =
iommu_domain *platform_domain,
>    struct device *dev,
>    struct iommu_domain *old)
> {
> - struct iommu_domain *domain =3D iommu_get_domain_for_dev(dev);
> + struct iommu_domain *domain =3D =
iommu_driver_get_domain_for_dev(dev);
> struct iommu_table_group *table_group;
> struct iommu_group *grp;
>=20
> --=20
> 2.53.0
>=20
>=20


