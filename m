Return-Path: <stable+bounces-114859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F532A305E8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2041888D4A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479841F0E23;
	Tue, 11 Feb 2025 08:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="f5RPPhnx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiStiiN3"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6091F03F7
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262954; cv=none; b=TcNLNg81ZuxbaK00V1HeTZ7xYuCumX0eHxfcm+HwtJr1jl4PZ61fH/DAuxWuGY3A2QjC/zwMDGIsHQOtJ5gNlE18t/McdUR0tgD2HWGUug/rQdWoov8NfprASPhl39wYU6uTVdZ3uNDJa933g8o2caUx/EM8vcDTPmwLN8LhykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262954; c=relaxed/simple;
	bh=ch0v+jkqNOfpY7u6o+7J8SCdDQI8/fFlucAIDHtfkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRI/x08RmRLE9FFFQmjgubzkwi9nxjw9OH/L/kbzICtQswvo0Q+Xfk9+cwXl3FE6gzRS2dksc/Z6E7zUja5UTmAi0EskucolLzDWTcQVUKCPwoFPq77KQGRuihLSe949OwX/5fASUQmL6crBpaAeB7LeUtIztIb6C4ysWef1dQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=f5RPPhnx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiStiiN3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C9FE51380219;
	Tue, 11 Feb 2025 03:35:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 11 Feb 2025 03:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739262947; x=1739349347; bh=KQId8qcKQj
	FHfREH+tAoqHQZJJ6jv9FHz3vHy2SnGdw=; b=f5RPPhnxyC4tKUvIaN/IRj5EYT
	bHqOK+uPa01TgH75hikqS+LPsU+8BVFOec7qiys0l5um2fT32m+B1FI1mE570uVW
	2Aj5GRAz0/fZg7rJbntxQsq/6nO5FVQAXsY5t/Do+ric7dbuxpzrljakF5X5g4av
	VhfEYAFqN1hAW2IoUswrcxUCWDXidCoErHr3LDXRTKfJMs0cj0dSPKROo3+U7t3F
	lzp4UALjNxB3f41Sgc0Xdc4eWZiR8ogtl3qCv4kU9BDzXxFKXErnOmoQTgi44GGH
	awQG8WqX9lapYYqYjAFzYe4mw8kovOJbYWqL6VjmTi3Orl+nX4uTTiit5YDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739262947; x=1739349347; bh=KQId8qcKQjFHfREH+tAoqHQZJJ6jv9FHz3v
	Hy2SnGdw=; b=DiStiiN39AlbxRo+DH8h8DX5ls/C66hJwhwR0r13JcTcv0V7Sfo
	nB/UirZASQaOQv1K8qWg91Q8PEr3XFk1L8Edav1Bb7X6ksHy7KP9Jt94m81u6kIr
	a+ooM0pWvTKeslr3GX4UoCEoGOVvXz0B72RtqoCNPH34CIF4HIL/l81IZ/W92HfQ
	71jKguBsNsq41pcHHNLBbrgBFn9hPmEdOtkOhgJT7oF45mAN46zOoz2fZpBkQnOa
	aTwH9CDeeBgTr2kSBVlJYRI+6pJ6cCUzgzt+hNuXD0fAoYJgFtf4Rw34RfsbUj0+
	S1iM+9JFon1QWyYGdcoXdcGg4A5sHTkTSmQ==
X-ME-Sender: <xms:4wurZ-jMOiNw7uW7NAq8XVH9Jd_-woRJj7h-3OG3Mxj8Blj9ctQqnA>
    <xme:4wurZ_DK9zEiKnc7RsbG1Asjo-5LLA3L13UlMtmrqMqAaN764qhYa-FJbEohG5hcY
    rwoihn5T75rWA>
