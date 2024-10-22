Return-Path: <stable+bounces-87780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C09AB954
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E9284CD6
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82771CCB59;
	Tue, 22 Oct 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BYsfOf8E"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545A1CCECB
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634854; cv=none; b=GKJ4suObifzqNKfZFdpAeHhLl/g3H2BL6jjTjpf98f06jiBIbrsnUVIPu6MrjH/UMpOFisxngDKidqEoUEcz8ow00HADfprXxxEvkmuiO3iRQ6jSqe4YGjZTMCj702rV6QURvyZC1JGReMrFsznJRTmNg73zFAKueG43meXqa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634854; c=relaxed/simple;
	bh=KlEYC8vAlPqo3Q2DM2d4e/RuF3L2MWDXz8f07S6OqEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih6p54v2J70HG9/pfW4A3MuQ0oasNpTXn4swj5WtfkbSht/3X84S5ydjX3j0flD/eJ4ihiSr8WoPVL+t4yBKicPomH1Apd4/vln3r18S02o45wNYxFlcnFN7iggfy2aZx091Vou6E2EQF39PdcIWIodkwrqI45nlsJ3PzG2J3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=BYsfOf8E; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLYwGI028426;
	Tue, 22 Oct 2024 22:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Vy
	wH1BfnN3mlhSINt8ZDDsQDI1v+YV8gCm/U1F3m7HU=; b=BYsfOf8EjwQt+7OoKq
	v7PrdyhpUv+ebj0ZgKYH5lzCTuhebJIIEha0vKXG2+27I8ZiDaXfYYDYQd2eb5d5
	ZMcIDXsV2mTdx7SXHGSgJKlfjC5RUM4562XiCwTPjwZBqlE7mmieqYtQ7Hn9YsRd
	uxA80U/GETZiQsacQ+R0LMInc1sYvD4dsv8QWzNwRVE19ElyFlxshmOs3n2ZCyWR
	VV29ZBYPUbzfrnwpCe2pwAmlD88ltySC/G/Vg7VhGRPqfMSLuDwk2lcrxhmEvGU9
	jdCg1Zgz16GQujuduYZt17t0Ii95eEhI+y3HTqyTgXT0uhWlHvrjcIADnbTlQDie
	7Iww==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42em36rax3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 22:06:56 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2C2EFD2A4;
	Tue, 22 Oct 2024 22:06:55 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id B799C8014F6;
	Tue, 22 Oct 2024 22:06:52 +0000 (UTC)
Date: Tue, 22 Oct 2024 17:06:50 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Steve Wahl <steve.wahl@hpe.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavin Joseph <me@pavinjoseph.com>, Simon Horman <horms@verge.net.au>,
        kexec@lists.infradead.org, Eric Hagberg <ehagberg@gmail.com>,
        dave.hansen@linux.intel.com, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
X-Proofpoint-GUID: aJQdN_SsE1yVeQ3REZJbsQ1HIEdaLQtb
X-Proofpoint-ORIG-GUID: aJQdN_SsE1yVeQ3REZJbsQ1HIEdaLQtb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220143

On Tue, Oct 22, 2024 at 07:51:38PM +0100, David Woodhouse wrote:
> On Thu, 2024-03-14 at 17:25 +0800, Dave Young wrote:
> > On Thu, 14 Mar 2024 at 00:18, Steve Wahl <steve.wahl@hpe.com> wrote:
> > > 
> > > On Wed, Mar 13, 2024 at 07:16:23AM -0500, Eric W. Biederman wrote:
> > > > 
> > > > Kexec happens on identity mapped page tables.
> > > > 
> > > > The files of interest are machine_kexec_64.c and relocate_kernel_64.S
> > > > 
> > > > I suspect either the building of the identity mappged page table in
> > > > machine_kexec_prepare, or the switching to the page table in
> > > > identity_mapped in relocate_kernel_64.S is where something goes wrong.
> > > > 
> > > > Probably in kernel_ident_mapping_init as that code is directly used
> > > > to build the identity mapped page tables.
> > > > 
> > > > Hmm.
> > > > 
> > > > Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
> > > > where full GB page should be mapped.")
> > > 
> > > Yeah, sorry, I accidentally used the stable cherry-pick commit id that
> > > Pavin Joseph found with his bisect results.
> > > 
> > > > Given the simplicity of that change itself my guess is that somewhere in
> > > > the first 1Gb there are pages that needed to be mapped like the idt at 0
> > > > that are not getting mapped.
> > > 
> > > ...
> > > 
> > > > It might be worth setting up early printk on some of these systems
> > > > and seeing if the failure is in early boot up of the new kernel (that is
> > > > using kexec supplied identity mapped pages) rather than in kexec per-se.
> > > > 
> > > > But that is just my guess at the moment.
> > > 
> > > Thanks for the input.  I was thinking in terms of running out of
> > > memory somewhere because we're using more page table entries than we
> > > used to.  But you've got me thinking that maybe some necessary region
> > > is not explicitly requested to be placed in the identity map, but is
> > > by luck included in the rounding errors when we use gbpages.
> > 
> > Yes, it is possible. Here is an example case:
> > http://lists.infradead.org/pipermail/kexec/2023-June/027301.html
> > Final change was to avoid doing AMD things on Intel platform, but the
> > mapping code is still not fixed in a good way.
> 
> I spent all of Monday setting up a full GDT, IDT and exception handler
> for the relocate_kernel() environment¹, and I think these reports may
> have been the same as what I've been debugging.

