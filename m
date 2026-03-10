Return-Path: <stable+bounces-224552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFIlHBZ2sGnJjQIAu9opvQ
	(envelope-from <stable+bounces-224552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:50:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B2E25726F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 20:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB71300D56F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 19:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF843359A86;
	Tue, 10 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FFad6Zaa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156283542CF
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172240; cv=none; b=VVXPJf0hz6f5OTwWgglgh73CT6YK/zXdbr8eylGl9u66k+QAHRWseyXx2lly3VVaDWoqfSylIeUEL10dWopbzehsav1lmthDZvJLn7XFYlzlZz27xzmudmPVc8KfUKNlTKw+lBVjbqDbMpYIhPfowz5OaGpK92lOqBHKtO+186c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172240; c=relaxed/simple;
	bh=PhgvFW0FCNZDACvek/Idg0RRJb/ysBDl0R65d16Qec0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uI7EVRtNqe1sdQuREyV1kzw+gm6+t8EIBA6mrH7kYEr15/Tv99VrAEKsLKZLgGXcOYtELmttOTXfs09He0tkiweZ+VAmtloccqwLioohoxRDniiBN/vNMTcT+3Y+WETWh/fwllR+f9Qogz2VSf2ZvlukX7X1jAapgBELim36i1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FFad6Zaa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7pqJ01274613;
	Tue, 10 Mar 2026 19:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WUcIp7
	+mO8b13f806YFpg6NESmLIKC2aAqShvpeTbGA=; b=FFad6Zaa9/39gRw8Pok5cd
	SFwt5G1tGUBikUfjDkCqrnllqMi9+IVa9wRdngK0D2sdvp2A6d0TgoEjJS+mLjQ9
	Eax4d8dt/uoecvbxjJZYLHPq517smnweE0mrOe/vpbKeH5m7qlCnKUdxa93ocQ7i
	RE4y5+Dl/i9YiixGWfx/gvIkJUV2Bhpdrg2pMNcB9JuGnJGWT1exLa7GV3C0RFzy
	wl/fOydqn3ct+/xNrs8kZndxT1WnwJpNN+kHWCTXRuJ/XygKiWZ0fBKONJwPUj5L
	PKDid+IAJOqpmbd2j3bEYrZFO+ZrpUngNvPOfbDFBscEz3f/DEK2Ia4P/bPWvKaA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuycp5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 19:50:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AIofjC029279;
	Tue, 10 Mar 2026 19:50:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uq7yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 19:50:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AJoNL329688110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 19:50:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A47642006A;
	Tue, 10 Mar 2026 19:50:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EAD220063;
	Tue, 10 Mar 2026 19:50:17 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.43.31.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 19:50:17 +0000 (GMT)
Message-ID: <fb35efc3c4e99851a626fc7a50ab7e724a907657.camel@linux.ibm.com>
Subject: Re: [PATCH v2] mm/kasan: Fix double free for kasan pXds
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander
 Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov	 <dvyukov@google.com>,
        Vincenzo Frascino
 <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
        Venkat Rao Bagalkote	 <venkat88@linux.ibm.com>
Date: Wed, 11 Mar 2026 01:20:15 +0530
In-Reply-To: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
References: 
	<2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b07603 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=lCLeCSViw0VO-R2WqsAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE3MCBTYWx0ZWRfX5mKNdB8jpVIM
 HH2D8geckdOpRKMUqzB9uY88oIomG+UsRkbZ5xE69APmrPmSNffqKckvRrFhwvRAVJr+7vHah90
 JImqY/W2G6ry2pYAgOPPFfsVjDZBooKZxLkRnI/oFjpR+o9rdeSg1TNOpg4Xojc749DZ7jM+DHd
 XSQr3FegPRfI27vnViK514+MNzy1QGh9Dyy7Bdq2YJuS+byDx0tojMrNsMQehzCaEPvOJ+R7fUN
 kEywNGY91pzPK1NI/EL3b65Pq7LCJCGLcHswIm88KQe10ZNfud1ouaJ+VLXOLbHUWs8RaeZShEB
 uohCRlxbOOEVbGybi+L5vKz1bcNKYCF425/n0hGGRzZ/c1aQZzl05rhxaZwBQole4ywip2/5rDR
 kSFr/ctCYOFOVqJgNAJWAF6aMkEashN9w7N0KRHaiEntjiFvTcriAjIOTo8OOtjVLsfRlHQFhan
 Mg+djESnuJHle7fvmGg==
X-Proofpoint-GUID: xL5Ilug5XMt6bdSaaR9b-Qn9K9Bf-VgQ
X-Proofpoint-ORIG-GUID: WrGaGUw17qMo4X9rqttbSAvd4Gqbw85u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100170
X-Rspamd-Queue-Id: 62B2E25726F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,google.com,arm.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-224552-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aboorvad@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 2026-02-24 at 18:53 +0530, Ritesh Harjani (IBM) wrote:

> kasan_free_pxd() assumes the page table is always struct page aligned.
> But that's not always the case for all architectures. E.g. In case of
> powerpc with 64K pagesize, PUD table (of size 4096) comes from slab
> cache named pgtable-2^9. Hence instead of page_to_virt(pxd_page()) let's
> just directly pass the start of the pxd table which is passed as the 1st
> argument.
>=20
> This fixes the below double free kasan issue seen with PMEM:
>=20
> radix-mmu: Mapped 0x0000047d10000000-0x0000047f90000000 with 2.00 MiB pag=
es
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: double-free in kasan_remove_zero_shadow+0x9c4/0xa20
> Free of addr c0000003c38e0000 by task ndctl/2164
>=20
> CPU: 34 UID: 0 PID: 2164 Comm: ndctl Not tainted 6.19.0-rc1-00048-gea1013=
c15392 #157 VOLUNTARY
> Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:I=
BM,FW1060.00 (NH1060_012) hv:phyp pSeries
> Call Trace:
> =C2=A0dump_stack_lvl+0x88/0xc4 (unreliable)
> =C2=A0print_report+0x214/0x63c
> =C2=A0kasan_report_invalid_free+0xe4/0x110
> =C2=A0check_slab_allocation+0x100/0x150
> =C2=A0kmem_cache_free+0x128/0x6e0
> =C2=A0kasan_remove_zero_shadow+0x9c4/0xa20
> =C2=A0memunmap_pages+0x2b8/0x5c0
> =C2=A0devm_action_release+0x54/0x70
> =C2=A0release_nodes+0xc8/0x1a0
> =C2=A0devres_release_all+0xe0/0x140
> =C2=A0device_unbind_cleanup+0x30/0x120
> =C2=A0device_release_driver_internal+0x3e4/0x450
> =C2=A0unbind_store+0xfc/0x110
> =C2=A0drv_attr_store+0x78/0xb0
> =C2=A0sysfs_kf_write+0x114/0x140
> =C2=A0kernfs_fop_write_iter+0x264/0x3f0
> =C2=A0vfs_write+0x3bc/0x7d0
> =C2=A0ksys_write+0xa4/0x190
> =C2=A0system_call_exception+0x190/0x480
> =C2=A0system_call_vectored_common+0x15c/0x2ec
> ---- interrupt: 3000 at 0x7fff93b3d3f4
> NIP:=C2=A0 00007fff93b3d3f4 LR: 00007fff93b3d3f4 CTR: 0000000000000000
> REGS: c0000003f1b07e80 TRAP: 3000=C2=A0=C2=A0 Not tainted=C2=A0 (6.19.0-r=
c1-00048-gea1013c15392)
> MSR:=C2=A0 800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>=C2=A0 CR=
: 48888208=C2=A0 XER: 00000000
> <...>
> NIP [00007fff93b3d3f4] 0x7fff93b3d3f4
> LR [00007fff93b3d3f4] 0x7fff93b3d3f4
> ---- interrupt: 3000
>=20
> =C2=A0The buggy address belongs to the object at c0000003c38e0000
> =C2=A0 which belongs to the cache pgtable-2^9 of size 4096
> =C2=A0The buggy address is located 0 bytes inside of
> =C2=A0 4096-byte region [c0000003c38e0000, c0000003c38e1000)
>=20
> =C2=A0The buggy address belongs to the physical page:
> =C2=A0page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:=
0x3c38c
> =C2=A0head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincou=
nt:0
> =C2=A0memcg:c0000003bfd63e01
> =C2=A0flags: 0x63ffff800000040(head|node=3D6|zone=3D0|lastcpupid=3D0x7fff=
f)
> =C2=A0page_type: f5(slab)
> =C2=A0raw: 063ffff800000040 c000000140058980 5deadbeef0000122 00000000000=
00000
> =C2=A0raw: 0000000000000000 0000000080200020 00000000f5000000 c0000003bfd=
63e01
> =C2=A0head: 063ffff800000040 c000000140058980 5deadbeef0000122 0000000000=
000000
> =C2=A0head: 0000000000000000 0000000080200020 00000000f5000000 c0000003bf=
d63e01
> =C2=A0head: 063ffff800000002 c00c000000f0e301 00000000ffffffff 00000000ff=
ffffff
> =C2=A0head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000=
000004
> =C2=A0page dumped because: kasan: bad access detected
>=20
> [=C2=A0 138.953636] [=C2=A0=C2=A0 T2164] Memory state around the buggy ad=
dress:
> [=C2=A0 138.953643] [=C2=A0=C2=A0 T2164]=C2=A0 c0000003c38dff00: fc fc fc=
 fc fc fc fc fc fc fc fc fc fc fc fc fc
> [=C2=A0 138.953652] [=C2=A0=C2=A0 T2164]=C2=A0 c0000003c38dff80: fc fc fc=
 fc fc fc fc fc fc fc fc fc fc fc fc fc
> [=C2=A0 138.953661] [=C2=A0=C2=A0 T2164] >c0000003c38e0000: fc fc fc fc f=
c fc fc fc fc fc fc fc fc fc fc fc
> [=C2=A0 138.953669] [=C2=A0=C2=A0 T2164]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^
> [=C2=A0 138.953675] [=C2=A0=C2=A0 T2164]=C2=A0 c0000003c38e0080: fc fc fc=
 fc fc fc fc fc fc fc fc fc fc fc fc fc
> [=C2=A0 138.953684] [=C2=A0=C2=A0 T2164]=C2=A0 c0000003c38e0100: fc fc fc=
 fc fc fc fc fc fc fc fc fc fc fc fc fc
> [=C2=A0 138.953692] [=C2=A0=C2=A0 T2164] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [=C2=A0 138.953701] [=C2=A0=C2=A0 T2164] Disabling lock debugging due to =
kernel taint
>=20
> Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work =
with KASAN")
> Cc: stable@vger.kernel.org
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>=20
> v1 -> v2:
> 1. cc'd linux-mm
> 2. Added tags (Fixes, CC, Reported).
>=20
> =C2=A0mm/kasan/init.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index f084e7a5df1e..9c880f607c6a 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -292,7 +292,7 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *p=
md)
> =C2=A0			return;
> =C2=A0	}
>=20
> -	pte_free_kernel(&init_mm, (pte_t *)page_to_virt(pmd_page(*pmd)));
> +	pte_free_kernel(&init_mm, pte_start);
> =C2=A0	pmd_clear(pmd);
> =C2=A0}
>=20
> @@ -307,7 +307,7 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *p=
ud)
> =C2=A0			return;
> =C2=A0	}
>=20
> -	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
> +	pmd_free(&init_mm, pmd_start);
> =C2=A0	pud_clear(pud);
> =C2=A0}
>=20
> @@ -322,7 +322,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p=
4d)
> =C2=A0			return;
> =C2=A0	}
>=20
> -	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
> +	pud_free(&init_mm, pud_start);
> =C2=A0	p4d_clear(p4d);
> =C2=A0}
>=20
> @@ -337,7 +337,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *p=
gd)
> =C2=A0			return;
> =C2=A0	}
>=20
> -	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
> +	p4d_free(&init_mm, p4d_start);
> =C2=A0	pgd_clear(pgd);
> =C2=A0}
>=20
> --
> 2.53.0