X-ME-Received: <xmr:4wurZ2FgdRPF7pzJMM83BzAkaYohP6zbhb54a-kcg62wE5AZpjhdE8mLIQrP5uW_dYDer3lIIwRra8CNEdShsSsczN7S7UgODlWlbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeef
    leevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
    pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    gvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjthhhohhughhhthhonhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhlvghvihhtshhksehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehsuhhrrghvvggvrdhsuhhthhhikhhulhhprghnihhtsegrmhgurdgtohhmpd
    hrtghpthhtohepghgrvhhinhhguhhosehighgrlhhirgdrtghomhdprhgtphhtthhopehm
    hhgrlhesrhgsohigrdgtohdprhgtphhtthhopehhrghohihufihuvdehgeesghhmrghilh
    drtghomhdprhgtphhtthhopehshiiisghothdoheeghehfudefvdeifhegtdehuggsgegv
    udgtfegvsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4wurZ3Sb4Pn4LdfWOPIcCMmbB7SIvB6hC7tjIbeiUts14bXZYstJhg>
    <xmx:4wurZ7wsgFMgl0ECu5bWbEUzJCdAjTxGiVUZ87bxLLS9Mxpo5KM76Q>
    <xmx:4wurZ16Q-nt9SSti_Ga2DDuA0B-naF8eH5MyiW2Ki7YM-PZH52uasQ>
    <xmx:4wurZ4x9qfTkZ-_yHK4qV4NpLG4NiTEPpGQQK2-gjFv7A7F2zqrIXA>
    <xmx:4wurZwz_wgO1RwqKBUJgVro7JqgfNzeuFzlZYxBADAEqTQuxadcK3VB5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 03:35:46 -0500 (EST)
Date: Tue, 11 Feb 2025 09:35:44 +0100
From: Greg KH <greg@kroah.com>
To: Sean Christopherson <seanjc@google.com>
Cc: James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Gavin Guo <gavinguo@igalia.com>, Michal Luczaj <mhal@rbox.co>,
	Haoyu Wu <haoyuwu254@gmail.com>,
	syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.6.y 1/2] KVM: x86: Make x2APIC ID 100% readonly
Message-ID: <2025021107-lining-gradually-ded0@gregkh>
References: <2024100123-unreached-enrage-2cb1@gregkh>
 <20250205222651.3784169-1-jthoughton@google.com>
 <20250205222651.3784169-2-jthoughton@google.com>
 <Z6qLKdvdJ0WeNx6R@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qLKdvdJ0WeNx6R@google.com>

On Mon, Feb 10, 2025 at 03:26:33PM -0800, Sean Christopherson wrote:
> On Wed, Feb 05, 2025, James Houghton wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Ignore the userspace provided x2APIC ID when fixing up APIC state for
> > KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
> > a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
> > register"), which added the fixup, didn't intend to allow userspace to
> > modify the x2APIC ID.  In fact, that commit is when KVM first started
> > treating the x2APIC ID as readonly, apparently to fix some race:
> > 
> >  static inline u32 kvm_apic_id(struct kvm_lapic *apic)
> >  {
> > -       return (kvm_lapic_get_reg(apic, APIC_ID) >> 24) & 0xff;
> > +       /* To avoid a race between apic_base and following APIC_ID update when
> > +        * switching to x2apic_mode, the x2apic mode returns initial x2apic id.
> > +        */
> > +       if (apic_x2apic_mode(apic))
> > +               return apic->vcpu->vcpu_id;
> > +
> > +       return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
> >  }
> > 
> > Furthermore, KVM doesn't support delivering interrupts to vCPUs with a
> > modified x2APIC ID, but KVM *does* return the modified value on a guest
> > RDMSR and for KVM_GET_LAPIC.  I.e. no remotely sane setup can actually
> > work with a modified x2APIC ID.
> > 
> > Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
> > calculation, which expects the LDR to align with the x2APIC ID.
> > 
> >   WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >   CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
> >   RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
> >   Call Trace:
> >    <TASK>
> >    kvm_apic_set_state+0x1cf/0x5b0 [kvm]
> >    kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
> >    kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
> >    __x64_sys_ioctl+0xb8/0xf0
> >    do_syscall_64+0x56/0x80
> >    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> >   RIP: 0033:0x7fade8b9dd6f
> > 
> > Unfortunately, the WARN can still trigger for other CPUs than the current
> > one by racing against KVM_SET_LAPIC, so remove it completely.
> > 
> > Reported-by: Michal Luczaj <mhal@rbox.co>
> > Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
> > Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
> > Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
> > Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20240802202941.344889-2-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > (cherry picked from commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071)
> 
> FWIW, for upstream LTS backports, the upstream commit information is usually place
> at the top, before the original commit's changelog begins, and the blurb explicitly
> calls out that it's an upstream commit.  I personally like this style:
> 
>   [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
> 
> as I find it easy to visually parse/separate from the original changelog.

Yes, we prefer it at the top as our tools take it that way, BUT we can
handle it in the footer down here and our tools will rewrite it to the
proper place, so it's not a big deal.

The only problem is when it's not included at all.

thanks,

greg k-h