David,

My original problem involved UV platform hardware catching a
speculative access into the reserved areas, that caused a BIOS HALT.
Reducing the use of gbpages in the page table kept the speculation
from hitting those areas.  I would believe this sort of thing might be
uniqe to the UV platform.

The regression reports I got from Pavin and others were due to my
original patch trimming down the page tables to the point where they
didn't include some memory that was actually referenced, not processor
speculation, because the regions were not explicitly included in the
creation of the kexec page map.  This was fixed by explicitly
including those regions when creating the map.

Can you dump the page tables to see if the address you're referencing
is included in those tables (or maybe you already did)?  Can you give
symbols and code around the RIP when you hit the #PF?  It looks like
this is in the region metioned as the "Control page", so it's probably
trampoline code that has been copied from somewhere else.  I'm using
my copy of perhaps different kernel source than you have, given your
exception handler modification.

Wait, I can't make sense of the dump. See more below.

What platform are you running on?  And under what conditions (is this
bare metal)? Is it really speculation that's causing your #PF?  If so,
you could cause it deterministically by, say, doing a quick checksum
on that area you're not supposed to touch (0xc142000000 -
0xC1420fffff) and see if it faults every time.  (As I said, I was
thinking faults from speculation might be unique to the UV platform.)

> We end up taking a #PF, usually on one of the 'rep mov's, one time on
> the 'pushq %r8' right before using it to 'ret' to identity_mapped. In
> each case it happens on the first *write* to a page.
> 
> Now I can print %cr2 when it happens (instead of just going straight to
> triple-fault), I spot an interesting fact about the address. It's
> always *adjacent* to a region reserved by BIOS in the e820 data, and
> within the same 2MiB page.

I'm not at all certain, but this feels like a red herring.  Be cautious.

> [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable
> 
> 
> 2024-10-22 17:09:14.291000 kern NOTICE [   58.996257] kexec: Control page at c149431000
> 2024-10-22 17:09:14.291000 Y
> 2024-10-22 17:09:14.291000 rip:000000c1494312f8
> 2024-10-22 17:09:14.291000 rsp:000000c149431f90
> 2024-10-22 17:09:14.291000 Exc:000000000000000e
> 2024-10-22 17:09:14.291000 Err:0000000080000003
> 2024-10-22 17:09:14.291000 rax:000000c142130000
> 2024-10-22 17:09:14.291000 rbx:000000010d4b8020
> 2024-10-22 17:09:14.291000 rcx:0000000000000200
> 2024-10-22 17:09:14.291000 rdx:000000000009c000
> 2024-10-22 17:09:14.291000 rsi:000000000009c000
> 2024-10-22 17:09:14.291000 rdi:000000c142130000
> 2024-10-22 17:09:14.291000 r8 :000000c149431000
> 2024-10-22 17:09:14.291000 r9 :000000c149430000
> 2024-10-22 17:09:14.291000 r10:000000010d4bc000
> 2024-10-22 17:09:14.291000 r11:0000000000000000
> 2024-10-22 17:09:14.291000 r12:0000000000000000
> 2024-10-22 17:09:14.291000 r13:0000000000770ef0
> 2024-10-22 17:09:14.291000 r14:ffff8c82c0000000
> 2024-10-22 17:09:14.291000 r15:0000000000000000
> 2024-10-22 17:09:14.291000 cr2:000000c142130000
> > 
> 
> And bit 31 in the error code is set, which means it's an RMP
> violation. 

RMP is AMD SEV related, right?  I'm not familiar with SEV operation,
but I have an itchy feeling it's involved in this problem.

I am having a hard time with the RIP listed above.  Maybe your
exception handler has affected it?  My disassembly seems to show this
address should be in a sea of 0xCC / int3 bytes past the end of swap
pages.

> Looks like we set up a 2MiB page covering the whole range from
> 0xc142000000 to 0xc142200000, but we aren't allowed to touch the first
> half of that.

Is it possible that, instead, some SEV tag is hanging around (TLB not
completely cleared?) and a page that was otherwise free is causing the
problem.  Are you using SEV/SME in your system, and if you stop using
it does it go away?  (Although I have a feeling the answer is no and
I'm barking up the wrong tree.)

The target of the pages above is c1421300000.  Have you checked to
make sure that's a valid address in the page map?

> For me it happens either with or without Steve's last patch, *but*
> clearing direct_gbpages did seem to make it go away (or at least
> reduced the incident rate far below the 1-crash-in-1000-kexecs which I
> was seeing before).

I assume you're referring to the "nogbpages" kernel option?  My patch
and the nogbpages option should have the exact same pages mapped in
the page table.  The difference being my patch would still use gbpages
in places where a whole gbpage region is included in the map,
nogbpages would use 2M pages to fill out the region.  This *would*
allocate more pages to the page table, which might be shifting things
around on you.

> I think Steve's original patch was just moving things around a little
> and because it allocate more pages for page tables, just happened to
> leave pages in the offending range to be allocated for writing to, for
> the unlucky victims.
> 
> I think the patch was actually along the right lines though, although
> it needs to go all the way down to 4KiB PTEs in some cases. And it
> could probably map anything that the e820 calls 'usable RAM', rather
> than really restricting itself to precisely the ranges which it's
> requested to map. 
> 
> 
> 
> ¹ I'll post that exception handler at some point once I've tidied it
> up.

I hope this might be of some help.  Good luck, I'll pitch in any way I
can.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