I observed this issue in the almost recent mainline kernel.

# ndctl create-namespace -t pmem -m fsdax -M dev -r region1 -s 10737418240
{
  "dev":"namespace1.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"9.99 GiB (10.72 GB)",
  "uuid":"..",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem1"
}

# ndctl destroy-namespace namespace1.0 --force
destroyed 1 namespace

# dmesg
...
[  940.927567] [   T3360] radix-mmu: Mapped 0x0000047d10000000-0x0000047f90=
000000 with 64.0 KiB pages
[  948.389280] [   T3382] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  948.389333] [   T3382] BUG: KASAN: double-free in kasan_remove_zero_shad=
ow+0x9c4/0xa20
[  948.389356] [   T3382] Free of addr c00000016f240000 by task ndctl/3382

[  948.389379] [   T3382] CPU: 17 UID: 0 PID: 3382 Comm: ndctl Not tainted =
7.0.0-rc2-00534-g014441d1e4b2 #3 PREEMPT(full)=20
[  948.389385] [   T3382] Hardware name: IBM,9080-HEX POWER10 (architected)=
 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
[  948.389391] [   T3382] Call Trace:
[  948.389394] [   T3382] [c00000017900f4e0] [c000000001cc0f64] dump_stack_=
lvl+0x88/0xc4 (unreliable)
[  948.389408] [   T3382] [c00000017900f510] [c000000000886470] print_repor=
t+0x228/0x658
[  948.389415] [   T3382] [c00000017900f600] [c000000000885e74] kasan_repor=
t_invalid_free+0xe4/0x110
[  948.389422] [   T3382] [c00000017900f6f0] [c0000000008844e0] check_slab_=
allocation+0x100/0x150
[  948.389428] [   T3382] [c00000017900f720] [c00000000081e980] kmem_cache_=
free+0xd0/0x650
[  948.389435] [   T3382] [c00000017900f7a0] [c000000000887264] kasan_remov=
e_zero_shadow+0x9c4/0xa20
[  948.389442] [   T3382] [c00000017900f8c0] [c0000000008fb408] memunmap_pa=
ges+0x2c8/0x5d0
[  948.389450] [   T3382] [c00000017900f9b0] [c000000001378614] devm_action=
_release+0x54/0x70
[  948.389459] [   T3382] [c00000017900f9e0] [c000000001378bd8] release_nod=
es+0xd8/0x260
[  948.389465] [   T3382] [c00000017900fa60] [c00000000137c0b0] devres_rele=
ase_all+0xe0/0x140
[  948.389471] [   T3382] [c00000017900fad0] [c00000000136d824] device_unbi=
nd_cleanup+0x34/0x160
[  948.389479] [   T3382] [c00000017900fb10] [c0000000013701c4] device_rele=
ase_driver_internal+0x3e4/0x450
[  948.389485] [   T3382] [c00000017900fb70] [c00000000136b94c] unbind_stor=
e+0xfc/0x110
[  948.389491] [   T3382] [c00000017900fbb0] [c0000000013699a8] drv_attr_st=
ore+0x78/0xb0
[  948.389498] [   T3382] [c00000017900fbf0] [c000000000a70054] sysfs_kf_wr=
ite+0x134/0x160
[  948.389504] [   T3382] [c00000017900fc40] [c000000000a6bb94] kernfs_fop_=
write_iter+0x264/0x3f0
[  948.389512] [   T3382] [c00000017900fca0] [c00000000090e56c] vfs_write+0=
x3bc/0x870
[  948.389517] [   T3382] [c00000017900fd90] [c00000000090ecd4] ksys_write+=
0xa4/0x190
[  948.389523] [   T3382] [c00000017900fdf0] [c00000000003ae40] system_call=
_exception+0x190/0x500
[  948.389530] [   T3382] [c00000017900fe50] [c00000000000d05c] system_call=
_vectored_common+0x15c/0x2ec
[  948.389538] [   T3382] ---- interrupt: 3000 at 0x7fffb0d3d3f4
[  948.389547] [   T3382] NIP:  00007fffb0d3d3f4 LR: 00007fffb0d3d3f4 CTR: =
0000000000000000
[  948.389550] [   T3382] REGS: c00000017900fe80 TRAP: 3000   Not tainted  =
(7.0.0-rc2-00534-g014441d1e4b2)
[  948.389553] [   T3382] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR=
,DR,RI,LE>  CR: 48888208  XER: 00000000
[  948.389571] [   T3382] IRQMASK: 0=20
                          GPR00: 0000000000000004 00007fffd47ce6f0 00000000=
