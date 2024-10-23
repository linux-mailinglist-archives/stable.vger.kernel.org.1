Return-Path: <stable+bounces-87932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093EC9ACEDD
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812531F24609
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67F1B4F3A;
	Wed, 23 Oct 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mpndXrjs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB81ACDE8
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697613; cv=none; b=AK4BfwEGR3TvQz93fF/ZgzqMMDyVSHvOuo4KGH1cnTBrFURN04HPjkjE7Eg6VTZZs/bCBoC8s6erpEbxWCAUC39oXY60KhAyTbphxaASRxUNSXXY39BvuD7L6ir2T3yCVR4jn8PYy6PMFYE6dQRpKDXI7BnMPDf7B1UIoJGzYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697613; c=relaxed/simple;
	bh=uorTuiF9382vobYzorgTe90bYXmH3UbS9HfN3R6f90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC+5MG6WOsjy6zUz11bqeC9GcWLeAOApRm22cUsoT3vJ2fu/Wl+0ZS+UFCh7tdDT3RsbGXTKU5/Ac69ZyZJCp0tFwy9p0GKId2EAnYFqFnaIj0xnLDUmZ7HGkAVDawsVRftptzmp08qZuA6sA7D2ox6GMTb/QMMVBg9+D/nFcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mpndXrjs; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8uVWI005717;
	Wed, 23 Oct 2024 15:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=xc
	Qbhgu8fXbeFvsJTSTR3kPcN/Slhdk5bjIe4ePu1HM=; b=mpndXrjsCjOfavpqY3
	R/DM8rX4Bnwv3LWTY90VHQGpfuryja9mJdZpmvSpiXlAZ4VymfMYJYkeVQpy+f4h
	XZQgZpc2Io6733nwKh0HMzoFFp0oEUJjg/1o/tnE/IiTOmIHW+PIMzbjpNHLtKdx
	K8+blo6r/xfwzbV+P7+QT8ZMiojRq6/9hf6bsK65ITqU6yQ+GfIwKcmHBFzCrI4M
	obOvNUM0sk/JpBZfNU1BbXjdn87yLBbdVd/HBQiMVLNxOvLPsGWfJr9ubDUZytWd
	VbPe0StEnRko3X1arziZgAHYkLNDyr5XtsZwAVBcL5xtE64UwsjPCSBl8rAusWOM
	K4Hg==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 42ex2xksr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:33:07 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id EDAE11376D;
	Wed, 23 Oct 2024 15:33:05 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 99B3A813358;
	Wed, 23 Oct 2024 15:33:00 +0000 (UTC)
Date: Wed, 23 Oct 2024 10:32:57 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <Ashish.Kalra@amd.com>, Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavin Joseph <me@pavinjoseph.com>, Simon Horman <horms@verge.net.au>,
        kexec@lists.infradead.org, Eric Hagberg <ehagberg@gmail.com>,
        dave.hansen@linux.intel.com, regressions@lists.linux.dev,
        stable@vger.kernel.org
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Message-ID: <ZxkXKcjfjFGLo_-u@swahl-home.5wahls.com>
References: <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
 <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com>
 <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
 <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
 <af634055643bd814e2204f61132610778d5ef5e5.camel@infradead.org>
 <Zxgh-hBK2FfhHJ9R@swahl-home.5wahls.com>
 <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e373dcbdd15d717898cfe8ebde74191b5f3acc4c.camel@infradead.org>
X-Proofpoint-GUID: nfjT2jtLv3okAx9NiY-flTXHvvWa-2G-
X-Proofpoint-ORIG-GUID: nfjT2jtLv3okAx9NiY-flTXHvvWa-2G-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230095

On Wed, Oct 23, 2024 at 08:39:40AM +0100, David Woodhouse wrote:
> On Tue, 2024-10-22 at 17:06 -0500, Steve Wahl wrote:
> > On Tue, Oct 22, 2024 at 07:51:38PM +0100, David Woodhouse wrote:
> > > I spent all of Monday setting up a full GDT, IDT and exception handler
> > > for the relocate_kernel() environment¹, and I think these reports may
> > > have been the same as what I've been debugging.
> > 
> > David,
> > 
> > My original problem involved UV platform hardware catching a
> > speculative access into the reserved areas, that caused a BIOS HALT.
> > Reducing the use of gbpages in the page table kept the speculation
> > from hitting those areas.  I would believe this sort of thing might be
> > uniqe to the UV platform.
> > 
> > The regression reports I got from Pavin and others were due to my
> > original patch trimming down the page tables to the point where they
> > didn't include some memory that was actually referenced, not processor
> > speculation, because the regions were not explicitly included in the
> > creation of the kexec page map.  This was fixed by explicitly
> > including those regions when creating the map.
> 
> Hm, I didn't see that part of the discussion. I saw that such was a
> theory, but haven't seen specific confirmation and fixes. And your
> original patch was reverted and still not reapplied, AFAICT.

