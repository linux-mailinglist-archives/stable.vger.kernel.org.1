Return-Path: <stable+bounces-225257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOP/Dt68s2nEaQAAu9opvQ
	(envelope-from <stable+bounces-225257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A033B27ECD8
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D9113042086
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BC342514;
	Fri, 13 Mar 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKEp4ZvE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6B3328FD
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773386873; cv=none; b=dSKHkzZVjYBvEK4juALnso/nZ+PjYd2wKK8WVRdDwOvFf/YCDc2od9g8PcOJgiNddsc8eUvj6RWNiFJs6LCWyDgQYvFKy+rLGzHyp/ErASxtCbBmQiIlI98T8eQItQyYCBq1v1UaTFg8X2OhbJkhpjifYZKZEKI431nKzCTcmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773386873; c=relaxed/simple;
	bh=Y36BQKdzYx7j5Xx3K2fT8g56hmoTj/rLA+PxSqd/D54=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rDa8iHMStT1SeUG7H/2chalCBNfUOU8UoJKgp58oSSM7fHkwjEJr2vAyFq7e2yNny5f+kSvoQWrOluIP7U9+3j80PUv7trxWP5vvCmtlOQfVCiUWP/M6eJ1CW7f01Vt8SB9FMy9+bGmilJzYeTTg1/NevaZBaL4bAjN4FTpXpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKEp4ZvE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D4Xw982581620;
	Fri, 13 Mar 2026 07:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iAenRQ
	tYFFXZgQjstRc4Jy6sCLPp0tS71T2Ij/xkLAI=; b=qKEp4ZvEBqxRVikttbrntF
	WWQ203Lua+crG05r6VAtBa0/bkbghmmMFp7CSi/eBIF8c/7Umd/HOwFvOAsO3Bwk
	aOBgWBWDw8W+mnEpWmbvnXwY/B07gZFUhhEy0+PmOo4+nhj+vNUP2Mww72hck3CU
	oIrRFe39/axbwiM28eqxsn3HpLE/8mBQrBshD4Tns0yNyBzWAojtrHyDUdOYkUj+
	NRjFuEzjs+AXjzld4+GB4tMgSyZ0r067coC5jcB34vhdrtLl2fEmeMG6fd/YxZKQ
	KospVEVdZE7lQq3MtjpUTVu5IsJIFKd+oBdxAUl4XWHZdZKnA66Bjj0g4dlyCX3A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh94xn7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:23:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D4u7OK025674;
	Fri, 13 Mar 2026 07:23:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8dnmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:23:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D7Ncwu19268138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 07:23:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CABA158043;
	Fri, 13 Mar 2026 07:23:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 098B658053;
	Fri, 13 Mar 2026 07:23:35 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.241.43])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Mar 2026 07:23:34 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] powerpc/xive: fix kmemleak caused by incorrect chip_data
 lookup
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <878qbw5lfb.fsf@yellow.woof>
Date: Fri, 13 Mar 2026 12:53:22 +0530
Cc: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, maz@kernel.org,
        ritesh.list@gmail.com, gautam@linux.ibm.com, stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3269117-075D-481E-AFD2-D4AE703C8EF2@linux.ibm.com>
References: <20260311134336.326996-1-nilay@linux.ibm.com>
 <878qbw5lfb.fsf@yellow.woof>
To: Nam Cao <namcao@linutronix.de>, Nilay Shroff <nilay@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b3bb7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=f1nbpkWOvNJN98Hr3BgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NSBTYWx0ZWRfX0c3fQme1dENq
 YrcBizyhRLpCW5TXMdEUMGtZCAd9tj8u3CjW/vv3XNMk2GVeRKHtghkuIrkPC+f96aOZuAh6wCR
 icjsi8tZxP7ukmc41XkSvTh6XFTDAC7KKrFu25zAPV/fyBA6gsm0VKVBGf/18PlyAgQXTtFg09G
 wIxHEB28IsFfkks5xSgRiW4tKANX4e4CP7eRPbJwCRU/pg99fU21rNkl76VfUviZXB8DowGAxNz
 QdMsL/NuvDZVF7Aw2qQKSrUyyK5r+C6AGLCv1t4b+b84crTyItAs+SIB05vgORtCICvdz40r0wd
 SEJdhTR4LelqdVGNV0Kzqe16hy02Moavo2G7e0A2Ku1nOdfnAG1t5w1mK1uSixqMmwIkn+5L7do
 UWKBfTcw9KnEji5dAb/Bcxu5BWT2W1c7gLj3dzg/tFgFDs1o6csR3OTgexE1P+pRBcpKr+FYvqw
 Qdf00CbosAV6Lwf8avA==
X-Proofpoint-ORIG-GUID: VcDjfrF1Vbhv5Eu-Xo1_Va33LsTkOq-G
X-Proofpoint-GUID: 7GB6S0IcmAyA1Q_LC7OwYbR91m6gc0ab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130055
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225257-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,ellerman.id.au,gmail.com,csgroup.eu,linutronix.de,kernel.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A033B27ECD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On 13 Mar 2026, at 11:18=E2=80=AFAM, Nam Cao <namcao@linutronix.de> =
wrote:
>=20
> Nilay Shroff <nilay@linux.ibm.com> writes:
>> The kmemleak reports the following memory leak:
> ...
>> Fix this by retrieving the irq_data from the correct domain using
>> irq_domain_get_irq_data() and then accessing the chip_data via
>> irq_data_get_irq_chip_data().
>>=20
>> Cc: stable@vger.kernel.org
>> Fixes: cc0cc23babc9 ("powerpc/xive: Untangle xive from child =
interrupt controller drivers")
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Hi,


I have tested this patch, and it fixes the reported kmemleak issue.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Below is the kmemleak output without this patch applied:

cat /sys/kernel/debug/kmemleak
unreferenced object 0xc00000000606fc80 (size 64):
  comm "kworker/0:1", pid 11, jiffies 4294937450
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 ab 0d 00 04 00 00  ................
    00 00 a1 80 00 00 0a c0 00 00 aa 0d 00 04 00 00  ................
  backtrace (crc 642b8a1d):
    __kmalloc_cache_noprof+0x350/0x7a4
    xive_irq_alloc_data.constprop.0+0x40/0xe0
    xive_irq_domain_alloc+0xd4/0x1ac
    irq_domain_alloc_irqs_parent+0x44/0x6c
    pseries_irq_domain_alloc+0x1c4/0x34c
    irq_domain_alloc_irqs_parent+0x44/0x6c
    msi_domain_alloc+0xb0/0x214
    irq_domain_alloc_irqs_locked+0x138/0x4d0
    __irq_domain_alloc_irqs+0x8c/0xfc
    __msi_domain_alloc_irqs+0x214/0x4c8
    msi_domain_alloc_irqs_all_locked+0x70/0xf8
    pci_msi_setup_msi_irqs+0x60/0x78
    msix_setup_interrupts+0x17c/0x318
    __pci_enable_msix_range+0x41c/0x770
    pci_alloc_irq_vectors_affinity+0x170/0x1d8
    nvme_pci_enable+0xa0/0x3b0 [nvme]

unreferenced object 0xc00000000606f900 (size 64):
  comm "kworker/0:1", pid 11, jiffies 4294937451

With the patch applied, no kmemleak reports are observed after repeated =
MSI=E2=80=91X enable/disable cycles on the NVMe controller.

Regards,
Venkat
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20


