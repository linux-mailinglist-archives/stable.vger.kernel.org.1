Return-Path: <stable+bounces-55137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5041915E3E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 07:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2871C225B9
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 05:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF1145A1E;
	Tue, 25 Jun 2024 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="afWWjRab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAUL2sbb"
X-Original-To: stable@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AAD2D600;
	Tue, 25 Jun 2024 05:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294012; cv=none; b=DgiLCoXEKz68vOCekb7FX7J9KI5PAQ63xsKEIv+dvx/9JdpZxvtaWX6ivQEE9ksnmsEend5w/+9oUtVtvBQdxEmrHr6WEieDAGJfGqEYtdJTG3A7Q8mNcbFzCG8gYYJ+V9GWVKs3/nNn8xaHrjGZyhvOg89pUI2Yid2luu76svY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294012; c=relaxed/simple;
	bh=M1FqSIWW5BGnL/+ElkI8tBTSC5SpVTp+vzAd7LBRrF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+WU/SFHnb/ox5xNfI9ZVA6/5OTYDWm5oAd/S10O9FaH0QyGKL/CTH4r7rxgAD+FNqnYfOjSxzDX1MY+MwQhoO7388ViAjdovz0UH+4uJSXxaxx1WbwIN6rfoKmWRVVRnUU+Qjddtzh4MPc+iIF6Gs0LHpbpvvssU8xes7UagMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=afWWjRab; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAUL2sbb; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id F34A92CC012E;
	Tue, 25 Jun 2024 01:40:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 25 Jun 2024 01:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719294007; x=1719301207; bh=VFc58tUfym
	8Rmo2MESo18wgM5PQCChXWwF/qI/zWFEs=; b=afWWjRabs19MBqGXlQrIPCAWcA
	0O8crcvEmNoM/SmFbXJZrwuUAuhwr42qsCVJM1ZTFGwjP2fE47ZZSAMM/5uHPDeW
	D6fo444Ehn/+Nz5dOYJtCvGUMElhqsy+qw4vus+lvnMHiM+kwQ+FzWbg6o2bbquH
	wW5L+tNZauYix+ryzCTG26lFiAxYVcT5LyO0aryVF7AX24dH6cbA6CT4kbO5JvoJ
	VcpFPp71HZ9Zx9NmjZakv68uohN5F+To2owTQfafhBrTLzTvVZl1XmLpb8vrJCKP
	oaLObx1SHnoB5TXS4jN/RlgxCI/ocTaL5dhV4JE5PhUAwUkoMbGbDKguxsog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719294007; x=1719301207; bh=VFc58tUfym8Rmo2MESo18wgM5PQC
	ChXWwF/qI/zWFEs=; b=LAUL2sbbYTKRagemKLgl2P+3AfMVJh2FDcVVowqbE6pj
	2HrlPLQacwpCuWDDu6QwrYhvpTSuHGsHQ1Qm7MPHQUyl7BTZn24lR2Fjnsc+bpOp
	GJJhAS650JzMvgLxswUZEP5ncIv9i40Qer8XH/0nm4JOkGKxNofVZeQ/frTkF6QB
	7+WTITNFdT/qoh/ES2KIASQcsyh6Hr6W3/UvTpdjLL1qxjnciHNDMBU9TXunkbyN
	A5JP5L61vT1eNQLZJ1zyL62qOKS2XPINidNCylJSv4pc8KIEi+8oWjAXYFu4bWEj
	5VzCuI6b04b4xMNccna+YSj/TLuqcPB9sZzv+1UN9A==
X-ME-Sender: <xms:N1h6Zss8MnH5unF4H6tD0qStt88V_SIR1TO9T6UeyANqiu54evnM8g>
    <xme:N1h6ZpdgHLKLmyFWr315sWrjCp0hpBQlo1mun5ioovNDvMy7K8Wr9wtZQZDe34NID
    VFVMyJsxT0URw>