It has been reapplied.  I think the cover letter explains the whole thing.

https://lore.kernel.org/all/20240717213121.3064030-1-steve.wahl@hpe.com/

> I did note that the victims all seemed to be using AMD CPUs, so it
> seemed likely that at least *some* of them were suffering the same
> problem that I've found.
> 
> Do you have references please? 
> 
> If anyone is still seeing such problems either with or without your
> patch, they can run with my exception handler and get an actual dump
> instead of a triple-fault.
> 
> (I'm also pushing CPU vendors to give us information from the triple-
> fault through the machine check architecture. It's awful having to do
> this blind. For VMs, I also had plans to register a crashdump kernel
> entry point with the hypervisor, so that on a triple fault the
> *hypervisor* could jump state of all the vCPUs to the configured
> location, then restart one CPU in the crash kernel for it to do its own
> dump). 
> 
> > Can you dump the page tables to see if the address you're referencing
> > is included in those tables (or maybe you already did)?  Can you give
> > symbols and code around the RIP when you hit the #PF?  It looks like
> > this is in the region metioned as the "Control page", so it's probably
> > trampoline code that has been copied from somewhere else.  I'm using
> > my copy of perhaps different kernel source than you have, given your
> > exception handler modification.
> > 
> > Wait, I can't make sense of the dump. See more below.
> > 
> > What platform are you running on?  And under what conditions (is this
> > bare metal)? Is it really speculation that's causing your #PF?  If so,
> > you could cause it deterministically by, say, doing a quick checksum
> > on that area you're not supposed to touch (0xc142000000 -
> > 0xC1420fffff) and see if it faults every time.  (As I said, I was
> > thinking faults from speculation might be unique to the UV platform.)
> 
> Yes, it's bare metal. AMD Genoa. No, it's not speculation. It's because
> we have a single 2MiB page which covers *both* the RMP table (1MiB
> reserved by BIOS in e820 as I showed), and a page that was allocated
> for the kimage. If I understand correctly, the hardware raises that
> fault (with bit 31 in the error code) when refusing to populate that
> TLB entry for writing.
> 
> According to the AMD manual we're allowed to *read* but not write.

Ah, I get it, thanks for the explanation.

That "feature" of not allowing a writable TLB entry to span reserved
and non-reserved areas is quite a departure from what has previously
been allowed in x86_64, if you asked me.  But nobody did ask me, nor
should they have.  :-)

> > > We end up taking a #PF, usually on one of the 'rep mov's, one time on
> > > the 'pushq %r8' right before using it to 'ret' to identity_mapped. In
> > > each case it happens on the first *write* to a page.
> > > 
> > > Now I can print %cr2 when it happens (instead of just going straight to
> > > triple-fault), I spot an interesting fact about the address. It's
> > > always *adjacent* to a region reserved by BIOS in the e820 data, and
> > > within the same 2MiB page.
> > 
> > I'm not at all certain, but this feels like a red herring.  Be cautious.
> 
> It wouldn't be our first in this journey, but I'm actually fairly
> confident this time. :)
> 
> > > [    0.000000] BIOS-e820: [mem 0x000000bfbe000000-0x000000c1420fffff] reserved
> > > [    0.000000] BIOS-e820: [mem 0x000000c142100000-0x000000fc7fffffff] usable
> > > 
> > > 
> > > 2024-10-22 17:09:14.291000 kern NOTICE [   58.996257] kexec: Control page at c149431000
> > > 2024-10-22 17:09:14.291000 Y
> > > 2024-10-22 17:09:14.291000 rip:000000c1494312f8
> > > 2024-10-22 17:09:14.291000 rsp:000000c149431f90
> > > 2024-10-22 17:09:14.291000 Exc:000000000000000e
> > > 2024-10-22 17:09:14.291000 Err:0000000080000003
> > > 2024-10-22 17:09:14.291000 rax:000000c142130000
> > > 2024-10-22 17:09:14.291000 rbx:000000010d4b8020
> > > 2024-10-22 17:09:14.291000 rcx:0000000000000200
> > > 2024-10-22 17:09:14.291000 rdx:000000000009c000
> > > 2024-10-22 17:09:14.291000 rsi:000000000009c000
> > > 2024-10-22 17:09:14.291000 rdi:000000c142130000
> > > 2024-10-22 17:09:14.291000 r8 :000000c149431000
> > > 2024-10-22 17:09:14.291000 r9 :000000c149430000
> > > 2024-10-22 17:09:14.291000 r10:000000010d4bc000
> > > 2024-10-22 17:09:14.291000 r11:0000000000000000
> > > 2024-10-22 17:09:14.291000 r12:0000000000000000
> > > 2024-10-22 17:09:14.291000 r13:0000000000770ef0
> > > 2024-10-22 17:09:14.291000 r14:ffff8c82c0000000
> > > 2024-10-22 17:09:14.291000 r15:0000000000000000
> > > 2024-10-22 17:09:14.291000 cr2:000000c142130000
> > > > 
> > > 
> > > And bit 31 in the error code is set, which means it's an RMP
> > > violation. 
> > 
> > RMP is AMD SEV related, right?  I'm not familiar with SEV operation,
> > but I have an itchy feeling it's involved in this problem.
> > 
> > I am having a hard time with the RIP listed above.  Maybe your
> > exception handler has affected it?  My disassembly seems to show this
> > address should be in a sea of 0xCC / int3 bytes past the end of swap
> > pages.
> 
> You'd have to have access to my kernel binary to have a hope of knowing
> that, surely? I don't think I checked that particular one, but it's
> normally one of the 'rep mov's in relocate_kernel_64.S.

