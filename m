Return-Path: <stable+bounces-98725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0149E4DF8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DC165A6A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73119D062;
	Thu,  5 Dec 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MRbcH0Hs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E4F1+/47"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A119D8B2
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382443; cv=none; b=hwZDzoJAcdw0vWlkL+KRIxahBnZMqLeyo9dvBat6csY+5/IqEbONPl6OMm1Q8OI/hV4PoIuq9pNQhbuWKYrdMDkfhw8/+O9EF/GUrTeKyifkqgiBm+JNFmtT0Qvu9pkaX+SfXW+GnCcNlBOXm6rKTgqI6Djg2C2oIUF4n10qM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382443; c=relaxed/simple;
	bh=bWWJDZr1kho0cvTJevW5fz/opOY9jaZBLBmZH1a9bXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjYNLqhMhCHVM8pTfkuEFYGEx+o/SwaPj3EGWTLQ/ub3S9ccQvSlIgT/7Tr0P+Vn4ftTN+gtLGJs8ik76i9rUuVpsPB3XFs0u+gW9jVNpPNNsces4ZmzcV/fZxUlhocflCxF+Gwk7+BU7zhR9AvQAcw0YsUDvyNYa4GkkygVPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=MRbcH0Hs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E4F1+/47; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F58013806A8;
	Thu,  5 Dec 2024 02:07:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 05 Dec 2024 02:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733382439; x=1733468839; bh=B34K08kK/t
	2ijHo2rdGDlTr4aVt8d3lxyIdKdn0BCQk=; b=MRbcH0HsFCiZTot3Yc6fWWWj/S
	8gGuVolPLzRKyHfTMnwomMSnTHTlososxHa1H4A8Vcdrp3iCDqlkY0mUpKQOQM5Y
	aDiEe/6RI8YiUn6sjNLvimlb1xG23y024Yoldplouan4CzukBFou+kUQRq6Pt2QD
	u1Rq4zQ84DyL7wzuBRwOhE8+69geHpkBBYEBSPuWn4hLBwzkLlQmr4eelfx1gNom
	9atl5LD5MOh6pt0k1aITiHkQ9qIrnj4s1ZpFvudoypkPBC7cOlnb0cIMTgwy/5JH
	JDdtR99nvhi4+se3ikcxHrZtx1ckEAPNzku4IkMgPqAKMryUP5XbcyCl3kDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733382439; x=1733468839; bh=B34K08kK/t2ijHo2rdGDlTr4aVt8d3lxyId
	Kdn0BCQk=; b=E4F1+/47Pqe4nRPqNDgvpdi0vDCn8AV81co0+vPxan/x7Q9pNAV
	ihZWelJUlpbeTLJyh3QUt+awXIO81Bn+WzCijJIAnOfh4Ko/6D2XOnvkJ2F7SMFm
	TpZvE3ndUUq6rDsspOUeAwKktAm0O/g6RTsuDWY2si+1n2WMqvwSM3kR26Pz/Ugm
	8yhi/0Q+mw2DK3lGHVPN95/lLWer9zLgmO5MU+EChNNIG/n3soLvnnasyF3oHhw/
	T9kUHv5qvGy2hCtiiDxvB8fWJ2aQvkP+06vd0cofTGeO/h6yqzgGxnbj20GVRGtx
	kIeDD5ZVfxtIughSDoax4z+Af6P3upsfBvg==
X-ME-Sender: <xms:JlFRZ483JWPbCAKwfaqFZmWvGxXXaQ2Qpzdk4iAecfdjnWoWtKfsqQ>
    <xme:JlFRZws-jSjeORW5m2bPpO0M2CKE-Scm0Bvi_6t1wFJF66kupqnLYEJMTQ5OrbFPX
    BtGDJJAcWnw8w>
X-ME-Received: <xmr:JlFRZ-CkZd36CaiF5OvI1pl3SowHULS_ecUFcxepROVeLA7R2tNT9ztK1KUwe4--l4RPR68rJnF4-LaiCMizIGBjjmIaU6HUWFHnEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeigdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrrh
    hnihhlseguvggsihgrnhdrohhrghdprhgtphhtthhopehmjhhtsehtlhhsrdhmshhkrdhr
    uhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrg
    gslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsmhgruggvuhhs
    segtohguvgifrhgvtghkrdhorhhg
X-ME-Proxy: <xmx:JlFRZ4ffyxlttJZ9dmjH0_NLM33AJuT1nYQ5IpkbbaGVeJD-N-u5oQ>
    <xmx:JlFRZ9M6WYX3WIJJOxarxlauDHDhYSIxasddu2SGT-6N2qLV-SJdfA>
    <xmx:JlFRZyk6QqdVsD1NFDtBpKzj0CDxKy8XS-gXJEcPG74aOWqfRJdpyg>
    <xmx:JlFRZ_sq3VVnGtn8TEpSUXG2RFCoPRNgUYTDwYVQuTh2JiSdKrn16w>
    <xmx:J1FRZ-EnIOYb_NFDmtfrAl_Vo27O_EqoB9y-iKBNoGJMJB8wTE_r8-oI>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 02:07:18 -0500 (EST)