00100000 0000000000000004=20
                          GPR04: 0000000145394bec 0000000000000007 00000000=
00000000 0000000000000000=20
                          GPR08: 0000000000000030 0000000000000000 00000000=
00000000 0000000000000000=20
                          GPR12: 0000000000000000 00007fffb12508a0 00000000=
40000000 0000000000000003=20
                          GPR16: 0000000040000000 00000001453948b0 00000001=
352f6060 00000001352f0810=20
                          GPR20: 00000001352f0818 00000001453953ac 00007fff=
d47ced18 000000000000000c=20
                          GPR24: 0000000145394400 00007fffd47ce840 00000001=
453953ac 0000000145394400=20
                          GPR28: 0000000000000007 0000000000000000 00000001=
45394bec 0000000000000004=20
[  948.389618] [   T3382] NIP [00007fffb0d3d3f4] 0x7fffb0d3d3f4
[  948.389621] [   T3382] LR [00007fffb0d3d3f4] 0x7fffb0d3d3f4
[  948.389624] [   T3382] ---- interrupt: 3000

[  948.389813] [   T3382] Allocated by task 3360:
[  948.389822] [   T3382]  kasan_save_stack+0x48/0x80
[  948.389831] [   T3382]  kasan_save_track+0x2c/0x50
[  948.389841] [   T3382]  kasan_save_alloc_info+0x44/0x60
[  948.389851] [   T3382]  __kasan_slab_alloc+0x90/0xe0
[  948.389860] [   T3382]  kmem_cache_alloc_noprof+0x1b4/0x620
[  948.389869] [   T3382]  __pud_alloc+0x90/0x260
[  948.389877] [   T3382]  __map_kernel_page+0x45c/0x5c0
[  948.389887] [   T3382]  create_physical_mapping.constprop.0+0x218/0x500
[  948.389898] [   T3382]  create_section_mapping+0x20/0x60
[  948.389908] [   T3382]  arch_create_linear_mapping+0x7c/0xf0
[  948.389917] [   T3382]  arch_add_memory+0x4c/0xf0
[  948.389926] [   T3382]  memremap_pages+0x434/0xd10
[  948.389935] [   T3382]  devm_memremap_pages+0x44/0xb0
[  948.389945] [   T3382]  pmem_attach_disk+0x73c/0x990
[  948.389955] [   T3382]  nvdimm_bus_probe+0x11c/0x350
[  948.389963] [   T3382]  really_probe+0x178/0x520
[  948.389971] [   T3382]  __driver_probe_device+0x10c/0x250
[  948.389980] [   T3382]  device_driver_attach+0x94/0x160
[  948.389988] [   T3382]  bind_store+0xd8/0x160
[  948.389997] [   T3382]  drv_attr_store+0x78/0xb0
[  948.390006] [   T3382]  sysfs_kf_write+0x134/0x160
[  948.390015] [   T3382]  kernfs_fop_write_iter+0x264/0x3f0
[  948.390024] [   T3382]  vfs_write+0x3bc/0x870
[  948.390032] [   T3382]  ksys_write+0xa4/0x190
[  948.390041] [   T3382]  system_call_exception+0x190/0x500
[  948.390049] [   T3382]  system_call_vectored_common+0x15c/0x2ec