X-ME-Received: <xmr:N1h6ZnwicUnbvWxG0RF4kfcJXw-4Uxctn-kLsutlQ3YuDIRUlqOVZnxcEIN96ylbceM2QwV8DY3TzemXwxZ1LL4yshSIIo4vXgQH3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:N1h6ZvOCWoE48-rVAqe20KJxctFG-TwL8SD1UwoF-nmXVf2la4P4vg>
    <xmx:N1h6Zs_XdxO4VVs2ruchk7OxpFzQB1z8oygPuFBHpzpMZgjx4S4uoA>
    <xmx:N1h6ZnV5pevL1znQGJCZTSsp_K5kV_41HdDaUGqHa_s1ore0xQCkdw>
    <xmx:N1h6ZldmDeG7enuMW0LOvmLGdZ7QQ84YB8E-WaJIpm3dXm6LjRNKRw>
    <xmx:N1h6Zni-QnekwnioqiNobE3ge9-KRyeGeTTGAhgcnVg1MWi2eSe79sw8>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 01:40:06 -0400 (EDT)
Date: Tue, 25 Jun 2024 07:40:04 +0200
From: Greg KH <greg@kroah.com>
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	chao.p.peng@linux.intel.com, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "KVM: Use gfn instead of hva for mmu_notifier_retry" has
 been added to the 6.6-stable tree
Message-ID: <2024062555-stainable-granular-eef6@gregkh>
References: <20240624135153.937666-1-sashal@kernel.org>
 <ZnmM8SCNDe5Hbmcq@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnmM8SCNDe5Hbmcq@google.com>

On Mon, Jun 24, 2024 at 03:12:49PM +0000, Sean Christopherson wrote:
> On Mon, Jun 24, 2024, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     KVM: Use gfn instead of hva for mmu_notifier_retry
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      kvm-use-gfn-instead-of-hva-for-mmu_notifier_retry.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 68a14ccc3fb35047cc4900c8ddd4b6f959e25b77
> > Author: Chao Peng <chao.p.peng@linux.intel.com>
> > Date:   Fri Oct 27 11:21:45 2023 -0700
> > 
> >     KVM: Use gfn instead of hva for mmu_notifier_retry
> >     
> >     [ Upstream commit 8569992d64b8f750e34b7858eac5d7daaf0f80fd ]
> >     
> >     Currently in mmu_notifier invalidate path, hva range is recorded and then
> >     checked against by mmu_invalidate_retry_hva() in the page fault handling
> >     path. However, for the soon-to-be-introduced private memory, a page fault
> >     may not have a hva associated, checking gfn(gpa) makes more sense.
> >     
> >     For existing hva based shared memory, gfn is expected to also work. The
> >     only downside is when aliasing multiple gfns to a single hva, the
> >     current algorithm of checking multiple ranges could result in a much
> >     larger range being rejected. Such aliasing should be uncommon, so the
> >     impact is expected small.
> >     
> >     Suggested-by: Sean Christopherson <seanjc@google.com>
> >     Cc: Xu Yilun <yilun.xu@intel.com>
> >     Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> >     Reviewed-by: Fuad Tabba <tabba@google.com>
> >     Tested-by: Fuad Tabba <tabba@google.com>
> >     [sean: convert vmx_set_apic_access_page_addr() to gfn-based API]
> >     Signed-off-by: Sean Christopherson <seanjc@google.com>
> >     Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >     Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> >     Message-Id: <20231027182217.3615211-4-seanjc@google.com>
> >     Reviewed-by: Kai Huang <kai.huang@intel.com>
> >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >     Stable-dep-of: c3f3edf73a8f ("KVM: Stop processing *all* memslots when "null" mmu_notifier handler is found")
> 
> Please drop this, and all other related patches.  This is not at all appropriate
> for stable trees.
> 
> I'm pretty sure your scripts are borked too, at least from KVM's perspective.  I
> specifically didn't tag c3f3edf73a8f for stable[*], and I thought we had agreed a
> while back that only KVM (x86?) fixes with an explicit "Cc: stable@" would be
> automatically included.
> 
> [*] https://lore.kernel.org/all/20240620230937.2214992-1-seanjc@google.com

All now dropped, sorry about that.

greg k-h