Date: Thu, 5 Dec 2024 08:07:15 +0100
From: Greg KH <greg@kroah.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: please revert backport of
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <2024120519-chamber-despise-c179@gregkh>
References: <202411210628.ECF1B494D7@keescook>
 <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>
 <Z1FOMMxv8bVt8RC3@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1FOMMxv8bVt8RC3@eldamar.lan>

On Thu, Dec 05, 2024 at 07:54:40AM +0100, Salvatore Bonaccorso wrote:
> Hi all,
> 
> On Mon, Nov 25, 2024 at 10:26:12AM +0300, Michael Tokarev wrote:
> > 21.11.2024 17:33, Kees Cook wrote:
> > > Hi stable tree maintainers,
> > > 
> > > Please revert the backports of
> > > 
> > > 44c76825d6ee ("x86: Increase brk randomness entropy for 64-bit systems")
> > > 
> > > namely:
> > > 
> > > 5.4:  03475167fda50b8511ef620a27409b08365882e1
> > > 5.10: 25d31baf922c1ee987efd6fcc9c7d4ab539c66b4
> > > 5.15: 06cb3463aa58906cfff72877eb7f50cb26e9ca93
> > > 6.1:  b0cde867b80a5e81fcbc0383e138f5845f2005ee
> > > 6.6:  1a45994fb218d93dec48a3a86f68283db61e0936
> > > 
> > > There seems to be a bad interaction between this change and older
> > > PIE-built qemu-user-static (for aarch64) binaries[1]. Investigation
> > > continues to see if this will need to be reverted from 6.6, 6.11,
> > > and mainline. But for now, it's clearly a problem for older kernels with
> > > older qemu.
> > > 
> > > Thanks!
> > > 
> > > -Kees
> > > 
> > > [1] https://lore.kernel.org/all/202411201000.F3313C02@keescook/
> > Unfortunately I haven't seen this thread and this email before now,
> > when things are already too late.
> > 
> > And it turned out it's entirely my fault with all this.  Let me
> > explain so things become clear to everyone.
> > 
> > The problem here is entirely in qemu-user.  The fundamental issue
> > is that qemu-user does not implement an MMU, instead, it implements
> > just address shift, searching for a memory region for the guest address
> > space which is hopefully not used by qemu-user itself.
> > 
> > In practice, this is rarely an issue though, when - and this is the
> > default - qemu is built as a static-pie executable.  This is important:
> > it's the default mode for the static build - it builds as static-pie
> > executable, which works around the problem in almost all cases.
> > This is done for quite a long time, too.
> > 
> > However, I, as qemu maintainer in debian, got a bug report saying
> > that qemu-user-static isn't "static enough" - because for some tools
> > used on debian (lintian), static-pie was something unknown and the
> > tool issued a warning.  And at the time, I just added --disable-pie
> > flag to the build, without much thinking.  This is where things went
> > wrong.
> > 
> > Later I reverted this change with a shame, because it causes numerous
> > configurations to fail randomly, and each of them is very difficult to
> > debug (especially due to randomness of failures, sometimes it can work
> > 50 times in a row but fail on the 51th).
> > 
> > But unfortunately, I forgot to revert this "de-PIEsation" change in
> > debian stable, and that's exactly where the original bug report come
> > from, stating kernel broke builds in qemu.
> > 
> > The same qemu-user-static configuration has been used by some other
> > distributions too, but hopefully everything's fixed now.  Except of
> > debian bookworm, and probably also ubuntu jammy (previous LTS).
> > 
> > It is not an "older qemu" anymore (though for a very old qemu this is
> > true again, that old one can't be used anymore with modern executables
> > anyway due to other reasons).  It is just my build mistake which is
> > *still* unfixed on debian stable (bookworm).  And even there, this
> > issue can trivially be fixed locally, since qemu-user-static is
> > self-contained and can be installed on older debian releases, and I
> > always provide up-to-date backports of qemu packages for debian stable.
> > 
> > And yes, qemu had numerous improvements in this area since bookworm
> > version, which addressed many other issues around this and fixed many
> > other configurations (which are not related to this kernel change),
> > but the fundamental issue (lack of full-blown MMU) remains.
> > 
> > Hopefully this clears things up, and it can be seen that this is not
> > a kernel bug.  And I'm hoping we'll fix this in debian bookworm soon
> > too.
> > 
> > Thanks, and sorry for all the buzz which caused my 2 mistakes.
> 
> So catching up with that as we currently did cherry-pick the revert in
> Debian but I defintivelfy would like to align with upstream (and drop
> the cherry-pick again if it's not going to be picked for 6.1.y
> upstream):
> 
> I'm a bit lost here. What are we going to do? Is the commit still
> temporarly be applied to the stable series or are we staying at the
> status quo and we should solely deal it within Debian on qemu side to
> address the issue above and then we are fine? 

I read this as "oops, we messed up in qemu and will fix it there" and so
I dropped the reverts from the kernel.  If that's not the case, please
let me know.

thanks,

greg k-h