[  948.390065] [   T3382] Freed by task 3382:
[  948.390071] [   T3382]  kasan_save_stack+0x48/0x80
[  948.390080] [   T3382]  kasan_save_track+0x2c/0x50
[  948.390089] [   T3382]  kasan_save_free_info+0x60/0xd0
[  948.390100] [   T3382]  __kasan_slab_free+0x78/0xc0
[  948.390110] [   T3382]  kmem_cache_free+0x104/0x650
[  948.390118] [   T3382]  remove_pagetable+0xe14/0xf90
[  948.390127] [   T3382]  radix__remove_section_mapping+0x24/0x40
[  948.390136] [   T3382]  remove_section_mapping+0x20/0x60
[  948.390147] [   T3382]  arch_remove_linear_mapping+0x5c/0xc0
[  948.390156] [   T3382]  memunmap_pages+0x28c/0x5d0
[  948.390166] [   T3382]  devm_action_release+0x54/0x70
[  948.390175] [   T3382]  release_nodes+0xd8/0x260
[  948.390183] [   T3382]  devres_release_all+0xe0/0x140
[  948.390193] [   T3382]  device_unbind_cleanup+0x34/0x160
[  948.390203] [   T3382]  device_release_driver_internal+0x3e4/0x450
[  948.390213] [   T3382]  unbind_store+0xfc/0x110
[  948.390222] [   T3382]  drv_attr_store+0x78/0xb0
[  948.390231] [   T3382]  sysfs_kf_write+0x134/0x160
[  948.390239] [   T3382]  kernfs_fop_write_iter+0x264/0x3f0
[  948.390249] [   T3382]  vfs_write+0x3bc/0x870
[  948.390257] [   T3382]  ksys_write+0xa4/0x190
[  948.390265] [   T3382]  system_call_exception+0x190/0x500
[  948.390274] [   T3382]  system_call_vectored_common+0x15c/0x2ec