It all depends on how much your kernel source differs from mine,
actually.  The above info includes the address of the control page,
and that's where the code from relocate_kernel_64.S gets copied to.

The RIP of c1494312f8 is 2f8 into the control page; after
machine_kexec_64.c copies the relocate kernel code there, that address
should represent <relocate_kernel> + 0x2f8.  This code comes from
assembly source code, not very compiler dependent.  And there's not
even a lot of kernel config dependent macros in there.

I'm thinking the reason yours differs from mine is probably debug you
added (your exception handler maybe).

It was way back yesterday, but I think I reasoned since rcx was 512, rax ==
rdi, and rdx == rsi, we're probably at the "middle" rep ; movsq line,
under the comment "copy destination page to source page".  But RIP did
not make sense.

> > > Looks like we set up a 2MiB page covering the whole range from
> > > 0xc142000000 to 0xc142200000, but we aren't allowed to touch the first
> > > half of that.
> > 
> > Is it possible that, instead, some SEV tag is hanging around (TLB not
> > completely cleared?) and a page that was otherwise free is causing the
> > problem.  Are you using SEV/SME in your system, and if you stop using
> > it does it go away?  (Although I have a feeling the answer is no and
> > I'm barking up the wrong tree.)
> > 
> > The target of the pages above is c1421300000.  Have you checked to
> > make sure that's a valid address in the page map?
> 
> Yeah, we dumped the page tables and it's present.
> 
> > > For me it happens either with or without Steve's last patch, *but*
> > > clearing direct_gbpages did seem to make it go away (or at least
> > > reduced the incident rate far below the 1-crash-in-1000-kexecs which I
> > > was seeing before).
> > 
> > I assume you're referring to the "nogbpages" kernel option?  
> 
> Nah, I just commented out the lines in init_pgtable() which set
> info.direct_gbpages=true.

Ack.

> 
> > My patch
> > and the nogbpages option should have the exact same pages mapped in
> > the page table.  The difference being my patch would still use gbpages
> > in places where a whole gbpage region is included in the map,
> > nogbpages would use 2M pages to fill out the region.  This *would*
> > allocate more pages to the page table, which might be shifting things
> > around on you.
> 
> Right. In fact the first trigger for this, in our case, was an
> innocuous change to the NMI watchdog period — which sent us on a *long*
> wild goose chase based on the assumption that it was a stray perf NMI
> causing the triple-faults, when in fact that was just shifting things
> around on us too, and causing pages in that dangerous 1MiB to be chosen
> for the kimage.
> 
> > > I think Steve's original patch was just moving things around a little
> > > and because it allocate more pages for page tables, just happened to
> > > leave pages in the offending range to be allocated for writing to, for
> > > the unlucky victims.
> > > 
> > > I think the patch was actually along the right lines though, although
> > > it needs to go all the way down to 4KiB PTEs in some cases. And it
> > > could probably map anything that the e820 calls 'usable RAM', rather
> > > than really restricting itself to precisely the ranges which it's
> > > requested to map. 
> > > 
> > > 
> > > 
> > > ¹ I'll post that exception handler at some point once I've tidied it
> > > up.
> > 
> > I hope this might be of some help.  Good luck, I'll pitch in any way I
> > can.
> 
> Thanks.

Sounds like the rest of the community have got you much further than
I have!

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