[  948.390289] [   T3382] The buggy address belongs to the object at c00000=
016f240000
                           which belongs to the cache pgtable-2^9 of size 4=
096
[  948.390302] [   T3382] The buggy address is located 0 bytes inside of
                           4096-byte region [c00000016f240000, c00000016f24=
1000)

[  948.390320] [   T3382] The buggy address belongs to the physical page:
[  948.390330] [   T3382] page: refcount:0 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x16f20
[  948.390341] [   T3382] head: order:3 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
[  948.390351] [   T3382] memcg:c00000017383e601
[  948.390357] [   T3382] flags: 0x13ffff800000040(head|node=3D1|zone=3D0|l=
astcpupid=3D0x7ffff)
[  948.390371] [   T3382] page_type: f5(slab)
[  948.390381] [   T3382] raw: 013ffff800000040 c00000000601a580 c00c000000=
646a10 c00c000000648210
[  948.390392] [   T3382] raw: 0000000000000000 00000008002a002a 00000000f5=
000000 c00000017383e601
[  948.390402] [   T3382] head: 013ffff800000040 c00000000601a580 c00c00000=
0646a10 c00c000000648210
[  948.390413] [   T3382] head: 0000000000000000 00000008002a002a 00000000f=
5000000 c00000017383e601
[  948.390423] [   T3382] head: 013ffff800000003 c00c0000005bc801 00000000f=
fffffff 00000000ffffffff
[  948.390432] [   T3382] head: ffffffffffffffff 0000000000000000 00000000f=
fffffff 0000000000000008
[  948.390441] [   T3382] page dumped because: kasan: bad access detected

[  948.390453] [   T3382] Memory state around the buggy address:
[  948.390461] [   T3382]  c00000016f23ff00: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[  948.390470] [   T3382]  c00000016f23ff80: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[  948.390479] [   T3382] >c00000016f240000: fa fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  948.390486] [   T3382]                    ^
[  948.390493] [   T3382]  c00000016f240080: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  948.390501] [   T3382]  c00000016f240100: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[  948.390510] [   T3382] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  948.390544] [   T3382] Disabling lock debugging due to kernel taint
...


With this patch I do not see the issue:

# ndctl create-namespace -t pmem -m fsdax -M dev -r region1 -s 10737418240
{
  "dev":"namespace1.0",
  "mode":"fsdax",
  "map":"dev",
  "size":"9.99 GiB (10.72 GB)",
  "uuid":"bd796a2a-f998-4e38-b399-7d414b60add3",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem1"
}

# ndctl destroy-namespace namespace1.0 --force
destroyed 1 namespace

# dmesg | grep "double-free"
..


...

So,

Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>


Thanks,
Aboorva

